
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/student/bills/add_bills/step2.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class BillPaymentScreen extends StatefulWidget{
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  String? selectedPaymentMethod;

  String? selectedBillType;
  String? selectedStudentClass;
  String? selectedSession;
  String? selectedTerm;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            context.pop();
          }
        ),
        title: Text('Bills Payment ', style: TextStyle(fontSize: 18)),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                    hint: Text("Select bill type"),
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
                        
                                    value: selectedBillType,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Christmas fee',
                                        child: Text('Christmas Fee')
                                      ),
                        
                                      DropdownMenuItem(
                                        value: 'utility bill',
                                        child: Text('Utitlity bill'),
                                      ),
                                    ], 
                                    onChanged: (value){
                                      setState(() {
                                        selectedBillType = value;
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
                                          MaterialPageRoute(builder: (ctx) => BillPaymentScreenTwo())
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