import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/providers/student_details.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/utils.dart';
import 'package:mobile_app/widgets/custom_container.dart';
import 'package:mobile_app/widgets/store/tabs.dart';
import 'package:mobile_app/widgets/fade_images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StoreHomeScreen extends ConsumerStatefulWidget {
  const StoreHomeScreen({super.key});

  @override
  ConsumerState<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends ConsumerState<StoreHomeScreen> {

  bool _loading = true;
  String? _error;

  int activeIndex = 0;
  final controller = CarouselSliderController();


  final List<Map<String, dynamic>> _product = [
    {
      'id': 1,
      'img': 'assets/image/uniform2.png',
      'title': 'Uniform',
      'description': 'Complete school uniform for all classes',
      'price': '5000',
      'rating': 4.5,
    },
    {
      'id': 2,
      'img': 'assets/image/school_bag.png',
      'title': 'Bags',
      'description': 'Durable and spacious school bags',
      'price': '3000',
      'rating': 4.0,

    },
    { 'id': 3,
      'img': 'assets/image/shoe.png',
      'title': 'Shoes',
      'description': 'Comfortable and stylish school shoes',
      'price': '4000',
      'rating': 4.2,
    },
    {
      'id': 4,
      'img': 'assets/image/stationary.png',
      'title': 'Stationaries',
      'description': 'All essential school stationaries',
      'price': '1500',
      'rating': 4.8,
    },
  ];



  final List<String> _imgList = [
    "assets/image/school_girl.png",
    "assets/image/school_girl2.png",
    "assets/image/school_girl3.png",
  ];

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


  

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final studentDetails = ref.watch(studentDetailsProvider);

    Widget buildGridItem(
      BuildContext context, 
      String img,  
      String title,
      String description,
      String price,
      double width,
      Function() onAddToCart,
    ){

      return InkWell(
        onTap: (){
          context.push('/store/product/individual');
        },
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Background container
                  CustomContainer(
                    height: 200,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(0),
                  ),
              
                  // Favorite icon at top-right
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined),
                    ),
                  ),
              
                  // Image that adjusts automatically to container without cropping
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, top: 10),
                      child: FittedBox(
                        fit: BoxFit.contain, // ✅ Show full image without cutting
                        child: Image.asset(
                          img,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 10,),
        
              Text(formatName(title), style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,),
              Text(formatName(description),
                overflow: TextOverflow.ellipsis, maxLines: 1,
                style: TextStyle(
                  color: customColors.lightText
                ),
              ),
        
              SizedBox(height: 5,),
        
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.amber,),
                  Icon(Icons.star, size: 20, color: Colors.amber,),
                  Icon(Icons.star, size: 20, color: Colors.amber,),
                  Icon(Icons.star_half, size: 20, color: Colors.amber,),
                  Icon(Icons.star_border_outlined, size: 20, color: customColors.lightText,),
                ],
              ),
        
              SizedBox(height: 5,),
        
              Text('NGN ${formatMoney(price)}', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),),
        
              SizedBox(height: 15,),
        
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton.icon(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
                  label:Text(
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
      );

    }
  
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
      appBar: AppBar(
        titleSpacing: 15, // optional: removes default left padding
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(studentDetails.passport),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${formatName(studentDetails.firstName)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: customColors.lightText

                      ),
                ),
                Text(
                  'Good ${getTimeOfDayGreeting()}!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () => context.push('/store/cart'),
            child: CustomContainer(
              child: Icon(Icons.shopping_cart_outlined),
            ),
          ),

          const SizedBox(width: 15),

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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            // controller: _searchController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 12.0),
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),               
                            ),
                            style: TextStyle(fontSize: 14.0), // smaller text
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: customColors.lightBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.filter_list),
                        )


                      ],

                    ),

                    SizedBox(height: 5,),

                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/image/background4.png'), // Replace with your image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          right: 5,
                          
                          child: FadeCarousel(width: 200, height: 200, duration: 5, images: _imgList,),
                        ),

                        Positioned(
                          left: 15,
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25,),
                              Text(
                                'Get Your\nSpecial sale\nUp to 50%',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                
                              ),

                              SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: customColors.lightBorder,
                                  foregroundColor: Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19
                            ),
                         
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Text(  
                            'See All',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          )
                        ),
                      ],
                    ),

                    Row(
                      spacing: 10,
                      children: [
                        InkWell(
                          child: CustomContainer(
                            color: Theme.of(context).colorScheme.primary,
                            child: Text('All', style: TextStyle(color: Colors.white),),
                            
                          ),
                        ),

                        InkWell(
                          child: CustomContainer(
                            child: Text('Uniform'),
                          ),
                        ),

                        InkWell(
                          child: CustomContainer(
                            child: Text('Sport Wear'),
                          ),
                        ),

                        InkWell(
                          child: CustomContainer(
                            child: Text('Stationaries'),
                          ),
                        ),


                      ],
                    ),

                    SizedBox(height: 5,),

                    Text(
                      'New Product',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                        ),
                      
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: 
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double totalWidth = constraints.maxWidth;
                                int itemsPerRow = 2; // Or 4 depending on screen size or design
           
                                
                                double spacing = 15;
                                double itemWidth = (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;
           
                                return Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: [
                                    buildGridItem(context, 'assets/image/school_girl2.png', 'Lady School Uniform', 'This is a girl full dressed with complete uniform', '50,000', itemWidth, (){
                                      context.push('/eh/');
                                    }),
                                    buildGridItem(context, 'assets/image/boy.png', 'Boy School Uniform', 'This is a boy full dressed with complete uniform', '36,210', itemWidth, (){}),
                                    buildGridItem(context, 'assets/image/uniform.png', 'School Uniform', 'Our new quality uniform, made of slik and fibre', '75,300', itemWidth, (){}),
                                    buildGridItem(context, 'assets/image/school_girl4.png', 'Grade 4 Monday Wear', 'Our new quality uniform, made of slik and fibre', '13,300', itemWidth, (){}),
                                  ],
                                );
                              },
                            ),                 
                    ),


                    SizedBox(height: 10,),

                    Text(
                      'Popular Product',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                      
                    ),

                    Column(
                      children: [
                        CarouselSlider.builder(
                          carouselController: controller,
                          itemCount: _product.length, 
                          itemBuilder: (context, index, realIndex){
                            // return Image.asset(_product[index]['img'])
                            return CustomContainer(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(_product[index]['img'], height: 100, width: 100,),
                                  

                                  SizedBox(width: 20,),

                                  Expanded(
                                    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(formatName(_product[index]['title']), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        SizedBox(height: 5,),
                                        

                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 14, color: Colors.amber,),
                                            Text(
                                              '${_product[index]['rating']} [star rating]',
                                              style: TextStyle(
                                                
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),

                                        SizedBox(height: 10,),

                                        Text('NGN ${formatMoney(_product[index]['price'])}', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),),

                                        SizedBox(height: 10,),

                                        Expanded(
                                          child: Row(
                                            spacing: 8,
                                            children: [
                                              InkWell(
                                                child: Icon(Icons.add_shopping_cart, size: 20,)
                                              ),
                                              InkWell(
                                                child: Icon(Icons.favorite_outline, size: 20,)
                                              ),
                                              
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }, 
                          options: CarouselOptions(
                            height: 130,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) => setState(() => activeIndex = index),
                          )
                        ),

                        const SizedBox(height: 12),

                        AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: _product.length,
                          effect: ExpandingDotsEffect( // you can change style
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Theme.of(context).colorScheme.primary,
                            dotColor: Colors.grey,
                          ),
                          onDotClicked: (index) => controller.animateToPage(index),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Text(
                      'Special Offer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                      
                    ),

                    CustomContainer(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(                
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('School Uniform', style: Theme.of(context).textTheme.titleLarge,),
                                SizedBox(height: 10,),
                                Text('Complete school uniform for all classes', overflow: TextOverflow.ellipsis, maxLines: 2,),
                                SizedBox(height: 5,),
                                Row(
                                  
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
                                SizedBox(height: 10,),

                                Text('NGN 4,000', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                ),),
                            
                                SizedBox(height: 15,),
                            
                                SizedBox(
                                      height: 35,
                                      child: ElevatedButton.icon(
                                        onPressed: (){},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        ),
                                        icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
                                        label:Text(
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

                          SizedBox(width: 20,),
                          

                          Expanded(
                            flex: 5,
                            child: Image.asset('assets/image/uniform_set.png')
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 15,),


                    Text(
                      'Uniform category',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                        ),
                      
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: 
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double totalWidth = constraints.maxWidth;
                                int itemsPerRow = 2; // Or 4 depending on screen size or design
           
                                
                                double spacing = 15;
                                double itemWidth = (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;
           
                                return Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: [
                                    buildGridItem(context, 'assets/image/school_girl2.png', 'Lady School Uniform', 'This is a girl full dressed with complete uniform', '50,000', itemWidth, (){}),
                                    buildGridItem(context, 'assets/image/boy.png', 'Boy School Uniform', 'This is a boy full dressed with complete uniform', '36,210', itemWidth, (){}),
                                    buildGridItem(context, 'assets/image/uniform.png', 'School Uniform', 'Our new quality uniform, made of slik and fibre', '75,300', itemWidth, (){}),
                                    buildGridItem(context, 'assets/image/school_girl4.png', 'Grade 4 Monday Wear', 'Our new quality uniform, made of slik and fibre', '13,300', itemWidth, (){}),
                                  ],
                                );
                              },
                            ),                 
                    )

                    


                    

                  ],
                  

                ),
              ),
            ),
         ),
          
          
          


        ],
      ),

      bottomNavigationBar: StoreTab(),
      
    );
  }
}