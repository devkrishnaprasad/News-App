import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppWrapper {
  String dateFormating(dateString) {
    DateTime dateTime = DateTime.parse(dateString.toString());
    String formattedDate = DateFormat('MMM dd yyyy - hh:mm a').format(dateTime);
    return formattedDate;
  }

  internetCheckConnection() async {
    bool status = await InternetConnectionChecker().hasConnection;
    if (status) {
      log("Internet Connected........");
    } else {
      log("Internet Not Connected........");
    }
    return status;
  }
}
