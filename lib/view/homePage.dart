import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:myforumapp/controller/authenticate.dart';
import 'package:myforumapp/controller/postcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myforumapp/view/createpost.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PostController postController = PostController();
  final AuthenticateController authenticateController = AuthenticateController();
  bool isLiked= false;
  late Future<List<dynamic>> _postsFuture; // Initialize future variable

  void _loadPosts() {
    setState(() {
      _postsFuture = postController.fetchAllPosts(); // Update the future to reload data
    });
  }

  void _toggleLike(post) async {
    // Simpan initial state dulu untuk rollback kalau API gagal
    final initialLiked = post['liked'];

    // Update UI secara lokal (optimistic UI)
    setState(() {
      post['liked'] = !initialLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                //Heading Text Design #1
                Container(
                  padding: EdgeInsets.only(top:10.0,bottom: 5.0),
                  margin: EdgeInsets.only(left: 20.0,right: 20.0,top:20.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Latest Post',
                          style: GoogleFonts.inter(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            // color: Colors.white
                          )
                      ),

                      TextButton(
                        onPressed: (){

                        },
                        child: Icon(Icons.person,color: Colors.black,weight: 2.0,size: 32.0,),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),

                      )

                    ],
                  ),
                ),

                const Divider(),

                Container(
                  margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePost()));
                        },
                        icon: Icon(Icons.add,color: Colors.black,weight: 2.0,size: 18.0,),
                        label: Text('Create Post',style: GoogleFonts.inter(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w500)),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black,width: 2.0)
                        ),

                      ),

                      TextButton.icon(
                        onPressed: (){
                          authenticateController.removeTokenLogout();
                          Navigator.pop(context,MaterialPageRoute(builder: (context)=>Homepage()));
                        },
                        icon: Icon(Icons.logout,color: Colors.red,weight: 2.0,size: 18.0,),
                        label: Text('Logout',style: GoogleFonts.inter(fontSize: 14.0,color: Colors.red,fontWeight: FontWeight.w500)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        )

                      ),
                    ],
                  ),
                ),

                FutureBuilder<List<dynamic>>(
                  future: postController.fetchAllPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: LinearProgressIndicator(color: Colors.black, backgroundColor: Colors.white));
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      final posts = snapshot.data ?? [];
                      return Expanded( // Tambah Expanded di sini
                        child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var post = posts[index];
                            var user = post['user']; // Handle potential null values
                            return Container(
                              margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0),
                              child: Card.outlined(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black,width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                color: Colors.white,
                                shadowColor: Colors.black,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0,left: 20.0,right: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "@"+ user['username'],
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              DateTimeFormat.format(DateTime.parse(post['created_at']), format: 'D, M j, H:i'),
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.0),
                                        Text(
                                          post['content'],
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  postController.likePost(post['id']);
                                                  _loadPosts();
                                                  _toggleLike(post['liked']);
                                                  print(post['id']);
                                                },
                                                icon: Icon(!post['liked'] ? Icons.thumb_up_off_alt : Icons.thumb_up_alt,
                                                color: post['liked'] ? Colors.redAccent : Colors.black)
                                            ),
                                            IconButton(
                                                onPressed: (){

                                                },
                                                icon: Icon(Icons.comment)
                                            ),
                                            IconButton(
                                                onPressed: (){

                                                },
                                                icon: Icon(Icons.edit)
                                            ),
                                          ],
                                        ),
                                      ],
                                    )



                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )


              ],
            ),
          ),
        )
    );
  }
}

