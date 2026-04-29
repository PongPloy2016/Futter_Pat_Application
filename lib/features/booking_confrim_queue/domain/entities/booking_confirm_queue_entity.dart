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
  });
}
