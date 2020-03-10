import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warnakaltim/src/model/chartModel.dart';

//code never lies

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
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
                                      Container(
                                          child: SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                  title:
                                                      AxisTitle(text: 'Tahun')),
                                              primaryYAxis: NumericAxis(
                                                  title:
                                                      AxisTitle(text: 'QTY')),
                                              series: <ChartSeries>[
                                            ColumnSeries<SalesData, String>(
                                                dataSource: _listChart.listChart
                                                    .map((i) => SalesData(
                                                        i.date
                                                            .toString(),
                                                        i.quantity))
                                                    .toList(),
                                                dataLabelSettings:
                                                    DataLabelSettings(
                                                        isVisible: true,
                                                        labelPosition:
                                                            ChartDataLabelPosition
                                                                .inside),
                                                xValueMapper:
                                                    (SalesData sales, _) =>
                                                        sales.x,
                                                yValueMapper:
                                                    (SalesData sales, _) =>
                                                        sales.y)
                                          ])),
                                      Container(
                                          child: SfCartesianChart(
                                              // Initialize category axis
                                              primaryXAxis: CategoryAxis(
                                                  title:
                                                      AxisTitle(text: 'Tahun')),
                                              primaryYAxis: NumericAxis(
                                                  title:
                                                      AxisTitle(text: 'Revenue')),
                                              series: <ChartSeries>[
                                            ColumnSeries<SalesData, String>(
                                                // Bind data source

                                                dataSource: _listChart.listChart
                                                    .map((i) => SalesData(
                                                        i.date
                                                            .toString(),
                                                        i.total))
                                                    .toList(),
                                                dataLabelSettings:
                                                    DataLabelSettings(
                                                        isVisible: true,
                                                        labelPosition:
                                                            ChartDataLabelPosition
                                                                .inside),
                                                xValueMapper:
                                                    (SalesData sales, _) =>
                                                        sales.x,
                                                yValueMapper:
                                                    (SalesData sales, _) =>
                                                        sales.y)
                                          ]))
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
}
