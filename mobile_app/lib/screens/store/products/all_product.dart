
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/providers/billls.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/utils.dart';
import 'package:mobile_app/widgets/custom_container.dart';
import 'package:mobile_app/widgets/store/tabs.dart';
import 'dart:async';


class AllProductScreen extends ConsumerStatefulWidget{
  const AllProductScreen({super.key});

  @override
  ConsumerState<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends ConsumerState<AllProductScreen> {
  bool _loading = true;
  String? _error;
  final _searchController = TextEditingController();
  Timer? _debounce;



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

    _loadPaymentDetails('', context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }


  Future<void> _loadPaymentDetails(String query, context) async{
    try{
      final respose = await ref.read(billsProvider.notifier).fetchBillsPayment(query, context, '');
      if(respose != 'success'){
        _error = respose;
      }
    }finally{
      if(_loading){
        setState(() {
          _loading = false;
        });
      }
      
    }
  }



  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    Widget buildGridItem(
      BuildContext context, 
      String img,  
      String title,
      String description,
      String price,
      double width,
      Function() onAddToCart,
    ){

      return SizedBox(
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
      );

    }


    Widget content = Center(
      child: Text('Welcome'),
    );

    if(_loading){
      content = Center(
        child: Image.asset(
          'assets/image/loading.gif',
          width: 120,
          height: 120,
        )
      );
    }

    if(_error != null){
      content = Center(child: Column(
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
      ));
    }

    if(!_loading && _error == null){
      content = Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
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

            SizedBox(height: 15,),

            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final billsList = ref.watch(billsProvider);
                  if (billsList.isEmpty) {
                    return  Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image/404.png',
                            width: 300,
                            height: 300,
                          ),
                          Text("No product found", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),
                          

                        ],
                      )
                    );
                  }

                  
                  return ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: billsList.length,
                    itemBuilder: (ctx, index){
                      // final bill = billsList[index];

                      return LayoutBuilder(
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
                            );
                    },  
                  );
                },
                
                
              ),
            )
        
          ],
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        
        title: Text('Product',  style: TextStyle(fontSize: 18),),
        actions: [
          InkWell(
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
        // backgroundColor: Theme.of(context).colorScheme.primary , // 👈 fully transparent
         // 👈 removes shadow

      ),

      body: content,

      bottomNavigationBar: StoreTab(),
      
    );
  }
}