

import 'package:isar/isar.dart';
part 'synced_friend.g.dart';


@Collection()
class SyncedFriend{
  Id id = Isar.autoIncrement;

  @Index(unique : true)
  late String friendId;
  late DateTime syncedAt;
}