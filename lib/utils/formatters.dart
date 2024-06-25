import 'package:intl/intl.dart';

class Formatter {
  Formatter._();

  static String formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    String formattedTime = DateFormat('hh:mm:ss a').format(dateTime);

    return formattedTime;
  }

  static String getTimeAgo(int timestamp) {
    DateTime currentTimestamp = DateTime.now();
    DateTime targetTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp);

    Duration difference = currentTimestamp.difference(targetTimestamp).abs();

    if (difference.inDays >= 365) {
      return "${difference.inDays ~/ 365} years ago";
    } else if (difference.inDays >= 30) {
      return "${difference.inDays ~/ 30} months ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      if (difference.inSeconds <= 0) {
        return "Just now";
      } else {
        return "${difference.inSeconds} seconds ago";
      }
    }
  }
}
