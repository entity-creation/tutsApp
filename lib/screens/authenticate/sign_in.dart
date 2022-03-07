import 'package:flutter/material.dart';
import 'package:tuts_app/services/auth.dart';
import 'package:tuts_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String emails = '';
  String passwords = '';
  bool obscurePassword = true;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return load? Loading() : SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange[900]!,
                        Colors.orange[800]!,
                        Colors.orange[400]!
                      ],
                    ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: ClipOval(
                          child: Image.asset('images/tuts_app_logo.jpg',
                              height: 100,
                              width: 100
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),

                                  // Email Form Field
                                  child: TextFormField(
                                    validator: (value) {
                                      if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]').hasMatch(value)) {
                                        return "Incorrect Email";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (val) {
                                      setState(() => emails = val);
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email,
                                      color: Colors.orange),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),

                                  // Password Form Field
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.length < 6 || value.length > 12) {
                                        return "Incorrect Password";
                                      }
                                      return null;
                                    },
                                    obscureText: obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    onChanged: (val) {
                                      setState(() => passwords = val);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.vpn_key,
                                      color: Colors.orange),
                                      suffixIcon: IconButton(
                                        onPressed: () => setState(() => obscurePassword = !obscurePassword),
                                        icon: Icon(
                                          obscurePassword ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () async {
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(onPressed: () async {
                                  final valid = _formKey.currentState?.validate();
                                  if (valid!) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Success!"))
                                    );
                                    setState(() {
                                      load = true;
                                    });
                                    await _auth.pass(emails, passwords);
                                  } else {
                                    load = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                          content: Text("Enter Valid Details!"))
                                    );
                                  }
                                },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                    minimumSize: const Size(0, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                OutlinedButton.icon(onPressed: () async {},
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(260, 50),
                                    side: const BorderSide(color: Colors.black, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                    icon: Image.asset('images/google-logo.png',
                                    height: 20,
                                    width: 20
                                    ),
                                    label: const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {
                                        widget.toggleView();
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
