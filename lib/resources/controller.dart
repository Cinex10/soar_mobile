import 'dart:convert';
import 'package:soar_mobile/models/attack_data.dart';
import 'package:soar_mobile/models/incident_model.dart';
import 'package:soar_mobile/models/warnings_model.dart';
import 'package:soar_mobile/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Controller {
  static Future<bool> login(String email, String password) async {
    final resp = await http.get(
      Uri.parse('$host/login?email=$email&password=$password'),
    );
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      // print(json);
      // print(json['fullname']);
      if (json['fullname'] != 'None') {
        return true;
      }
    }
    return false;
  }

  static Future<List<IncidentModel>?> fetchIncidents() async {
    final resp = await http.get(
      Uri.parse('$host/incedent'),
    );
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      // print(json);
      List<IncidentModel> incedents =
          (json as List).map((model) => IncidentModel.fromMap(model)).toList();
      return incedents;
    }
    return null;
  }

  static Future<List<WarningsModel>?> fetchWarnings() async {
    final resp = await http.get(
      Uri.parse('$host/warning'),
    );
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      // print(json);
      List<WarningsModel> warnings =
          (json as List).map((model) => WarningsModel.fromMap(model)).toList();
      return warnings;
    }
    return null;
  }

  //TODO :devices

  static void createSocketClient() {
    IO.Socket socket = IO.io('$host');

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.on('getDevicesStatus', (data) {
      print('Received message: $data');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  static Future<Map<String, List<AttackData>>?> fetchStat() async {
    // print('ee');
    final resp = await http.get(
      Uri.parse('$host/stat'),
    );
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      print((json[1] as List).length);

      List<AttackData> attacks = List.generate(
        (json[1] as List).length,
        (index) => AttackData(
          months[int.parse(json[1][index]['month']) - 1],
          json[1][index]['pv'],
        ),
      );
      List<AttackData> protocols = List.generate((json[0][0] as List).length,
          (index) => AttackData(json[0][0][index], json[0][1][index]));
      // print(json);
      return {
        'attacks': attacks,
        'protocols': protocols,
      };
    }
    return null;
  }
}
