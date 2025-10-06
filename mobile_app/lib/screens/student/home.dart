import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_app/screens/student/school_fees/history.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/carousel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobile_app/widgets/student/tabs.dart';


class StudentHomeScreen extends StatelessWidget {
  StudentHomeScreen({super.key});
  final double pending = 100;
  final double declined = 50;
  final double successful = 60;

  final double billspending = 100;
  final double billsdeclined = 50;
  final double billssuccessful = 60;

  final List<String> imgList = [
    "https://picsum.photos/800/400?img=1",
    "https://picsum.photos/800/400?img=2",
    "https://picsum.photos/800/400?img=3",
  ];

  @override
  Widget build(BuildContext context) {
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Text('data')
          ],
        ),
      ),
      body: Column(
        children: [
          // Top green curve
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 15),
              child: Stack(
                children: [
                  // 🔹 Main Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.white, size: 30),
                          SizedBox(width: 5),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/image/passports.jpg'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Greetings Shara!', style: TextStyle(color: Colors.white, fontSize: 17)),
                              Text('How can we be off help today', style: TextStyle(color: Colors.white, fontSize: 17)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Primary 1',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          

          Expanded(    
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselWithDots(),
                
                      SizedBox(height: 25,),

                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: 
                                Wrap(
                                  spacing: 25.0, // horizontal spacing between widgets
                                  runSpacing: 25.0,
                                  
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.push('/student/fees-history');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.money, color: Theme.of(context).colorScheme.primary,),
                                          SizedBox(height: 5,),
                                          Text('Pay fees')
                                        ],
                                      ),
                                    ),
                                          
                                    GestureDetector(
                                      onTap: () {
                                        context.push('/student/bills-history');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.monetization_on, color: Theme.of(context).colorScheme.secondary,),
                                          SizedBox(height: 5,),
                                          Text('Pay Bill')
                                        ],
                                      ),
                                    ),
                                          
                                    GestureDetector(
                                      onTap: () {
                                        context.push('/student/assignment');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.book_rounded, color: Theme.of(context).colorScheme.tertiary,),
                                          SizedBox(height: 5,),
                                          Text('Assignment')
                                        ],
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        context.push('/student/assignment-submission');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.assessment, color: Theme.of(context).colorScheme.secondary,),
                                          SizedBox(height: 5,),
                                          Text('Result')
                                        ],
                                      ), 
                                    ),

                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Icon(Icons.monetization_on, color: Colors.orange,),
                                          SizedBox(height: 5,),
                                          Text('Scheme')
                                        ],
                                      ),
                                    ),
                                          
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Icon(Icons.calendar_today, color: Colors.orange,),
                                          SizedBox(height: 5,),
                                          Text('Timetable')
                                        ],
                                      ),
                                    ),
                                          
                                    
                                          
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Icon(Icons.event, color: Theme.of(context).colorScheme.secondary,),
                                          SizedBox(height: 5,),
                                          Text('Events')
                                        ],
                                      ),
                                    ),
                                          
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary,),
                                          SizedBox(height: 5,),
                                          Text('notice')
                                        ],
                                      ),
                                    ),
                                          
                                    
                                          
                                    
                                  ],
                                ),
                            
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          // foregroundColor: ,
                                          child:Icon(Icons.person, color: Colors.white,)
                                        ),
                                
                                        SizedBox(height: 15,),
                                
                                        Text('Student ID'),
                                          
                                        Text('SBHSISE34', style: TextStyle(fontSize: 18,),)
                                      ],
                                    ),
                                  ),
                                                            
                                ),
                              ),

                              SizedBox(width: 10,),
                        
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          // foregroundColor: ,
                                          child:Icon(Icons.school, color: Colors.white,)
                                        ),
                                
                                        SizedBox(height: 15,),
                                
                                        Text('Class'),
                                          
                                        Text('Primary1', style: TextStyle(fontSize: 18,),)
                                      ],
                                    ),
                                  ),
                                                            
                                ),
                              ),
                        
                        
                        
                              
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [

                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                                      // foregroundColor: ,
                                      child:Icon(Icons.description, color: Colors.white,)
                                    ),
                            
                                    SizedBox(height: 15,),
                            
                                    Text('5', style: TextStyle(fontSize: 28),),
                                      
                                    Text('Assignment Given'),
                                  ],
                                ),
                              ),
                                                        
                            ),
                          ),

                          SizedBox(width: 10,),

                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      // foregroundColor: ,
                                      child:Icon(Icons.task, color: Colors.white,)
                                    ),
                            
                                    SizedBox(height: 15,),
                            
                                    Text('5', style: TextStyle(fontSize: 28),),
                                      
                                    Text('Assignment Done'),
                                  ],
                                ),
                              ),
                                                        
                            ),
                          ),
                            
                        ],
                      ),
                      
                
                    
              
                      SizedBox(height: 15,),
              
              
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            // height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Recent Class Notification'),
                                SizedBox(height: 10,),
                                ListView(
                                  padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text('27/7/2022'),
                                            ),
                                                                    
                                            Text('Posted by: Iseghohimhen',),
                                                                    
                                            Text('LOremmmmmm')
                                                                    
                                          ],
                                        ),
                                      ),
                            
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text('27/7/2022'),
                                            ),
                                                                    
                                            Text('Posted by: Iseghohimhen',),
                                                                    
                                            Text('LOremmmmmm')
                                                                    
                                          ],
                                        ),
                                      ),
              
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text('27/7/2022'),
                                            ),
                                                                    
                                            Text('Posted by: Iseghohimhen',),
                                                                    
                                            Text('LOremmmmmm')
                                                                    
                                          ],
                                        ),
                                      ),
              
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text('27/7/2022'),
                                            ),
                                                                    
                                            Text('Posted by: Iseghohimhen',),
                                                                    
                                            Text('LOremmmmmm')
                                                                    
                                          ],
                                        ),
                                      ),
              
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text('27/7/2022'),
                                            ),
                                                                    
                                            Text('Posted by: Iseghohimhen',),
                                                                    
                                            Text('LOremmmmmm')
                                                                    
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),
              
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context).colorScheme.primary,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          child: Text(
                                            "View All",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
              
                                      SizedBox(height: 10,),
                                    ],
                                  )
                              
                              ],
                            ),
                          ),
                        ),
                      ),
              
                      SizedBox(height: 15,),
              
                      Card(
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('School Fees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: 5,),
                              Text('School Fees Chart'),
                              SizedBox(height: 15,),
                              
                              Wrap(
                                spacing: 15,
                                runSpacing: 15,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('All Fees')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Pending')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Success')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Declined')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('(NGN)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      
                                    ],
                                  ),
                                ],
                              ),
              
                              SizedBox(height: 20,),
              
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child:BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: 120, // highest bar value + some space
                                      barTouchData: BarTouchData(enabled: true),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              switch (value.toInt()) {
                                                case 0:
                                                  return Text("Pending");
                                                case 1:
                                                  return Text("Declined");
                                                case 2:
                                                  return Text("Successful");
                                                default:
                                                  return Text("");
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      borderData: FlBorderData(show: false),
                                      barGroups: [
                                        BarChartGroupData(
                                          x: 0,
                                          barRods: [
                                            BarChartRodData(toY: pending, color: Colors.orange, width: 20),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 1,
                                          barRods: [
                                            BarChartRodData(toY: declined, color: Colors.red, width: 20),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 2,
                                          barRods: [
                                            BarChartRodData(toY: successful, color: Colors.green, width: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
              
                      SizedBox(height: 15,),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent School Fees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(height: 5,),
                              Text('Note: Red means declined, yellow means pending, green means approved'),
                              SizedBox(height: 16,),
              
                              ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.successful,
                                      child: Icon(Icons.check,  color: Colors.white,),
                                    ),
                                    title: Text('School Fess'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.declined,
                                      child: Icon(Icons.cancel_outlined, color: Colors.white,),
                                    ),
                                    title: Text('P.T.A'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.pending,
                                      child: Icon(Icons.hourglass_top,  color: Colors.white,),
                                    ),
                                    title: Text('P.T.A'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.pending,
                                      child: Icon(Icons.hourglass_top,  color: Colors.white,),
                                    ),
                                    title: Text('School Fees'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.declined,
                                      child: Icon(Icons.cancel,  color: Colors.white,),
                                    ),
                                    title: Text('P.T.A'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15,),                     
                      
                      Card(
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: 5,),
                              Text('Bills Chart'),
                              SizedBox(height: 15,),
                              
                              Wrap(
                                spacing: 15,
                                runSpacing: 15,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('All Bills')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Pending')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Success')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('Declined')
                                    ],
                                  ),
              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('(NGN)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      
                                    ],
                                  ),
                                ],
                              ),
              
                              SizedBox(height: 49,),
              
                              SizedBox(
                                width: double.infinity,
                                height: 200,
                                child:PieChart(
                                  PieChartData(
                                    sectionsSpace: 0, // no borders between sections
                                    centerSpaceRadius: 40, // empty circle in middle (optional)
                                    sections: [
                                      PieChartSectionData(
                                        value: pending,
                                        title: "Pending",
                                        color: Colors.orange,
                                        radius: 100,
                                        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      PieChartSectionData(
                                        value: declined,
                                        title: "Declined",
                                        color: Colors.red,
                                        radius: 100,
                                        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      PieChartSectionData(
                                        value: successful,
                                        title: "Success",
                                        color: Colors.green,
                                        radius: 100,
                                        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 60,)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15,),

                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Bills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(height: 5,),
                              Text('Note: Red means declined, yellow means pending, green means approved'),
                              SizedBox(height: 16,),
              
                              ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.successful,
                                      child: Icon(Icons.check,  color: Colors.white,),
                                    ),
                                    title: Text('Utilty bill'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.declined,
                                      child: Icon(Icons.cancel_outlined, color: Colors.white,),
                                    ),
                                    title: Text('Utilty bill'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.pending,
                                      child: Icon(Icons.hourglass_top,  color: Colors.white,),
                                    ),
                                    title: Text('Hostel due'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.pending,
                                      child: Icon(Icons.hourglass_top,  color: Colors.white,),
                                    ),
                                    title: Text('Class due'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: customColors.declined,
                                      child: Icon(Icons.cancel,  color: Colors.white,),
                                    ),
                                    title: Text('Utilty bill'),
                                    trailing: Text('4000 NGN', style: TextStyle(fontSize: 16),),
                                  ),
              
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 15,),
                      Card(
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/image/support.png',
                                width: 200,
                                height: 200,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'We’re here to help you!',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                                
                              ),

                              Text('Ask a question or file a support ticket, manage request, report an issues. Our team support team will get back to you by email.'),
                              SizedBox(height: 17,),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                  ),
                                  child: Text(
                                    "Get Support Now",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),
          
          ),
          


        ],
      ),

      bottomNavigationBar: StudentTab(),
      
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
   @override
  Path getClip(Size size) {
    const double radius = 0;

    Path path = Path();

    // Start at top-left
    path.moveTo(0, 0);

    // Line to top-right
    path.lineTo(size.width, 0);

    // Line to bottom-right before corner
    path.lineTo(size.width, size.height - radius);

    // Bottom-right arc
    path.quadraticBezierTo(
      size.width, size.height,
      size.width - radius, size.height,
    );

    // Line to bottom-left before corner
    path.lineTo(radius, size.height);

    // Bottom-left arc
    path.quadraticBezierTo(
      0, size.height,
      0, size.height - radius,
    );

    // Close the path back to top-left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
