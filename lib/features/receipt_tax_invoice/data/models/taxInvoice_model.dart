class TaxInvoiceModel {
  final int id;
  final String name;

  const TaxInvoiceModel({required this.id, required this.name});

  /// 🔹 fromJson (รองรับ API)
  factory TaxInvoiceModel.fromJson(Map<String, dynamic> json) {
    return TaxInvoiceModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  /// 🔹 toJson (ส่งกลับ API)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  /// 🔹 copyWith (แก้ค่าแบบ immutable)
  TaxInvoiceModel copyWith({int? id, String? name}) {
    return TaxInvoiceModel(id: id ?? this.id, name: name ?? this.name);
  }

  /// 🔹 override equality (สำคัญมากกับ Dropdown)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxInvoiceModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'TaxInvoiceModel(id: $id, name: $name)';
}
