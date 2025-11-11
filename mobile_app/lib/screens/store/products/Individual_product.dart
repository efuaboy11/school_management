import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/providers/student_details.dart';
import 'package:mobile_app/widgets/custom_container.dart';
import 'package:mobile_app/widgets/fade_images.dart';
import 'package:mobile_app/widgets/liquid_display.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';
import 'package:mobile_app/widgets/store/tabs.dart';

class IndividualProductScreen extends ConsumerStatefulWidget {
  const IndividualProductScreen({super.key});

  @override
  ConsumerState<IndividualProductScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<IndividualProductScreen> {
  bool _loading = true;
  String? _error;

  final List<String> _imgList = [
    "assets/image/uniform_set.png",
    "assets/image/school_girl2.png",
    "assets/image/school_girl3.png",
  ];

  @override
  void initState() {
    super.initState();
    AuthService.isTokenExpired().then((isExpired){
      if(isExpired) {
        if(!mounted) return;
        context.go('/login');
        AuthService.logout();
      }
    });
    _loadStudentDetails();
  }

  Future<void> _loadStudentDetails() async{
    try{
      final respose = await ref.read(studentDetailsProvider.notifier).fetchStudentDetails(context);
      if(respose != 'success'){
        _error = respose;
      }
    }finally{
      setState(() {
        _loading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    // final studentDetails = ref.watch(studentDetailsProvider);
    // final customColors = Theme.of(context).extension<CustomColors>()!;


    if (_loading) {
      return Scaffold(
        body: Center(
          child: Image.asset(
            'assets/image/loading.gif',
            width: 120,
            height: 120,
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/error.png',
              width: 300,
              height: 300,
            ),
            Text("Error: $_error", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: 15,),
            ElevatedButton.icon(
              icon: Icon(Icons.dashboard),
              label: Text('Home'),
              onPressed: () {
                context.go('/student/home');
              },
            ),

          ],
        )),
        bottomNavigationBar: StoreTab(),
      );
    }


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows profile image to overflow
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/background5.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              Positioned(
                top: 80,
                left: 10,
                child: LiquidDisplay(
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: (){
                      context.pop();
                    },
                    child: PlatformBackButton(),
                  )
                ),
              ),

              Positioned(
                top: 80,
                right: 10,
                child: LiquidDisplay(
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: (){
                      // context.pop();
                    },
                    child: Icon(Icons.logout),
                  )
                ),
              ),


              Positioned(
                top: 40,
                left: 30,
                
                child: FadeCarousel(width: 350, height: 350, duration: 15, images: _imgList,),
              ),
            ],
          ), 


          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('School Uniform', 
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),

                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.favorite, color: const Color.fromARGB(255, 240, 32, 17),)
                        )
                      ],
                    ),
                    CustomContainer(    
                      width: 150,
                      child: Row(
                                  
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber,),
                          Text(
                            '4.5 [star rating]',
                            style: TextStyle(
                              
                              fontSize: 14,
                            ),
                          ),                    
                        ],
                      ),
                    ),

                    LiquidDisplay(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('NGN 5,000', style: TextStyle(fontSize: 18),),
                          Icon(Icons.monetization_on)

                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Text('Lorem ipsum dolor sit amet consectetur adipisicing elit. Amet sequi porro cumque incidunt dolorum id enim quibusdam quod autem. Aperiam quasi, saepe dignissimos quo necessitatibus enim rerum deserunt amet numquam!'),

                    SizedBox(height: 10,),

                    SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child:Text(
                              "Add to cart",
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
            )
          )
          
          
        ],
      ),
      bottomNavigationBar: StoreTab(),

    );
  }
}