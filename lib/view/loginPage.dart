import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforumapp/controller/authenticate.dart';
import 'package:myforumapp/view/homePage.dart';
import 'package:myforumapp/view/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernamecont = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();
  AuthenticateController authenticateController = Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              child: const Text(
                'MyForum',
                style:TextStyle(
                  color:Colors.black,
                  fontSize: 16.0,
                  letterSpacing: 1.5
                )
              )
            ),
            Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                child: const Text(
                    'Welcome Back !',
                    style:TextStyle(
                        color:Colors.teal,
                        fontSize: 32.0,
                        letterSpacing: 1.5
                    )
                )
            ),
            Container(
                margin: EdgeInsets.only(top:5.0,left: 25.0, right: 25.0),
                child: const Text(
                    'Please enter your Email and Password correctly.',
                    style:TextStyle(
                        color:Colors.grey,
                        fontSize: 14.0,
                        letterSpacing: 1.5
                    )
                )
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0,top:50.0),
                  padding: EdgeInsets.only(left: 15,right: 10,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller: usernamecont,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0,top:20.0),
                  padding: EdgeInsets.only(left: 15,right: 10,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller: passwordcont,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0,top:20.0),
                  child: ElevatedButton.icon(
                      onPressed: () async {
                          final result;
                          result = await authenticateController.loginUser(
                              usernamecont.text.trim(),
                              passwordcont.text.trim()
                          );
                          if(result == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                          }
                      },
                      label: Text('Log In', style: TextStyle(color: Colors.white,fontSize: 18.0)),
                      icon: Icon(Icons.arrow_circle_right,size: 30.0,color: Colors.white,),
                      iconAlignment: IconAlignment.end,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal) ,
                        minimumSize: MaterialStateProperty.all(Size.fromHeight(55)),
                      ),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25,top: 30),
                      child: const Text("Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 1.5,
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 25,top: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                        },
                        child: const Text(" Sign In",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16.0,
                                letterSpacing: 1.5,
                                decoration: TextDecoration.underline
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),

      )

    );
  }
}
