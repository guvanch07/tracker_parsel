import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_pkg/const/color.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 280.h,
        width: 344.w,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 30.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 55.h, horizontal: 16.w),
              child: Text(
                'Если у Вас возникли какие-нибудь вопросы, напишите нам на почту @dgrhrw. Наши разработчики незамедлительно свяжутся с Вами ;,)',
                style: TextStyle(color: ktextColor, fontSize: 18.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
