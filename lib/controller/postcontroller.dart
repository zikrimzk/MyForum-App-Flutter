import 'dart:convert'; 
import 'package:myforumapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myforumapp/controller/authenticate.dart';

class PostController extends GetxController {

  final AuthenticateController authenticateController = AuthenticateController();

  Future<List<dynamic>> fetchAllPosts() async {
    final token = await authenticateController.getToken();
    final response = await http.get(
      Uri.parse('$url/showpost'),
      headers: {
        'Authorization': 'Bearer '+ token!, // Replace with your actual token
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Print response for debugging
      print('Response: ${response.body}');

      // Parse and return the list of posts
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['posts'] ?? []; // Return an empty list if 'posts' is null
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load posts');
    }
  }

  Future<dynamic> likePost(int id) async {
    final token = await authenticateController.getToken();
    final response = await http.post(
      Uri.parse('$url/likepost-$id'),
      headers: {
        "Content-Type": 'application/json',
        'Authorization': 'Bearer '+ token! ,
      }
    );

    if (response.statusCode == 201) {
      print('Liked Successfully');
      return true;

    } else {
      print('Error: ${response.body}');
      return false;
    }
  }

  Future<dynamic> craetePost(String content) async {
    final token = await authenticateController.getToken();
    final response = await http.post(
      Uri.parse('$url/insertpost'),
      headers: {
        'Authorization': 'Bearer '+ token!,
        "Content-Type": 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'content':content,
      }),
    );

    if (response.statusCode == 201) {
      print('Post Success!');
      return true;

    } else {
      print('Error: ${response.body}');
      return false;
    }
  }
}
