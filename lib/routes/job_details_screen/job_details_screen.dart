
import 'package:flutter/material.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_constansts.dart';
import 'package:twongere/util/app_styles.dart';

import '../../respository/job_service.dart';



class JobDetailsScreen extends StatefulWidget {
  final int jobId; // Add this to pass the job ID

  const JobDetailsScreen({Key? key, required this.jobId}) : super(key: key);

  @override
  JobDetailsScreenState createState() => JobDetailsScreenState();
}

class JobDetailsScreenState extends State<JobDetailsScreen> {
  late Future<Job> _jobDetails; // Declare a future to hold the job details

  @override
  void initState() {
    super.initState();
    _jobDetails = JobService().fetchJobDetails(widget.jobId); // Fetch the job details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job details", style: AppStyles.titleBlackTxtStyle),
      ),
      body: SafeArea(
        child: FutureBuilder<Job>(
          future: _jobDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load job details'));
            } else if (snapshot.hasData) {
              final job = snapshot.data!; // Get the job data
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints.expand(height: 250),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        image: job.image.isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(job.image),
                          fit: BoxFit.cover,
                        )

                            : null, // Handle empty image case
                      ),
                      margin: const EdgeInsets.all(10),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.title, style: AppStyles.smallBlackTxtStyle),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 5),
                              Text("Location : $job.location", style: AppStyles.normalBlackTxtStyle),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Row(
                            children: [
                              const Icon(Icons.currency_exchange_sharp),
                              const SizedBox(width: 5),
                              Text("${job.amount} USH", style: AppStyles.normalBlackTxtStyle),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text("Description", style: AppStyles.normalBoldBlackTxtStyle),
                          Text(job.description, style: AppStyles.normalBlackTxtStyle),
                          const SizedBox(height: 20),
                          const Text("Qualification", style: AppStyles.normalBoldBlackTxtStyle),
                          // You can add a placeholder for qualification if needed
                          const SizedBox(height: 40),
                          DSolidButton(
                            label: "Apply Now",
                            btnHeight: 45,
                            bgColor: AppColors.primarColor,
                            borderRadius: 15,
                            textStyle: AppStyles.normalWhiteTxtStyle,
                            onClick: () {
                              // Add apply logic
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(); // Fallback UI
          },
        ),
      ),
    );
  }
}

//
// class JobDetailsScreen extends StatefulWidget{
//   const JobDetailsScreen({super.key});
//
//
//   @override
//   JobDetailsScreenState createState () => JobDetailsScreenState();
// }
//
//
// class JobDetailsScreenState extends State<JobDetailsScreen>{
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Job details",style: AppStyles.titleBlackTxtStyle,),
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 constraints: const BoxConstraints.expand(height: 250),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(15)
//                 ),
//                 margin: const EdgeInsets.all(10),
//               ),
//               const SizedBox(height: 10,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Cognosphere dynamics Limited", style: AppStyles.smallBlackTxtStyle,),
//                     const SizedBox(height: 5,),
//                     const SizedBox(
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           SizedBox(
//                             child: Row(
//                               children: [
//                                 Icon(Icons.location_on),
//                                 SizedBox(width: 5,),
//                                 Text("Kampala", style: AppStyles.normalBlackTxtStyle,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 30,),
//                           SizedBox(
//                             child: Row(
//                               children: [
//                                 Icon(Icons.currency_exchange_sharp),
//                                 SizedBox(width: 5,),
//                                 Text("500,000 USH", style: AppStyles.normalBlackTxtStyle,)
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 20,),
//                     const Text("Description", style: AppStyles.normalBoldBlackTxtStyle,),
//                     const Text(AppConstansts.longTxt, style: AppStyles.normalBlackTxtStyle,),
//
//                     const SizedBox(height: 20,),
//                     const Text("Qualification", style: AppStyles.normalBoldBlackTxtStyle,),
//                     const Text(AppConstansts.lontxt2, style: AppStyles.normalBlackTxtStyle,),
//                     const SizedBox(height: 40,),
//                     DSolidButton(
//                       label: "Apply Now",
//                       btnHeight: 45,
//                       bgColor: AppColors.primarColor,
//                       borderRadius: 15,
//                       textStyle: AppStyles.normalWhiteTxtStyle,
//                       onClick: (){}),
//                     const SizedBox(height: 10,),
//
//                   ],
//                 ),
//               )
//
//             ],
//           ),
//         )),
//     );
//   }
// }