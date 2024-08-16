import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

import '../model/dummy/report_product_chart.dart';

class TableReportComponent extends StatefulWidget {
  final List<ProductData> data;
  const TableReportComponent({super.key, required this.data});

  @override
  State<TableReportComponent> createState() => _TableReportComponentState();
}

class _TableReportComponentState extends State<TableReportComponent> {
  Widget _buildTableRows() {
    Widget cont = Container();
    List<Widget> widgets = [];
    widget.data.asMap().forEach((index, _) {
      widgets.add(tableBody(index));
    });
    cont = Column(
      children: widgets,
    );
    return cont;
  }

  Widget headerBuilder() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Text('Product',
                style: kSemiBoldTextStyle.copyWith(
                    color: const Color(0xFFE1B667), fontSize: 12)),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Text('Stock In',
                style: kSemiBoldTextStyle.copyWith(
                    color: const Color(0xFFE1B667), fontSize: 12)),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Text('Stock Out',
                style: kSemiBoldTextStyle.copyWith(
                    color: const Color(0xFFE1B667), fontSize: 12)),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Text('Revenue',
                textAlign: TextAlign.left,
                style: kSemiBoldTextStyle.copyWith(
                    color: const Color(0xFFE1B667), fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget tableBody(int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Text(widget.data[index].product.toString(),
                textAlign: TextAlign.left,
                style: kMediumTextStyle.copyWith(fontSize: 12)),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all()),
          child: Text(widget.data[index].stockIn.toString(),
              textAlign: TextAlign.left,
              style: kMediumTextStyle.copyWith(fontSize: 12)),
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all()),
          child: Text(widget.data[index].stockOut.toString(),
              textAlign: TextAlign.left,
              style: kMediumTextStyle.copyWith(fontSize: 12)),
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all()),
          child: Text(widget.data[index].revenue,
              textAlign: TextAlign.left,
              style: kMediumTextStyle.copyWith(fontSize: 12)),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [headerBuilder(), _buildTableRows()],
      ),
    );
  }
}
