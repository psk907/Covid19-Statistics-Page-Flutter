import '/apicovid19_main.dart';
import 'package:flutter/material.dart';

class DataTableExample extends StatefulWidget {
  List<StateWiseReport> perstatereport;
  DataTableExample({Key key, this.perstatereport}) : super(key: key);

  @override
  _DataTableExampleState createState() =>
      _DataTableExampleState(perstatereport: perstatereport);
}

class _DataTableExampleState extends State<DataTableExample> {
  List<StateWiseReport> perstatereport;

  _DataTableExampleState({this.perstatereport});
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return (perstatereport == null)
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: PaginatedDataTable(
              columnSpacing: 2.0,
              header: Container(alignment: Alignment.center,
                                         
                      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 5.0),
                      child: Text("STATEWISE DATA",style: TextStyle(fontFamily: 'Archia',fontSize: 18),),
                  ),
              
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: <int>[5, 10, 20],
              onRowsPerPageChanged: (int value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              columns: kTableColumns,
              source: DessertDataSource(desserts: perstatereport),
            ),
          );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: const Text('State',style: TextStyle(fontSize: 16),),
    
  ),
  DataColumn(
    label: const Text('Total Cases',style: TextStyle(fontSize: 16),),
    tooltip: 'The total number of cases registered as positive so far',
    numeric: true,
  ),
  
  /*DataColumn(
    label: const Text('New Cases Registered today',style: TextStyle(fontSize: 16),),
    numeric: true,
  ),*/
  DataColumn(
    label: const Text('Total Deaths',style: TextStyle(fontSize: 16),),
    numeric: true,
  ),
 /* DataColumn(
    label: const Text('New Deaths today'),
    numeric: true,
  ),*/
  DataColumn(
    label: const Text('Total Recovered',style: TextStyle(fontSize: 16),),
    tooltip:
        'The number of patients discharged today',
    numeric: true,
  ),
  DataColumn(
    label: const Text('Active Cases',style: TextStyle(fontSize: 16),),
    tooltip: 'The total number of active cases at the moment',
    numeric: true,
  ),
  DataColumn(
    label: const Text('Last Updated Time',style: TextStyle(fontSize: 16),),
    numeric: true,
  ),
];

////// Data source class for obtaining row data for PaginatedDataTable.
class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;

  DessertDataSource({
    this.desserts,
  });
  List<StateWiseReport> desserts;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= desserts.length) return null;
    final StateWiseReport dessert = desserts[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${dessert.state}',style: TextStyle(color:Colors.grey[700],fontSize: 15),)),
      DataCell(
        RichText(
          text: TextSpan(
            text: dessert.deltaconfirmed > 0
                ? '(+${dessert.deltaconfirmed})'
                : '',
            style: TextStyle(color: Colors.red, fontSize: 11),
            children: <TextSpan>[
              TextSpan(
                text: '  ${dessert.confirmed}',
                style:
                    TextStyle(color: Colors.blueAccent, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
     
     // DataCell(Text('${dessert.deltaconfirmed}')),
      DataCell(RichText(
          text: TextSpan(
            text: dessert.deltadeaths > 0
                ? '(+${dessert.deltadeaths})'
                : '',
            style: TextStyle(color: Colors.redAccent, fontSize: 11),
            children: <TextSpan>[
              TextSpan(
                text: '  ${dessert.deaths}',
                style:
                    TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        ),),
     // DataCell(Text('${dessert.deltadeaths}')),
      DataCell(RichText(
          text: TextSpan(
            text: dessert.deltarecovered > 0
                ? '(+${dessert.deltarecovered})'
                : '',
            style: TextStyle(color: Colors.blueAccent, fontSize: 11),
            children: <TextSpan>[
              TextSpan(
                text: '  ${dessert.recovered}',
                style:
                    TextStyle(color: Colors.green, fontSize: 15),
              ),
            ],
          ),
        ),),
         DataCell(Text('${dessert.active}',style: TextStyle(color:Colors.grey[700],))),
      DataCell(Text('${dessert.lastupdatedtime}',style: TextStyle(color:Colors.grey[700],))),
    ]);
  }

  @override
  int get rowCount => desserts.length;

  @override
  bool get isRowCountApproximate => false;
  
  @override
  int get selectedRowCount => _selectedCount;
}
