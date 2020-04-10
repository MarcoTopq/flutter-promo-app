import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warnakaltim/src/model/chartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//code never lies

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  var series;

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<ChartModel>(context, listen: false).fetchDataChart();
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'Summary',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        // backgroundColor: Colors.grey[850],
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<ChartModel>(context, listen: false)
                    .fetchDataChart(),
                builder: (ctx, snapshop) {
                  if (snapshop.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshop.error != null) {
                      return Center(
                        child: Text("Error Loading Data"),
                      );
                    }
                    return Consumer<ChartModel>(
                        builder: (ctx, _listChart, child) => Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(20)),
                                      Text(
                                        'Grafik Ringkasan',
                                        style: new TextStyle(
                                          fontSize: 26.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Container(
                                      //     child: SfCartesianChart(
                                      //         primaryXAxis: CategoryAxis(
                                      //             title:
                                      //                 AxisTitle(text: 'Tahun')),
                                      //         primaryYAxis: NumericAxis(
                                      //             title:
                                      //                 AxisTitle(text: 'QTY')),
                                      //         series: <ChartSeries>[
                                      //       ColumnSeries<SalesData, String>(
                                      //           dataSource: _listChart.listChart
                                      //               .map((i) => SalesData(
                                      //                   i.date.toString(),
                                      //                   i.quantity))
                                      //               .toList(),
                                      //           dataLabelSettings:
                                      //               DataLabelSettings(
                                      //                   isVisible: true,
                                      //                   labelPosition:
                                      //                       ChartDataLabelPosition
                                      //                           .inside),
                                      //           xValueMapper:
                                      //               (SalesData sales, _) =>
                                      //                   sales.x,
                                      //           yValueMapper:
                                      //               (SalesData sales, _) =>
                                      //                   sales.y)
                                      //     ])),
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          child: SizedBox(
                                              height: 400,
                                              child: charts.BarChart(
                                                series = [
                                                  charts.Series<SalesData,
                                                      String>(
                                                    id: 'Grafik',
                                                    data: _listChart.listChart
                                                        .map((i) => SalesData(
                                                              i.date
                                                                  .toString()
                                                                  .substring(
                                                                      0, 8),
                                                              i.quantity,
                                                            ))
                                                        .toList(),
                                                    domainFn:
                                                        (SalesData sales, _) =>
                                                            sales.x,
                                                    measureFn:
                                                        (SalesData sales, _) =>
                                                            sales.y,
                                                    // colorFn: (SalesData sales,
                                                    //         _) =>
                                                    //     charts.ColorUtil
                                                    //         .fromDartColor(
                                                    //             sales.color)
                                                    //  colorFn: Colors.pink
                                                  ),
                                                ],
                                                animate: true,
                                                // defaultRenderer: new charts
                                                //         .LineRendererConfig(
                                                //     includePoints: true),
                                              ))),
                                              // Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        'Tanggal',
                                        style: new TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))));
                  }
                })));
  }
}

class SalesData {
  SalesData(this.x, this.y);
  final String x;
  final int y;
  Color color;
}
