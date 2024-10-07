import 'package:flutter/material.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../respository/auth_repository_api.dart';
import '../../route.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

final AuthRepositoryApi authRepositoryApi = AuthRepositoryApi();
final FlutterSecureStorage storage = const FlutterSecureStorage();

class SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationOn = false;

  String userName = ""; // These would be dynamically set based on user data
  String email = "";
  String profilePicUrl = "";

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data from storage when screen initializes
  }

  Future<void> _loadUserData() async {
    final storedName = await storage.read(key: 'name');
    final storedEmail = await storage.read(key: 'email');
    final storedProfilePic = await storage.read(
        key: 'profilePic'); // Assuming profile pic is saved as 'profilePic'

    setState(() {
      userName = storedName ?? "John Doe"; // Default value
      email = storedEmail ?? "johndoe@example.com"; // Default value
      profilePicUrl = storedProfilePic ??
          "https://via.placeholder.com/150"; // Default value
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: AppStyles.normalBlackTxtStyle,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
                child: CircleAvatar(
              radius: 50,
              backgroundImage: profilePicUrl.isNotEmpty
                  ? NetworkImage(profilePicUrl)
                  : const AssetImage("assets/placeholder_profile.png")
                      as ImageProvider,
            )),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              userName,
              style: AppStyles.normalBlackTxtStyle,
            )),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              email,
              style: AppStyles.normalBlackTxtStyle,
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Account",
              style: AppStyles.normalBoldBlackTxtStyle,
            ),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 10,
            ),
            buildAccountOptionRow("Edit Profile", Icons.arrow_forward_ios),
            buildAccountOptionRow("Subscribe", Icons.arrow_forward_ios),
            const SizedBox(height: 40),
            const Text(
              "Application Settings",
              style: AppStyles.normalBoldBlackTxtStyle,
            ),
            const SizedBox(
              height: 10,
            ),

buildToggleOptionRow("App Notification", isNotificationOn, (val) {
              setState(() {
                isNotificationOn = val;
              });
            }),
            // itemWidget("Primary Color"),
            // itemWidget("App Notification"),
            // itemWidget("Translation Language"),

            const SizedBox(
              height: 40,
            ),
            DSolidButton(
                label: "Logout",
                btnHeight: 45,
                bgColor: AppColors.primarColor,
                borderRadius: 15,
                textStyle: AppStyles.normalWhiteTxtStyle,
// onClick: (){},
                onClick: () async {
                  // await authRepositoryApi.signOut();
                  await authRepositoryApi.clearToken();

                  setState(() {
                    userName = '';
                    email = '';
                    profilePicUrl = '';
                  });
                  Navigator.pushNamed(context, RoutesGenerator.loginScreen);
                })
          ],
        )),
      )),
    );
  }

  Widget buildAccountOptionRow(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle account option tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppStyles.normalGreyColorTxtStyle),
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  Widget buildToggleOptionRow(
      String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: AppStyles.normalBlackTxtStyle),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primarColor,
          ),
        ],
      ),
    );
  }

  Widget itemWidget(String label) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.greyColor),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(7),
        child: Row(
          children: [
            Expanded(
                child: Text(
              label,
              style: AppStyles.normalBlackTxtStyle,
            )),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      );
}
