import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/services/utils.dart';
import '../models/message.dart';
import 'package:tuts_app/data.dart';

class FirebaseApi {
  static Stream<List<MainUser>> getUsers() => FirebaseFirestore.instance
      .collection('User')
      // .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(MainUser.fromJson));

  static Future uploadMessage(String idUser, String recUid, String username,
      String message, String imageUrl, DateTime dateSent) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      uid: idUser,
      recUid: recUid,
      urlAvatar: imageUrl,
      name: username,
      message: message,
      createdAt: dateSent,
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('User');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String uid) =>
      FirebaseFirestore.instance
          .collection('chats/$uid/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<MainUser> users) async {
    final refUsers = FirebaseFirestore.instance.collection('User');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(
            uid: userDoc.id,
            name: null as String,
            urlAvatar: null as String,
            lastMessageTime: null as dynamic,
            number: '',
            gender: null as int,
            address: '',
            function: null as int,
            courses: [],
            faculty: []);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
