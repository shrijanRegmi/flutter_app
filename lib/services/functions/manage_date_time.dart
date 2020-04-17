class ManageDateTime {
  final _dateTimeFromFirebase;
  ManageDateTime(this._dateTimeFromFirebase);

  DateTime _date;

  getDay() {
    _date = DateTime.parse(_dateTimeFromFirebase);
    if (_date.day == DateTime.now().day) {
      return "Today";
    } else if (_date.day == DateTime.now().day - 1) {
      return "Yesterday";
    } else {
      return _date.day;
    }
  }

  getSingleDay() {
    _date = DateTime.parse(_dateTimeFromFirebase);
    return _date.day;
  }

  getMonth() {
    _date = DateTime.parse(_dateTimeFromFirebase);
    switch (_date.month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
      default:
        return null;
    }
  }

  getTime() {
    _date = DateTime.parse(_dateTimeFromFirebase);
    if (_date.hour > 12) {
      return "At 0${_date.hour - 12}:${_date.minute} pm";
    } else {
      return "At ${_date.hour}:${_date.minute} am";
    }
  }
}
