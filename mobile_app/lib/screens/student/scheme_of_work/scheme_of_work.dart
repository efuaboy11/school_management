
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class SchemeOfWorkScreen extends StatelessWidget{
  const SchemeOfWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () => context.pop(),
        ),
        title: Text('Scheme of work', style: TextStyle(fontSize: 18)),
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
        child: Center(
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Scheme of work for first term, primary 1'),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.download),
                          Text(
                            'Click here to download scheme'
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          
        ),
      ),

      bottomNavigationBar: StudentTab(),
      
    );
  }
}