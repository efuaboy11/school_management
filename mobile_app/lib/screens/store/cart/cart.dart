
import 'package:flutter/material.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/custom_container.dart';
import 'package:mobile_app/widgets/store/tabs.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('My cart', style: TextStyle(fontSize: 18)),
        actions: [
          InkWell(
            child: CustomContainer(
              child: Icon(Icons.logout),
            ),
          ),       

          const SizedBox(width: 15),
        ],


      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    spacing: 15,
                    children: [
                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/uniform.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),

                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/uniform2.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),

                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/school_girl.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),    

                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/stationary.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),                     


                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/shoe.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),    



                      CustomContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/image/school_girl3.png',
                                height: 120,
                                fit: BoxFit.contain,
                              )
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('School Uniform', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text('This is the school uniform for all students.', overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  

                                  Row(
                                    
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.amber,),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          
                                          fontSize: 14,
                                        ),
                                      ),                    
                                    ],
                                  ),
                                  
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: customColors.lightBorder),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Size'),
                                            SizedBox(width: 10,),
                                        
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Text('M'),
                                                  Icon(Icons.arrow_drop_down),
                                        
                                                ],
                                              ),
                                            )
                                          ],
                                        
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.remove_circle_outline, size: 20,),
                                          SizedBox(width: 8,),
                                          Text('1', style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 8,),
                                          Icon(Icons.add_circle_outline, size: 20,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            
                            ),
                            
                            SizedBox(width: 10,),
                            Icon(
                              Icons.delete_outline
                            ),
                          ],
                        ),
                      ),    
                    ],
                  ),
                ),
              ),
            ),
          ),



          SizedBox(height: 20,),
          CustomContainer(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text("Subtotal: ₦12,000", style: TextStyle(fontSize: 19),),
                SizedBox(height: 10,),
                const Divider(),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),

          

          
      
        ],
      ),
      

      bottomNavigationBar: StoreTab(),
      
    );
  }
}