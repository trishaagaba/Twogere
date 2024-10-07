import 'package:flutter/material.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';

class TopSearchWidget extends StatelessWidget{
  final TextEditingController controller;
  const TopSearchWidget({super.key, required this.controller});


  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: AppStyles.normalBlackTxtStyle,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter text to search",
                hintStyle: AppStyles.normalGreyColorTxtStyle
              ),)),
          const SizedBox(width:  10,),
          const Icon(Icons.manage_search_sharp, color: AppColors.blackColor,)
        ],
      ),
    );
  }

}

class AudioWidget extends StatelessWidget{
  const AudioWidget({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(10),
      child: const Row(
        children: [
          Expanded(child: Divider(thickness: 2, color: AppColors.blackColor,)),
          SizedBox(width:  10,),
          Icon(Icons.play_arrow, color: AppColors.blackColor,)
        ],
      ),
    );
  }

}



class SelectLangaugeWidget extends StatelessWidget{
  const SelectLangaugeWidget({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(5),
      child: const Row(
        children: [
          CircleAvatar(radius: 20,),
          Expanded(child: Text("Select your langauge", style: AppStyles.normalPrimaryColorTxtStyle,)),
          SizedBox(width:  10,),
          Icon(Icons.keyboard_arrow_down, color: AppColors.blackColor,),
          SizedBox(width:  10,),
        ],
      ),
    );
  }

}