import 'package:flutter/material.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';

class SubscribeScreen extends StatefulWidget{
  const SubscribeScreen({super.key});


  @override
  _subscribeScreenState createState() => _subscribeScreenState();

}

class _subscribeScreenState extends State<SubscribeScreen>{

  late final TextEditingController _mobileController;
  late final TextEditingController _amountController;
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();

    _mobileController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose(){

    _mobileController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Simulate a payment process
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    // Show a success message after payment processing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment processed successfully!')),
    );
  }

    @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primarColor,
          leading: IconButton(
            onPressed:()=> Navigator.pop(context) , 
            icon: const Icon(Icons.arrow_back, color: Colors.white,)),
          
          title: const Text("SUBSCRIBE", style: AppStyles.titleWhiteTxtStyle,),
          centerTitle: true,

          actions: [

            // IconButton(
            //   onPressed: (){}, 
            //   icon: const Icon(Icons.stadium_rounded, color: Colors.white,)),

            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.notifications, color: Colors.white,)),
          ],
        ),


        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children:[
              Expanded(
              child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 50,),
                  // const Center(child:Text("SUBSCRIBE", style: AppStyles.titleBlackTxtStyle,) ),
                  const SizedBox(height: 20,),
                  const Text("Select Network", style: AppStyles.normalGreyColorTxtStyle,),
                  const SizedBox(height: 5,),
                  SingleDropDownWidget(
                      list: const ["MTN", "AIRTEL"],
                      onChange: (v){
                        setState(() {
                         
                        });
                      },),

                  const SizedBox(height: 20,),
                  const Text("Select Plan", style: AppStyles.normalGreyColorTxtStyle,),
                  const SizedBox(height: 5,),
                  SingleDropDownWidget(
                      list: const ["Day: 1300UGX", "1 Month: 25000UGX", "3 Months: 25000UGX"],
                      onChange: (v){
                        setState(() {
                         
                        });
                      },),



                  const SizedBox(height: 20,),
                  Container(
                    constraints: const BoxConstraints.expand(height: 50,),
                    decoration: BoxDecoration(
                      color: AppColors.bgGreyColor,
                      borderRadius: BorderRadius.circular(60)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      style: AppStyles.normalBlackTxtStyle,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Mobile Number",
                        hintStyle: AppStyles.normalGreyColorTxtStyle
                      ),
                    )  
                  ),


                  const SizedBox(height: 20,),
                  // Container(
                  //   constraints: const BoxConstraints.expand(height: 50,),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.bgGreyColor,
                  //     borderRadius: BorderRadius.circular(60)
                  //   ),
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: TextFormField(
                  //     controller: _amountController,
                  //     style: AppStyles.normalBlackTxtStyle,
                  //     keyboardType: TextInputType.number,
                  //     decoration: const InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: "Enter Amount",
                  //       hintStyle: AppStyles.normalGreyColorTxtStyle
                  //     ),
                  //   )  
                  // ),
                  // const SizedBox(height: 20,),
                  // SizedBox(
                  //   child: CorneredButton(
                  //     label: "Process Payment >>>>", 
                  //     bgColor: AppColors.primarColor, 
                  //     txtColor: AppColors.whiteColor, 
                  //     onClick: (){}),
                  // )
                ],
              ),
            )),
            const SizedBox(height: 10,),
            SizedBox(
                    child: CorneredButton(
                      label: "Process Payment >>>>", 
                      bgColor: AppColors.primarColor, 
                      txtColor: AppColors.whiteColor, 
                      onClick: (){
                        _isLoading ? null : _processPayment; }
                      ),
                  ),
                if (_isLoading) ...[
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(), // Show loading indicator
                ],
            const SizedBox(height: 10,),
            ]),),
            ),

    );
  }
}