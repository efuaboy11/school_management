
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/student/school_event/school_event_details.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class SchoolEventScreen extends StatelessWidget{
  const SchoolEventScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void openDetailsOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => SchoolEventDetails());
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
        title: Text('School Events', style: TextStyle(fontSize: 18)),
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

            SizedBox(height: 24,),

            SizedBox(height: 15,),

            Expanded(
              child: ListView(
                children: [
                  
                  GestureDetector(
                    onTap: () {
                      openDetailsOverlay();
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('School open day', 
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text('This is the school day open day, it will happen and interesting', style: TextStyle(color: customColors.lightText,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('From 12th nov, 2025')
                              ],
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Row(
                              children: [
                                Icon(Icons.event, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('To: 2nd april 2025')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      openDetailsOverlay();
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('School open day', 
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text('This is the school day open day, it will happen and interesting', style: TextStyle(color: customColors.lightText,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('From 12th nov, 2025')
                              ],
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Row(
                              children: [
                                Icon(Icons.event, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('To: 2nd april 2025')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      openDetailsOverlay();
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('School open day', 
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text('This is the school day open day, it will happen and interesting', style: TextStyle(color: customColors.lightText,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('From 12th nov, 2025')
                              ],
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Row(
                              children: [
                                Icon(Icons.event, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('To: 2nd april 2025')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      openDetailsOverlay();
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('School open day', 
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text('This is the school day open day, it will happen and interesting', style: TextStyle(color: customColors.lightText,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('From 12th nov, 2025')
                              ],
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Row(
                              children: [
                                Icon(Icons.event, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('To: 2nd april 2025')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      openDetailsOverlay();
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('School open day', 
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text('This is the school day open day, it will happen and interesting', style: TextStyle(color: customColors.lightText,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('From 12th nov, 2025')
                              ],
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Row(
                              children: [
                                Icon(Icons.event, size: 16, color: customColors.lightText,),
                                SizedBox(width: 6,),
                                Text('To: 2nd april 2025')
                              ],
                            )
                          ],
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