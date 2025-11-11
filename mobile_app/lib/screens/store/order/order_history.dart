
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/providers/school_fee.dart';

import 'package:mobile_app/theme.dart';
import 'package:mobile_app/utils.dart';
import 'package:mobile_app/widgets/custom_container.dart';
import 'package:mobile_app/widgets/store/tabs.dart';
import 'dart:async';


class OrderHistoryScreen extends ConsumerStatefulWidget{
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
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
      final respose = await ref.read(schoolFeesProvider.notifier).fetchSchoolFeesPayment(query, context, '');
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
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;


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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),               
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _loadPaymentDetails(value, context);
                });
              },
              style: TextStyle(fontSize: 14.0), // smaller text
            ),

            SizedBox(height: 15,),

            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final schoolFeesList = ref.watch(schoolFeesProvider);
                  if (schoolFeesList.isEmpty) {
                    return  Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image/404.png',
                            width: 300,
                            height: 300,
                          ),
                          Text("No matching fee found", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),
                          

                        ],
                      )
                    );
                  }
                  return ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: schoolFeesList.length,
                    itemBuilder: (ctx, index){
                      final fee = schoolFeesList[index];
                  
                      Widget status = CircleAvatar(
                        backgroundColor: customColors.successful,
                        child: Icon(Icons.check,  color: Colors.white,),
                      );
                  
                      if(fee.status == 'pending'){
                        status = CircleAvatar(
                          backgroundColor: customColors.pending,
                          child: Icon(Icons.hourglass_top,  color: Colors.white,),
                        );
                      }
                  
                      if(fee.status == 'declined'){
                        status = CircleAvatar(
                          backgroundColor: customColors.declined,
                          child: Icon(Icons.cancel_outlined, color: Colors.white,),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: customColors.lightBorder,
                              width: 1.0
                            )
                          )
                          
                        ),
                        child: ListTile(
                          
                          onTap: (){
                            context.push('/store/orders/receipt');
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (ctx) => SchoolFeesDetailScreen(feeDetails: fee,)) 
                            // );
                          },
                          contentPadding: EdgeInsets.zero,
                        
                          leading: status,
                          title: Text(formatName(fee.feeTypeDetails['fee_choice'])),
                          trailing: Text('${formatMoney(fee.feeTypeDetails['amount'].toString())} NGN', style: TextStyle(fontSize: 14),),
                          subtitle: Text(formatDate(fee.date)),
                        ),
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
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('My Orders', style: TextStyle(fontSize: 18)),
        actions: [
          InkWell(
            child: CustomContainer(
              child: Icon(Icons.logout),
            ),
          ),       

          const SizedBox(width: 15),
        ],


      ),

      body: content,

      bottomNavigationBar: StoreTab(),
      
    );
  }
}