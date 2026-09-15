import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

RxBool isRadioPlay = false.obs;

enum BottomDisplay { song, video, none }

extension NameInitials on String {
  ///Geting Initials String for Contect Name Avatar
  String getInitials() {
    List<String> nameParts = split(' ');
    if (nameParts.length < 2) {
      if (nameParts.isNotEmpty && nameParts != '') {
        String firstInitial = nameParts[0][0].capitalize ?? '';
        String secondInitial = nameParts[0][1].isNotEmpty
            ? nameParts[0][1].capitalize ?? ''
            : nameParts[0][0].capitalize ?? '';
        return '$firstInitial$secondInitial';
      } else {
        return '';
      }
    }
    String firstInitial = nameParts[0][0].capitalize ?? '';
    String secondInitial = nameParts[1][0].capitalize ?? '';

    return '$firstInitial$secondInitial';
  }
}

String durationToStringTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

// import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 10) {
      digits = digits.substring(0, 10); // max 10 digits
    }

    StringBuffer buffer = StringBuffer();
    int len = digits.length;

    if (len >= 1) buffer.write('(');
    if (len >= 1) buffer.write(digits.substring(0, len >= 3 ? 3 : len));
    if (len >= 3) buffer.write(') ');
    if (len >= 4) buffer.write(digits.substring(3, len >= 6 ? 6 : len));
    if (len >= 6) buffer.write('-');
    if (len >= 7) buffer.write(digits.substring(6));

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

extension StringDateTimeExtension on String {
  String toFormattedTime() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
