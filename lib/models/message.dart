


import 'package:isar/isar.dart';

part 'message.g.dart';
@Collection()
// van la 1 class thong thuong
class Message{
  Id id = Isar.autoIncrement; // .autoIncrement chi bao cho isar biet rang, hay tu tao id tu dong
  late String uuid ;
  late String content ;
  late String friendId;
  late int type ;
  late String link ;
  late int messageType;
  @Index() // de co the sort theo lastime
  late String lastTime;
}