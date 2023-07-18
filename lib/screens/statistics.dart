import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:soar_mobile/models/attack_data.dart';
import 'package:soar_mobile/resources/controller.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartsExample();
  }
}

class ChartsExample extends StatelessWidget {
  final List<AttackData> attackData = [
    AttackData('Jan', 20),
    AttackData('Feb', 15),
    AttackData('Mar', 10),
    AttackData('Apr', 5),
    AttackData('May', 12),
    AttackData('Jun', 8),
  ];

  final List<AttackData> protocolData = [
    AttackData('HTTP', 35),
    AttackData('FTP', 20),
    AttackData('SSH', 15),
    AttackData('SMTP', 10),
    AttackData('DNS', 5),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          // bottom: TabBar(
          tabs: [
            Tab(text: 'Monthly Attacks'),
            Tab(text: 'Protocol Attacks'),
          ],
        ),
        body: FutureBuilder(
            future: Controller.fetchStat(),
            builder: (context, snapshot) {
              // print(snapshot.data);
              return TabBarView(
                children: [
                  // Monthly Attacks Bar Chart
                  Center(
                    child: ((snapshot.connectionState ==
                                ConnectionState.done) &&
                            (snapshot.data != null))
                        ? Container(
                            padding: EdgeInsets.all(16.0),
                            child: charts.BarChart(
                              [
                                charts.Series<AttackData, String>(
                                  id: 'attacks',
                                  domainFn: (AttackData data, _) => data.value,
                                  measureFn: (AttackData data, _) =>
                                      data.attacks,
                                  data: snapshot.data!['attacks']!,
                                )
                              ],
                              animate: true,
                              vertical: false,
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),

                  // Protocol Attacks Pie Chart
                  Center(
                    child: ((snapshot.connectionState ==
                                ConnectionState.done) &&
                            (snapshot.data != null))
                        ? charts.PieChart<String>(
                            [
                              charts.Series<AttackData, String>(
                                id: 'attacks',
                                domainFn: (AttackData data, _) => data.value,
                                measureFn: (AttackData data, _) => data.attacks,
                                data: snapshot.data!['protocols']!,
                                labelAccessorFn: (AttackData data, _) =>
                                    '${data.value}: ${data.attacks}',
                              )
                            ],
                            defaultRenderer: charts.ArcRendererConfig(
                              arcWidth: 120,
                              arcRendererDecorators: [
                                charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.auto,
                                ),
                              ],
                            ),
                            behaviors: [
                              charts.DatumLegend(
                                position: charts.BehaviorPosition.bottom,
                                horizontalFirst: false,
                                desiredMaxColumns: 2,
                              ),
                            ],
                          )
                        : CircularProgressIndicator(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
