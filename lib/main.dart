import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MaterialApp(home: PullToRefreshSample()));
}

class PullToRefreshSample extends StatefulWidget {
  const PullToRefreshSample({Key? key}) : super(key: key);

  @override
  _PullToRefreshSampleState createState() => _PullToRefreshSampleState();
}

EmployeeDataSource _employeeDataSource = EmployeeDataSource();
List<Employee> _employees = <Employee>[];
final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

class _PullToRefreshSampleState extends State<PullToRefreshSample> {
  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDataGrid(
        key: key,
        allowPullToRefresh: true,
        source: _employeeDataSource,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'ID',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'name',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Name',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'designation',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Designation',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'salary',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Salary',
                    overflow: TextOverflow.ellipsis,
                  ))),
        ],
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource() {
    buildDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 5));
    _addMoreRows(_employees, 15);
    buildDataGridRows();
    notifyListeners();
  }

  void buildDataGridRows() {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  void _addMoreRows(List<Employee> employees, int count) {
    final Random _random = Random();
    final startIndex = employees.isNotEmpty ? employees.length : 0,
        endIndex = startIndex + count;
    for (int i = startIndex; i < endIndex; i++) {
      employees.add(Employee(
        1000 + i,
        _names[_random.nextInt(_names.length - 1)],
        _designation[_random.nextInt(_designation.length - 1)],
        10000 + _random.nextInt(10000),
      ));
    }
  }

  final List<String> _names = <String>[
    'Welli',
    'Blonp',
    'Folko',
    'Furip',
    'Folig',
    'Picco',
    'Frans',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Seves',
    'Vaffe',
    'Alfki'
  ];

  final List<String> _designation = <String>[
    'Project Lead',
    'Developer',
    'Manager',
    'Designer',
    'System Analyst',
    'CEO'
  ];
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  int id;
  String name;
  String designation;
  int salary;
}

List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 10000),
    Employee(10005, 'Martin', 'Developer', 20000),
    Employee(10006, 'Newberry', 'Manager', 25000),
    Employee(10007, 'Balnc', 'Developer', 35000),
    Employee(10008, 'Perry', 'Designer', 45000),
    Employee(10009, 'Gable', 'Developer', 10000),
    Employee(10010, 'Grimes', 'Developer', 30000),
    Employee(10011, 'Grimes', 'Project Lead', 20000),
    Employee(10012, 'Gable', 'Manager', 30000),
    Employee(10013, 'Perry', 'Developer', 15000),
    Employee(10014, 'Balnc', 'Designer', 10000),
    Employee(10015, 'Newberry', 'Developer', 20000),
    Employee(10016, 'Martin', 'Developer', 25000),
    Employee(10017, 'Michael', 'Manager', 35000),
    Employee(10018, 'Lara', 'Developer', 45000),
    Employee(10019, 'Kathryn', 'Designer', 10000),
    Employee(10020, 'James', 'Lead', 30000)
  ];
}
