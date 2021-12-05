//Login Page for Loggin into the App
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/signup_page.dart';
import 'package:mooc_app/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //form Key
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;
  bool _error = false;

  late FirebaseAuth auth;
  //Firebase Auth

  //Checking the condition if the user is SignedIn or not
  checkAuthentication() async {
    await Firebase.initializeApp();
    auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage(user: user)),
            (route) => false,
          );
          print('User is signed in!');
        }
      },
    );
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
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
    super.initState();

    this.initializeFlutterFire();
    this.checkAuthentication();
  }

  login() async {
    print(_formKey.currentState);

    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        try {
          print(emailController.text);
          print(passwordController.text);
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          if (userCredential.user != null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(
                  user: userCredential.user!,
                ), // MainPage
              ), // MaterialPageRoute
              (route) => false,
            );
          }
          print(userCredential);
        } on FirebaseAuthException catch (e) {
          //Catching the Exceptions
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            //printing the messages on the console for Debugging Purpose
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            //printing the messages on the console for Debugging Purpose
          }
        }
      }
    }
  }

  // Controller for editable TextField
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final linkStyle = new TextStyle(color: Colors.blue);

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      //Setting the keyboardType to TextInputType.emailAddress
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (input) {
        if (input == null || input.isEmpty)
          return 'Email Field Cannot Be empty';
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            //Regex for Email Validation
            .hasMatch(input)) return 'Invalid Email Format';
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //Email Icon
        prefixIcon: Icon(Icons.mail),
        hintText: "email",
        hintStyle: TextStyle(
          color: Colors.white,
        ), // TextStyle
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ), // InputDecoration
    ); //TextFormField

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _isHidden,
      enableSuggestions: false,
      autocorrect: false,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      //Displaying the errors to the users on the App
      validator: (input) {
        if (input == null || input.isEmpty)
          return 'Password Field Cannot Be empty';

        if (input.length < 6) return 'Password must be atleast 6 characters';
      },
      decoration: InputDecoration(
        //Password Icon
        prefixIcon: Icon(Icons.password_rounded),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: "password",
        suffixIcon: InkWell(
          onTap: _togglePasswordView,
          child: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10,
                  ),
                  child: Image(
                    image: AssetImage(
                      'assets/logo/logo-no-glow.png',
                    ),
                    width: 300,
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      emailField,
                      passwordField,
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 20,
                  ),
                  child: MaterialButton(
                    height: 40,
                    color: Colors.white,
                    onPressed: login,
                    child: Text(
                      "Login",
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
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 20,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Don’t have an account? '),
                        TextSpan(
                            text: 'Sign Up',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                  (route) => false,
                                );
                              }),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 10,
                      bottom: MediaQuery.of(context).size.height / 50,
                    ),
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
      ),
    );
  }

  void _togglePasswordView() {
    setState(
      () {
        _isHidden = !_isHidden;
      },
    );
  }
}
