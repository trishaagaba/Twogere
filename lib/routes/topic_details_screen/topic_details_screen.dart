import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_constansts.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:video_player/video_player.dart';
import '../../respository/learn_service.dart';

class TrainingDetails {
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;


  TrainingDetails({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,

  });

  // Factory constructor to create TrainingDetails from JSON
  factory TrainingDetails.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return TrainingDetails(
      title: user['title'],
      description: user['description'],
      imageUrl: user['image'] ?? "",
      videoUrl: user['video'] ?? ""
    );
  }
}

class TopicDetailsScreen extends StatefulWidget {
  final int topicId;

  const TopicDetailsScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  TopicDetailsScreenState createState() => TopicDetailsScreenState();
}

class TopicDetailsScreenState extends State<TopicDetailsScreen> {
  late VideoPlayerController controller;
  late Future<TrainingDetails> _trainingDetailsFuture;
  bool isText = false;

  @override
  void initState() {
    super.initState();
    // Fetch the topic details based on the topicId passed
    _trainingDetailsFuture = fetchTopicDetails(widget.topicId);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // Function to fetch details of a specific topic
  Future<TrainingDetails> fetchTopicDetails(int topicId) async {
    final response = await http.get(Uri.parse(
        'https://api.cognospheredynamics.com/api/auth/getSingleTraining/$topicId'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return TrainingDetails.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load topic details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TOPIC DETAILS",
          style: AppStyles.normalBoldBlackTxtStyle,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<TrainingDetails>(
          future: _trainingDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading topic details'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No details available'));
            } else {
              final topicDetails = snapshot.data!;
              // Initialize video player only when data is loaded
              controller = VideoPlayerController.network(topicDetails.videoUrl)
                ..initialize().then((_) {
                  setState(() {});
                  controller.play(); // Auto play video
                });

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: isText ? textWidget(topicDetails) : videoWidget(),
                    ),
                    const SizedBox(height: 10),
                    toggleViewButton(),
                    const SizedBox(height: 10),
                    if (!isText) downloadButton(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget videoWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.bgGreyColor,
      ),
      child: controller.value.isInitialized
          ? VideoPlayer(controller)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget textWidget(TrainingDetails topicDetails) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Topic: ${topicDetails.title}",
              style: AppStyles.normalBoldBlackTxtStyle,
            ),
            const SizedBox(height: 10),
            Text(
              topicDetails.description, // The full text content of the topic
              style: AppStyles.normalBlackTxtStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleViewButton() {
    return SizedBox(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Logic for previous video/text
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bgGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  isText = !isText;
                });
              },
              child: Text(isText ? "Use Gesture" : "Read Text"),
            ),
          ),
          IconButton(
            onPressed: () {
              // Logic for next video/text
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget downloadButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
      ),
      onPressed: () {
        // Logic to download video to storage
      },
      child:  const Text("Download to storage"),
    );
  }
}

//
// class TopicDetailsScreen extends StatefulWidget {
//   final int topicId;
//
//   const TopicDetailsScreen({Key? key, required this.topicId}) : super(key: key);
//
//   @override
//   TopicDetailsScreenState createState() => TopicDetailsScreenState();
// }
//
// class TopicDetailsScreenState extends State<TopicDetailsScreen> {
//   late Future<Training> _trainingFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch data based on topicId
//     _trainingFuture = LearnService().fetchSingleTraining(widget.topicId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "Topic Details",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: AppStyles.normalBoldBlackTxtStyle,
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: FutureBuilder<Training>(
//             future: _trainingFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return const Center(child: Text('Failed to load topic details'));
//               } else if (!snapshot.hasData) {
//                 return const Center(child: Text('No data available'));
//               } else {
//                 final training = snapshot.data!;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     Text(
//                       "TOPIC: ${training.title}",
//                       style: AppStyles.normalBoldBlackTxtStyle,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       training.description,
//                       style: AppStyles.normalBlackTxtStyle,
//                     ),
//                     // You can add other details about the topic here
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// class TopicDetailsScreen extends StatefulWidget{
//   const TopicDetailsScreen({super.key});
//
//   @override
//   TopicDetailsScreenState createState () => TopicDetailsScreenState();
// }
//
//
// class TopicDetailsScreenState extends State<TopicDetailsScreen>{
//   VideoPlayerController xcontroller = VideoPlayerController.networkUrl(
//     Uri.parse("uri")
//   );
//
//   VideoPlayerController controller = VideoPlayerController.asset("assets/videos/earthena.mp4");
//
//   bool isText = false;
//
//   @override
//   void initState() {
//
//     super.initState();
//
//
//     controller.setLooping(true);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "TOPIC: Introduction to ICT",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: AppStyles.normalBoldBlackTxtStyle,),
//       ),
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               const SizedBox(height: 20,),
//               Expanded(
//                 child: isText? textWidget(): gestureWidget()),
//               const SizedBox(height: 10,),
//               SizedBox(
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: (){},
//                       icon: const Icon(Icons.arrow_back_ios)),
//                     Expanded(
//                       child: DSolidButton(
//                         label: isText?"Use Gesture": "Read Text",
//                         btnHeight: 45,
//                         bgColor: AppColors.bgGreyColor,
//                         borderRadius: 20,
//                         textStyle: AppStyles.normalBlackTxtStyle,
//                         onClick: (){
//                           setState(() {
//                             isText = !isText;
//                           });
//                         })),
//                     IconButton(
//                       onPressed: (){},
//                       icon: const Icon(Icons.arrow_forward_ios))
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               isText? const SizedBox() : DSolidButton(
//                 label: "Download to storage",
//                 btnHeight: 45,
//                 bgColor: AppColors.primarColor,
//                 borderRadius: 20,
//                 textStyle: AppStyles.normalWhiteTxtStyle,
//                 onClick: (){}),
//               const SizedBox(height: 10,),
//             ],
//           ),)),
//     );
//   }
//
//
//   Widget gestureWidget()
//    => Container(
//     constraints: const BoxConstraints.expand(),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: AppColors.bgGreyColor
//     ),
//     child: FutureBuilder(
//       future: controller.initialize(),
//       builder: (context, snapshot) {
//
//         if(snapshot.connectionState == ConnectionState.done){
//           controller.play();
//           return VideoPlayer(controller);
//         }
//
//         if(snapshot.hasError){
//           return const Text("Error loading video");
//         }
//
//         return const Center(
//           child: SizedBox(
//             height: 40,
//             width: 40,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       }, )
//    );
//
//   Widget textWidget ()
//    => Container(
//     constraints: const BoxConstraints.expand(),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(
//         color: Colors.grey, width: 0.5
//       )
//     ),
//     padding: const EdgeInsets.all(10),
//     child: const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "English", style: AppStyles.normalBoldBlackTxtStyle,),
//
//         SizedBox(height: 10,),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Text(
//             AppConstansts.longTxt+AppConstansts.lontxt2,
//             style: AppStyles.normalBlackTxtStyle,
//             ),
//           ))
//       ],
//     ),
//    );
// }
