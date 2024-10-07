import 'package:flutter/material.dart';
import 'package:twongere/route.dart';
import 'package:twongere/routes/home_screen/navigations/dictionary_screen/widgets/dictionary_nav_widget.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/tabs/text_trans_tab/widgets/text_trans_tab_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_constansts.dart';
import 'package:twongere/util/app_styles.dart';

class TopLearnDropDown extends StatelessWidget{
  final String label;
  const TopLearnDropDown({super.key, required this.label});


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const CircleAvatar(radius: 20,),
          const SizedBox(width: 10,),
          Expanded(child:Text(label, style: AppStyles.normalPrimaryColorTxtStyle,)),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.blackColor, size: 30,))

        ],
      ),
    );
  }
}


class PhraseInput extends StatefulWidget{
  const PhraseInput({super.key});

  @override
  _phraseInputState createState() => _phraseInputState();


}

class _phraseInputState extends State<PhraseInput>{


  final TextEditingController controller = TextEditingController();

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            controller: controller,
            style: AppStyles.normalBlackTxtStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Wandika wano",
              hintStyle: AppStyles.normalGreyColorTxtStyle
            ),
          )),
          const SizedBox(width: 10,),
          const Icon(Icons.send, color: AppColors.primarColor, size: 30,)
        ],
      ),
      
    );
  }
}





class LangTranslate extends StatelessWidget{
  const LangTranslate({super.key});


  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
                    const Text("Select translation type", style: AppStyles.normalGreyColorTxtStyle,),
                    const TxtTransTop(),

                    const SizedBox(height: 30,),
                    const Text("Input: Character, Word of Phrase.", style: AppStyles.normalGreyColorTxtStyle,),
                    const PhraseInput(),

                    const SizedBox(height: 30,),
                    Container(
                      constraints: const BoxConstraints.expand(height: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.bgGreyColor
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Text("The translation for the search here..", style: AppStyles.normalGreyColorTxtStyle,),
                    ),

                    const SizedBox(height: 30,),
                    const Text("Speech translation", style: AppStyles.normalGreyColorTxtStyle,),
                    const SizedBox(height: 10,),
                    const AudioWidget(),
      ],
    );
  }
}


class QuickSearchInput extends StatefulWidget{

  const QuickSearchInput({super.key});

  @override
  _quickSearchInputState createState() => _quickSearchInputState();
}

class _quickSearchInputState extends State<QuickSearchInput>{

  late final TextEditingController controller;

  @override
  void initState(){
    super.initState();

    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgGreyColor
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: AppStyles.normalBlackTxtStyle,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter text to search",
                hintStyle: AppStyles.normalGreyColorTxtStyle
              ),)),
          const SizedBox(width:  10,),
          const Icon(Icons.search, color: AppColors.blackColor,)
        ],
      ),
    );
  }
}



class SignLang extends StatelessWidget{
  const SignLang({super.key});


  @override
  Widget build(BuildContext context){
    List<String> items = [
      "Food",
      "Actions",
      "Responses",
      "Positioning",
      "Emotions"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const SizedBox(height: 30,),
          const Text("Your lessons", style: AppStyles.normalGreyColorTxtStyle,),
          const QuickSearchInput(),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.bgGreyColor
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                CircleAvatar(radius: 20,),
                SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    "Free Daily Lesson", 
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.normalGreyColorTxtStyle,))
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: List.generate(
               items.length , 
               (index) => GestureDetector(
                onTap: ()=> Navigator.pushNamed(context, RoutesGenerator.lessonDetailsScreen),
                child:Container(
                height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.bgGreyColor
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:Text(
                    items[index], 
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppStyles.normalGreyColorTxtStyle,))
              ],
            ),
          ))),
            ),
          )

      ],
    );
  }
}



class UnitEducationContent extends StatefulWidget{
  const UnitEducationContent({super.key});

  @override
  UnitEducationContentState createState () => UnitEducationContentState();
}


class UnitEducationContentState extends State<UnitEducationContent>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutesGenerator.topicDetailsScreen),
      child:Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14
      ),
      child:Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            color: AppColors.greyColor
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "TOPIC: Introduction to ICT", 
                        style: AppStyles.normalBoldBlackTxtStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        )),
                      GestureDetector(
                        onTap: (){}, 
                        child: const CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.thumb_up, size: 20 ,color: AppColors.whiteColor,),
                        )),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){}, 
                        child: const CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.favorite, size: 20, color: AppColors.whiteColor,),
                        )),
                  ],
                ),
              ),
              const Text(
                AppConstansts.longTxt, 
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: AppStyles.normalBlackTxtStyle,)
            ],
          ))
      ],
    )));
  }
}