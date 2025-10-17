
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/student/check_result/result_score_details.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class CheckResutDetailsScreen extends StatelessWidget{
  const CheckResutDetailsScreen({super.key});

  // onPressed: () => context.pop(),



  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;

    void openResultScoreverlay(subject, totalCa, exam, totalGrade, grade, position){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => ResultScoreDetails(subject: subject, totalCa: totalCa, totalGrade: totalGrade, exam: exam, grade: grade, position: position));
    }

    Widget buildGridItem(BuildContext context, String text, String subText, double width){
      return SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: customColors.lightText
            ),),
            Text(subText)
          ],
        ),
      );
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
        title: Text('Result details', style: TextStyle(fontSize: 18)),
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
                  
                                child: Text('Academic Profile', textAlign: TextAlign.center,),
                              ),
                  
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: LayoutBuilder(
                                  builder:  (context, constraints){
                                    double totalWidth = constraints.maxWidth;
                                    int itemsPerRow = 2;
                                    double spacing = 15;
                                    double itemWidth = (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;
                                
                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        buildGridItem(context, 'Student name', 'Iseghohimhen Efua', itemWidth),
                                        buildGridItem(context, 'Student ID', 'stubam70', itemWidth),
                                        buildGridItem(context, 'Class', 'Primary 1', itemWidth),
                                        buildGridItem(context, 'Term', 'First term', itemWidth),
                                        buildGridItem(context, 'Session', '2025/2026', itemWidth),
                                      ],
                                    );
                                
                                
                                  }
                                ),
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
                  
                                child: Text('Performance Summary', textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 15,),


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total mark obtained:'),
                                    Text('23', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Student average:'),
                                    Text('23', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('class average:'),
                                    Text('23', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total student:'),
                                    Text('23', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('position:'),
                                    Text('5th', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Decision:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 20,)
                  
                  
                  
                            ],
                          ),
                        ),



                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  
                                child: Text('Result Scores', textAlign: TextAlign.center,),
                              ),

                              SizedBox(height: 15,),

                              ListView(
                                padding: EdgeInsets.all(10),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: customColors.lightBorder, width: 1)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        openResultScoreverlay('Mathematics', '50', '50', '100', 'A1', '5th');
                                      },
                                      child: Text('Mathematics'),
                                    )
                                  ),
                                  SizedBox(height: 10,),

                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: customColors.lightBorder, width: 1)
                                    ),
                                    child: GestureDetector(
                                      child: Text('Mathematics'),
                                    )
                                  ),
                                ]
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
                  
                                child: Text('Grade Intepretation', textAlign: TextAlign.center,),
                              ),
                  
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: LayoutBuilder(
                                  builder:  (context, constraints){
                                    double totalWidth = constraints.maxWidth;
                                    int itemsPerRow = 2;
                                    double spacing = 15;
                                    double itemWidth = (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;
                                
                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        buildGridItem(context, 'A1 = 80 - 100', 'EXCELLENT', itemWidth),
                                        buildGridItem(context, 'B2 = 70 - 79', 'VERY GOOD', itemWidth),
                                        buildGridItem(context, 'B3 = 65 - 69', 'GOOD', itemWidth),
                                        buildGridItem(context, 'C4 = 69 -64', 'CREDIT', itemWidth),
                                        buildGridItem(context, 'C5 = 55 - 59', 'CREDIT', itemWidth),
                                        buildGridItem(context, 'C6 = 59 - 54', 'CREDIT', itemWidth),
                                        buildGridItem(context, 'D7 = 45 - 49', 'FAIR', itemWidth),
                                        buildGridItem(context, 'E8 = 40 - 44', 'PASS', itemWidth),
                                        buildGridItem(context, 'F9 = 1 - 39', 'FAIL', itemWidth),
                                      ],
                                    );
                                
                                
                                  }
                                ),
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
                  
                                child: Text('Affective Trait', textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 15,),


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Agility:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Caring:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Communication:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Loving:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Punality:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Seriousness:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Honesty:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Leadership:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Perservance:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Socializtion:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Politeness:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Music:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 20,)
                  
                  
                  
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
                  
                                child: Text('Psychomotor Trait', textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 15,),


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Attentiveness:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Handling tools:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Neatness:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tools:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: 20,)
                  
                  
                  
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
                  
                                child: Text('Trait Scale', textAlign: TextAlign.center,),
                              ),
                  
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: LayoutBuilder(
                                  builder:  (context, constraints){
                                    double totalWidth = constraints.maxWidth;
                                    int itemsPerRow = 2;
                                    double spacing = 15;
                                    double itemWidth = (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;
                                
                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        buildGridItem(context, 'A = EXCELLENT', '', itemWidth),
                                        buildGridItem(context, 'B = VERY GOOD', '', itemWidth),
                                        buildGridItem(context, 'C = GOOD', '', itemWidth),
                                        buildGridItem(context, 'D = FAIR', '', itemWidth),
                                        buildGridItem(context, 'E = POOR', '', itemWidth),
                                      ],
                                    );
                                
                                
                                  }
                                ),
                              ),


                              
                  
                  
                  
                  
                            ],
                          ),
                        ),

                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  
                                child: Text('Remarks', textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 15,),


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Teacher comment:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Principal comment:'),
                                    Text('Good', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next term begins:'),
                                    Text('25th 2005', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: customColors.lightText
                                    ),)
                                  ],
                                ),
                              ),


                            
                              
                              SizedBox(height: 20,)
                  
                  
                  
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