import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invo/components/chart_report.dart';
import 'package:invo/components/loading.dart';
import 'package:invo/components/table_report.dart';
import 'package:invo/database/dummy/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as picker;

import '../../../api_config/api.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/date_picker.dart';
import '../../../model/constant/constant.dart';
import '../../../model/dummy/report_product_chart.dart';
import '../../../model/refreshModel.dart';
import '../../../model/reportModel.dart';

class ReportProductPage extends StatefulWidget {
  const ReportProductPage({super.key});

  @override
  State<ReportProductPage> createState() => _ReportProductPageState();
}

class _ReportProductPageState extends State<ReportProductPage> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  List<ProductReport> dataProduct = [];
  bool _isLoad = true;

  Future getReports() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      RefreshModel refresh = await Api().doRefresh();
      await pref.setString('token_user', refresh.accessToken);
      ReportModel model = await Api().getReports(
          token: pref.getString('token_user').toString(),
          createdAfter: DateFormat('yyyy-MM-dd').format(_startDate),
          createdBefore: DateFormat('yyyy-MM-dd').format(_endDate));
      setState(() {
        dataProduct = model.data.productReports;
        _isLoad = false;
      });
    } on HttpException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Error', 'Http Exception', 'error');
    } on SocketException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Login Failed', 'No internet connection', 'error');
    } on TimeoutException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(context, 'Timeout',
          'There seems to be an internet connection error', 'warning');
    }
  }

  void _onSelectedRangeChanged(picker.PickerDateRange dateRange) {
    final DateTime startDateValue = dateRange.startDate!;
    final DateTime endDateValue = dateRange.endDate ?? startDateValue;
    setState(() {
      if (startDateValue.isAfter(endDateValue)) {
        _startDate = endDateValue;
        _endDate = startDateValue;
        getReports();
      } else {
        _startDate = startDateValue;
        _endDate = endDateValue;
        getReports();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Report', style: kBoldTextStyle.copyWith(fontSize: 14))),
      body: _isLoad
          ? const LoadingAnimation()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChartReportComponent(dataProduct: dataProduct),
                  const SizedBox(height: 25),
                  Text('Current report period',
                      style: kMediumTextStyle.copyWith(
                          color: const Color(0xFF7F7F7F), fontSize: 14)),
                  const SizedBox(height: 8),
                  _getBooking(),
                  const SizedBox(height: 20),
                  TableReportComponent(data: dataProduct),
                ],
              ),
            ),
    );
  }

  Widget _getBooking() {
    return Card(
      child: Row(children: <Widget>[
        Expanded(
            flex: 5,
            child: RawMaterialButton(
                padding: const EdgeInsets.all(5),
                onPressed: () async {
                  final picker.PickerDateRange? range =
                      await showDialog<picker.PickerDateRange?>(
                          context: context,
                          builder: (BuildContext context) {
                            return DateRangePicker(
                              null,
                              picker.PickerDateRange(
                                _startDate,
                                _endDate,
                              ),
                              displayDate: _startDate,
                            );
                          });

                  if (range != null) {
                    _onSelectedRangeChanged(range);
                  }
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Created After',
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: Text(
                              DateFormat('dd MMM yyyy').format(_startDate),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )))),
        Expanded(
            flex: 5,
            child: RawMaterialButton(
                padding: const EdgeInsets.all(5),
                onPressed: () async {
                  final picker.PickerDateRange? range =
                      await showDialog<picker.PickerDateRange>(
                          context: context,
                          builder: (BuildContext context) {
                            return DateRangePicker(
                              null,
                              picker.PickerDateRange(_startDate, _endDate),
                              displayDate: _endDate,
                            );
                          });

                  if (range != null) {
                    _onSelectedRangeChanged(range);
                  }
                },
                child: Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Created Before',
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: Text(
                              DateFormat('dd MMM yyyy').format(_endDate),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ))))
      ]),
    );
  }
}
