
import 'package:flutter/material.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class AssignmentDetailsScreen extends StatelessWidget{
  const AssignmentDetailsScreen({super.key});

  // onPressed: () => context.pop(),



  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;


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
                  
                                child: Text('Assignment Details', textAlign: TextAlign.center,),
                              ),

                              ListTile(
                                title: Text('Teacher Name'),
                                trailing: Text('Ben Mark'),
                              ),

                              ListTile(
                                title: Text('Class'),
                                trailing: Text('Primary 1'),
                              ),

                              ListTile(
                                title: Text('Subject'),
                                trailing: Text('English'),
                              ),

                              ListTile(
                                title: Text('Assinment Name'),
                                trailing: Text('Take Home Assignment'),
                              ),

                              ListTile(
                                title: Text('Assingment Code'),
                                trailing: Text('12355767'),
                              ),

                              ListTile(
                                title: Text('Due date'),
                                trailing: Text('7 jul 2023'),
                              ),

                              ListTile(
                                title: Text('Date given'),
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
                  
                                child: Text('Instruction', textAlign: TextAlign.center,),
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