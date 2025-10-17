
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class AssignmentSubmissionScreen extends StatelessWidget{
  const AssignmentSubmissionScreen({super.key});

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
        title: Text('Assignment submission', style: TextStyle(fontSize: 18)),
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
            
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/student/submit-assignment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(Icons.add, color: Colors.white,),
                label: Text(
                  "Submit assignment",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

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
                  child: Text('Total of 2 assignment submitted'),
                ),
              ),
            ),

            SizedBox(height: 15,),

            Expanded(
              child: ListView(
                children: [
                  
                  GestureDetector(
                    onTap: (){
                      context.push('/student/assignment-submission-details');
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
                              color: Theme.of(context).colorScheme.tertiary,  // 💡 Change to your theme color
                              width: 5,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Iseghohimhen Rita, the Primary 1 English teacher, '
                            'Take Home Assignment with (code: 12355767) was submitted at 7 Jul 2025 at 1:25 PM.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ),

                  GestureDetector(
                    onTap: (){
                      context.push('/student/assignment-submission-details');
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
                              color: Theme.of(context).colorScheme.tertiary,  // 💡 Change to your theme color
                              width: 5,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Iseghohimhen Rita, the Primary 1 English teacher, '
                            'Take Home Assignment with (code: 12355767) was submitted at 7 Jul 2025 at 1:25 PM.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
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