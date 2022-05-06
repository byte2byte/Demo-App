import 'package:demo_app/Utils/Colors.dart';
import 'package:demo_app/View/ChangeLangScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class kDrawer extends StatelessWidget {
  const kDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 8.0.h,
                ),
                Text('Demo App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        color: Kolors.primaryText,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ChangeLangScreen()));
                  },
                  child: Text('Change Language',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0.sp,
                          color: Kolors.primaryText,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Text('Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0.sp,
                        color: Kolors.primaryText,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            Column(
              children: [
                Text('App version: 1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5.0.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
