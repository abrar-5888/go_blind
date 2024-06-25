import 'package:go_blind/app/data/models/conversationMode.dart';

class MessagesModels {
  String? firebaseKey;
  final String image;
  final List<ConseverationModel> message;
  final List<String> uids;
  final String lastMessage;
  final int timeStamp;
  final String senderId;

  MessagesModels({
    this.firebaseKey,
    required this.senderId,
    required this.image,
    required this.message,
    required this.uids,
    required this.lastMessage,
    required this.timeStamp,
  });

  factory MessagesModels.fromJson(String? key, Map<String, dynamic> json) {
    var messageList = (json['message'] as List<dynamic>).map((item) => ConseverationModel.fromJson(item)).toList();
    
    return MessagesModels(
      firebaseKey: key,
      image: json['image'] as String,
      message: messageList,
      uids: List<String>.from(json['uids']),
      lastMessage: json['lastMessage'] as String,
      timeStamp: json['timeStamp'] as int,
      senderId: json['senderId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'message': message.map((conversation) => conversation.toJson()).toList(),
      'uids': uids,
      'lastMessage': lastMessage,
      'timeStamp': timeStamp,
      'senderId': senderId,
    };
  }
}
