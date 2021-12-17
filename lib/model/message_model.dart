class MessageModel {
  String message;
  String sentByMe;
  String date;

  MessageModel({
    required this.message,
    required this.sentByMe,
    required this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      sentByMe: json['sentByMe'],
      date: json['date'],
    );
  }
}
