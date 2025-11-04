
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/providers/class_notification.dart';
import 'package:mobile_app/screens/student/class_notifications/class_notifcation_details.dart';
import 'package:mobile_app/theme.dart';
import 'package:mobile_app/utils.dart';
import 'package:mobile_app/widgets/student/tabs.dart';
import 'package:mobile_app/widgets/student/menu.dart';
import 'package:mobile_app/widgets/platform_back_button.dart';

class ClassNotificationScreen extends ConsumerStatefulWidget{
  const ClassNotificationScreen({super.key});

  @override
  ConsumerState<ClassNotificationScreen> createState() => _ClassNotificationScreenState();
}

class _ClassNotificationScreenState extends ConsumerState<ClassNotificationScreen> {
  String _currentPage = 'all';
  bool _loading = true;
  final _searchController = TextEditingController();
  Timer? _debounce;

  void _showAll(){
    showLoadingDialog(context);
    _loadAllNotification('', context);

    setState(() {
      _currentPage ='all';
    });
  }

  void _showRead(){
    showLoadingDialog(context);
    _loadReadNotification('', context);
    setState(() {
      _currentPage = 'read';
    });

  }

  void _showUnRead(){
    showLoadingDialog(context);
    _loadUnreadNotification('', context);
    setState(() {
      _currentPage = 'unread';
    });

  }


  Future<void> _loadAllNotification(String query, context) async{
    final respose = await ref.read(classNotificationProvider.notifier).fetchClassNotificationPayment(query, context, '');
    if(respose != 'success'){
      showSnackbar(context, respose);
    }
    
  }

  Future<void> _loadReadNotification(String query, context) async{
    final respose = await ref.read(classNotificationProvider.notifier).fetchClassNotificationPayment(query, context, 'read');
    if(respose != 'success'){
      showSnackbar(context, respose);
    }
    hideLoadingDialog(context);
    
  }

  Future<void> _loadUnreadNotification(String query, context) async{
    final respose = await ref.read(classNotificationProvider.notifier).fetchClassNotificationPayment(query, context, 'unread');
    if(respose != 'success'){
      showSnackbar(context, respose);
    }
    hideLoadingDialog(context);
    
  }

  Future<void> _loadNotification() async{
    _loadAllNotification('', context);
    if(!mounted) return;
    if(_loading){
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

    _loadNotification();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    void openEditOverlay(){
      showModalBottomSheet(useSafeArea: true, isScrollControlled: true, context: context, builder: (ctx) => ClassNotificationDetails());
    }
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<CustomColors>()!;

    

    Widget pageTab = Row(
      spacing: 10,
      children: [
        InkWell(
          onTap: _showAll,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _currentPage == 'all' ?Theme.of(context).colorScheme.primary : customColors.lightBorder
            ),
          
            child: Text('All', 
              style: TextStyle(color: _currentPage == 'all' ? Colors.white : null,),
            
            ),
          ),
        ),


        InkWell(
          onTap: _showRead,
          
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: _currentPage == 'read' ? Theme.of(context).colorScheme.primary : customColors.lightBorder
            ),
            child: Text('Read',
              style: TextStyle(color: _currentPage == 'read' ? Colors.white : null,),
            
            ),
          ),
        ),

        InkWell(
          onTap: _showUnRead,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: _currentPage == 'unread' ? Theme.of(context).colorScheme.primary : customColors.lightBorder
            ),
            child: Text('Unread 20+',
              style: TextStyle(color: _currentPage == 'unread' ? Colors.white : null,),
            
            ),
          ),
        ),

        
      ],
    );

    Widget listContent = Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final notificationList = ref.watch(classNotificationProvider);

          if(notificationList.isEmpty){
            return  Center(child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/404.png',
                    width: 300,
                    height: 300,
                  ),
                  Text("Ooops... data not found", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),                  
                ],
              )
            );
          }

          return ListView.builder(
            itemCount: notificationList.length,
            itemBuilder: (ctx, index){
              final notice = notificationList[index];

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
                  onTap: openEditOverlay,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: customColors.lightBorder,
                    child: Icon(notice.status == 'read' ?  Icons.notifications : Icons.notifications_active_outlined,),
                  ),
                  title: Text(formatName(notice.subject)),
                  trailing: Text(formatCurrentDate(notice.date), style: TextStyle(color: customColors.lightText),),
                  subtitle: Text('${formatName(notice.text)}\nPosted by:  ${formatName(notice.text)}', 
                                  style: TextStyle(color: customColors.lightText),
                                  overflow: TextOverflow.ellipsis, maxLines: 2
                                ),
                ),
              );
            }
          );
        }),




        
    );

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        children: [
          TextField(
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
                _loadAllNotification(value, context);
              });
            },
            style: TextStyle(fontSize: 14.0), // smaller text
          ),

          SizedBox(height: 24,),

          pageTab,

          SizedBox(height: 15,),

          listContent,
      
        ],
      ),
    );



    
    
    if(_currentPage == 'read'){
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            TextField(
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
                  _loadReadNotification(value, context);
                });
              },
              style: TextStyle(fontSize: 14.0), // smaller text
            ),

            SizedBox(height: 24,),

            pageTab,

            SizedBox(height: 15,),

            listContent,
        
          ],
        ),
      );
    }


    if(_currentPage == 'unread'){
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            TextField(
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
                  _loadUnreadNotification(value, context);
                });
              },
              style: TextStyle(fontSize: 14.0), // smaller text
            ),

            SizedBox(height: 24,),

            pageTab,

            SizedBox(height: 15,),

            listContent,
        
          ],
        ),
      );
    }

    if(_loading){
      return Center(
        child: Image.asset(
          'assets/image/loading.gif',
          width: 120,
          height: 120,
        )
      );
    }



    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: PlatformBackButton(),
          onPressed: () => context.pop(),
        ),
        title: Text('Class Notifications', style: TextStyle(fontSize: 18)),
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

      body: content,

      bottomNavigationBar: StudentTab(),
      
    );
  }
}