import 'package:flutter/material.dart';
import 'package:twongere/routes/edit_profile_screen.dart';
import 'package:twongere/routes/home_screen/home_screen.dart';
import 'package:twongere/routes/job_details_screen/job_details_screen.dart';
import 'package:twongere/routes/lesson_details_screen/lesson_details_screen.dart';
import 'package:twongere/routes/login_screen/login_screen.dart';
import 'package:twongere/routes/settings_screen/settings_screen.dart';
import 'package:twongere/routes/signup_screen/signup_screen.dart';
import 'package:twongere/routes/splash_screen/splash_screen.dart';
import 'package:twongere/routes/subscribe_screen/subscribe_screen.dart';
import 'package:twongere/routes/topic_details_screen/topic_details_screen.dart';
import 'package:twongere/routes/home_screen/navigations/learn_screen/learn_screen.dart';


class RoutesGenerator{

  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String homeScreen = "/homeScreen";
  static const String lessonDetailsScreen = "/lessonDetailsScreen";
  static const String subscribeScreen = "/subcribeScreen";
  static const String settingsScreen = "/settingsScreen";

  static const String topicDetailsScreen = "/topicDetailsScreen";
  static const String jobDetailsScreen = "/jobDetailsScreen";

  // static get topicId => null;

  static Route<dynamic> generateRoute (RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen());
      
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen());

      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen());

      // case jobDetailsScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const JobDetailsScreen());

      // case topicDetailsScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => TopicDetailsScreen(topicId: topicId,));


      case subscribeScreen:
        return MaterialPageRoute(
          builder: (context) => const SubscribeScreen());

      case lessonDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const LessonDetailsScreen());
      

      case signupScreen:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen());

      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen());

      // case editProfileScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => EditProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen());
    }
  }
}