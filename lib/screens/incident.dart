import 'package:flutter/material.dart';
import 'package:soar_mobile/models/incident_model.dart';
import 'package:soar_mobile/models/warnings_model.dart';
import 'package:soar_mobile/resources/controller.dart';
import 'package:soar_mobile/resources/socket_manager.dart';
import 'package:soar_mobile/resources/styles_manager.dart';
import 'package:intl/intl.dart';

class IncidentScreen extends StatefulWidget {
  const IncidentScreen({super.key});

  @override
  State<IncidentScreen> createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  // SocketManager socketManager = SocketManager();

  bool isLoading = false;
  void fetchIncidents() async {
    isLoading = true;
    setState(() {});

    incidents = await Controller.fetchIncidents();
    incidents = incidents!.reversed.toList();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchIncidents();
    // socketManager.connect();

    SocketManager.socket.on(
      'incedent',
      (data) {
        setState(() {
          incidents!.insert(0, IncidentModel.fromMap(data));
        });
      },
    );
  }

  List<IncidentModel>? incidents = [];

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
          if ((isLoading) && (incidents != null)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (incidents!.isEmpty) {
            return Center(
              child: Text(
                'There are no incedents!',
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
                incidents!.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(incidents![index].protocol)),
                    DataCell(Text(incidents![index].description)),
                    DataCell(Text(DateFormat('dd MMM y')
                        .format(incidents![index].date.toDateTime()))),
                    DataCell(Text(incidents![index].date.time)),
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
