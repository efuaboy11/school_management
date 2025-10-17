
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/student/assignment_submission/edit_assignment.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class AssignmentSubmisionDetailsScreen extends StatelessWidget{
  const AssignmentSubmisionDetailsScreen({super.key});

  // onPressed: () => context.pop(),





  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;

    void openEditOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => EditAssignmentScreen());
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: PlatformBackButton(),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text('Assignment details', style: TextStyle(fontSize: 18)),
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
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      spacing: 15,
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: customColors.lightBorder,
                                      width: 1.0
                                    )
                                  )
                                  
                                ),
                  
                                child: Text('Assignment File', textAlign: TextAlign.center,),
                              ),
                  
                              GestureDetector(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No file attached',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: customColors.lightText),
                                      ),
                                    ],
                                  )
                                ),
                              )
                  
                  
                  
                  
                            ],
                          ),
                        ),

                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: customColors.lightBorder,
                                      width: 1.0
                                    )
                                  )
                                  
                                ),
                  
                                child: Text('Assignment Photo', textAlign: TextAlign.center,),
                              ),
                  
                              GestureDetector(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No file attached',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: customColors.lightText),
                                      
                                      ),
                                    ],
                                  )
                                ),
                              )
                  
                  
                  
                  
                            ],
                          ),
                        ),



                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: customColors.lightBorder,
                                      width: 1.0
                                    )
                                  )
                                  
                                ),
                  
                                child: Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      OutlinedButton.icon(
                                        onPressed: openEditOverlay,
                                        icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                                        label: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),

                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete_outline, color: Colors.white),
                                        label: Text('Delete', style: TextStyle(color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: customColors.declined,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),



                                    ],
                                  
                                ),
                              ),

                              ListTile(
                                title: Text('Teacher Name'),
                                trailing: Text('Ben Mark'),
                              ),

                             

                              ListTile(
                                title: Text('Subject'),
                                trailing: Text('English'),
                              ),

                              

                              ListTile(
                                title: Text('Assingment Code'),
                                trailing: Text('12355767'),
                              ),

                              ListTile(
                                title: Text('Grade'),
                                trailing: Text('60'),
                              ),  

                              ListTile(
                                title: Text('Submission date'),
                                trailing: Text('7 jul 2023'),
                              ),

                                         
                  
                            ],
                          ),
                        ),
                  


                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: customColors.lightBorder,
                                      width: 1.0
                                    )
                                  )
                                  
                                ),
                  
                                child: Text('Assignemt submission note', textAlign: TextAlign.center, style: TextStyle(color: customColors.lightText),),
                              ),
                  
                              Padding(
                                padding: EdgeInsetsGeometry.all(10),
                                child: Text('data'),
                              )
                  
                  
                  
                  
                            ],
                          ),
                        ),

                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: customColors.lightBorder,
                                      width: 1.0
                                    )
                                  )
                                  
                                ),
                  
                                child: Text('Assignemt submission feedback', textAlign: TextAlign.center, style: TextStyle(color: customColors.lightText),),
                              ),
                  
                              Padding(
                                padding: EdgeInsetsGeometry.all(10),
                                child: Text('data'),
                              )
                  
                  
                  
                  
                            ],
                          ),
                        ),
                        
                      ],
                  
                    )
                      
                    
                  ),
                ),
              ),
            )

            

            
        
          ],
        ),
      

      // bottomNavigationBar: StudentTab(),
      
    );
  }
}