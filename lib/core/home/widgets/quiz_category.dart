import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/category_data.dart';
import '../../../widgets/reusable_text.dart';
import '../../quiz/screens/quiz_parameter_page.dart';

class QuizCategory extends StatelessWidget {
  const QuizCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: categories.length-1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            //crossAxisSpacing: 1.w, // Horizontal spacing between items
            mainAxisSpacing: 25.h, // Vertical spacing between items
            childAspectRatio: 1.1, // Aspect ratio of each item
          ),
          itemBuilder: (context, index){
            return gridItem(context: context,image: categories[index+1].asset, quizTitle: categories[index+1].name, questionsNum: "1400",index: index+1);
          }),
    );
  }

 Widget gridItem({
   required int index,
   required BuildContext context,
   required String image,
   required String quizTitle,
   required String questionsNum}){
    return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QuizParameterPage(title: quizTitle,index: index)));
        },
        child: Container(
          margin: EdgeInsets.only(top:index == 2?10.w:0,left: 25.w,right: 25.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-1,2)
              ),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0.5,-1)
              )
            ]
          ),
          padding: EdgeInsets.only(left: 10.w,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            //alignment: Alignment.topLeft,
            //clipBehavior: Clip.none,
            children: [
              Container(
                  child: Center(child: Image.asset("assets/category/$image",width: 100.w,height: 80.h,))
              ),
              SizedBox(
                //margin: EdgeInsets.only(top: 100.h),
                  height: 50.h,
                  child: Center(
                    child: Reusable(
                      text: quizTitle,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ),
              //SizedBox(height: 5.h),

            ],
          ),
        ),
      );
 }
}
