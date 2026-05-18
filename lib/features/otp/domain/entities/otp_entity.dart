class OtpEntity {
  final String? expireDate;
  final String? codeReference;
  final String? token;
  final bool? isBlocked;
  final DateTime? blockTime;

  const OtpEntity({
    this.expireDate,
    this.codeReference,
    this.token,
    this.isBlocked,
    this.blockTime,
  });
}
