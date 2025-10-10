
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class EditUserContactInformation extends StatefulWidget{
  const EditUserContactInformation({super.key});

  @override
  State<EditUserContactInformation> createState() => _EditUserContactInformationState();
}

class _EditUserContactInformationState extends State<EditUserContactInformation> {
  String? selectedDisability;
  File? selectedImage;


  


  @override
  Widget build(BuildContext context) {

    

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
                          hintText: 'Enter state of origin', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter state of origin';
                          }
                          return null;
                        },
                        
                      ),


                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter city or town', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last city or town';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter house address', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter house address';
                          }
                          return null;
                        },
                        
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter phone number', 
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phones number';
                          }
                          return null;
                        },
                        
                      ),
                      


            
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // context.push('/student/pay-2');
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (ctx) => EditUserContactInformationTwo())
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
                      
                      SizedBox(height: 20,),
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