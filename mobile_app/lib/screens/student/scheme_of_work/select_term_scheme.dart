
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class SelectTermSchemeScreen extends StatefulWidget{
  const SelectTermSchemeScreen({super.key});

  @override
  State<SelectTermSchemeScreen> createState() => _SelectTermSchemeScreenState();
}

class _SelectTermSchemeScreenState extends State<SelectTermSchemeScreen> {
  String? selectedTerm;
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
        child: MenuBarWidget()
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Center(
          child:
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    child: Column(
                      spacing: 20,
                      children: [
                        DropdownButtonFormField(
                          hint: Text("Select term"),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                            
                            prefixIcon: Icon(Icons.payment),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            
                            
                          ),
                          
                          validator: (value){
                            if(value == null){
                              return 'Please select a term';
                            }
                            return null;
                          },
                          value: selectedTerm,
                          items: [
                            DropdownMenuItem(
                              value: 'First term',
                              child: Text('First Term')
                            ),
                            
                            DropdownMenuItem(
                              value: 'card',
                              child: Text('Second Term'),
                            ),
                          ], 
                          onChanged: (value){
                            setState(() {
                              selectedTerm = value;
                            });
                          }
                        ),
                            
                        
                            
                        
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/student/scheme');
                              
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