
import 'package:file_picker/file_picker.dart';
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: job.descriptions.map<Widget>((qualification) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("• ", style: AppStyles.normalBlackTxtStyle),  // Bullet point
                                  Expanded(
                                    child: Text(qualification.name, style: AppStyles.normalBlackTxtStyle),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 40),
                          DSolidButton(
                            label: "Apply Now",
                            btnHeight: 45,
                            bgColor: AppColors.primarColor,
                            borderRadius: 15,
                            textStyle: AppStyles.normalWhiteTxtStyle,
                            onClick: () async {
                              _showUploadDialog(context);
                              // Prompt the user to upload files
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: true,
                              //   type: FileType.custom,
                              //   allowedExtensions: ['pdf', 'doc', 'docx'], // Application letter, CV, National ID
                              // );
                              //
                              // if (result != null) {
                              //   List<PlatformFile> files = result.files;
                              //
                              //   // Handle the selected files (e.g., upload them to the server)
                              //   for (var file in files) {
                              //     print('Picked file: ${file.name}');  // Example action
                              //   }
                              //
                              //   // Add your logic here to handle the uploaded files
                              // } else {
                              //   // User canceled the picker
                              // }
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

void _showUploadDialog(BuildContext context) {
  // Variables to hold file paths
  String? nationalIdPath;
  String? applicationLetterPath;
  String? otherFilePath;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Upload Documents'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload National ID'),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    nationalIdPath = result.files.single.path;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('National ID uploaded'))
                    );
                  }
                },
                child: Text('Upload National ID'),
              ),
              SizedBox(height: 10),
              Text('Upload Application Letter'),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    applicationLetterPath = result.files.single.path;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Application Letter uploaded'))
                    );
                  }
                },
                child: Text('Upload Application Letter'),
              ),
              SizedBox(height: 10),
              Text('Upload Other Document'),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    otherFilePath = result.files.single.path;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Other document uploaded'))
                    );
                  }
                },
                child: Text('Upload Other Document'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              // You can perform the submit action here, such as sending the files to a server.
              if (nationalIdPath != null && applicationLetterPath != null && otherFilePath != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Documents Submitted'))
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please upload all required documents'))
                );
              }
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

