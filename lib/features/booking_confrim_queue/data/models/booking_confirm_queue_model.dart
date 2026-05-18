import '../../domain/entities/booking_confirm_queue_entity.dart';

class BookingDocumentModel extends BookingDocumentEntity {
  const BookingDocumentModel({
    required super.fileName,
    required super.fileSize,
  });

  factory BookingDocumentModel.fromJson(Map<String, dynamic> json) {
    return BookingDocumentModel(
      fileName: json['fileName'] as String? ?? '',
      fileSize: json['fileSize'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileSize': fileSize,
    };
  }
}

class BookingConfirmQueueModel extends BookingConfirmQueueEntity {
  const BookingConfirmQueueModel({
    required super.bookingId,
    required super.queueNumber,
    required super.timeLabel,
    required super.customerName,
    required super.contractId,
    required super.appointmentDate,
    required super.appointmentTime,
    required super.appointmentType,
    required super.detail,
    required super.location,
    super.phone,
    super.appointmentItems,
    super.documents,
  });

  factory BookingConfirmQueueModel.mock() {
    return const BookingConfirmQueueModel(
      bookingId: '210000001',
      queueNumber: '00011',
      timeLabel: 'ช่วงเช้า (08:30 - 11:00)',
      customerName: 'นายมานะ ออกน',
      contractId: '2101/2569',
      appointmentDate: '10/03/2569',
      appointmentTime: 'ช่วงเช้า (08:30 - 11:00)',
      appointmentType: 'ต่อสัญญาเช่า (ที่ดิน)',
      detail: 'ต่อสัญญาเช่าของนายมานะ ออกน',
      location: 'อาคารการท่าเรือแห่งประเทศไทย ชั้น 8 แผนกทะเบียนและสัญญา',
      phone: '098-888-8888',
      appointmentItems:
          'ที่ดินแปลงหมายเลข 47(1)/56 เนื้อที่ 20.2 ตารางวา\nที่ดินแปลงหมายเลข 47(1)/56 เนื้อที่ 20.2 ตารางวา',
      documents: [
        BookingDocumentEntity(
          fileName: 'บัตรประชาชน.pdf',
          fileSize: '2 MB',
        ),
        BookingDocumentEntity(
          fileName: 'เอกสารสัญญาเช่าที่ดิน.pdf',
          fileSize: '3 MB',
        ),
      ],
    );
  }

  factory BookingConfirmQueueModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmQueueModel(
      bookingId: json['bookingId'] as String? ?? '',
      queueNumber: json['queueNumber'] as String? ?? '',
      timeLabel: json['timeLabel'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      contractId: json['contractId'] as String? ?? '',
      appointmentDate: json['appointmentDate'] as String? ?? '',
      appointmentTime: json['appointmentTime'] as String? ?? '',
      appointmentType: json['appointmentType'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      location: json['location'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      appointmentItems: json['appointmentItems'] as String? ?? '',
      documents: (json['documents'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BookingDocumentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'queueNumber': queueNumber,
      'timeLabel': timeLabel,
      'customerName': customerName,
      'contractId': contractId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentType': appointmentType,
      'detail': detail,
      'location': location,
      'phone': phone,
      'appointmentItems': appointmentItems,
      'documents': documents
          .map((d) => {
                'fileName': d.fileName,
                'fileSize': d.fileSize,
              })
          .toList(),
    };
  }
}
