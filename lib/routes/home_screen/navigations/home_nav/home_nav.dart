import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/tabs/text_trans_tab/text_trans_tab.dart';
import 'package:twongere/routes/pair_screen/widgets/paired_screen_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';

class HomeNav extends StatefulWidget{
  final bool isPaired;
  const HomeNav({super.key, required this.isPaired});

  @override
  _homeNavState createState ()=> _homeNavState();
  
}

class _homeNavState extends State<HomeNav> with WidgetsBindingObserver{

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

      int _currentCamera = 0;

    bool isText = true;



  @override
  Widget build(BuildContext context){
    return   DefaultTabController(
      length: 5, 
      child: Scaffold(

        body: SafeArea(
          child: widget.isPaired? Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        isText = !isText;
                      });
                    }, icon: Icon(Icons.compare_arrows_sharp, color: AppColors.primarColor,)),
                ),
                
                Expanded(
                  child:isText? TextInfoComponent():VideoInfoComponent()),
                  SizedBox(height: 10,)
              ],
            ))
          : const TextTransTab(),),


      ));
  }
}