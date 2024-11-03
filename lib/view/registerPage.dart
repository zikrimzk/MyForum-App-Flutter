import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforumapp/controller/authenticate.dart';

// import 'package:myforumapp/controller/authenticate.dart';
// import 'package:myforumapp/controller/registercontroller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullnamecont = TextEditingController();
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController usernamecont = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: const Text(
                'Created Account',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 32.0,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
              child: const Text(
                'Start exploring all that our app has to offer. We are excited to welcome you to our community!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Column(
              children: [
                _buildTextField(
                    controller: fullnamecont, hintText: 'Full Name'),
                _buildTextField(controller: usernamecont, hintText: 'Username'),
                _buildTextField(controller: emailcont, hintText: 'Email'),
                _buildTextField(
                    controller: passwordcont,
                    hintText: 'Password',
                    obscureText: true),
                Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result;
                      result = await authenticateController.registerUser(
                          fullnamecont.text.trim(),
                          usernamecont.text.trim(),
                          emailcont.text.trim(),
                          passwordcont.text.trim()
                     );

                      if (result == true){
                        Navigator.pop(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                      }
                    },
                    label: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: const Size.fromHeight(55),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      padding: const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
