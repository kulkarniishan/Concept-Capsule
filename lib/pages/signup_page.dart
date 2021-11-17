import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/login_page.dart';
import 'package:mooc_app/pages/signup_page.dart';
import 'package:mooc_app/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //form Key
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;
  bool _error = false;

  late FirebaseAuth auth;
  //Firebase Auth

  checkAuthentication() async {
    await Firebase.initializeApp();
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false,
        );
      }
    });
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        auth = FirebaseAuth.instance;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    this.initializeFlutterFire();
    this.checkAuthentication();
    super.initState();
  }

  SignUp() async {
    print(_formKey.currentState);

    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        try {
          print(emailController.text);
          print(passwordController.text);
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          User? user = userCredential.user;
          print(user);

          print(user!.updateDisplayName(nameController.text));

          print(userCredential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-foun') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
      }
    }
  }

  //editing Controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final linkStyle = new TextStyle(color: Colors.blue);

    //Email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (input) {
        if (input == null || input.isEmpty)
          return 'Email Field Cannot Be empty';
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(input)) return 'Invalid Email Format';
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: "email",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)),
    );

    //Name Field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameController.text = value!;
      },
      validator: (input) {
        if (input == null || input.isEmpty) return 'Name Cannot Be empty';
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: "name",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)),
    );

    //Password Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (input) {
        if (input == null || input.isEmpty)
          return 'Password Field Cannot Be empty';

        if (input.length < 6) return 'Password must be atleast 6 characters';
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_rounded),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: "password",
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Color.fromRGBO(13, 147, 145, 1),
                  Color.fromRGBO(42, 53, 81, 1),
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Image(
                  image: AssetImage('assets/images/capsule.png'),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    nameField,
                    emailField,
                    passwordField,
                  ]),
                ),
              ),
              Container(
                child: MaterialButton(
                  height: 40,
                  color: Colors.white,
                  onPressed: SignUp,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                          text: 'Login',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false,
                              );
                            }),
                    ],
                  ),
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/button_icons/google-icon.png"),
                          ),
                        ),
                      ),
                      Text(
                        "Sign In With Google",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
