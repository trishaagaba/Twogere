import 'package:flutter/material.dart';
// import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twongere/route.dart';
import 'package:twongere/util/app_styles.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // AppUpdateInfo? _updateInfo;
  bool _isUpdateAvailable = false;
  bool _flexibleUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
    // _checkForUpdate();
    _checkRememberMe(); // Start checking for updates when splash screen loads
  }

  Future<void> _checkRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRemembered = prefs.getBool('remember_me'); // Get "Remember Me" flag

    await Future.delayed(const Duration(seconds: 7));
    // Navigate to the home screen if "Remember Me" is true, otherwise, to the login screen
    if (isRemembered == true) {
      if (mounted) { // Ensure the widget is still mounted
        Navigator.pushReplacementNamed(context, RoutesGenerator.homeScreen);
      }
    } else {
      if (mounted) { // Ensure the widget is still mounted
        Navigator.pushReplacementNamed(context, RoutesGenerator.loginScreen);
      }
  }}
  //
  // Future<void> _checkForUpdate() async {
  //   try {
  //     AppUpdateInfo info = await InAppUpdate.checkForUpdate();
  //     if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //       setState(() {
  //         _updateInfo = info;
  //         _isUpdateAvailable = true;
  //       });
  //     } else {
  //       _navigateToHome(); // No update available, navigate to home
  //     }
  //   } catch (e) {
  //     print("Failed to check for update: $e");
  //     _navigateToHome(); // In case of any error, proceed with the app
  //   }
  // }
  //
  // void _navigateToHome() {
  //  _checkRememberMe();
  // }
  //
  // void _startImmediateUpdate() {
  //   InAppUpdate.performImmediateUpdate().catchError((e) {
  //     print("Failed to perform immediate update: $e");
  //   });
  // }
  //
  // void _startFlexibleUpdate() {
  //   if (_updateInfo != null && _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
  //     InAppUpdate.startFlexibleUpdate().catchError((e) {
  //       print("Failed to start flexible update: $e");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context){

    // Future.delayed(const Duration(seconds: 5)).then(
    //   (value) => Navigator.pushNamed(context, RoutesGenerator.loginScreen));

    return Scaffold(
      body:
         Container(
          constraints:  const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bg.png")

            )
          ),
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 150,),
                    Text("TWOGERE", style:  AppStyles.splashTitleBlackTxtStyle,),

                    // Text("\"TWOGERE\"", style:  AppStyles.splashTitleBlackTxtStyle,),
                  ],
                )),
              const SizedBox(
                child: Center(
                  child: Image(
                    width: 30,
                    height: 30,
                    image: AssetImage("assets/images/loding.gif")),
                ),
              ),
              const SizedBox(height: 70,),
              // _isUpdateAvailable
              //     ? Column(
              //   children: [
              //     ElevatedButton(
              //       // onPressed: _startImmediateUpdate,
              //       child: const Text("Update Now"),
              //     ),
              //     const SizedBox(height: 10),
              //     ElevatedButton(
              //       onPressed: _navigateToHome,
              //       child: const Text("Later"),
              //     ),
              //   ],
              // )
              //     :
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/cog.png"))
                      ),
                    )
                    ,
                    const SizedBox(width: 10,),
                    const Text("Cognosphere Dynamics.",style: AppStyles.normalGreyColorTxtStyle)
                  ],
                )
              ),
              SizedBox(height: 10,),
            ],
          // ),

        )),
    );
  }

}