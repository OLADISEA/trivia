import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';

class QuizCategory extends StatelessWidget {
  const QuizCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 10.w, // Horizontal spacing between items
            mainAxisSpacing: 10.h, // Vertical spacing between items
            childAspectRatio: 1, // Aspect ratio of each item
          ),
          itemBuilder: (context, index){
            final imageList = ["general_knowledge.jpg","books.jpg","music.png","computer.jpg"];
            final titleList = ["General_knowledge","books","music","computer"];
            return gridItem(image: imageList[index], quizTitle: titleList[index], questionsNum: "1400");
          }),
    );
  }

 Widget gridItem({required String image, required String quizTitle, required String questionsNum}){
    return InkWell(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r)
          ),
          padding: EdgeInsets.only(left: 10.w,right: 10),
          child: Column(
            children: [
              Image.asset("assets/images/$image",width: 100.w,height: 80.h,),
              SizedBox(height: 8.h,),
              Reusable(text: quizTitle),
              SizedBox(height: 5.h),
              Reusable(text: '$questionsNum questions')
            ],
          ),
        ),
      );
 }
}
