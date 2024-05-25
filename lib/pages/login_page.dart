import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          margin: EdgeInsets.only(top: 80),
          width: double.maxFinite,
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Image.asset('assets/icons/logo.png'),
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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Color(0xffC9C9C9))
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Color(0xffC9C9C9))
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('sign in ditekan');
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
                                          print('sign up ditekan');
                                        },
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                            color: Color(0xff6987B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      )
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