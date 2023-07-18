import 'package:flutter/material.dart';
import 'package:soar_mobile/models/warnings_model.dart';
import 'package:soar_mobile/resources/controller.dart';
import 'package:soar_mobile/resources/socket_manager.dart';
import 'package:soar_mobile/resources/styles_manager.dart';

class WarningsScreen extends StatefulWidget {
  const WarningsScreen({super.key});

  @override
  State<WarningsScreen> createState() => _WarningsScreenState();
}

class _WarningsScreenState extends State<WarningsScreen> {
  // SocketManager socketManager = SocketManager();
  bool isLoading = false;
  void fetchWarnings() async {
    isLoading = true;
    setState(() {});

    warnings = await Controller.fetchWarnings();
    warnings = warnings!.reversed.toList();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchWarnings();
    // socketManager.connect();

    SocketManager.socket.on(
      'warning',
      (data) {
        setState(() {
          warnings!.insert(0, WarningsModel.fromMap(data));
        });
      },
    );
  }

  List<WarningsModel>? warnings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Builder(
            // future: Controller.fetchWarnings(),
            builder: (
          context,
        ) {
          if ((isLoading) && (warnings != null)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (warnings!.isEmpty) {
            return Center(
              child: Text(
                'There are no warnings!',
                style: getMediumStyle(
                  fontSize: 14.0,
                  color: Colors.black45,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: DataTable(
              columnSpacing: 20,
              columns: [
                DataColumn(
                  label: Text(
                    'ID',
                    style: getBoldStyle(),
                  ),
                ),
                DataColumn(
                    label: Text(
                  'Protocol',
                  style: getBoldStyle(),
                )),
                DataColumn(
                    label: Text(
                  'Description',
                  style: getBoldStyle(),
                )),
                DataColumn(
                    label: Text(
                  'Time',
                  style: getBoldStyle(),
                )),
                DataColumn(
                    label: Text(
                  'Status',
                  style: getBoldStyle(),
                )),
              ],
              rows: List<DataRow>.generate(
                warnings!.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(warnings![index].protocol)),
                    DataCell(Text(warnings![index].description)),
                    DataCell(Text(warnings![index].date.time)),
                    DataCell(
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: (warnings![index].status == 'not seen')
                              ? Colors.red
                              : Colors.green,
                        ),
                        child: Text(
                          warnings![index].status,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
