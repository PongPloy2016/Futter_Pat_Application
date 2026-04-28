import '../../domain/entities/contract_entity.dart';

class ContractModel extends ContractEntity {
  const ContractModel({
    required super.contractId,
    required super.contractName,
    required super.startDate,
    required super.endDate,
    required super.monthlyRent,
    required super.dueDate,
    required super.status,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      contractId: json['contractId'] ?? '',
      contractName: json['contractName'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      monthlyRent: json['monthlyRent'] ?? '',
      dueDate: json['dueDate'] ?? '',
      status: ContractStatus.values.firstWhere(
        (e) => e.toString() == 'ContractStatus.${json['status']}',
        orElse: () => ContractStatus.pending,
      ),
    );
  }
}
