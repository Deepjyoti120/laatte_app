import 'dart:io';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static flutterToast(msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.black.withOpacity(0.75));
  }

  static Future<void> launchUrl2(
      {required String url, LaunchMode? launchMode}) async {
    if (!await launchUrl(Uri.parse(url),
        mode: launchMode ?? LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static String getSignalFlag(String signalFlag) {
    if (signalFlag == "Y") {
      return "Normal";
    } else if (signalFlag == "H") {
      return "High";
    } else if (signalFlag == "M") {
      return "Medium";
    } else {
      return '';
    }
  }

  static getHeight(BuildContext context) {
    var orientationOf = MediaQuery.orientationOf(context);
    Size size = MediaQuery.sizeOf(context);
    if (orientationOf == Orientation.portrait) {
      return size.height;
    } else {
      return size.width;
    }
  }

  static String getFormattedDateString(String date) {
    if (date.isEmpty) {
      return "";
    }
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTimeFormatted = dateFormat.parse(date);
    DateFormat dateFormatReadable = DateFormat('dd MMM yyyy');
    return dateFormatReadable.format(dateTimeFormatted);
  }

  static double calculateBMI(double weightInKg, double height,
      {bool isCms = true}) {
    double bmi;
    if (isCms) {
      height = height / 100;
    } else {
      height = height * 0.0254;
    }
    bmi = weightInKg / (height * height);
    return bmi;
  }

  static Future<TimeOfDay> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
    }
    return selectedTime;
  } // TimeOfDay To Format AM/PM

  static String timeOfDayAMPM(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat('h:mm a');
    return format.format(dateTime);
  }

  static Future<List<File>> pickFiles({
    FileType type = FileType.custom,
    bool allowMultiple = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: type,
      allowedExtensions: type == FileType.custom ?  ['pdf', 'doc','docx'] : null,
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    }
    return [];
  }

  //Get Current Year First Day OR Last Date
  static Future<DateTime> getYearDate(bool isLastDate) async {
    DateTime now = await NTP.now();
    DateTime firstDateOfYear = DateTime(now.year, 1, 1);
    DateTime lastDateOfYear = DateTime(now.year, 12, 31);
    if (isLastDate) {
      return lastDateOfYear;
    } else {
      return firstDateOfYear;
    }
  }

  static Future<List<DateTime>> getDateTimeRange(String range) async {
    DateTime now = await NTP.now();
    DateTime firstDateOfYear = DateTime(now.year, 1, 1);
    DateTime lastDateOfYear = DateTime(now.year, 12, 31);
    DateTime firstDateOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDateOfMonth = DateTime(now.year, now.month + 1, 0);
    DateTime firstDateOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime lastDateOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
    DateTime firstDateOfToday = DateTime(now.year, now.month, now.day);
    DateTime lastDateOfToday =
        DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime firstDateOfYesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime lastDateOfYesterday =
        DateTime(now.year, now.month, now.day - 1, 23, 59, 59);
    DateTime firstDateOfLastYear = DateTime(now.year - 1, 1, 1);
    DateTime lastDateOfLastYear = DateTime(now.year - 1, 12, 31);
    if (range == "Today") {
      return [firstDateOfToday, lastDateOfToday];
    } else if (range == "Yesterday") {
      return [firstDateOfYesterday, lastDateOfYesterday];
    } else if (range == "This Week") {
      return [firstDateOfWeek, lastDateOfWeek];
    } else if (range == "This Month") {
      return [firstDateOfMonth, lastDateOfMonth];
    } else if (range == "This Year") {
      return [firstDateOfYear, lastDateOfYear];
    } else if (range == "Last Year") {
      return [firstDateOfLastYear, lastDateOfLastYear];
    } else {
      return [firstDateOfToday, lastDateOfToday];
    }
  } 

  static Future<DateTime?> filterDatePicker(
      BuildContext context, Function(DateTime) onDateSelected, String helpText,) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: helpText,
    );
    if (picked != null) {
      onDateSelected(picked);
    }
    return picked;
  }
  // static Future<DateTime?> filterDatePicker(
  //     DateTime? dateTime, String helpText, BuildContext context) async {
  //   return showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: dateTime ?? DateTime(1990),
  //     lastDate: DateTime.now(),
  //     helpText: helpText,
  //   );
  // }

  static Future<String> getTodayString() async {
    try {
      final ntp = await NTP.now();
      return DateFormat().add_yMMMEd().format(ntp);
    } catch (e) {
      return DateFormat().add_yMMMEd().format(DateTime.now());
    }
  }

  static logPrint(String message) {
    developer.log(message);
  }

  static bool get isIOS {
    return Platform.isIOS;
  }

  //

  static logPrintColor(String message, {String color = 'reset'}) {
    // Define ANSI escape codes for different colors
    Map<String, String> colors = {
      'black': '\x1B[30m',
      'red': '\x1B[31m',
      'green': '\x1B[32m',
      'yellow': '\x1B[33m',
      'blue': '\x1B[34m',
      'magenta': '\x1B[35m',
      'cyan': '\x1B[36m',
      'white': '\x1B[37m',
      'reset': '\x1B[0m'
    };
    String? colorCode =
        colors.containsKey(color) ? colors[color] : colors['white'];
    developer.log('$colorCode$message${colors['reset']}');
  }

  // app auth
  // static Future<bool> get authStart async {
  //   try {
  //     final LocalAuthentication auth = LocalAuthentication();
  //     final isAuth = await auth.authenticate(
  //       localizedReason: 'Please authenticate to continue',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //         biometricOnly: false,
  //         useErrorDialogs: false,
  //       ),
  //       // authMessages: const [
  //       //   AndroidAuthMessages(
  //       //     signInTitle: 'Oops! Biometric authentication required!',
  //       //     cancelButton: 'No thanks',
  //       //   ),
  //       //   IOSAuthMessages(
  //       //     cancelButton: 'No thanks',
  //       //   ),
  //       // ],
  //     );
  //     return isAuth;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  static num generateRandomNumber(int maxLength) {
    Random random = Random();
    num min = pow(10, maxLength - 1);
    num max = pow(10, maxLength) - 1;
    return min + random.nextInt(max.toInt() - min.toInt());
  }

  static String? validateEmail(String? value) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter.';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least 1 lowercase letter.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least 1 special character.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  static bool validatePhoneNumber(String phoneNumber) {
    String phonePattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(phonePattern);
    return regExp.hasMatch(phoneNumber);
  }

  static String formatPercentage(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  static Future<String?> getDeviceIpAddress() async {
    String? ipAddress;
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            ipAddress = addr.address;
            break;
          }
        }
        if (ipAddress != null) {
          break;
        }
      }
    } catch (e) {
      logPrint("Error getting IP address: $e");
    }
    return ipAddress;
  }

  static String get getPlatformName {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  static String formatDateTime(String? dateTime) {
    if (dateTime == null) {
      return "";
    }
    dateTime = DateFormat("dd MMM yyyy, h:m a")
        .format(DateTime.parse(dateTime).toLocal());
    return dateTime;
  }

  static String formatDate(String? dateTime) {
    if (dateTime == null) {
      return "";
    }
    dateTime = DateFormat("dd MMM yyyy").format(DateTime.parse(dateTime));
    return dateTime;
  }

  static Future openLocationSettings() async {
    Geolocator.openLocationSettings();
  }

  static Future<bool> isAllowGPS() async {
    final location = await Geolocator.checkPermission();
    if (location == LocationPermission.always ||
        location == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<String> getLatLngToAddress(LatLng? latLng) async {
  //   if (latLng != null) {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  //     Placemark placemark =
  //         placemarks.isNotEmpty ? placemarks[0] : const Placemark();
  //     List<String> addressComponents = [];
  //     if (placemark.street != null && placemark.street!.isNotEmpty) {
  //       addressComponents.add(placemark.street!);
  //     }
  //     if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
  //       addressComponents.add(placemark.subLocality!);
  //     }
  //     if (placemark.locality != null && placemark.locality!.isNotEmpty) {
  //       addressComponents.add(placemark.locality!);
  //     }
  //     if (placemark.administrativeArea != null &&
  //         placemark.administrativeArea!.isNotEmpty) {
  //       addressComponents.add(placemark.administrativeArea!);
  //     }
  //     if (placemark.country != null && placemark.country!.isNotEmpty) {
  //       addressComponents.add(placemark.country!);
  //     }
  //     return addressComponents.join(', ');
  //   }
  //   return "";
  // }

  // static Color? statusColor(num? id) {
  //   // Define ANSI escape codes for different colors
  //   Map<int, dynamic> colors = {
  //     1: DesignColor.rejected,
  //     3: DesignColor.error400,
  //     4: DesignColor.success600,
  //   };
  //   return colors[id];
  // }

  // static double _calculateDistance(LatLng location1, LatLng location2) {
  //   const double earthRadius = 6371;

  //   double dLat = _degreesToRadians(location2.latitude - location1.latitude);
  //   double dLng = _degreesToRadians(location2.longitude - location1.longitude);

  //   double a = pow(sin(dLat / 2), 2) +
  //       cos(_degreesToRadians(location1.latitude)) *
  //           cos(_degreesToRadians(location2.latitude)) *
  //           pow(sin(dLng / 2), 2);

  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  //   return earthRadius * c;
  // }

  // static double _degreesToRadians(double degrees) {
  //   return degrees * pi / 180;
  // }

  // static LatLng? findNearestLocation(
  //     List<LatLng> locations, LatLng currentLocation) {
  //   double minDistance = double.infinity;
  //   LatLng? nearestLocation;

  //   for (LatLng location in locations) {
  //     double distance = _calculateDistance(currentLocation, location);

  //     if (distance < minDistance) {
  //       minDistance = distance;
  //       nearestLocation = location;
  //     }
  //   }

  //   return nearestLocation;
  // }

  // static Future<String> getJsonFile(String path) async {
  //   ByteData byte = await rootBundle.load(path);
  //   var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
  //   return utf8.decode(list);
  // }

  // static Future<BitmapDescriptor> customMarker(String path) async {
  //   return BitmapDescriptor.fromAssetImage(
  //       const ImageConfiguration(size: Size(40, 40)), path);
  // }

  // static Future<Uint8List> getImages(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetHeight: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  // static Future<String> markerStatus(String? actualEndDate) async {
  //   String assetName = AssetsName.imgLocationGreen;
  //   if (actualEndDate != null) {
  //     return assetName;
  //   }
  //   DateTime actualEndDateToDate = DateTime.parse(actualEndDate!);
  //   DateTime currentDate = await NTP.now();
  //   if (actualEndDateToDate.isAfter(currentDate)) {
  //     if (actualEndDateToDate.difference(currentDate).inDays > 7) {
  //       assetName = AssetsName.imgLocationGreen;
  //     } else {
  //       assetName = AssetsName.imgLocationYellow;
  //     }
  //   } else {
  //     assetName = AssetsName.imgLocationRed;
  //   }
  //   return assetName;
  // }

  // static Color? workStatusColorByDate({
  //   required DateTime datetime,
  //   required DateTime today,
  //   required num statusID,
  // }) {
  //   Color? filterColor;
  //   DateTime actualEndDateToDate = datetime;
  //   int days = actualEndDateToDate.difference(today).inDays;
  //   final isCompleted = statusID == ApplicationStatusCode.applicationCompleted;
  //   final isCrossed =
  //       statusID == ApplicationStatusCode.applicationAccepted && days < 0;
  //   final isNear = statusID == ApplicationStatusCode.applicationAccepted &&
  //       days >= 0 &&
  //       days <= Constants.endDays;
  //   final isOntime = statusID == ApplicationStatusCode.applicationAccepted &&
  //       ((days >= 0 && days <= Constants.endDays) || days > Constants.endDays);
  //   if (isOntime && !isCompleted && !isCrossed && !isNear) {
  //     filterColor = DesignColor.success600;
  //   }
  //   if (isNear) {
  //     filterColor = DesignColor.colorPrimary;
  //   }
  //   if (isCrossed) {
  //     filterColor = DesignColor.red;
  //   }
  //   if (isCompleted) {
  //     filterColor = DesignColor.blue;
  //   }
  //   return filterColor;
  // }

  // static bool workDateTimeStatus({
  //   required DateTime datetime,
  //   required DateTime today,
  //   required num statusID,
  //   required DateTimeStatus dateTimeStatus,
  // }) {
  //   DateTime day = DateTime.now();
  //   int days = datetime.difference(day).inDays;
  //   if (dateTimeStatus == DateTimeStatus.ontime) {
  //     return statusID == ApplicationStatusCode.applicationAccepted &&
  //         ((days >= 0 && days <= Constants.endDays) ||
  //             days > Constants.endDays);
  //   }
  //   if (dateTimeStatus == DateTimeStatus.nearingdate) {
  //     return statusID == ApplicationStatusCode.applicationAccepted &&
  //         days >= 0 &&
  //         days <= Constants.endDays;
  //   }
  //   if (dateTimeStatus == DateTimeStatus.crosseddate) {
  //     return statusID == ApplicationStatusCode.applicationAccepted && days < 0;
  //   }
  //   if (dateTimeStatus == DateTimeStatus.completed) {
  //     return statusID == ApplicationStatusCode.applicationCompleted;
  //   }
  //   return false;
  // }

  // static bool searchAddress(String query, String address) {
  //   query = query.toLowerCase();
  //   address = address.toLowerCase();
  //   List<String> queryWords = query.split(" ");
  //   List<String> addressWords = address.split(" ");
  //   for (var word in queryWords) {
  //     if (!addressWords.contains(word)) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  // static bool searchTextFilter(String query, String actualText) {
  //   query = query.toLowerCase();
  //   actualText = actualText.toLowerCase();
  //   List<String> queryWords = query.split(" ");
  //   List<String> addressWords = actualText.split(" ");
  //   if (!actualText.contains(query)) {
  //     for (var word in queryWords) {
  //       if (!addressWords.contains(word)) {
  //         return false;
  //       }
  //     }
  //   }
  //   return true;
  // }

  // static String applicationApiStatusNameCustomize(num apiStatus) {
  //   final statusText = apiStatus == ApplicationStatusCode.applicationCompleted
  //       ? 'Completed'
  //       : apiStatus == WorkStatusCode.workPending
  //           ? 'Pending'
  //           : 'Work in Progress';
  //   return statusText;
  // }

  static List<int> get getMonths {
    return List.generate(12, (index) => index + 1);
  }

  static String numberToMonth(int number) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    if (number < 1 || number > 12) {
      return "Invalid month number";
    }

    return months[number - 1];
  }

  static List<int> getLastYears([int number = 6]) {
    int currentYear = DateTime.now().year;
    return List.generate(number, (index) => currentYear - index);
  } 
  static Future<void> sleep(int seconds) {
    return Future.delayed(Duration(seconds: seconds));
  }
}
