import 'package:flutter/material.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/tabs/text_trans_tab/widgets/text_trans_tab_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:video_player/video_player.dart';

class TextInfoComponent extends StatefulWidget{
  const TextInfoComponent({super.key});

  @override
  _textInfoComponentState createState() => _textInfoComponentState();

}


class _textInfoComponentState extends State<TextInfoComponent>{
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(
          child:  UnitTextResponseItemwidget(controller: controller,),
          ),
          // SizedBox(height: 10,),
          // SimpleMessageBoxWidget()
      ],
    );
  }
}



class UnitTextResponseItemwidget extends StatelessWidget{
  final TextEditingController controller;
  const UnitTextResponseItemwidget({
    required this.controller,
    super.key,
  });



  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(7),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   child: Row(
          //     children: [
          //       Text("English", style: AppStyles.normalBlackTxtStyle,),
          //       SizedBox(width: 6,),
          //       Icon(Icons.volume_down_outlined)
          //     ],
          //   ),
          // ),
          const SizedBox(height: 5,),
          // Text(textData, style: AppStyles.normalBlackTxtStyle,),
          Expanded(
            child:TextField(
              maxLines: 100,
            controller: controller,
            style: AppStyles.normalBlackTxtStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter text to translate",
              hintStyle: AppStyles.normalGreyColorTxtStyle
            ),
          )),
          const SizedBox(height: 10,),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      
                      const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.mic, color: AppColors.blackColor, size: 20,),
                            // Text("Voice", style: AppStyles.normalBlackTxtStyle,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.send_rounded, color: AppColors.primarColor, size: 20,),
                )
              ],
            ),
          ),
          // SizedBox(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       IconButton(
          //         onPressed: (){}, 
          //         icon: const Icon(Icons.share)),
          //       SizedBox(width: 6,),
          //       IconButton(
          //         onPressed: (){}, 
          //         icon: const Icon(Icons.copy)),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}



class SimpleMessageBoxWidget extends StatefulWidget{
  const SimpleMessageBoxWidget({super.key});


  @override
  _simpleMessagingBoxWidget createState ()=> _simpleMessagingBoxWidget();

}


class _simpleMessagingBoxWidget extends State<SimpleMessageBoxWidget>{

  late final TextEditingController _messageController;

  @override
  void initState(){
    super.initState();

    _messageController = TextEditingController();
  }

  @override
  void dispose(){
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.mic)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.bgGreyColor
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:TextField (
            controller:  _messageController,
            minLines:1,
            maxLines: 5,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "enter your message here"
            )),
          )),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.send, color: AppColors.primarColor,))
      ],
    );
  }
}



class VideoInfoComponent extends StatefulWidget{

  const VideoInfoComponent({super.key});


  @override
  _videoInfoComponentState createState () => _videoInfoComponentState();

}


class _videoInfoComponentState extends State<VideoInfoComponent>{

  VideoPlayerController controller = VideoPlayerController.asset("assets/videos/earthena.mp4");

  @override
  void initState() {
    
    super.initState();
    // controller.play();
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: BoxConstraints.expand(),
      child: LayoutBuilder(
        builder:(context, constraints) {
          
          double height = constraints.maxHeight;

          return SizedBox(
            height: height,
            child: Stack(
              children: [
                Align(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.bgGreyColor,
                    ),

                    child: FutureBuilder(
                        future: controller.initialize(), 
                        builder: (context, snapshot) {
                          
                          if(snapshot.connectionState == ConnectionState.done){
                            controller.play();
                            return VideoPlayer(controller);
                          }

                          if(snapshot.hasError){
                            return const Text("Error loading video");
                          }

                          return const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }, ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: IconButton(
                //     onPressed: (){}, 
                //     icon: const CircleAvatar(
                //       backgroundColor: AppColors.primarColor,
                //       child: Icon(Icons.video_camera_back, color: AppColors.whiteColor,),
                //     )),
                // )
              ],
            ),
          );
        },),
    );
  }
}