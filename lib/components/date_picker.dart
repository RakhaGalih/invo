import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as picker;

class DateRangePicker extends StatefulWidget {
  /// Creates Date range picker
  const DateRangePicker(this.date, this.range,
      {super.key, this.minDate, this.maxDate, this.displayDate});

  /// Holds date value
  final dynamic date;

  /// Holds date range value
  final dynamic range;

  /// Holds minimum date value
  final dynamic minDate;

  /// Holds maximum date value
  final dynamic maxDate;

  /// Holds showable date value
  final dynamic displayDate;

  @override
  State<StatefulWidget> createState() {
    return _DateRangePickerState();
  }
}

class _DateRangePickerState extends State<DateRangePicker> {
  dynamic _date;
  dynamic _controller;
  dynamic _range;
  late SfLocalizations _localizations;

  @override
  void initState() {
    _date = widget.date;
    _range = widget.range;
    _controller = picker.DateRangePickerController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = SfLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Widget selectedDateWidget = Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _range == null ||
                    _range.startDate == null ||
                    _range.endDate == null ||
                    _range.startDate == _range.endDate
                ? Text(
                    DateFormat('dd MMM, yyyy').format(_range == null
                        ? _date
                        : (_range.startDate ?? _range.endDate)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(
                          DateFormat('dd MMM, yyyy').format(
                              _range.startDate.isAfter(_range.endDate) == true
                                  ? _range.endDate
                                  : _range.startDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          DateFormat('dd MMM, yyyy').format(
                              _range.startDate.isAfter(_range.endDate) == true
                                  ? _range.startDate
                                  : _range.endDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )));

    _controller.selectedDate = _date;
    _controller.selectedRange = _range;
    Widget pickerWidget;
    pickerWidget = picker.SfDateRangePicker(
      controller: _controller,
      initialDisplayDate: widget.displayDate,
      showNavigationArrow: true,
      showActionButtons: true,
      onCancel: () => Navigator.pop(context),
      enableMultiView: false,
      selectionMode: _range == null
          ? picker.DateRangePickerSelectionMode.single
          : picker.DateRangePickerSelectionMode.range,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
      todayHighlightColor: Colors.transparent,
      headerStyle: const picker.DateRangePickerHeaderStyle(
          textAlign: TextAlign.center, textStyle: TextStyle(fontSize: 15)),
      onSubmit: (Object? value) {
        if (_range == null) {
          Navigator.pop(context, _date);
        } else {
          Navigator.pop(context, _range);
        }
      },
      onSelectionChanged: (picker.DateRangePickerSelectionChangedArgs details) {
        setState(() {
          if (_range == null) {
            _date = details.value;
          } else {
            _range = details.value;
          }
        });
      },
    );

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
            height: 400,
            width: _range != null ? 500 : 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                selectedDateWidget,
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: pickerWidget)),
              ],
            )));
  }

  String getFormattedHijriString(
      HijriDateTime date, SfLocalizations localizations, String monthFormat) {
    return date.day.toString() +
        ' ' +
        getHijriMonthText(date, localizations, monthFormat) +
        ' ' +
        date.year.toString();
  }

  String getHijriMonthText(
      dynamic date, SfLocalizations localizations, String format) {
    if (date.month == 1) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortMuharramLabel;
      }
      return localizations.muharramLabel;
    } else if (date.month == 2) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortSafarLabel;
      }
      return localizations.safarLabel;
    } else if (date.month == 3) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRabi1Label;
      }
      return localizations.rabi1Label;
    } else if (date.month == 4) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRabi2Label;
      }
      return localizations.rabi2Label;
    } else if (date.month == 5) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortJumada1Label;
      }
      return localizations.jumada1Label;
    } else if (date.month == 6) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortJumada2Label;
      }
      return localizations.jumada2Label;
    } else if (date.month == 7) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRajabLabel;
      }
      return localizations.rajabLabel;
    } else if (date.month == 8) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortShaabanLabel;
      }

      return localizations.shaabanLabel;
    } else if (date.month == 9) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRamadanLabel;
      }

      return localizations.ramadanLabel;
    } else if (date.month == 10) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortShawwalLabel;
      }
      return localizations.shawwalLabel;
    } else if (date.month == 11) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortDhualqiLabel;
      }
      return localizations.dhualqiLabel;
    } else {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortDhualhiLabel;
      }
      return localizations.dhualhiLabel;
    }
  }
}
