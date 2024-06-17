import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/quiz/data/category_data.dart';
import 'package:trivia/features/quiz/presentation/quiz_page.dart';
import 'package:trivia/features/quiz/presentation/quiz_parameter_page.dart';

class QuizCategory extends StatelessWidget {
  const QuizCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 10.w, // Horizontal spacing between items
            mainAxisSpacing: 25.h, // Vertical spacing between items
            childAspectRatio: 1, // Aspect ratio of each item
          ),
          itemBuilder: (context, index){
            final imageList = ["general_knowledge.jpg","books.jpg","music.png","computer.jpg"];
            final titleList = ["General knowledge","Books","Music","Computer"];
            return gridItem(context: context,image: categories[index+1].asset, quizTitle: categories[index+1].name, questionsNum: "1400",);
          }),
    );
  }

 Widget gridItem({
   required BuildContext context,
   required String image,
   required String quizTitle,
   required String questionsNum}){
    return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QuizParameterPage(title: quizTitle,)));
        },
        child: Container(
          height: 300.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(-1,2)
              ),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0.5,-1)
              )
            ]
          ),
          padding: EdgeInsets.only(left: 10.w,right: 10),
          child: Stack(
            alignment: Alignment.topLeft,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: -12.h,
                  left: 15.w,
                  child: Image.asset("assets/category/$image",width: 100.w,height: 80.h,)
              ),
              //SizedBox(height: 70.h,),
              Container(
                margin: EdgeInsets.only(top: 80.h),
                  //height: 50.h,
                  //width: 100.w,
                  child: Reusable(text: quizTitle,fontSize: 20.sp,textAlign: TextAlign.left,fontWeight: FontWeight.w700,)),
              //SizedBox(height: 5.h),
              Container(
                  margin: EdgeInsets.only(top: 110.h),
                  child: Reusable(text: '$questionsNum questions',fontSize: 15.sp,))
            ],
          ),
        ),
      );
 }
}
