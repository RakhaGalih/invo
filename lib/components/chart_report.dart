import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../database/dummy/database.dart';
import '../model/dummy/report_product_chart.dart';
import '../model/reportModel.dart';

class ChartReportComponent extends StatefulWidget {
  final List<ProductReport> dataProduct;
  const ChartReportComponent({super.key, required this.dataProduct});

  @override
  State<ChartReportComponent> createState() => _ChartReportComponentState();
}

class _ChartReportComponentState extends State<ChartReportComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      padding: const EdgeInsets.fromLTRB(0, 12, 5, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2)),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis:
            const NumericAxis(minimum: 0, maximum: 1000, interval: 250),
        series: <LineSeries<ProductReport, String>>[
          LineSeries<ProductReport, String>(
            dataSource: widget.dataProduct,
            xValueMapper: (ProductReport data, _) => data.name,
            yValueMapper: (ProductReport data, _) => data.reports[0].stockIn,
            color: Colors.green,
            markerSettings:
                const MarkerSettings(isVisible: true, color: Colors.green),
            name: 'Stock In',
          ),
          LineSeries<ProductReport, String>(
            dataSource: widget.dataProduct,
            xValueMapper: (ProductReport data, _) => data.name,
            yValueMapper: (ProductReport data, _) => data.reports[0].stockOut,
            color: Colors.pink,
            markerSettings:
                const MarkerSettings(isVisible: true, color: Colors.pink),
            name: 'Stock Out',
          ),
        ],
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      ),
    );
  }
}
