import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/api/firebase_api.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/pages/profile_page.dart';

class NewMessageWidget extends StatefulWidget {
  final String uid;
  final String username;

  const NewMessageWidget({
    required this.uid,
    required this.username,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  String uid = "";
  String url = ProfilePage().imageUrl;
  String groupId = "";

  void sendMessage(String senderUid, String receiverUid, String username,
      String message, String imageUrl, DateTime dateSent) async {
    FocusScope.of(context).unfocus();
    if (senderUid.hashCode <= receiverUid.hashCode) {
      groupId = "$senderUid-$receiverUid";
    } else {
      groupId = "$receiverUid-$senderUid";
    }

    await FirebaseApi.uploadMessage(
        groupId, senderUid, receiverUid, username, message, imageUrl, dateSent);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    dynamic launcher = Provider.of<Tester>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              cursorColor: Colors.orange,
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.orange),
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message',
                labelStyle: TextStyle(color: Colors.orange),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              message.trim().isEmpty
                  ? null
                  : sendMessage(launcher.uid, widget.uid, widget.username,
                      message, url, DateTime.now());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
