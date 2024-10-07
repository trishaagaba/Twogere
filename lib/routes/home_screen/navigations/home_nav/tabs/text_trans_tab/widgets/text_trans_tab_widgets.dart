import 'package:flutter/material.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';

class TxtTransTop extends StatelessWidget{
  const TxtTransTop({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric( vertical: 10),
      child:const Cordionwidget(list: ["Sign langauge", "English", "Spanish"]),
    );
  }
}

class FirstTxt extends StatelessWidget{
  final TextEditingController controller;
  const FirstTxt({
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.bgGreyColor,
        border: Border.all(color: const Color.fromARGB(255, 224, 224, 224), width: 2)
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical:10),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Expanded(
            child:TextField(
              maxLines: 100,
            controller: controller,
            style: AppStyles.normalBlackTxtStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter text to translate",
              hintStyle: AppStyles.normalGreyColorTxtStyle
            ),
          )),
          const SizedBox(height: 10,),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      // const SizedBox(
                      //   child: Column(
                      //     children: [
                      //       Icon(Icons.volume_up_outlined, color: AppColors.blackColor, size: 20,),
                      //       Text("Liston", style: AppStyles.normalBlackTxtStyle,)
                      //     ],
                      //   ),
                      // ),

                      // Container(
                      //   width: 1.5,
                      //   height: 30,
                      //   color: Color.fromARGB(255, 212, 212, 212),
                      //   margin: const EdgeInsets.symmetric(horizontal: 15),
                      // ),
                      const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.mic, color: AppColors.blackColor, size: 20,),
                            // Text("Voice", style: AppStyles.normalBlackTxtStyle,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.send_rounded, color: AppColors.primarColor, size: 20,),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}


class TranslatedTextWidget extends StatelessWidget{
  final String language;
  final String text;

  const TranslatedTextWidget({
    required this.text,
    required this.language,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.bgGreyColor,
        border: Border.all(color: const Color.fromARGB(255, 224, 224, 224), width: 2)
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              children: [
                Text(language, style: AppStyles.normalPrimaryColorTxtStyle,),
                const SizedBox(width: 10,),
                const Icon(Icons.volume_up_outlined, color: AppColors.blackColor, size: 20,)
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: Text(text, style: AppStyles.normalBlackTxtStyle,),
            )),
          const SizedBox(height: 10,),
          const SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.share, color: AppColors.blackColor, size: 20,),
                SizedBox(width: 10,),
                Icon(Icons.star_border_outlined, color: AppColors.blackColor, size: 20,),
                SizedBox(width: 10,),
                Icon(Icons.copy, color: AppColors.blackColor, size: 20,)
              ],
            ),
          )
        ],
      ),
    );
  }
}



