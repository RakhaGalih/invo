import 'package:flutter/material.dart';
import 'package:invo/components/chart_report.dart';
import 'package:invo/components/table_report.dart';
import 'package:invo/database/dummy/database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/constant/constant.dart';
import '../../../model/dummy/report_product_chart.dart';

class ReportProductPage extends StatefulWidget {
  const ReportProductPage({super.key});

  @override
  State<ReportProductPage> createState() => _ReportProductPageState();
}

class _ReportProductPageState extends State<ReportProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Report', style: kBoldTextStyle.copyWith(fontSize: 14))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChartReportComponent(),
            const SizedBox(height: 25),
            Text('Current report period',
                style: kMediumTextStyle.copyWith(
                    color: const Color(0xFF7F7F7F), fontSize: 14)),
            const SizedBox(height: 12),
            Text('Aug 01 - 31, 2024',
                style: kMediumTextStyle.copyWith(fontSize: 14)),
            const SizedBox(height: 25),
            TableReportComponent(data: DataDummy.productData)
          ],
        ),
      ),
    );
  }
}
