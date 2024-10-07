import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twongere/routes/pair_screen/widgets/paired_screen_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';

class PairedScreen extends StatefulWidget{
  const PairedScreen({super.key});


  @override
  _pairedScreenState createState ()=> _pairedScreenState();
}


class _pairedScreenState extends State<PairedScreen>{


  bool _isTextOrAudio = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primarColor,
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor,)),

        title: const Text(
          "Twogere", 
          style: AppStyles.titleWhiteTxtStyle,),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              children: [
                SizedBox(height: 20,),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:SingleDropDownWidget(
                          onChange: (p0) {
                            setState(() {
                              _isTextOrAudio = p0==0;
                            });
                          },
                          list: [ "Text/Audio","Sign Language"])),
                      // SizedBox(width: 10,),
                      // CircleAvatar (
                      //   backgroundColor: AppColors.bgGreyColor,
                      //   child:IconButton(
                      //   onPressed: (){}, 
                      //   icon: const Icon(Icons.arrow_outward, color: AppColors.blackColor,),))
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: _isTextOrAudio?TextInfoComponent(): VideoInfoComponent()),
                const SizedBox(height: 20,)
                

              ],
            ),
          ),),
    );
  }
}