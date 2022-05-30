class Message {
  String message;
  String senderId;
  DateTime sentTime;

  Message(
      {required this.message, required this.senderId, required this.sentTime});

  factory Message.formJson(Map<String, dynamic> json) {
    return Message(
      message: json["message"],
      senderId: json["sentByMe"],
      sentTime: DateTime.parse(json["sentTime"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "sentByMe": senderId == null ? null : senderId,
        "sentTime": sentTime == null ? null : sentTime.toIso8601String(),
      };
}
