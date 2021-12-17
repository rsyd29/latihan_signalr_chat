import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:latihan_signalr_chat/model/message_model.dart';
import 'package:signalr_core/signalr_core.dart';

class HomeController extends GetxController {
  late TextEditingController chatController;
  late HubConnection connection;

  var chatMessage = <MessageModel>[].obs;

  Future<void> startConnection() async {
    await recreateConnection();
    print('Connection Started');
  }

  Future recreateConnection() async {
    print('HomeController.startConnection');

    connection = HubConnectionBuilder()
        .withUrl(
          'http://10.0.2.2:5000/chatHub',
          HttpConnectionOptions(
            skipNegotiation: true,
            transport: HttpTransportType.webSockets,
            client: IOClient(
                HttpClient()..badCertificateCallback = (x, y, z) => true),
            logging: (level, message) => print('$level: $message'),
          ),
        )
        .build();

    connection.onclose((exception) async {
      await retryUntilSuccessfulConnection(exception);
    });

    connection.on('ReceiveMessage', (arguments) {
      print(arguments.toString());
    });

    await connection.start();
  }

  Future retryUntilSuccessfulConnection(Exception? exception) async {
    while (true) {
      var delayTime = Random().nextInt(20);
      await Future.delayed(Duration(seconds: delayTime));

      try {
        await recreateConnection();

        if (connection.state == HubConnectionState.connected) {
          update();
          return;
        }
      } catch (e) {
        print('Exception here :( ${e.toString()}');
      } finally {
        print('finally:');
      }
    }
  }

  void sendMessage(String text) async {
    if (text.isNotEmpty) {
      var messageJson = {
        "message": text,
        "sentByMe": connection.connectionId,
        "date": DateTime.now().toIso8601String(),
      };

      await connection.invoke(
        'SendMessage',
        args: [messageJson],
      );

      chatMessage.add(MessageModel.fromJson(messageJson));
    }
    chatController.clear();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    chatController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    chatController.dispose();
    super.dispose();
  }
}
