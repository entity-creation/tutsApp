import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/models/user.dart';
import 'chat_page.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<MainUser> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: buildChats(),
      ),
    );
  }

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          String uid = Provider.of<Tester>(context).uid;
          if (users[index].uid != uid) {
            return Container(
              color: Colors.white,
              height: 75,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(user: user),
                  ));
                },
                leading: CircleAvatar(
                  radius: 25,
                  // child: FadeInImage(
                  //   image: NetworkImage(user.urlAvatar),
                  //   placeholder: AssetImage("images/default_profile.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                  backgroundImage: user.urlAvatar != "image"
                      ? NetworkImage(user.urlAvatar)
                      : AssetImage("images/default_profile.jpg")
                          as ImageProvider,
                ),
                title: Text(user.name),
              ),
            );
          }
          return Container();
        },
        itemCount: users.length,
      );
}
