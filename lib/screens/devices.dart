import 'package:flutter/material.dart';
import 'package:soar_mobile/models/device_model.dart';
import 'package:soar_mobile/resources/socket_manager.dart';
import 'package:soar_mobile/resources/styles_manager.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  // SocketManager socketManager = SocketManager();

  bool isLoading = true;

  List<DeviceModel> routers = [];
  List<DeviceModel> switchs = [];
  List<DeviceModel> firewalls = [];
  List<DeviceModel> servers = [];

  @override
  void initState() {
    super.initState();
    // Connect to the socket when the widget is initialized
    SocketManager.connect();
    // Set the callback function to update the UI when a message is received
    SocketManager.socket.emit('getDevices', 'b3at b3at');
    SocketManager.socket.on('getDevicesStatus', (data) {
      print(data);
      bool isExisted = false;
      print('object');
      switch (data['type']) {
        case 'router':
          for (DeviceModel device in routers) {
            if (device.name == data['name']) {
              isExisted = true;
              device = DeviceModel.fromMap(data);
              break;
            }
          }

          if (!isExisted) {
            routers.add(DeviceModel.fromMap(data));
          }

          break;
        case 'switch':
          for (DeviceModel device in switchs) {
            if (device.name == data['name']) {
              isExisted = true;
              device = DeviceModel.fromMap(data);
              break;
            }
          }

          if (!isExisted) {
            switchs.add(DeviceModel.fromMap(data));
          }

          break;
        case 'firewall':
          for (DeviceModel device in firewalls) {
            if (device.name == data['name']) {
              isExisted = true;
              device = DeviceModel.fromMap(data);
              break;
            }
          }

          if (!isExisted) {
            firewalls.add(DeviceModel.fromMap(data));
          }

          break;
        case 'server':
          for (DeviceModel device in servers) {
            if (device.name == data['name']) {
              isExisted = true;
              device = DeviceModel.fromMap(data);
              break;
            }
          }

          if (!isExisted) {
            servers.add(DeviceModel.fromMap(data));
          }

          break;
        default:
      }
      setState(() {});
    });

    SocketManager.socket.on(
      'getDevicesStatus-finish',
      (data) {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Column(
            children: [
              if (isLoading) LinearProgressIndicator(),
              TabBar(
                // bottom: TabBar(
                tabs: [
                  Tab(text: 'Routers', icon: Icon(Icons.router)),
                  Tab(
                    text: 'Switches',
                    icon: Icon(Icons.swap_horizontal_circle_sharp),
                  ),
                  Tab(
                    text: 'Firewalls',
                    icon: Icon(Icons.security),
                  ),
                  Tab(
                    text: 'Servers',
                    icon: Icon(Icons.computer),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DevicesTable(
              devices: routers,
            ),
            DevicesTable(
              devices: switchs,
            ),
            DevicesTable(
              devices: firewalls,
            ),
            DevicesTable(
              devices: servers,
            ),
          ],
        ),
      ),
    );
  }
}

class DevicesTable extends StatelessWidget {
  const DevicesTable({required this.devices, super.key});

  final List<DeviceModel> devices;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 40,
          columns: [
            DataColumn(
              label: Text(
                'ID',
                style: getBoldStyle(),
              ),
            ),
            DataColumn(
                label: Text(
              'Name',
              style: getBoldStyle(),
            )),
            DataColumn(
                label: Text(
              'IP Address',
              style: getBoldStyle(),
            )),
            DataColumn(
                label: Text(
              'Status',
              style: getBoldStyle(),
            )),
          ],
          rows: List<DataRow>.generate(
            devices.length,
            (index) => DataRow(
              cells: [
                DataCell(Text(index.toString())),
                DataCell(Text(devices[index].name)),
                DataCell(Text(devices[index].ip)),
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: (devices[index].status == 'down')
                          ? Colors.red
                          : Colors.green,
                    ),
                    child: Text(
                      devices[index].status,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
