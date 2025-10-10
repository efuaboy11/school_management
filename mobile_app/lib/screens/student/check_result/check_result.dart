
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/student/check_result/check_resut_details.dart';
// import 'package:mobile_app/screens/student/school_fees/add_school_fees/step2.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';

class CheckResultScreen extends StatefulWidget{
  const CheckResultScreen({super.key});

  @override
  State<CheckResultScreen> createState() => _CheckResultScreenState();
}

class _CheckResultScreenState extends State<CheckResultScreen> {
  String? selectedStudentClass;
  String? selectedSession;
  String? selectedTerm;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            context.pop();
          }
        ),
        title: Text('Check Result', style: TextStyle(fontSize: 18)),
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
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [

                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(18),
                            
                            child: Form(
                              child: Column(
                                spacing: 20,
                                children: [                       
                                  DropdownButtonFormField(
                                    hint: Text("Select class"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select student class';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedStudentClass,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'primary 1',
                                        child: Text('Primary 1')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'primary 2',
                                        child: Text('Primary 2'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedStudentClass = value;
                                      });
                                    }
                                  ),
                        
                        
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select Session"),
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
                        
                                    value: selectedSession,
                                    items: [
                                      DropdownMenuItem(
                                        value: '2021/2022',
                                        child: Text('2021/2022')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: '2022/2023',
                                        child: Text('2022/2023'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedSession = value;
                                      });
                                    }
                                  ),
                        
                        
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select Term"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select term';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedTerm,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'first term',
                                        child: Text('first term')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'Second Term',
                                        child: Text('Second Term'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedSession = value;
                                      });
                                    }
                                  ),
                        

                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Scratch card pin',
                                      prefixIcon: Icon(Icons.code), // You can change this icon
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter pin';
                                      }
                                      return null;
                                    },
                                    
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) => CheckResutDetailsScreen())
                                        );
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