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

//String dropdownValue = 'One';

class _DropButtonState extends State<DropButton> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Все посылки"), value: "Все посылки"),
      DropdownMenuItem(child: Text("Отслеживаются"), value: "Отслеживаются"),
      DropdownMenuItem(child: Text("Архив"), value: "Архив"),
      DropdownMenuItem(child: Text("Не найдено"), value: "Не найдено"),
    ];
    return menuItems;
  }

  String selectedValue = "Все посылки";
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
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: 'filtr',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 2),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            filled: true,
            fillColor: Colors.white,
          ),
          dropdownColor: Colors.white,
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: dropdownItems),
      // child: DropdownButton<String>(
      //   value: dropdownValue,
      //   isExpanded: true,
      //   //icon: const Icon(Icons.keyboard_arrow_down),
      //   // iconSize: 24,
      //   elevation: 16,
      //   style: const TextStyle(color: Colors.deepPurple),
      //   onChanged: (String? newValue) {
      //     setState(() {
      //       dropdownValue = newValue!;
      //     });
      //   },
      //   items: <String>['One', 'Two', 'Free', 'Four']
      //       .map<DropdownMenuItem<String>>((String value) {
      //     return DropdownMenuItem<String>(
      //       value: value,
      //       child: Container(
      //         width: 361.w,
      //         decoration:
      //             BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      //         child: Text(value),
      //       ),
      //     );
      //   }).toList(),
      // ),
    );
  }
}
