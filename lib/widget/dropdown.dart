import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class DropButton extends StatefulWidget {
  const DropButton({Key? key}) : super(key: key);

  @override
  _DropButtonState createState() => _DropButtonState();
}

String dropdownValue = 'One';

class _DropButtonState extends State<DropButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 47.h,
      width: 361.w,
      margin: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        //icon: const Icon(Icons.keyboard_arrow_down),
        // iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: 361.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
