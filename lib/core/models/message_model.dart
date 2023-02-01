class Message {
  String? message;
  String? contentType; //product, contact, url, text
  dynamic timeSent;
  String? senderId;
  String? receiverId;
  bool? read;
  Message(
      {this.contentType,
      this.message,
      this.read,
      this.receiverId,
      this.senderId,
      this.timeSent});
  toJson() {
    return {
      "message": message,
      "contentType": contentType,
      "timeSent": timeSent,
      "senderId": senderId,
      "receiverId": receiverId,
      "read": read
    };
  }
}
