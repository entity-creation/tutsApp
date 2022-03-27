import 'package:flutter/material.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/pages/profile_page.dart';
import 'package:tuts_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/shared/loading.dart';

class CheckBoxState {
  final String title;
  bool val;

  CheckBoxState({
    required this.title,
    this.val = false,
  });
}

class DropDownItems {
  final String faculties;

  DropDownItems({
    required this.faculties,
  });
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final studies = [
    CheckBoxState(title: "Physics"),
    CheckBoxState(title: "Chemistry"),
    CheckBoxState(title: "Biology"),
  ];

  final List<String> dept = [
    "Software Engineering",
    "Computer Science",
    "Information Technology"
  ];
  String selFaculty = "Software Engineering";
  List listfaculty = [];

  DropDownItems? selectedFaculty;
  List<DropDownItems> facultyName = <DropDownItems>[
    DropDownItems(faculties: "Science"),
    DropDownItems(faculties: "Commerce"),
    DropDownItems(faculties: "Art"),
  ];

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  dynamic gender = 1;
  dynamic school = 1;
  dynamic userAvatar = ProfilePage().imageUrl;
  dynamic messageTime = DateTime.now();

  List<dynamic> faculty = ['Physics', 'Chemistry', 'Biology'];
  List<dynamic> courses = [];

  String? values;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    dynamic launcher = Provider.of<Tester?>(context);

    String naming = nameController.text;
    String numbering = numberController.text;
    String addressing = addressController.text;

    Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.orange,
        title: Text(checkbox.title),
        value: checkbox.val,
        onChanged: (value) {
          setState(() {
            checkbox.val = value!;
            if (checkbox.val) {
              courses.add(checkbox.title);
            }
          });
        });

    return StreamBuilder<MainUser>(
        stream: DatabaseService(uid: launcher.uid).oneUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MainUser? mainUser = snapshot.data;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.orange),
                  ),
                  leading: IconButton(
                    color: Colors.orange,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 4) {
                                return "Enter your name";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.perm_identity,
                                    color: Colors.orange),
                                labelText: 'Full Name',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.orange),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              const pattern =
                                  r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                              final regExp = RegExp(pattern);
                              if (value!.isEmpty || !regExp.hasMatch(value)) {
                                return "Enter valid phone number";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            controller: numberController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone,
                                    color: Colors.orange),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.orange),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Enter home address";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.streetAddress,
                            controller: addressController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.house,
                                    color: Colors.orange),
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.orange),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                          SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const Text(
                                'Gender',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    activeColor: Colors.orange,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 2,
                                    activeColor: Colors.orange,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const Text(
                                'Function',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    activeColor: Colors.orange,
                                    groupValue: school,
                                    onChanged: (value) {
                                      setState(() {
                                        school = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Teacher',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 2,
                                    activeColor: Colors.orange,
                                    groupValue: school,
                                    onChanged: (value) {
                                      setState(() {
                                        school = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Student',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 3,
                                    activeColor: Colors.orange,
                                    groupValue: school,
                                    onChanged: (value) {
                                      setState(() {
                                        school = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Admin',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          (mainUser!.function == 2)
                              ? Column(
                                  children: [
                                    Text(
                                      "Faculty",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.orange, width: 2)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: Text(dept[0]),
                                          value: selFaculty,
                                          onChanged: (String? newvalue) {
                                            setState(() {
                                              selFaculty = newvalue!;
                                              print("this is ${selFaculty}");
                                            });
                                          },
                                          items: dept
                                              .map<DropdownMenuItem<String>>(
                                                  (String myvalue) {
                                            return DropdownMenuItem(
                                                value: myvalue,
                                                child: Text(myvalue));
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Courses",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    ),
                                    ...studies
                                        .map(buildSingleCheckBox)
                                        .toList(),
                                  ],
                                )
                              : (mainUser.function == 1)
                                  ? Column(
                                      children: [
                                        ...studies
                                            .map(buildSingleCheckBox)
                                            .toList(),
                                      ],
                                    )
                                  : Text("Admin"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              primary: Colors.orange,
                            ),
                            onPressed: () async {
                              if (listfaculty.isEmpty) {
                                listfaculty.add(selFaculty);
                              } else {
                                listfaculty.clear();
                                listfaculty.add(selFaculty);
                              }

                              if (_formKey.currentState!.validate()) {
                                await DatabaseService(uid: launcher.uid)
                                    .updateUserData(
                                        launcher.uid,
                                        naming,
                                        numbering,
                                        addressing,
                                        gender,
                                        school,
                                        userAvatar,
                                        messageTime,
                                        listfaculty,
                                        courses);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
