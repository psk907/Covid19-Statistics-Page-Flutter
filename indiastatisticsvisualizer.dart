import 'dart:ffi';
//import 'dart:html';
import 'package:covid19/components/counter.dart';
import 'package:covid19/components/statestable.dart';
import 'package:covid19/components/totalcasesgraph.dart';

import 'package:covid19/models/apicovid19_main.dart';
import 'package:covid19/models/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndiaStatisticsPage extends StatefulWidget {
  IndiaStatisticsPage({Key key}) : super(key: key);

  @override
  _IndiaStatisticsPage createState() => _IndiaStatisticsPage();
}

class _IndiaStatisticsPage extends State<IndiaStatisticsPage> {
  final String apiUrl = 'https://api.covid19india.org/data.json';
  List<DailyReport> DaywiseData; //Country daily reports
  List<StateWiseReport> StatesData; //Statewise data

  Future<Void> get fetchOverallData async {
    final response = await http.get(apiUrl);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final resp = json.decode(response.body);

        //Countrydata
        List<dynamic> dailystats = resp['cases_time_series'] ??
            {
              {'error': 'yes'}
            };

        this.DaywiseData = dailystats
            .map((dailyjson) => DailyReport.fromJson(dailyjson))
            .toList();

        //adding date stamp
        for (int i = 0; i < DaywiseData?.length ?? 0; i++) {
          DaywiseData[i].date =
              DateTime(2020, 1, 31).add(new Duration(days: i));
        }

        List<dynamic> statestats = resp['statewise'] ??
            {
              {'error': 'yes'}
            };

        this.StatesData = statestats
            .map((statestats) => StateWiseReport.fromJson(statestats))
            .toList();

        print(StatesData.length);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOverallData;
  }

  Center notLoadedScreen = new Center(
    child: CircularProgressIndicator(),
  );

  Card numbertile(String titleh, int numberc) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.white,
        elevation: 0.5,
        child: ListTile(
          title: Text(titleh ?? 'na'),
          subtitle: Text('${numberc ?? 0}'),
        ));
  }

  Center daywiselist() => Center(
        child: ListView.builder(
          itemCount: DaywiseData?.length ?? 0,
          reverse: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('${DaywiseData[index].date}'),
            );
          },
        ),
      );

  SliverToBoxAdapter heading(String heading, {int fsize = 18}) =>
      SliverToBoxAdapter(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
            child: Text(
              "$heading",
              style:
                  TextStyle(fontFamily: 'Archia', fontSize: fsize.toDouble()),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {

        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
        Color dynamicbgcolor =
        (!isDarkMode) ? Colors.grey[200] : Colors.black;
    return Scaffold(
      backgroundColor: dynamicbgcolor ,
      /* appBar: AppBar(
        

        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation: 0.1,
        title: Text("STATISTICS", style: TextStyle(color: Colors.black87,fontFamily: 'Archia')),

        

        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.black87,
        ),
      ),*/
      body: (DaywiseData == null)
          ? notLoadedScreen
          //:daywiselist,
          : SafeArea(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  heading('TIMELINE', fsize: 18),
                  SliverToBoxAdapter(
                    child: chart2(
                      totalcasesdata:
                          DaywiseData ?? DailyReport(0, 0, 0, 0, 0, 0),
                    ),
                  ),
                  heading('OVERVIEW'),
                  SliverGrid.count(
                    crossAxisCount: 3,
                    //childAspectRatio: 2.0,
                    crossAxisSpacing: 1.4,
                    mainAxisSpacing: 2.0,
                    children: <Widget>[
                      // numbertile('Total Cases',DaywiseData.last.totalconfirmed),
                      Counter(
                        color: kInfectedColor,
                        number: DaywiseData.last.totalconfirmed,
                        delta: DaywiseData.last.dailyconfirmed,
                        title: "Cases",
                      ),
                      //numbertile('New Cases today',DaywiseData.last.dailyconfirmed),
                      //numbertile('Total Deaths',DaywiseData.last.totaldeceased),
                      Counter(
                        color: kDeathColor,
                        number: DaywiseData.last.totaldeceased,
                        delta: DaywiseData.last.dailydeceased,
                        title: "Deaths",
                      ),
                      //numbertile('Deaths today',DaywiseData.last.dailydeceased),
                      Counter(
                        color: kRecovercolor,
                        number: DaywiseData.last.totalrecovered,
                        delta: DaywiseData.last.dailyrecovered,
                        title: "Recoveries",
                      ),
                    ],
                  ),
                  heading('', fsize: 1),
                  SliverToBoxAdapter(
                    child: DataTableExample(
                      perstatereport: StatesData,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
