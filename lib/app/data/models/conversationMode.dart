// ignore_for_file: file_names

class ConseverationModel {
  final String message;
  final String senderId;

  ConseverationModel({required this.message, required this.senderId});

  factory ConseverationModel.fromJson(Map<String, dynamic> data) {
    return ConseverationModel(message: data['message'], senderId: data['senderId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
    };
  }
}
