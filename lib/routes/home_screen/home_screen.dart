import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/dictionary_screen/dictionary_screen.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/home_nav.dart';
import 'package:twongere/routes/home_screen/navigations/learn_screen/learn_screen.dart';
import 'package:twongere/routes/home_screen/navigations/opportunity_screen/oppotunity_screen.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _homeScreenState createState () => _homeScreenState();


}



class _homeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  int _currentIndex = 1;

  int _tabIndex = 1;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
     _scaffoldKey.currentState!.openDrawer();
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'pdf', 'doc'], // Specify file types
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // Handle file (e.g., upload to server or process)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File selected: ${file.name}'),
        ),
      );
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected.'),
        ),
      );
    }
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  late PageController pageController;

  bool isPaired= false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: AppColors.primarColor,
          leading:
        // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [

              IconButton(
            onPressed:(){
              _openDrawer();
            } , 
            icon: const Icon(Icons.menu_rounded, color: Colors.white,)
              ),

            // IconButton(
            // onPressed:(){
            //    _pickFile(context);
            // } ,
            // icon: const Icon(Icons.upload, color: Colors.white,))
            // ],
          // ),

          title: Text(tabIndex==0?"Opportunity":tabIndex==1?"Twogere":"Learn", 
          style: AppStyles.titleWhiteTxtStyle,),
          centerTitle: true,

          actions: [
            IconButton(
              onPressed: (){
                isPaired?setState(() {
                  isPaired = false; 
                  
                }): showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder:(context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(5),
                      actionsPadding: const EdgeInsets.all(5),
                      titlePadding: const EdgeInsets.all(7),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      title: const Center(
                        child:Text(
                          "Pair with",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                          ),)
                        ),
                      
                      content: PairDialogWidget(),
                      actions: [
                        TextButton(
                          onPressed: (){
                            setState(() {
                              isPaired = true;
                              Navigator.pop(context);
                            });
                          }, 
                          child: const Text(
                            "Connect",
                            style: TextStyle(
                              color: AppColors.primarColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                            ),
                          )),

                        TextButton(
                          onPressed: ()=> Navigator.pop(context) , 
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                            ),
                          ))
                      ],
                    );
                  },);
              }, 
              icon: Icon(
                !isPaired? Icons.connect_without_contact: Icons.cancel, 
                color: AppColors.whiteColor,)),

            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.notifications, color: Colors.white,)),
          ],
        ),
        
      bottomNavigationBar:  isPaired
          ? null // Hide the bottom navigation bar when isPaired is true
          : CircleNavBar(
        activeIcons: const [
          Icon(Icons.layers_outlined, color: AppColors.primarColor),
          Icon(Icons.translate, color: AppColors.primarColor),
          Icon(Icons.ac_unit_outlined, color: AppColors.primarColor),
        ],
        inactiveIcons: const [
          Text("Opportunity"),
          Text("Home"),
          Text("Learn"),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: AppColors.primarColor,
        elevation: 5,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: [
          const OpportunityScreen(),
          HomeNav(isPaired:isPaired,),
          const LearnNav(),
          
        ],
      ),

      drawer: SafeArea(
        child:Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: const SideDrawerWidget(),
              )),
      
    );
  }
}