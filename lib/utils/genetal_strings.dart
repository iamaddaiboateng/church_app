import 'package:date_format/date_format.dart';

const String kDatabaseEmpty =
    'You have not added any member to your membership database. '
    'Please click on the button below to add members to your database';

bool amountString(String amount) {
  if (amount.isEmpty) {
    return false;
  }

  return double.tryParse(amount) != null;
}

formattedDate(DateTime dateTime) {
  return formatDate(dateTime, [DD, ', ', MM, ', ', yyyy, ' ', hh, ' : ', mm]);
}

monthYearDate(DateTime dateTime) {
  return formatDate(dateTime, [MM, ', ', yyyy]);
}

yearDate(DateTime dateTime) {
  return formatDate(dateTime, [yyyy]);
}
