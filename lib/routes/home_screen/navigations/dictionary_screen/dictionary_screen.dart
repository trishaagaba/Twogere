import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/dictionary_screen/widgets/dictionary_nav_widget.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/tabs/text_trans_tab/widgets/text_trans_tab_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';

class DictionaryNav extends StatefulWidget{
  const DictionaryNav({super.key});

  @override
  _dictionaryNavState createState ()=> _dictionaryNavState();

}

class _dictionaryNavState extends State<DictionaryNav>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();


  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      

        body:  SafeArea(
          child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            TopSearchWidget(controller: controller,),
            const SizedBox(height: 20,),
            const Text("Text translation", style: AppStyles.normalGreyColorTxtStyle,),
            const SizedBox(height: 10,),
            Container(
              constraints: const BoxConstraints.expand(height: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.bgGreyColor
              ),
              padding: const EdgeInsets.all(16),
              child: const Text("The translation for the search here..", style: AppStyles.normalGreyColorTxtStyle,),
            ),

            const SizedBox(height: 50,),
            const Text("Speech translation", style: AppStyles.normalGreyColorTxtStyle,),
            const SizedBox(height: 10,),
            const AudioWidget(),
            const SizedBox(height: 50,),
            const Text("Speech translation", style: AppStyles.normalGreyColorTxtStyle,),
            const SizedBox(height: 10,),
            const SingleDropDownWidget(list: [
              "English","Luganda","Sign language"])
            // const TxtTransTop(),
            
          ],
        ),
      ), 
      ),),


      );
  }
}



