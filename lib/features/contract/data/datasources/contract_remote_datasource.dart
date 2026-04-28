import '../models/contract_model.dart';
import '../../domain/entities/contract_entity.dart';

abstract class ContractRemoteDataSource {
  Future<List<ContractModel>> getContracts();
}

class ContractRemoteDataSourceImpl implements ContractRemoteDataSource {
  @override
  Future<List<ContractModel>> getContracts() async {
    // จำลองการดึงข้อมูลจาก API
    await Future.delayed(const Duration(seconds: 1));
    return const [
      ContractModel(
        contractId: '2101/2569',
        contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
        startDate: '01 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: ContractStatus.pending,
      ),
      ContractModel(
        contractId: '2102/2569',
        contractName: 'สัญญาเช่าพื้นที่ดิน',
        startDate: '01 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: ContractStatus.paid,
      ),
      ContractModel(
        contractId: '2103/2569',
        contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
        startDate: '01 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: ContractStatus.pending,
      ),
      ContractModel(
        contractId: '2104/2569',
        contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
        startDate: '01 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: ContractStatus.pending,
      ),
    ];
  }
}
