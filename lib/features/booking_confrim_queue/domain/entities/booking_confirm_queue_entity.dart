class BookingDocumentEntity {
  final String fileName;
  final String fileSize;

  const BookingDocumentEntity({
    required this.fileName,
    required this.fileSize,
  });
}

class BookingConfirmQueueEntity {
  final String bookingId;
  final String queueNumber;
  final String timeLabel;
  final String customerName;
  final String contractId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentType;
  final String detail;
  final String location;
  final String phone;
  final String appointmentItems;
  final List<BookingDocumentEntity> documents;

  const BookingConfirmQueueEntity({
    required this.bookingId,
    required this.queueNumber,
    required this.timeLabel,
    required this.customerName,
    required this.contractId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
    required this.detail,
    required this.location,
    this.phone = '',
    this.appointmentItems = '',
    this.documents = const [],
  });
}
