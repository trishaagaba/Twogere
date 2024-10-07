import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/learn_screen/widgets/learn_nav_widgets.dart';
// import 'package:twongere/services/learn_service.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_constansts.dart';
import 'package:twongere/util/app_styles.dart';

import '../../../../respository/learn_service.dart';
import '../../../topic_details_screen/topic_details_screen.dart';

class LearnNav extends StatefulWidget {
  const LearnNav({super.key});

  @override
  LearnNavState createState() => LearnNavState();
}

class LearnNavState extends State<LearnNav> {
  late Future<List<Training>> _trainingsFuture;

  @override
  void initState() {
    super.initState();
    _trainingsFuture = LearnService().fetchTrainings(); // Fetch data on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints.expand(height: 250),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(2, 3),
                      ),
                    ],
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(15), // Apply the same radius here
    child: Image.network(
    'https://th.bing.com/th/id/OIP.GqfnpWpzZK9TbtJQFWsBzwHaEK?w=1250&h=703&rs=1&pid=ImgDetMain',
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
    return const Center(child: Icon(Icons.error));}))
               //    child: Image.network('https://th.bing.com/th/id/OIP.GqfnpWpzZK9TbtJQFWsBzwHaEK?w=1250&h=703&rs=1&pid=ImgDetMain',
               // fit: BoxFit.cover)
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<Training>>(
                  future: _trainingsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to load data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final trainings = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "TOPIC: ${trainings[0].title}",
                                      maxLines: 1,
                                      style: AppStyles.normalBoldBlackTxtStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      trainings[0].description,
                                      maxLines: 2,
                                      style: AppStyles.normalBlackTxtStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),

                                  color: AppColors.greyColor,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: const Center(
                                  child: Text("Gestures", style: AppStyles.normalBlackTxtStyle),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 50,
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),

                                  color: AppColors.greyColor,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: const Center(
                                  child: Text("Text", style: AppStyles.normalBlackTxtStyle),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text("More Content", style: AppStyles.normalBoldBlackTxtStyle),
                          Column(
                            children: List.generate(
                              trainings.length,
                                  (index) => UnitEducationContent(
                                training: trainings[index],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}



class UnitEducationContent extends StatelessWidget {
  final Training training;

  const UnitEducationContent({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to TopicDetailsScreen, passing the topicId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicDetailsScreen(
              topicId: training.topicId, // Pass the topicId directly
            ),
          ),
        );
      },
      child: Container(
         padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 3),
            ),
          ],
        ),
    child: Row(
    children: [
    Container(
    width: 100,
    height: 120,
    decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(15),

    image: training.image != null && training.image!.isNotEmpty
    ? DecorationImage(
      image: NetworkImage('https://th.bing.com/th/id/OIP.R2NeGizjTOuCOXZN0c7OFgHaEE?w=1117&h=613&rs=1&pid=ImgDetMain',),// Default image URL

    // image: NetworkImage(training.image!), // Properly handle the URL with NetworkImage
    fit: BoxFit.cover,
    )
        : DecorationImage(
    // image: NetworkImage('https://www.dallasisd.org/cms/lib/TX01001475/Centricity/Domain/579/PL-Logo-FullStacked-05.png'),
      image: NetworkImage('https://th.bing.com/th/id/OIP.R2NeGizjTOuCOXZN0c7OFgHaEE?w=1117&h=613&rs=1&pid=ImgDetMain',),// Default image URL
      // Default image URL
    fit: BoxFit.cover,
    ),
    // Handle empty image case
    ),
    margin: const EdgeInsets.all(10),
    ),
    // const SizedBox(height: 10),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
            Text( "TOPIC: ${training.title}", style: AppStyles.normalBoldBlackTxtStyle),
            const SizedBox(height: 5),
            Text(
              training.description,
              style: AppStyles.normalBlackTxtStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      // )])
      ),
    ])
    )
    );

  }
}

