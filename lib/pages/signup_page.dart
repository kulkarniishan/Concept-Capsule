import 'package:flutter/material.dart';
import 'package:mooc_app/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //form Key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double Width1 = MediaQuery.of(context).size.width;
    double Height1 = MediaQuery.of(context).size.height;
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
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
              ])),
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
                child: Column(children: [
                  emailField,
                  passwordField,
                ]),
              ),
              Container(
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
