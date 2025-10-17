
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class BillsDetailScreen extends StatelessWidget{
  const BillsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: PlatformBackButton(),
          onPressed: () => context.pop(),
        ),
        title: Text('Payment Details ', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(onPressed: (){
            context.push('/student/bills-payment');
          }, icon: Icon(Icons.attach_money,)),
          IconButton(
            icon: Icon(Icons.menu),
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
              alignment: Alignment.center,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Payment Receipt', style: TextStyle(fontSize: 20),),
                ),
              ),
            ),

            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Transaction',
                              style: TextStyle(fontSize: 17),
                              children: [
                                TextSpan(
                                  text: ' #969A83202B19AB71',
                                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary)
                                )
                              ]
                            )
                          ),

                          SizedBox(height: 20,), 

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
                              title: Text('200.00 NGN'),
                              subtitle: Text('Date: 27th may 2023'),

                              trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: customColors.pending,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child:Row(
                                  mainAxisSize: MainAxisSize.min, // Wraps content instead of taking full width
                                  children: [
                                    Icon(Icons.hourglass_top, color: Colors.white,), // Use any icon you want
                                    SizedBox(width: 8), // Spacing between icon and text
                                    Text('Pending', style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: customColors.lightBorder,
                                  width: 1.0
                                )
                              )
                              
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('In Transaction', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                SizedBox(height: 25,),

                                Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Transaction ID', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('969A83202B19AB71'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Bill Type', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('Utility and resources Bills'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Amount', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('300 NGN'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Payment Methos', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('Online Payment'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Bill Payment Description', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('Uitility resources'),
                                      ],
                                    ),
                                                
                                
                                  ],
                                ),
                          ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: customColors.lightBorder,
                                  width: 1.0
                                )
                              )
                              
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('In Account', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                SizedBox(height: 25,),

                                Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('User ID', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('othmar964'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('User account', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('Ben Mark'),
                                      ],
                                    ),
                                
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Email', style: TextStyle(color: customColors.lightText, fontSize: 15),),
                                        Text('Augustsailor01@gmail.com'),
                                      ],
                                    ),
                                
                                  
                                
                                  
                
                                
                                
                                  ],
                                ),
                                
                              ],
                            ),
                          ),


                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Transaction Proof', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                SizedBox(height: 25,),

                                Image.asset('assets/image/receipt.jpg',
                                  width: double.infinity,
                                  height: 300,
                                  
                                )

                                
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    
                  ),
                ),
              ),
            )

            

            
        
          ],
        ),
      ),

      bottomNavigationBar: StudentTab(),
      
    );
  }
}