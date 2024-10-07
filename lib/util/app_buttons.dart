import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twongere/util/app_fontsize.dart';

class CorneredButton  extends StatelessWidget{
  final String label;
  final Color bgColor;
  final Color txtColor;
  final Function() onClick;
  const CorneredButton({
    required this.label,
    required this.bgColor,
    required this.txtColor,
    required this.onClick,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return  GestureDetector(
      onTap: () => onClick(), 
      child: Container(
        constraints: const BoxConstraints.expand(

          height: 45
        ),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bgColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Text(label, style: TextStyle(
            fontSize: AppFontSize.normalFontSize,
            color: txtColor,
            fontWeight: FontWeight.normal
          ),),
        ),

      ));
  }

}



class DOutlinedButton extends StatefulWidget{
  final String label;
  final Color borderColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle textStyle;
  final Function onClick;

  const DOutlinedButton({
    super.key,
    required this.label,
    required this.btnHeight,
    required this.borderColor,
    required this.borderRadius,
    required this.textStyle,
    required this.onClick
  });


  @override
  DOutlinedButtonState createState() => DOutlinedButtonState();


}

class DOutlinedButtonState extends State<DOutlinedButton>{


  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> _toggalAnimation(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        height: widget.btnHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: _isClicked?null: Border.all(
            color: widget.borderColor,
            width: 1
          ),
          color: _isClicked? widget.borderColor:null
        ),

        padding:  const EdgeInsets.all(5),  

        child: Center(
          child: Text(
            widget.label,
            style: widget.textStyle,        
          ),
        ),
      ),
    );
  }

  void _toggalAnimation(){
    
    setState(() {
      _isClicked = true;
    });

    widget.onClick();

    Timer(const Duration(milliseconds: 500 ), (){
      setState(() {
        _isClicked = false;
      });
    });

  }


}


class DSolidButton extends StatefulWidget{
  final String label;
  final Color bgColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle textStyle;
  final Function onClick;

  const DSolidButton({
    super.key,
    required this.label,
    required this.btnHeight,
    required this.bgColor,
    required this.borderRadius,
    required this.textStyle,
    required this.onClick
  });


  DSolidButtonState createState() => DSolidButtonState();

}

class DSolidButtonState extends State<DSolidButton>{

  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> _toggalAnimation(),
      child: Container(
        height: widget.btnHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _isClicked?null: widget.bgColor,
          border: _isClicked? Border.all(
            color: widget.bgColor,
            width: 1
          ):null
        ),

        child: Center(
          child: Text(
            widget.label,
            style: widget.textStyle,        
          ),
        ),
      ),
    );
  }


  void _toggalAnimation(){
    
    setState(() {
      _isClicked = true;
    });

    widget.onClick();

    Timer(const Duration(milliseconds: 500 ), (){
      setState(() {
        _isClicked = false;
      });
    });

  }
}