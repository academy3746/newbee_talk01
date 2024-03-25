class ChatRoomModel {
  final int? idx;

  final List<String> membersUid;

  final DateTime? createdAt;

  ChatRoomModel({
    this.idx,
    required this.membersUid,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'members_uid': membersUid,
    };
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> data) {
    return ChatRoomModel(
      idx: data['idx'],
      membersUid: List<String>.from(data['members_uid']),
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
