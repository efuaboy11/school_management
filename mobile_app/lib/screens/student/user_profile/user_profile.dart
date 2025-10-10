import 'package:flutter/material.dart';
import 'package:mobile_app/screens/student/user_profile/edit_user_contact_info.dart';
import 'package:mobile_app/screens/student/user_profile/edit_user_personal_information.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/widgets/student/tabs.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    void openEditPersonalInfoOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => EditUserPersonalInformation());
    }

    void openEditContactInfoOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => EditUserContactInformation());
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
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows profile image to overflow
            children: [
              // Background rectangle with image
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/background2.png'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Profile image at bottom center, half outside
              Positioned(
                bottom: -50, // Half of the circle will hang outside
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/image/passports.jpg'), // Replace with user image
                  ),
                ),
              ),

              Positioned(
                bottom: -70, // Half of the circle will hang outside
                
                right: 20,
                
                child: Image.asset('assets/image/verified.png', height: 30, width: 30,)
              ),
            ],
          ),

          const SizedBox(height: 60), 
          Text('Iseghohimhen Efua', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge,),
          Text('Primary 1', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  spacing: 10,
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
              
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Personal Information'),
                                OutlinedButton.icon(
                                  onPressed: openEditPersonalInfoOverlay,
                                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                                  label: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                    buildGridItem(context, 'Student ID', 'stuban710', itemWidth),
                                    buildGridItem(context, 'D.0.B', '7 may 2025', itemWidth),
                                    buildGridItem(context, 'Gender', 'Male', itemWidth),
                                    buildGridItem(context, 'Father Name', 'Alfred', itemWidth),
                                    buildGridItem(context, 'Mothers name', 'Mothers Name', itemWidth),
                                    buildGridItem(context, 'Disability', 'No', itemWidth),
                                    buildGridItem(context, 'Religion', 'Muslim', itemWidth),
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
              
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('School Information'),
                                
                              ],
                            ),
                          ),
              
                          SizedBox(height: 15,),


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account username:'),
                                Text('Oluwabunmi', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('Current class:'),
                                Text('Primary 1', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('Admission number:'),
                                Text('7887', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('Account Status:'),
                                Text('Active', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
              
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Contact Information'),
                                OutlinedButton.icon(
                                  onPressed: openEditContactInfoOverlay,
                                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                                  label: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              
                          SizedBox(height: 15,),


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('State of Origin:'),
                                Text('Edo', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('City/town:'),
                                Text('Benin', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('House Address:'),
                                Text('Adolo college', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                Text('Phone number:'),
                                Text('08079022633', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                ),

              ),
            )
          )
          
          
        ],
      ),
      bottomNavigationBar: StudentTab(),

    );
  }
}