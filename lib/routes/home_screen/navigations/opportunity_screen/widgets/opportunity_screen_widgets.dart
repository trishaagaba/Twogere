import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twongere/route.dart';
import 'package:twongere/util/app_styles.dart';

import '../../../../../respository/job_service.dart';
import '../../../../job_details_screen/job_details_screen.dart';

class TopWidget extends StatefulWidget{
  const TopWidget({super.key});

  @override
  TopWidgetState createState () => TopWidgetState();
}


class TopWidgetState extends State<TopWidget>{

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SimpleSliderCarousel(),
          ),



        ],
      ),
    );
  }
}

Widget _buildInfoRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, color: Colors.orange),
      const SizedBox(width: 4),
      Text(text, style: AppStyles.normalBlackTxtStyle),
    ],
  );
}


class SimpleSliderCarousel extends StatelessWidget{
  const SimpleSliderCarousel({super.key});


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: 250.0,
          viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 4),
      enlargeCenterPage: true,
      aspectRatio: 2.0,
      onPageChanged: (index, reason) {
        // You can add logic here for indicators if needed
      },
          ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://th.bing.com/th/id/OIP.R2NeGizjTOuCOXZN0c7OFgHaEE?w=1117&h=613&rs=1&pid=ImgDetMain',),// Default image URL

                    // image: AssetImage('assets/images/locate.jpg'), // replace with your images
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Slide $i', style: const TextStyle(fontSize: 16.0,  color: Colors.white,
                    fontWeight: FontWeight.bold,),),
                )
              );
            },
          );
        }).toList(),
      );
  }
}

class UnitOpportunityItem extends StatelessWidget {
  final String? title;
  final String? description;
  final String? deadline;
  final String? location;
  final String? salary;
  final int id;
  final String? image;

  const UnitOpportunityItem({
    super.key,
    this.title,
    this.description,
    this.deadline,
    this.location,
    this.salary,
    required this.id,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(
              jobId: id, // Pass the topicId directly
            ),
          ),
        );
        // Navigate to the Job Details screen with full description
        // Navigator.pushNamed(
        //   context,
        //   '/jobDetailsScreen',
        //   arguments: {
        //     'title': title,
        //     'description': description,
        //     'deadline': deadline,
        //     'location': location,
        //     'salary': salary,
        //   },
        // );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
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
                image: image != null
                    ? DecorationImage(
                  image: NetworkImage(image!), // Properly handle the URL with NetworkImage
                  fit: BoxFit.cover,
                )
                    : DecorationImage(
                  // image: NetworkImage('https://defaultimage.url/image.png'),
                  image: NetworkImage('https://th.bing.com/th/id/OIP.GqfnpWpzZK9TbtJQFWsBzwHaEK?w=1250&h=703&rs=1&pid=ImgDetMain',),// Default image URL
                  fit: BoxFit.cover,
                ),
                     // Handle empty image case
              ),
              margin: const EdgeInsets.all(10),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "No title",
                    style: AppStyles.normalBoldBlackTxtStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description ?? "No description available",
                    style: AppStyles.normalBlackTxtStyle,
                    maxLines: 2, // Limit the number of lines displayed
                    overflow: TextOverflow.ellipsis, // Show ellipsis (...) at the end
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 5),
                          Text(location ?? "Unknown", style: AppStyles.normalBlackTxtStyle),
                        ],
                      ),

                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.currency_exchange_sharp),
                      const SizedBox(width: 10),
                      Text("shs.$salary" ?? "N/A", style: AppStyles.normalBlackTxtStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class UnitOpportunityItem extends StatefulWidget{
//   const UnitOpportunityItem({super.key});
//
//   @override
//   UnitOpportunityItemState createState () => UnitOpportunityItemState();
//
// }
//
// class UnitOpportunityItemState extends State<UnitOpportunityItem>{
//   bool isFavourite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ()=> Navigator.pushNamed(context, RoutesGenerator.jobDetailsScreen),
//       child:Container(
//         padding: const EdgeInsets.all(15),
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 5,
//               spreadRadius: 2,
//               offset: Offset(2, 3),
//             ),
//           ],
//         ),
//         child: Row(
//         children: [
//           Container(
//             width: 70,
//             height: 100,
//             // margin: const EdgeInsets.symmetric(vertical: 17),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey
//             ),
//           ),
//           const SizedBox(width:  10,),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                   SizedBox(
//                     child: Row(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Deadline-Date", style: AppStyles.normalBlackTxtStyle,),
//                               SizedBox(height: 10,),
//                               Text("Longer decriptive text goes over here for viewers",
//                                   style: AppStyles.normalBlackTxtStyle,
//                                   maxLines: 3,),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: (){
//                             setState(() {
//                               isFavourite = !isFavourite;  // Toggle the favorite state
//                             });
//                           },
//     icon: Icon(
//     isFavourite ? Icons.favorite : Icons.favorite_border,
//     color: Colors.orange,),)
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                   const SizedBox(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         SizedBox(
//                           child: Row(
//                             children: [
//                               Icon(Icons.location_on),
//                               SizedBox(width: 5,),
//                               Text("Kampala", style: AppStyles.normalBlackTxtStyle,)
//                             ],
//                           ),
//                         ),
//
//                         SizedBox(
//                           child: Row(
//                             children: [
//                               Icon(Icons.currency_exchange_sharp),
//                               SizedBox(width: 4,),
//                               Text("500,000 USH", style: AppStyles.normalBlackTxtStyle,)
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//               ],
//             ))
//         ],
//             ),
//       ));
//   }
//
// }