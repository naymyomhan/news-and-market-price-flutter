import 'package:intl/intl.dart';

class AppUtils {
  static Future<int> currentTime() async {
    String currentTime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    return int.parse(currentTime);
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  String formatDateToYMD(DateTime date) {
    final DateFormat formatter = DateFormat('y, MMM d');
    return formatter.format(date);
  }
}
