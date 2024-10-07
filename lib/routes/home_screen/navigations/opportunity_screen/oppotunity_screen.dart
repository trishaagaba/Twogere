import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/opportunity_screen/widgets/opportunity_screen_widgets.dart';
import 'package:twongere/util/app_styles.dart';
import '../../../../respository/job_service.dart';


class OpportunityScreen extends StatefulWidget {
  const OpportunityScreen({super.key});

  @override
  OpportunityScreenState createState() => OpportunityScreenState();
}
class OpportunityScreenState extends State<OpportunityScreen> {


  List<dynamic> jobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      final fetchedJobs = await JobService().fetchJobs();
      setState(() {
        jobs = fetchedJobs;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching jobs: $error");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const TopWidget(),
                const SizedBox(height: 20),
                const Text("Job Opportunities", style: AppStyles.normalBoldBlackTxtStyle),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return UnitOpportunityItem(
                      title: job['title'],
                      description: job['description'],
                      deadline: job['deadline'],
                      location: job['location'],
                      salary: job['amount'],
                      id: job['id'],
                      image: 'https://api.cognospheredynamics.com/storage/${job['image']}',
                    );
                  },
                ),
                // SizedBox(
                //   child: Column(
                //     children: List.generate(
                //       7,
                //           (index) => const UnitOpportunityItem(), // Placeholder for job items
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
