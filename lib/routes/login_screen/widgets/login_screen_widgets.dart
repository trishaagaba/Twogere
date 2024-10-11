import 'package:flutter/material.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';

class TextInputWidget extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final EdgeInsets contentPadding;

  const TextInputWidget({ 
    required this.controller, 
    required this.hintText,
    required this.isPassword,
    this.suffixIcon,
    required this.contentPadding,
    this.keyboardType,
    super.key, required bool isOutlined, required Color outlineColor, });


  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(

        // borderRadius: BorderRadius.circular(15),
        // border: Border.all(color: AppColors.bgGreyColor, width: 2)
      ),

      // padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller:  controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        obscuringCharacter: "*",
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarColor, width: 2),
            ),
         border: InputBorder.none,
         hintText: hintText,
         hintStyle: AppStyles.normalGreyColorTxtStyle,
            suffixIcon: suffixIcon
        ),
      ),
    );
  }
}




class PhoneInputWidget extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  const PhoneInputWidget({ 
    required this.controller, 
    required this.hintText,
    this.keyboardType,
    this.contentPadding,
    required this.isPassword,
    super.key, required bool isOutlined, required Color outlineColor});


  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.bgGreyColor, width: 2)
      ),

      // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          TextButton(
            onPressed: (){}, 
            child: const Text("+256", style: AppStyles.normalBlackTxtStyle,)),
            Container(
              width: 2,
              height: 30,
              color: AppColors.bgGreyColor,
            ),
            const SizedBox(width: 5,),
          Expanded(
            child:TextFormField(
        controller:  controller,
        obscureText: isPassword,
         keyboardType: keyboardType,
        obscuringCharacter: "*",
        decoration: InputDecoration(
         // border: InputBorder.none,
         hintText: hintText,
            // contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12),

         hintStyle: AppStyles.normalGreyColorTxtStyle
        ),
      ))
        ],
      ),
    );
  }
}