import 'package:flutter/material.dart';

class EdTableList extends StatefulWidget {
  @override
  _EdTableListState createState() => _EdTableListState();
}

class _EdTableListState extends State<EdTableList> {
  bool _selectAll = false;
  List<bool> _selectedRows = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
          columns: [
            DataColumn(
              label: Checkbox(
                value: _selectAll,
                onChanged: (bool? value) {
                  setState(() {
                    _selectAll = value!;
                    for (int i = 0; i < _selectedRows.length; i++) {
                      _selectedRows[i] = _selectAll;
                    }
                  });
                },
              ),
            ),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Especialidade")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Data de Cadastro")),
            DataColumn(label: Text("Actions")),
          ],
          rows: List<DataRow>.generate(
            10,
                (index) => DataRow(
              selected: _selectedRows[index],
              cells: [
                DataCell(Checkbox(
                  value: _selectedRows[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedRows[index] = value!;
                    });
                  },
                )),
                DataCell(Text("Nome $index")),
                DataCell(Text("Especialidade $index")),
                DataCell(Text("Email $index")),
                DataCell(Text("Data $index")),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete
                      },
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
    );
  }
}
