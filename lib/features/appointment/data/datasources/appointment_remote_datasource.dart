import '../models/appointment_model.dart';
import '../../domain/entities/Appointment_entity.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAppointment();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  @override
  Future<List<AppointmentModel>> getAppointment() async {
    // Mock data for the appointment renewal flow.
    await Future.delayed(const Duration(seconds: 1));
    return const [
      AppointmentModel(
        contractId: '2101/2569',
        contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.pending,
        landItems: [
          LandItemModel(
            landNo: '47(1)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(1) เนื้อที่ 20.1 ตารางวา',
            area: '20.2',
            isSelected: true,
          ),
          LandItemModel(
            landNo: '47(2)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(2) เนื้อที่ 20.2 ตารางวา',
            area: '20.2',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '47(3)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(3) เนื้อที่ 20.2 ตารางวา',
            area: '20.2',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '47(4)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(4) เนื้อที่ 20.2 ตารางวา',
            area: '20.2',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '47(5)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(5) เนื้อที่ 20.2 ตารางวา',
            area: '20.2',
            isSelected: false,
          ),
        ],
      ),
      AppointmentModel(
        contractId: '2102/2569',
        contractName: 'สัญญาเช่าพื้นที่ดิน',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.pending,
        landItems: [
          LandItemModel(
            landNo: '48(2)/56',
            landname: 'ที่ดินแปลงหมายเลข 47(1) เนื้อที่ 20.2 ตารางวา',
            area: '35.0',
            isSelected: false,
          ),
        ],
      ),
      AppointmentModel(
        contractId: '2103/2569',
        contractName: 'สัญญาเช่าพื้นที่คลังสินค้า',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.paid,
      ),
      AppointmentModel(
        contractId: '2104/2569',
        contractName: 'ต่อสัญญาเช่า (อาคารพาณิชย์)',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.paid,
        landItems: [
          LandItemModel(
            landNo: '504(1)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(2)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(3)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(4)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(5)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(6)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(7)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(8)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(9)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(10)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(11)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
          LandItemModel(
            landNo: '504(12)/',
            landname: '504/12 ถ.แก้วอินทร์ บางบังทอง อาคารพาณิชย์ 2 ชั้น',
            area: '15,000',
            isSelected: false,
          ),
        ],
      ),
    ];
  }
}
