import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuts_app/models/info.dart';
import 'package:tuts_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userData = FirebaseFirestore.instance.collection('User');

  Future updateUserData(String name, String number, String address, int gender, int function, String urlAvatar,
      String lastMessageTime, List<dynamic> faculty, List<dynamic> courses) async {
    return await userData.doc(uid).set({
      'Name' : name,
      'Phone Number' : number,
      'Address' : address,
      'Gender' : gender,
      'Function' : function,
      'Faculty' : faculty,
      'Courses' : courses,
      'urlAvatar': urlAvatar,
      'lastMessageTime': lastMessageTime,
    });
  }

  //User data from snapshot
  MainUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MainUser(
        uid: uid,
        name: snapshot['Name'],
        number: snapshot['Phone Number'],
        address: snapshot['Address'],
        gender: snapshot['Gender'],
        function: snapshot['Function'],
        faculty: snapshot['Faculty'],
        courses: snapshot['Courses'],
        urlAvatar: snapshot['urlAvatar'],
        lastMessageTime: snapshot['lastMessageTime']);
  }

  //List from snapshot
  List<Info> _infoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Info(
          name: doc.data().toString().contains('Name') ? doc.get('Name') : '',
          number: doc.data().toString().contains('Phone Number') ? doc.get('Phone Number') : '',
          address: doc.data().toString().contains('Address') ? doc.get('Address') : '',
          gender: doc.data().toString().contains('Gender') ? doc.get('Gender') : 0,
          function: doc.data().toString().contains('Function') ? doc.get('Function') : 0,
          faculty: doc.data().toString().contains('Faculty') ? doc.get('Faculty') : [],
          courses: doc.data().toString().contains('Courses') ? doc.get('Courses') : [],
          lastMessageTime: doc.data().toString().contains('lastMessageTime') ? doc.get('lastMessageTime') : '',
          urlAvatar: doc.data().toString().contains('urlAvatar') ? doc.get('urlAvatar') : '',
      );
    }).toList();
  }

  //Get Streams
  Stream<List<Info>> get users {
    return userData.snapshots().map(_infoFromSnapshot);
  }

  Stream<MainUser> get oneUser {
    return userData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}