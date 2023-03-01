class UserListItemModel {
  final String uid;
  final bool hasAvatar;
  final String name;

  UserListItemModel({
    required this.uid,
    required this.hasAvatar,
    required this.name,
  });

  UserListItemModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        hasAvatar = json["hasAvatar"],
        name = json["name"];
}
