
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class SchoolFeesHistoryScreen extends StatelessWidget{
  const SchoolFeesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: Colors.white,),
          onPressed: () => context.pop(),
        ),
        title: Text('Fees History', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            context.push('/student/pay-fees');
          }, icon: Icon(Icons.attach_money, color: Colors.white, size: 30)),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 30),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        
        ],
        backgroundColor: Theme.of(context).colorScheme.primary , // 👈 fully transparent
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

            SizedBox(height: 15,),

            Align(
              alignment: Alignment.center,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Transaction History', style: TextStyle(fontSize: 20),),
                ),
              ),
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
                      onTap: (){
                        context.push('/student/fees-history/detail');
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.successful,
                        child: Icon(Icons.check,  color: Colors.white,),
                      ),
                      title: Text('School Fess'),
                      trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                      subtitle: Text('Date: 27th may 2023'),
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
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.declined,
                        child: Icon(Icons.cancel_outlined, color: Colors.white,),
                      ),
                      title: Text('P.T.A'),
                      trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                      subtitle: Text('Date: 27th may 2023'),
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
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.pending,
                        child: Icon(Icons.hourglass_top,  color: Colors.white,),
                      ),
                      title: Text('P.T.A'),
                      trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                      subtitle: Text('Date: 27th may 2023'),
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
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.declined,
                        child: Icon(Icons.cancel_outlined, color: Colors.white,),
                      ),
                      title: Text('P.T.A'),
                      trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                      subtitle: Text('Date: 27th may 2023'),
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
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: customColors.pending,
                        child: Icon(Icons.hourglass_bottom, color: Colors.white,),
                      ),
                      title: Text('P.T.A'),
                      trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                      subtitle: Text('Date: 27th may 2023'),
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