import 'dart:convert';
import 'package:myforumapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateController extends GetxController {


  //Register User Method
  Future<dynamic> registerUser(String name, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/register'),
      headers: {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name':name,
        'username':username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Register success!');
      return true;

    } else {
      print('Error: ${response.body}');
      return false;
    }
  }

  //Function simpan token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  //Function fetch token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // Dia return null kalau token tak ada
  }

  //Login User Method
  Future<dynamic> loginUser(String username, String password) async{
    final response = await http.post(
      Uri.parse('$url/login'),
      headers:{
        "Content-Type": 'application/json',
        'Accept': 'application/json',
      },
      body:jsonEncode({
        'username' : username,
        'password' : password
      })
    );

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var token = data['token'];
      await saveToken(token);
      print('User Authnticated');
      return true;
    }
    else{
      print('Error: ${response.body}');
      return false;
    }
  }

  //Function remove token (logout)
  Future<void> removeTokenLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Buang token dari local storage
  }


}
