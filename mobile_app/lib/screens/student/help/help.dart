
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class HelpScreen extends StatefulWidget{
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String? selectedPaymentMethod;

  String? selectedFeeType;
  String? selectedStudentClass;
  String? selectedSession;
  String? selectedTerm;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: PlatformBackButton(),
          onPressed: (){
            context.pop();
          }
        ),
        title: Text('Help', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(Icons.menu,),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        
        ],
        // backgroundColor: Theme.of(context).colorScheme.primary , // 👈 fully transparent
         // 👈 removes shadow

      ),

      drawer: Drawer(
        child: MenuBarWidget()
      ),

      body:
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(  
                            children: [
                              Text('Support Center', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold
                              ), textAlign: TextAlign.center,),
                              SizedBox(height: 5,),
                              Text('Send us a direct mail and our support team will get back to you shortly', style: TextStyle(color: customColors.lightText), textAlign: TextAlign.center,),
                              SizedBox(height: 20,),
                  
                            ],
                  
                          )
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(18),
                            
                            child: Form(
                              child: Column(
                                spacing: 20,
                                children: [

                                  Row(
                                    children: [
                                      Text('Your email'),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: TextFormField(
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
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text('Full name'),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter full name', 
                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter full name';
                                            }
                                            return null;
                                          },
                                          
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text('Subject'),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter Subject', 
                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter subject';
                                            }
                                            return null;
                                          },
                                          
                                        ),
                                      ),
                                    ],
                                  ),

                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.top,
                                    maxLines: 10, // Makes it a text area with 5 lines height
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Write your message',
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    // No validator since it's optional
                                  ),





                                     
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // context.push('/student/pay-2');
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(builder: (ctx) => HelpScreenTwo())
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
                          
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            

            
        
          ],
        ),
      

      bottomNavigationBar: StudentTab(),
      
    );
  }
}