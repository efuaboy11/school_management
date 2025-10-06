
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class EditAssignmentScreen extends StatefulWidget{
  const EditAssignmentScreen({super.key});

  @override
  State<EditAssignmentScreen> createState() => _EditAssignmentScreenState();
}

class _EditAssignmentScreenState extends State<EditAssignmentScreen> {
  String? selectedTeacher;
  String? selectedSubject;
  String? assignemtCode;
  String? submissionNote;
  String? assignmentImage;
  String? assignmentFile;
  File? selectedImage;
  File? selectedFile;


  void _getPicture(String method) async{
    final imagePicker = ImagePicker();
    dynamic pickedImage;

    if(method == 'camera'){
      pickedImage = await imagePicker.pickImage(source: ImageSource.camera,);
    }else{
      pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 600);
    }

    if(pickedImage == null){
      return;
    }

    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }


  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if(result == null && result!.files.single.path == null){
      return;
    }
    setState(() {
      selectedFile = File(result.files.single.path!);
    });
    
  }


  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    Widget imgContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.camera),
        Text('Select Image')
      ],
    );

    if(selectedImage != null){
      imgContent = SizedBox(
        width: 100,
        height: 100,
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
          ),
        ),
      );

    }



    Widget fileContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.insert_drive_file),
        Text('Select File')
      ],
    );

    if(selectedFile != null){
      fileContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.insert_drive_file),
        Text(path.basename(selectedFile!.path),)
      ],
    );

    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(onPressed: (){
                  context.pop();
                }, icon: Icon(Icons.arrow_downward)),
              ),

              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsetsGeometry.all(10),
                
                child: Form(
                  child: Column(
                    spacing: 20,
                    children: [
                      DropdownButtonFormField(
                        hint: Text("Select Teacher"),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          
                          
                        ),
                        
                        validator: (value){
                          if(value == null){
                            return 'Please select a payment method';
                          }
                          return null;
                        },
                        value: selectedTeacher,
                        items: [
                          DropdownMenuItem(
                            value: 'mr frank',
                            child: Text('Mr Frank')
                          ),
            
                          DropdownMenuItem(
                            value: 'mrs joy',
                            child: Text('Mrs joy'),
                          ),
                        ], 
                        onChanged: (value){
                          setState(() {
                            selectedTeacher = value;
                          });
                        }
                      ),
            
                      DropdownButtonFormField(
                        hint: Text("Select Subject"),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          prefixIcon: Icon(Icons.book),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          
                          
                        ),
                        
                        validator: (value){
                          if(value == null){
                            return 'Please select a fee type';
                          }
                          return null;
                        },
            
                        value: selectedSubject,
                        items: [
                          DropdownMenuItem(
                            value: 'Mathematics',
                            child: Text('Mathematics')
                          ),
            
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English'),
                          ),
                        ], 
                        onChanged: (value){
                          setState(() {
                            selectedSubject = value;
                          });
                        }
                      ),


                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Assignment code',
                          prefixIcon: Icon(Icons.code), // You can change this icon
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter assignment code';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 5, // Makes it a text area with 5 lines height
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Submission note',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        // No validator since it's optional
                      ),


                      PopupMenuButton<String>(
                        onSelected: (value) {
                          _getPicture(value);
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'gallery',
                            child: Text('Select Image from gallery'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'camera',
                            child: Text('Take Picture'),
                          ),
                        ],
                        child: Container(
                          width: double.infinity,
                          
                          decoration: BoxDecoration(
                            color: customColors.lightBorder
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Align(
                              alignment: Alignment.center,
                              child: imgContent
                            ),
                          ),
                        ), // or use any widget as the trigger
                      ),

                      GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          width: double.infinity,
                          
                          decoration: BoxDecoration(
                            color: customColors.lightBorder
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Align(
                              alignment: Alignment.center,
                              child: fileContent
                            ),
                          ),
                        ), 
                      ),


            
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // context.push('/student/pay-2');
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (ctx) => EditAssignmentScreenTwo())
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                )
                  
                
              ),
                
              
            ],
          ),
        ),
      ),
    );

      
      
    
  }
}