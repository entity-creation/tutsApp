import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/pages/edit_profile.dart';
import 'package:tuts_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/services/database.dart';
import 'package:tuts_app/shared/loading.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuts_app/shared/sharedPref.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  String Myurl = "";
  String get imageUrl => Myurl;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = "";

  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    instantiatePref().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> instantiatePref() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final launcher = Provider.of<Tester?>(context);
    dynamic database = DatabaseService(uid: launcher!.uid);
    uid = launcher.uid;
    SharedPref pref;

    List courses = [];

    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return StreamBuilder<MainUser>(
        stream: database.oneUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MainUser? mainUser = snapshot.data;
            String function = mainUser!.function.toString();
            String gender = mainUser.gender.toString();
            courses = mainUser.courses;
            if (function == '1') {
              function = 'Teacher';
            } else if (function == '2') {
              function = 'Student';
            } else {
              function = 'Admin';
            }
            if (gender == '1') {
              gender = 'Male';
            } else {
              gender = 'Female';
            }
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: bottom),
                            child: Stack(children: [
                              coverImage(),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: cameraIconOne(),
                              ),
                            ]),
                          ),
                          Positioned(
                              top: top,
                              child: Stack(children: [
                                profileImage(),
                                Positioned(
                                    bottom: 0,
                                    right: 4,
                                    child: cameraIconTwo()),
                              ])),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        mainUser.name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (gender == 'Male') ? maleIcon() : femaleIcon(),
                          SizedBox(width: 5),
                          Text(
                            gender,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        function,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10),
                          Text(
                            mainUser.number,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10),
                          Text(
                            mainUser.address,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text(
                        function + " Details",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      (function == 'Admin')
                          ? Column(
                              children: [
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: Colors.orange,
                                  ),
                                  label: Text('Add Faculty'),
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    _addDept();
                                  },
                                ),
                                SizedBox(height: 10),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: Colors.orange,
                                  ),
                                  label: Text('Add Course'),
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    _addCourse();
                                  },
                                ),
                              ],
                            )
                          : (function == 'Student')
                              ? Text(courses.toString())
                              : Text("Nothing to show"),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                        icon: Icon(Icons.edit_outlined),
                        label: Text("Edit Profile"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        },
                      ),
                      TextButton.icon(
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          icon: Icon(Icons.exit_to_app),
                          label: Text('Sign Out'))
                    ],
                  ),
                ),
              ),
            );
          } else {
            print(snapshot.error);
            print("uid: " + launcher.uid);
            return Loading();
          }
        });
  }

  final double coverHeight = 200;
  final double profileHeight = 144;

  Widget coverImage() => Container(
        color: Colors.grey,
        child: (image != null)
            ? Image.file(image!,
                height: coverHeight, width: double.infinity, fit: BoxFit.cover)
            : Image.asset(
                'images/cover_image.png',
                width: double.infinity,
                height: coverHeight,
                fit: BoxFit.cover,
              ),
      );

  Widget profileImage() => ClipOval(
        child: Container(
          color: Colors.orange,
          child: CircleAvatar(
            radius: profileHeight / 2,
            backgroundColor: Colors.grey,
            child: (imageTwo != null)
                ? Image.file(
                    imageTwo!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset('images/default_profile.jpg'),
          ),
        ),
      );

  void _takeImage() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt, color: Colors.orange),
                    title: Text('Camera'),
                    onTap: () => getCameraImage(),
                  ),
                  ListTile(
                    leading: Icon(Icons.image, color: Colors.orange),
                    title: Text('Gallery'),
                    onTap: () => getGalleryImage(),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _selectImage() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt, color: Colors.orange),
                    title: Text('Camera'),
                    onTap: () => getCameraImageTwo(),
                  ),
                  ListTile(
                    leading: Icon(Icons.image, color: Colors.orange),
                    title: Text('Gallery'),
                    onTap: () async {
                      getGalleryImageTwo();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  File? image;
  File? imageTwo;

  Future getCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final coverImage = await saveCoverImage(image.path);
      setState(() {
        this.image = coverImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future getGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final coverImage = await saveCoverImage(image.path);
      setState(() {
        this.image = coverImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File?> saveCoverImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future<File?> saveProfileImage(String imagePath) async {
    final directoryTwo = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final imageTwo = File('${directoryTwo.path}/$name');

    return File(imagePath).copy(imageTwo.path);
  }

  Future getCameraImageTwo() async {
    try {
      final imageTwo =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageTwo == null) return;

      final profileImage = await saveProfileImage(imageTwo.path);
      widget.Myurl = await DatabaseService(uid: uid).uploadImage(
          profileImage, uid, "$uid/${basename(profileImage!.path)}");

      this.preferences = await SharedPreferences.getInstance();
      this.preferences!.setString("profileUrl", widget.Myurl);
      setState(() {
        this.imageTwo = profileImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future getGalleryImageTwo() async {
    try {
      final imageTwo =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageTwo == null) return;

      final profileImage = await saveProfileImage(imageTwo.path);
      widget.Myurl = await DatabaseService(uid: uid).uploadImage(
          profileImage, uid, "$uid/${basename(profileImage!.path)}");

      this.preferences = await SharedPreferences.getInstance();
      this.preferences!.setString("profileUrl", widget.Myurl);
      setState(() {
        this.imageTwo = profileImage;
      });
      print(preferences!.getString("profileUrl"));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget cameraIconOne() => ClipOval(
        child: Container(
          color: Colors.orange,
          child: IconButton(
            onPressed: () {
              _takeImage();
            },
            icon: Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      );

  Widget cameraIconTwo() => ClipOval(
        child: Container(
          color: Colors.orange,
          child: IconButton(
            onPressed: () {
              _selectImage();
            },
            icon: Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      );

  Widget maleIcon() => Icon(
        Icons.male,
        color: Colors.blue,
      );

  Widget femaleIcon() => Icon(
        Icons.female,
        color: Colors.pink,
      );

  final deptController = TextEditingController();
  final courseController = TextEditingController();

  void _addDept() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Enter valid faculty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: deptController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.book, color: Colors.orange),
                        labelText: 'Department',
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.orange),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () async {
                        await DatabaseService(uid: uid)
                            .uploadDept(deptController.text);
                        Fluttertoast.showToast(
                            msg: "Successfully added department",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                        deptController.clear();
                      },
                      icon: Icon(Icons.upload),
                      label: Text('Upload')),
                ],
              ),
            ),
          );
        });
  }

  void _addCourse() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Enter valid course";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: courseController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.school, color: Colors.orange),
                        labelText: 'Course',
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.orange),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () async {
                        await DatabaseService(uid: uid)
                            .uploadCourse(courseController.text);
                        Fluttertoast.showToast(
                            msg: "Successfully added course",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                        courseController.clear();
                      },
                      icon: Icon(Icons.upload),
                      label: Text('Upload')),
                ],
              ),
            ),
          );
        });
  }
}
