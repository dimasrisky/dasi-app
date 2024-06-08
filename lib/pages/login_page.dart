import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final Function whenSave;
  const CustomFormField({
    super.key,
    required this.label,
    required this.whenSave
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: label == 'Password' ? true : false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xffC9C9C9))
        ),
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "please fill the $label";
        }

        return null;
      },
      onSaved: (newValue) => whenSave(newValue),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool showSnackbar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          margin: EdgeInsets.only(top: 80),
          width: double.maxFinite,
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 120,
                    height: 110,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          color: Color(0xff5A5A5A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomFormField(
                              label: 'Email', 
                              whenSave: (value){
                                  setState(() {
                                    email = value;
                                  }
                                );
                              }
                            ),
                            SizedBox(height: 30),
                            CustomFormField(
                              label: 'Password', 
                              whenSave: (value){
                                  setState(() {
                                    password = value;
                                  }
                                );
                              }
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if(_formKey.currentState!.validate()){
                                        _formKey.currentState!.save();
                                        try{
                                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                                          setState(() {
                                            email = '';
                                            password = '';
                                          });
                                          Navigator.pushNamed(context, '/home');
                                        }on FirebaseAuthException catch(err){
                                          final errorSnackBar = SnackBar(
                                            content: Text(err.code),
                                            backgroundColor: Colors.red,
                                            action: SnackBarAction(
                                              label: 'Close',
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                        }
                                      }
                                    }, 
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Color(0xff6987B7),
                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                      ),
                                      child: Text(
                                        'Sign In',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    )
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don`t have account ?',
                                        style: TextStyle(
                                          color: Color(0xff5A5A5A),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/register');
                                        },
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                            color: Color(0xff6987B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}