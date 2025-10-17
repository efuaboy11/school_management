
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class AssignmentScreen extends StatelessWidget{
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: PlatformBackButton(),
          onPressed: () => context.pop(),
        ),
        title: Text('Assignment', style: TextStyle(fontSize: 18)),
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

      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                
                
              ),
              style: TextStyle(fontSize: 14.0), // smaller text
            ),

            SizedBox(height: 15,),

            Align(
              alignment: Alignment.center,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Total of 2 assignment given'),
                ),
              ),
            ),

            SizedBox(height: 15,),

            Expanded(
              child: ListView(
                children: [
                  
                  GestureDetector(
                    onTap: () {
                      context.push('/student/assignment-details');
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.blue, // 💡 Use your desired color or theme color
                              width: 5,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Iseghohimhen Rita, the Primary 1 English teacher, gave a Take Home Assignment '
                            '(code: 12355767) on 7 Jul 2025 at 1:25 PM, due by 7 Jul 2025.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),



                  GestureDetector(
                    onTap: () {
                      context.push('/student/assignment-details');
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.blue, // 💡 Use your desired color or theme color
                              width: 5,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Iseghohimhen Rita, the Primary 1 English teacher, gave a Take Home Assignment '
                            '(code: 12355767) on 7 Jul 2025 at 1:25 PM, due by 7 Jul 2025.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),


                
                ],
              ),
            )
        
          ],
        ),
      ),

      bottomNavigationBar: StudentTab(),
      
    );
  }
}