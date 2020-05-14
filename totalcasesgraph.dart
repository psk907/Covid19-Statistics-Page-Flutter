import 'package:covid19/models/apicovid19_main.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesSimple {
  final DateTime time;
  final int item;

  TimeSeriesSimple(
    this.item,
    this.time,
  );
}

class chart2 extends StatefulWidget {
  List<DailyReport> totalcasesdata;
  chart2({Key key, this.totalcasesdata}) : super(key: key);

  @override
  _chart2State createState() => _chart2State(
      totalcasesdata: totalcasesdata ?? [DailyReport(0, 0, 0, 0, 0, 0)]);
}

class _chart2State extends State<chart2> {
  List<DailyReport> totalcasesdata;
  int zoomfactor = 14;
  List<charts.Series> seriesList;
  Function(DateTime) onItemClicked;
  List<charts.Series<TimeSeriesSimple, DateTime>> _createSampleData() {
    List<TimeSeriesSimple> datapoints = generatePoints();
    return [
      charts.Series<TimeSeriesSimple, DateTime>(
        id: 'Total Cases',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (TimeSeriesSimple data, _) => data.time,
        measureFn: (TimeSeriesSimple data, _) => data.item,
        data: datapoints,
        seriesCategory: 'Cases',
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }

  /*factory chart2.withSampleData() {
    return new chart2(

        // Disable animations for image tests.

        );
  }*/
  _chart2State({
    this.totalcasesdata,
    //this.seriesList,
  });
  List<TimeSeriesSimple> generatePoints() {
    List<TimeSeriesSimple> datapointscreate = new List();
    for (int i = totalcasesdata?.length - 18??0;
        i < totalcasesdata?.length ?? 0;
        i++) {
      datapointscreate.add(TimeSeriesSimple(
          totalcasesdata[i].totalconfirmed, totalcasesdata[i].date));
    }
    return datapointscreate;
  }

  _onSelectionChanged(charts.SelectionModel<DateTime> model) {
    onItemClicked(model.selectedDatum.first.datum.time);
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
 bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
        Color dynamicbgcolor =
        (!isDarkMode) ? Colors.grey[200] : Colors.black;
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(5, 28, 0, 28),
              decoration: BoxDecoration(
                  color: dynamicuicolor,
                  borderRadius: BorderRadius.circular(20.0)),
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width * 0.95,
              child: charts.TimeSeriesChart(seriesList,
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: _onSelectionChanged)
                  ],
                  customSeriesRenderers: [
                    new charts.LineRendererConfig(
                      //includePoints: true,
                      areaOpacity: 0.5,
includePoints: true,
                      customRendererId: 'customArea',
                      includeArea:(isDarkMode)?false: true,
                    ),
                  ])),
        ],
      );
    });
  }
}
