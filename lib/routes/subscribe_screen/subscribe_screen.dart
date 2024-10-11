import 'package:flutter/material.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:twongere/util/custom_widgets.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';

class SubscribeScreen extends StatefulWidget{
  const SubscribeScreen({super.key});


  @override
  _subscribeScreenState createState() => _subscribeScreenState();

}

class _subscribeScreenState extends State<SubscribeScreen>{

  late final TextEditingController _mobileController;
  late final TextEditingController _amountController;
  bool _isLoading = false;
  String? selectedNetwork;
  String? selectedPlan;

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
    if (selectedNetwork == null || selectedPlan == null || _mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final Customer customer = Customer(
      name: 'User Name', // Replace with actual user name
      phoneNumber: _mobileController.text,
      email: 'user@example.com', // Replace with actual email
    );

    String amount = selectedPlan!.split(':').last.trim().replaceAll(',', '').replaceAll('UGX', '').trim();

    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: "FLWPUBK_TEST-c3eb7a2a5e9bf2736f14c6e413336085-X",
      currency: "UGX", // Adjust currency if needed
      txRef: const Uuid().v1(),
      amount: amount,
      redirectUrl: 'twogere://payment', // Replace with your actual redirect URL
      customer: customer,
      paymentOptions: "card",
      customization: Customization(title: "Subscription Payment"),
      isTestMode: true,
    );

    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      print("${response.toJson()}");
    } else {
      print("no response");
    }

    // Simulate a payment process
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    if (response != null && response.status == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment processed successfully!')),
      );
      // Navigate to a success page or perform additional actions
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed!')),
      );
    }
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
                          selectedNetwork = v as String?;
                          print("Selected Plan: $selectedPlan");
                        });
                      },),

                  const SizedBox(height: 20,),
                  const Text("Select Plan", style: AppStyles.normalGreyColorTxtStyle,),
                  const SizedBox(height: 5,),
                  SingleDropDownWidget(
                      list: const ["Day: 1,500UGX", "1 Month: 10,000UGX", "3 Months: 29,700UGX", "6 Months: 58,212UGX", "1 Year: 112,932UGX"],
                      onChange: (v){
                        setState(() {
                          selectedPlan = v as String?;
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
                        _isLoading ? null : _processPayment(); }
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