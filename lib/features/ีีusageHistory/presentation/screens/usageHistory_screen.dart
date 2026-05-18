import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../../domain/entities/usageHistory_entity.dart';
import '../providers/usageHistory_provider.dart';

class UsageHistoryScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const UsageHistoryScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<UsageHistoryScreen> createState() => _UsageHistoryScreenState();
}

class _UsageHistoryScreenState extends ConsumerState<UsageHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usageHistoryProvider);

    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        appBar: CustomtitleCustomerAppBar(
          title: '',
          onSuccess: () => context.pop(),
          showActions: false,
        ),
        body: SafeArea(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
                  ? Center(child: Text('Error: ${state.error}'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        _buildTabBar(),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildTabContent(state.waterInvoices, 'น้ำ'),
                              _buildTabContent(state.electricInvoices, 'ไฟ'),
                              _buildTabContent(state.phoneInvoices, 'โทรศัพท์'),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: const Color(0xFF009ADB),
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          SizedBox(width: 12.w),
          Builder(builder: (context) {
            final tabController = DefaultTabController.of(context);
            return ListenableBuilder(
              listenable: tabController,
              builder: (context, child) {
                final names = ['ใช้น้ำ', 'ใช้ไฟ', 'ใช้โทรศัพท์'];
                return Text(
                  'ประวัติการ${names[tabController.index]}',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF009ADB),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFF009ADB),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(4.r),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: const Color(0xFF003D6B),
            borderRadius: BorderRadius.circular(8.r),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'ค่าน้ำ'),
            Tab(text: 'ค่าไฟ'),
            Tab(text: 'ค่าโทรศัพท์'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(List<UsageHistoryEntity> invoices, String typeName) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          _buildChartCard(typeName, invoices),
          SizedBox(height: 24.h),
          _buildTableCard(invoices),
        ],
      ),
    );
  }

  Widget _buildChartCard(String typeName, List<UsageHistoryEntity> invoices) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF3F7FA), Colors.white],
          stops: [0.0, 0.3],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ประวัติการใช้$typeName',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          SizedBox(height: 20.h),
          _buildChart(_getChartValues(invoices)),
        ],
      ),
    );
  }

  List<double> _getChartValues(List<UsageHistoryEntity> invoices) {
    // Initialize 12 months with 0.0
    final List<double> values = List.filled(12, 0.0);

    final monthMap = {
      'มกราคม': 0,
      'กุมภาพันธ์': 1,
      'มีนาคม': 2,
      'เมษายน': 3,
      'พฤษภาคม': 4,
      'มิถุนายน': 5,
      'กรกฎาคม': 6,
      'สิงหาคม': 7,
      'กันยายน': 8,
      'ตุลาคม': 9,
      'พฤศจิกายน': 10,
      'ธันวาคม': 11,
    };

    for (var invoice in invoices) {
      for (var monthName in monthMap.keys) {
        if (invoice.billingMonth.contains(monthName)) {
          final index = monthMap[monthName]!;
          // If there are multiple entries for the same month, we use the value.
          values[index] = invoice.amount;
          break;
        }
      }
    }
    return values;
  }

  Widget _buildChart(List<double> values) {
    double maxValue =
        values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);
    double maxY = maxValue < 1000 ? 1200 : (maxValue + 50);

    return SizedBox(
      height: 220.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 500.w, // กว้างพอสำหรับ 12 เดือน ให้เลื่อนดูได้
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 11, // 12 months (0 to 11)
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY / 3,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 30.h,
                    getTitlesWidget: (value, meta) {
                      const months = [
                        'ม.ค.',
                        'ก.พ.',
                        'มี.ค.',
                        'เม.ย.',
                        'พ.ค.',
                        'มิ.ย.',
                        'ก.ค.',
                        'ส.ค.',
                        'ก.ย.',
                        'ต.ค.',
                        'พ.ย.',
                        'ธ.ค.'
                      ];
                      if (value.toInt() >= 0 && value.toInt() < months.length) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            months[value.toInt()],
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 11.sp,
                              color: Colors.green,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY / 3,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      );
                    },
                    reservedSize: 35.w,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    values.length,
                    (i) => FlSpot(i.toDouble(), values[i]),
                  ),
                  isCurved: true,
                  color: const Color(0xFF009ADB),
                  barWidth: 4,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, bar, index) {
                      return FlDotCirclePainter(
                        radius: 5,
                        color: const Color(0xFF009ADB),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF009ADB).withOpacity(0.3),
                        const Color(0xFF009ADB).withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCard(List<UsageHistoryEntity> invoices) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF3F7FA), Colors.white],
          stops: [0.0, 0.1],
        ),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          ...invoices.map((invoice) => _buildTableRow(invoice)),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerCell('รอบบิล', 2),
          _headerCell('วันที่จดเลข', 2),
          _headerCell('หน่วย', 1),
          _headerCell('วันที่ชำระ', 2),
          _headerCell('บาท', 1),
        ],
      ),
    );
  }

  Widget _headerCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 11.sp, // Slightly smaller font
          fontWeight: FontWeight.w600,
          color: const Color(0xFF009ADB),
        ),
      ),
    );
  }

  Widget _buildTableRow(UsageHistoryEntity invoice) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _dataCell(invoice.billingMonth, 2),
          _dataCell(invoice.meterReadDate, 2),
          _dataCell(invoice.usageUnit.toStringAsFixed(0), 1),
          _dataCell(invoice.paymentDate, 2),
          _dataCell(invoice.amount.toStringAsFixed(0), 1),
        ],
      ),
    );
  }

  Widget _dataCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // Add ellipsis if still too long
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 11.sp, // Slightly smaller font
          color: const Color(0xFF333333),
        ),
      ),
    );
  }
}
