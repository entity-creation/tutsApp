import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/services/utils.dart';
import '../models/message.dart';
import 'package:tuts_app/data.dart';

class FirebaseApi {
  static Stream<List<MainUser>> getUsers() => FirebaseFirestore.instance
      .collection('user')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(MainUser.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      uid: myId,
      urlAvatar: myUrlAvatar,
      name: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
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
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(uid: userDoc.id,
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