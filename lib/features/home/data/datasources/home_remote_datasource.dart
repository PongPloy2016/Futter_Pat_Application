import '../../../../router/app_router.dart';
import '../models/home_service_item_model.dart';
import '../models/home_news_item_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeServiceItemModel>> getHomeServices();
  Future<List<HomeNewsItemModel>> getHomeNews();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<HomeServiceItemModel>> getHomeServices() async {
    // Simulating API call
    return const [
      HomeServiceItemModel(
        name: 'สัญญา',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_contract.png',
        routeName: AppRouter.contractList,
      ),
      HomeServiceItemModel(
        name: 'นัดหมาย',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_clock.png',
        routeName: AppRouter.appointmentRenewal,
      ),
      HomeServiceItemModel(
        name: 'ใบแจ้งหนี้',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_money.png',
      ),
      HomeServiceItemModel(
        name: 'ตรวจสอบ\nสถานะนัดหมาย',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_project-status.png',
      ),
      HomeServiceItemModel(
        name: 'ใบเสร็จ/ใบกำกับ\nภาษี',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_receipt.png',
      ),
      HomeServiceItemModel(
        name: 'ประวัติการ\nชำระเงิน',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_transaction_history.png',
      ),
      HomeServiceItemModel(
        name: 'ประวัติการใช้\nไฟฟ้า',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_eco_house.png',
      ),
      HomeServiceItemModel(
        name: 'ประวัติการใช้\nน้ำประปา',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_water_tap.png',
      ),
      HomeServiceItemModel(
        name: 'ประวัติการใช้\nโทรศัพท์',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_phone_call.png',
      ),
      HomeServiceItemModel(
        name: 'การสื่อสาร',
        icon: 'lib/assets/icons/ic_svg_receipt.svg',
        iconPng: 'lib/assets/icons/ic_phone_call.png',
        routeName: AppRouter.communication,
      ),
    ];
  }

  @override
  Future<List<HomeNewsItemModel>> getHomeNews() async {
    // Simulating API call
    return const [
      HomeNewsItemModel(title: "ประกาศการท่าเรือแห่งประเทศไทย เรื่อง ขอเชิญชวนผู้สนใจใช้พื้นที่ในเขตท่าเรือระนอง เนื้อที่จำนวน 10,120 ตารางเมตร"),
      HomeNewsItemModel(title: "ประกาศการท่าเรือแห่งประเทศไทย เลื่อนการประชาพิจารณ์"),
      HomeNewsItemModel(title: "ประกาศรับสมัครพนักงานการท่าเรือแห่งประเทศไทย"),
      HomeNewsItemModel(title: "ประกาศการท่าเรือแห่งประเทศไทย เรื่อง ขอเชิญชวนผู้สนใจใช้พื้นที่ในเขตท่าเรือระนอง เนื้อที่จำนวน 10,120 ตารางเมตร"),
      HomeNewsItemModel(title: "ประกาศการท่าเรือแห่งประเทศไทย เลื่อนการประชาพิจารณ์"),
      HomeNewsItemModel(title: "ประกาศรับสมัครพนักงานการท่าเรือแห่งประเทศไทย"),
    ];
  }
}
