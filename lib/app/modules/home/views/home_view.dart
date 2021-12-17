import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latihan_signalr_chat/app/routes/app_pages.dart';
import 'package:latihan_signalr_chat/constant.dart';
import 'package:signalr_core/signalr_core.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Obx(() {
                print("data ada berapa? ${controller.chatMessage.length}");
                return ListView.builder(
                  itemCount: controller.chatMessage.length,
                  itemBuilder: (context, index) {
                    var currentItem = controller.chatMessage[index];
                    // return SizedBox();
                    return MessageItem(
                      // sentByMe: currentItem.sentByMe ==
                      //     controller.hubConnection.connectionId,
                      message: currentItem.message,
                      // date: currentItem.date,
                    );
                  },
                );
              }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: blue,
                  controller: controller.chatController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.sendMessage(
                              controller.chatController.text.trim());
                          print(
                              "Keyboard: ${controller.chatController.text.trim()}");
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    // required this.sentByMe,
    required this.message,
    // required this.date,
  }) : super(key: key);

  // final bool sentByMe;
  final String message;

  // final String date;

  @override
  Widget build(BuildContext context) {
    // var parseDate = DateTime.parse(date);
    return Align(
      // alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          // color: sentByMe ? blue : white,
          color: blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                // color: sentByMe ? white : blue,
                color: white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              // DateFormat.jm().format(parseDate),
              '10:10 PM',
              style: TextStyle(
                fontSize: 10,
                // color: (sentByMe ? white : blue).withOpacity(0.7),
                color: white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
