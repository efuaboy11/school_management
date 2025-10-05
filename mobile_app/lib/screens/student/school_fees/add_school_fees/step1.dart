
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/student/school_fees/add_school_fees/step2.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class SchoolFeesPaymentScreen extends StatefulWidget{
  const SchoolFeesPaymentScreen({super.key});

  @override
  State<SchoolFeesPaymentScreen> createState() => _SchoolFeesPaymentScreenState();
}

class _SchoolFeesPaymentScreenState extends State<SchoolFeesPaymentScreen> {
  String? selectedPaymentMethod;

  String? selectedFeeType;
  String? selectedStudentClass;
  String? selectedSession;
  String? selectedTerm;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: Colors.white,),
          onPressed: (){
            context.pop();
          }
        ),
        title: Text('School Fees Payment ', style: TextStyle(color: Colors.white),),
        actions: [
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

      body:
        Column(
          children: [
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(  
                            children: [
                              Text('This step is to verify the fees details and ensure they are authentic.', style: TextStyle(fontSize: 19), textAlign: TextAlign.center,),
                              SizedBox(height: 5,),
                              Text('Note: Please enter the verified details for the specific fee you intend to pay.', style: TextStyle(color: customColors.lightText), textAlign: TextAlign.center,),
                              SizedBox(height: 20,),
                  
                            ],
                  
                          )
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(18),
                            
                            child: Form(
                              child: Column(
                                spacing: 20,
                                children: [
                                  DropdownButtonFormField(
                                    hint: Text("Select payment method"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      prefixIcon: Icon(Icons.payment),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select a payment method';
                                      }
                                      return null;
                                    },
                                    value: selectedPaymentMethod,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'cash',
                                        child: Text('Cash payment')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'card',
                                        child: Text('Card payment'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedPaymentMethod = value;
                                      });
                                    }
                                  ),
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select fee type"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select a fee type';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedFeeType,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'school_fees',
                                        child: Text('School Fees')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'P.T.A',
                                        child: Text('P.T.A payment'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedFeeType = value;
                                      });
                                    }
                                  ),
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select student class"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select student class';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedStudentClass,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'primary 1',
                                        child: Text('Primary 1')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'primary 2',
                                        child: Text('Primary 2'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedStudentClass = value;
                                      });
                                    }
                                  ),
                        
                        
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select Session"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select session';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedSession,
                                    items: [
                                      DropdownMenuItem(
                                        value: '2021/2022',
                                        child: Text('2021/2022')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: '2022/2023',
                                        child: Text('2022/2023'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedSession = value;
                                      });
                                    }
                                  ),
                        
                        
                        
                                  DropdownButtonFormField(
                                    hint: Text("Select Term"),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                      
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      
                                      
                                    ),
                                    
                                    validator: (value){
                                      if(value == null){
                                        return 'Please select term';
                                      }
                                      return null;
                                    },
                        
                                    value: selectedTerm,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'first term',
                                        child: Text('first term')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'Second Term',
                                        child: Text('Second Term'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedSession = value;
                                      });
                                    }
                                  ),
                        
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // context.push('/student/pay-2');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) => SchoolFeesPaymentScreenTwo())
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            )
                              
                            
                          ),
                          
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            

            
        
          ],
        ),
      

      bottomNavigationBar: StudentTab(),
      
    );
  }
}