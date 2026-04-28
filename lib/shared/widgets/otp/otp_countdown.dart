import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/fontsize.dart';

class OtpCountdown extends StatefulWidget {
  const OtpCountdown({
    super.key,
    required this.onOutOfTime,
    required this.expireDate,
  });

  final Function() onOutOfTime;
  final String expireDate;

  @override
  State<OtpCountdown> createState() => OtpCountdownState();
}

class OtpCountdownState extends State<OtpCountdown> {
  bool _outOfTime = false;
  Timer? _timer;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    final expireDateTime = DateTime.parse(widget.expireDate);
    setState(() {
      _countdown = expireDateTime.difference(DateTime.now()).inSeconds;
      _outOfTime = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final remainingTime = expireDateTime
              .difference(DateTime.now())
              .inSeconds;
          if (remainingTime > 0) {
            _countdown = remainingTime;
          } else {
            _timer?.cancel();
            _outOfTime = true;
            widget.onOutOfTime();
          }
        });
      }
    });
  }

  void stopCountdown() {
    setState(() {
      _countdown = 0;
      _outOfTime = false;
    });
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${format(_countdown ~/ 60)} : ${format(_countdown % 60)}',
      style: TextStyle(
        color: _outOfTime ? Colors.red : const Color(primaryColor),
        fontWeight: fontBold,
      ),
    );
  }
}

String format(int value) {
  return value.toString().padLeft(2, '0');
}
