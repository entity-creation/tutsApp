import 'package:flutter/material.dart';
import 'package:tuts_app/services/auth.dart';
import 'package:tuts_app/shared/loading.dart';

class Forms {
  static final _formKey1 = GlobalKey<FormState>();
  static final _formKey2 = GlobalKey<FormState>();
}

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  int currentStep = 0;
  bool isCompleted = false;
  bool obscurePassword = true;
  dynamic gender = 1;
  dynamic school = 1;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  String error = "";
  bool load = false;

  stepState(int step) {
    if (currentStep > step) {
      return StepState.complete;
    }
    else if (currentStep < step) {
      return StepState.indexed;
    }
    else {
      return StepState.editing;
    }
  }

  steps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text('Account'),
      content: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                    key: Forms._formKey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                return "Enter valid email";
                              }
                              else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                return "Password must be 6 - 12 characters long";
                              }
                              else {
                                return null;
                              }
                            },
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text('Profile'),
      content: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                    key: Forms._formKey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),

                          // Full Name Form Field
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length < 4) {
                                return "Enter your name";
                              }
                              else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity,
                                  color: Colors.orange),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),

                          // Phone Number Form Field
                          child: TextFormField(
                            validator: (value) {
                              const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                              final regExp = RegExp(pattern);
                              if (value!.isEmpty || !regExp.hasMatch(value)) {
                                return "Enter valid phone number";
                              }
                              else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            controller: numberController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone,
                                  color: Colors.orange),
                              hintText: 'Phone Number',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),

                          // Address Form Field
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Enter home address";
                              }
                              else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.streetAddress,
                            controller: addressController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.house,
                                  color: Colors.orange),
                              hintText: 'Address',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),

                          // Gender Form Field
                          child: Column(
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
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),

                          // School Form Field
                          child: SingleChildScrollView(
                            child: Column(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return load ? Loading() : SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 220,
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
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Center(
                              child: ClipOval(
                                child: Image.asset('images/tuts_app_logo.jpg',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account?',
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
                      'Login',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.orange,
                      colorScheme: ColorScheme.light(primary: Colors.orange),
                    ),
                    child: Stepper(
                      physics: ClampingScrollPhysics(),
                      controlsBuilder: (BuildContext context, ControlsDetails controls) {
                        final isLastStep = currentStep == steps().length - 1;
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: ElevatedButton(
                                  onPressed: controls.onStepContinue,
                                  child: Text(isLastStep ? 'SUBMIT' : 'NEXT'),
                                ),
                              ),
                              if (currentStep != 0)
                                TextButton(
                                  onPressed: controls.onStepCancel,
                                  child: const Text(
                                    'BACK',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      onStepTapped: (step) => setState(() => currentStep = step),
                      onStepContinue: () async {
                        final isLastStep = currentStep == steps().length -1;

                        if (isLastStep) {
                          final isValid = Forms._formKey1.currentState?.validate();
                          final isAlsoValid = Forms._formKey2.currentState?.validate();
                          if (isValid! && isAlsoValid!) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                    Text("Success!"))
                            );
                            setState(() {
                              load = true;
                            });
                            await _auth.registerForm(
                                gender,
                                school,
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                numberController.text,
                                addressController.text);
                          }
                          else if (isValid || isAlsoValid! == false) {
                            setState(() {
                              load = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Enter Valid Details!"))
                            );
                          }
                        }
                        else {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      },
                      onStepCancel: () {
                        setState(() {
                          if (currentStep > 0) {
                            currentStep -= 1;
                          } else {
                            currentStep = 0;
                          }
                        });
                      },
                      currentStep: currentStep,
                      steps: steps(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
