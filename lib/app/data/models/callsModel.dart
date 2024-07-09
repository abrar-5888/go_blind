// ignore_for_file: file_names

class CallsModel {
  final String name;
  final String senderId;
  final String image;
  final List<String> uids;
  final String status;
  final String roomName;

  CallsModel({required this.roomName, required this.senderId, required this.status, required this.image, required this.name, required this.uids});

  factory CallsModel.fromJson(Map<String, dynamic> json) {
    return CallsModel(
      roomName: json['roomName'],
      name: json['name'],
      image: json['image'],
      senderId: json['senderId'],
      uids: List<String>.from(json['uids']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'status': status,
      'senderId': senderId,
      'name': name,
      'image': image,
      'uids': uids,
    };
  }
}
