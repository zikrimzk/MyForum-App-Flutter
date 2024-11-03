import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myforumapp/controller/postcontroller.dart';
import 'package:myforumapp/view/homePage.dart';
import 'package:rich_text_editor_controller/rich_text_editor_controller.dart';
// import 'package:flutter_quill/flutter_quill.dart';


class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // final QuillController _controller = QuillController.basic();
  final PostController postController = PostController();
  // final TextEditingController contentcontroller = TextEditingController();
  final RichTextEditorController contentcontroller = RichTextEditorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor:Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5.0),
                margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Create Post',
                        style: GoogleFonts.inter(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                          // color: Colors.white
                        )
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0,color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0)
                ),
                margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0,top: 25.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0,bottom: 10.0),
                child:
                RichTextField(
                  controller:contentcontroller,
                  minLines: 12,
                  maxLines: 50,
                  style: GoogleFonts.inter(fontSize: 16.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type here...',
                  ),
                ),
              ),

            // QuillSimpleToolbar(
            //   controller: _controller,
            //   configurations: const QuillSimpleToolbarConfigurations(),
            // ),
            // QuillEditor.basic(
            //   controller: _controller,
            //   configurations: const QuillEditorConfigurations(),
            // ),
        
              Container(
                margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0,top: 10.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0,bottom: 10.0),
                child:ElevatedButton.icon(
                    onPressed: ()async{
                      final result;
                      result = await postController.craetePost(contentcontroller.text.trim());

                      if(result == true){
                        Navigator.pop(context,MaterialPageRoute(builder: (context)=>CreatePost()));
                        Navigator.pop(context,MaterialPageRoute(builder: (context)=>Homepage()));
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Homepage()));


                      }
                    }, 
                    icon: Icon(Icons.create,color: Colors.white,size: 18.0),
                    label: Text('Post',style: GoogleFonts.inter(fontSize: 15.0,color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      minimumSize: MaterialStateProperty.all(Size.fromHeight(55)),
                    ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
