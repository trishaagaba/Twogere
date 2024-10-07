import 'package:flutter/material.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';

class BottomNavBar extends StatelessWidget{
  final Function(int) onChange;
  final int currentIndex;
  const BottomNavBar({super.key, required this.onChange, required this.currentIndex});


  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
        builder: (context, dimen){

          double width1 = dimen.maxWidth*0.30;
          double width2 = ((dimen.maxWidth - ((dimen.maxWidth*0.30)*3)));

          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints:  const BoxConstraints.expand(height: 80),
                  decoration: const BoxDecoration(
                    color: AppColors.bgGreyColor
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width1,
                        child:IconButton(
                        onPressed: ()=> onChange(0), 
                        icon: const UnitNavItem(label: "Learn", 
                        icon: Icon(Icons.photo_camera)))),

                      SizedBox(width: width2-10,),

                      SizedBox(
                        width: width1,
                        child:IconButton(
                        onPressed: ()=> onChange(2), 
                        icon: const UnitNavItem(label: "Dictionary", 
                        icon: Icon(Icons.mic)))),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: ()=> onChange(1), 
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child:CircleAvatar(
                      radius: 41, 
                      backgroundColor: Colors.white,
                      child:Padding(
                        padding: EdgeInsets.all(1),
                        child:CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primarColor,
                      child: Icon(Icons.translate, color: Colors.white,),))),))
              )
            ],
          );
        },
    );
  }
}


class UnitNavItem extends StatelessWidget{
 final String label;
 final Widget icon;
 const UnitNavItem({
  required this.label,
  required this.icon,
  super.key
 });


  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        icon,
        Expanded(
          child:Text(label, style: AppStyles.smallBlackTxtStyle, maxLines: 1,))
      ],
    );
  }

}