import 'package:isar/isar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/constants.dart';
import 'package:untitled/models/synced_friend.dart';


// Trien khai Singleton tron dart

class IsarServices{
  static late IsarServices instance;

  static void init(String username) {
    instance = IsarServices._internal(username);
  }
  late Future<Isar> db;
  // Future<Isar> : chua co ngay lap tuc, ma se co trong tuong lai
  // Isar chinh la 1 connection toi database

  String username;
  IsarServices._internal(this.username){
    // Ham khoi tao, khong duoc phep co async
    // ngan chan nguoi ngoai goi IsarServices, tao nhieu ket noi voi database
    db = _initIsar();
  }

  Future<Isar> _initIsar() async {

    final dir = await getApplicationDocumentsDirectory();
    AppUrl.path = dir.path;
    // khoi tao luon các thu muc
    final Directory pathImages = Directory('${AppUrl.path}/${username}/images');
    AppUrl.pathImages = '${AppUrl.path}/${username}/images';
    final Directory pathFiles = Directory('${AppUrl.path}/${username}/files');
    AppUrl.pathFiles = '${AppUrl.path}/${username}/files';

    final Directory pathAvatar = Directory('${AppUrl.path}/${username}/images/avatars');
    AppUrl.pathAvatars = '${AppUrl.path}/${username}/images/avatars';
    if ( ! await pathAvatar.exists() ) {
      // Neu khong phai tai khoan truoc do, xoa toan bo ?
      // khong xoa toan bo, ke no
      await pathAvatar.create(recursive : true);
    }
    if ( ! await pathFiles.exists() ) {
      // Neu khong phai tai khoan truoc do, xoa toan bo ?
      // khong xoa toan bo, ke no
      await pathFiles.create(recursive : true);
    }
    return await Isar.open([MessageSchema, SyncedFriendSchema], directory: '${dir.path}/${username}'); // open nay se tra ve 1 connection
  }

  Future<void> saveMessage(Message msg) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // isar.writeTxn() là cách Isar đảm bảo tính toàn vẹn dữ liệu (data integrity) khi ghi dữ liệu.
      // Mọi thao tác ghi (write) như put(), delete(), clear() đều phải nằm trong một writeTxn().
      await isar.messages.put(msg); // dua vao trong local database
    });
  }

  Future<List<Message>> getMessages(String FriendID) async {
    final isar = await db;
    return await isar.messages
        .filter()
        .friendIdEqualTo(FriendID)
        .sortBySaveTime()
        .findAll();
  }
  Future<SyncedFriend?> checkSynced(String friendId) async {
    final isar = await db;
    return await isar.syncedFriends
        .filter()
        .friendIdEqualTo(friendId)
        .findFirst();
  }

  // Truy van list database
  Future<void> updateSynced(SyncedFriend sf) async {
    final isar = await db;
    await isar.writeTxn( () async  {
      await isar.syncedFriends.put(sf);
    });
  }
}
