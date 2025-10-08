
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/screens/student/general_notification/general_notifcation_details.dart';

class GeneralNotificationScreen extends StatelessWidget{
  const GeneralNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void openEditOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => GeneralNotificationDetails());
    }
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () => context.pop(),
        ),
        title: Text('General Notifications', style: TextStyle(fontSize: 18)),
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
        child: Column(
          children: [
            Text('data')
          ],
        ),
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

            SizedBox(height: 24,),

            Row(
              spacing: 10,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary
                    ),
                  
                    child: Text('All'),
                  ),
                ),


                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: customColors.lightBorder
                    ),
                    child: Text('Read'),
                  ),
                ),

                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: customColors.lightBorder
                    ),
                    child: Text('Unread 20+'),
                  ),
                ),

                
              ],
            ),

            SizedBox(height: 15,),

            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: customColors.lightBorder,
                          width: 1.0
                        )
                      )
                      
                    ),
                    child: ListTile(
                      onTap: openEditOverlay,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.lightBorder,
                        child: Icon(Icons.notifications,),
                      ),
                      title: Text('Christmas Event'),
                      trailing: Text('25m ago', style: TextStyle(color: customColors.lightText),),
                      subtitle: Text('Christmas event to be hold on the 10th of jan 2023', style: TextStyle(color: customColors.lightText)),
                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: customColors.lightBorder,
                          width: 1.0
                        )
                      )
                      
                    ),
                    child: ListTile(
                      onTap: (){
                        context.push('/student/bills-history/details');
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.lightBorder,
                        child: Icon(Icons.notifications,),
                      ),
                      title: Text('Christmas Event'),
                      trailing: Text('25m ago', style: TextStyle(color: customColors.lightText),),
                      subtitle: Text('Christmas event to be hold on the 10th of jan 2023', style: TextStyle(color: customColors.lightText)),
                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: customColors.lightBorder,
                          width: 1.0
                        )
                      )
                      
                    ),
                    child: ListTile(
                      onTap: (){
                        context.push('/student/bills-history/details');
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.lightBorder,
                        child: Icon(Icons.notifications,),
                      ),
                      title: Text('Christmas Event'),
                      trailing: Text('25m ago', style: TextStyle(color: customColors.lightText),),
                      subtitle: Text('Christmas event to be hold on the 10th of jan 2023', style: TextStyle(color: customColors.lightText)),
                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: customColors.lightBorder,
                          width: 1.0
                        )
                      )
                      
                    ),
                    child: ListTile(
                      onTap: (){
                        context.push('/student/bills-history/details');
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.lightBorder,
                        child: Icon(Icons.notifications,),
                      ),
                      title: Text('Christmas Event'),
                      trailing: Text('25m ago', style: TextStyle(color: customColors.lightText),),
                      subtitle: Text('Christmas event to be hold on the 10th of jan 2023', style: TextStyle(color: customColors.lightText)),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: customColors.lightBorder,
                          width: 1.0
                        )
                      )
                      
                    ),
                    child: ListTile(
                      onTap: (){
                        context.push('/student/bills-history/details');
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.lightBorder,
                        child: Icon(Icons.notifications_outlined,),
                      ),
                      title: Text('Christmas Event'),
                      trailing: Text('25m ago', style: TextStyle(color: customColors.lightText),),
                      subtitle: Text('Christmas event to be hold on the 10th of jan 2023', style: TextStyle(color: customColors.lightText)),
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