
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditUserPersonalInformation extends StatefulWidget{
  const EditUserPersonalInformation({super.key});

  @override
  State<EditUserPersonalInformation> createState() => _EditUserPersonalInformationState();
}

class _EditUserPersonalInformationState extends State<EditUserPersonalInformation> {
  String? selectedDisability;
  File? selectedImage;
  


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
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter first name', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                        
                      ),


                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter last name', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter email', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter D.O.B', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter D.O.B';
                          }
                          return null;
                        },
                        
                      ),


                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Gender', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter gender';
                          }
                          return null;
                        },
                        
                      ),


                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Father name', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter father name';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Mother name', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mother name';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Religion', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        
                      ),


                      DropdownButtonFormField(
                        hint: Text("Any Disability"),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            ),
                          
                          
                        ),
                        
                        validator: (value){
                          if(value == null){
                            return 'Please select session';
                          }
                          return null;
                        },
            
                        value: selectedDisability,
                        items: [
                          DropdownMenuItem(
                            value: 'yes',
                            child: Text('Yes')
                          ),
            
                          DropdownMenuItem(
                            value: 'no',
                            child: Text('No'),
                          ),
                        ], 
                        onChanged: (value){
                          setState(() {
                            selectedDisability = value;
                          });
                        }
                      ),

                      TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 5, // Makes it a text area with 5 lines height
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Diability note',
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

                      


            
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // context.push('/student/pay-2');
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (ctx) => EditUserPersonalInformationTwo())
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
                      
                      SizedBox(height: 40,),
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