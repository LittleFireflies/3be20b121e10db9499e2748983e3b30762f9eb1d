String getFullDateFormat(DateTime date) {
  return '${getWeekDay(date.weekday)}, ${date.day} ${getMonth(date.month)} ${date.year}';
}

String getWeekDay(int weekday) {
  switch (weekday) {
    case 1:
      return 'Senin';
    case 2:
      return 'Selasa';
    case 3:
      return 'Rabu';
    case 4:
      return 'Kamis';
    case 5:
      return 'Jumat';
    case 6:
      return 'Sabtu';
    case 7:
      return 'Minggu';
    default:
      throw 'Weekday not valid';
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'Januari';
    case 2:
      return 'Februari';
    case 3:
      return 'Maret';
    case 4:
      return 'April';
    case 5:
      return 'Mei';
    case 6:
      return 'Juni';
    case 7:
      return 'Juli';
    case 8:
      return 'Agustus';
    case 9:
      return 'September';
    case 10:
      return 'Oktober';
    case 11:
      return 'November';
    case 12:
      return 'Desember';
    default:
      return 'Month not valid';
  }
}

List<DateTime> getSaturdayAndSunday() {
  final today = DateTime.now();
  final List<DateTime> saturdayAndSunday = [];

  for (int i = 1; i <= 56; i++) {
    final date = today.add(Duration(days: i));
    if (date.weekday == DateTime.sunday || date.weekday == DateTime.saturday) {
      saturdayAndSunday.add(date);
    }
  }

  return saturdayAndSunday;
}

bool isTodaySaturday() {
  return DateTime.now().weekday == DateTime.saturday;
}

bool isTodaySunday() {
  return DateTime.now().weekday == DateTime.sunday;
}

DateTime getInitialDate() {
  return isTodaySaturday()
      ? DateTime.now().add(Duration(days: 2))
      : isTodaySunday()
          ? DateTime.now().add(Duration(days: 1))
          : DateTime.now();
}
