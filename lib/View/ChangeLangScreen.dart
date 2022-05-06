import 'package:demo_app/Utils/Colors.dart';
import 'package:demo_app/Utils/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChangeLangScreen extends StatefulWidget {
  const ChangeLangScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  int _selecetedLanVal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Kolors.primaryText,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Kolors.primaryText,
        centerTitle: true,
        title: Text(
          "Change Language",
          style: TextStyle(color: Kolors.primaryText, fontSize: 15.0.sp),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          ListTile(
            title: Text(
              "English",
              style: kFont(),
            ),
            leading: Radio<int>(
              value: 0,
              groupValue: _selecetedLanVal,
              onChanged: (value) {
                setState(() {
                  _selecetedLanVal = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              "Arabic",
              style: kFont(),
            ),
            leading: Radio<int>(
              value: 1,
              groupValue: _selecetedLanVal,
              onChanged: (value) {
                setState(() {
                  _selecetedLanVal = value!;
                });
              },
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          SizedBox(
            width: 85.0.w,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Save',
                style: bttnTextStyle(),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(color: Kolors.primaryText, width: 0.6),
                    borderRadius: BorderRadius.circular(2.0.w),
                  )),
            ),
          )
        ],
      ),
    );
  }

  TextStyle kFont() {
    return TextStyle(
        color: Kolors.primaryText,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w600);
  }
}
