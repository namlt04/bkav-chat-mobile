class User{
  String username;
  String friendId;
  String? Fullname;
  String content;
  String? avatar;
  bool isOnline;
  User({required this.username,required this.friendId,required this.content , required this.isOnline  ,this.Fullname, this.avatar});
}