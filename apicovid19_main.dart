


class DailyReport {
  final int dailyconfirmed;
  final int dailydeceased;
  final int dailyrecovered;
  final int totalconfirmed;
  final int totaldeceased;
  final int totalrecovered;
   DateTime date;

  DailyReport(
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
    
  );

  factory DailyReport.fromJson(dynamic json){
  return DailyReport(
    int.parse(json['dailyconfirmed']) as int,
    int.parse(json['dailydeceased']) as int,
     int.parse(json['dailyrecovered']) as int,
     int.parse(json['totalconfirmed']) as int,
    int.parse(json['totaldeceased']) as int,
     int.parse(json['totalrecovered']) as int,
    //json['date'],
    
  );
}
/*
@override
String toString() {
    // TODO: implement toString
    return '{${this.dailyconfirmed},${this.dailydeceased},${this.dailyrecovered},${this.totalconfirmed},${this.totaldeceased},${this.totalrecovered}}';

  }
*/
}

class StateWiseReport {
  final int active;

  final int confirmed;

  final int deaths;

  final int deltaconfirmed;

  final int deltadeaths;

  final int deltarecovered;

  final String lastupdatedtime;

  final int recovered;

  final String state;

  final String statecode;

  StateWiseReport(
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.recovered,
    this.state,
    this.statecode,
  );

  
  factory StateWiseReport.fromJson(Map<String, dynamic> json){
  return StateWiseReport(
    int.parse(json['active']),
    int.parse(json['confirmed']),
    int.parse(json['deaths']),
    int.parse(json['deltaconfirmed']),
    int.parse(json['deltadeaths']),
    int.parse(json['deltarecovered']),
    json['lastupdatedtime'],
    int.parse(json['recovered']),
    json['state'],
    json['statecode'],
  );
}
}

class TestReport {
  final int positivecasesfromsamplesreported;
  final int samplereportedtoday;
  final String source;
  final int testsconductedbyprivatelabs;
  final int totalindividualstested;
  final int totalpositivecases;
  final int totalsamplestested;
  final DateTime updatetimestamp;

  TestReport({
    this.positivecasesfromsamplesreported,
    this.samplereportedtoday,
    this.source,
    this.testsconductedbyprivatelabs,
    this.totalindividualstested,
    this.totalpositivecases,
    this.totalsamplestested,
    this.updatetimestamp,
  });
}
