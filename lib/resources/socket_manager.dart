import 'package:soar_mobile/resources/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static late IO.Socket socket;

  static void connect() {
    socket = IO.io('http://192.168.73.88:4000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.onConnectError((data) {
      print('Connection error: $data');
    });

    socket.onConnectTimeout((data) {
      print('Connection timeout: $data');
    });

    socket.onError((error) {
      print('Error: $error');
    });
  }
}
