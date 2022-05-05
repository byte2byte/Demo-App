import 'package:demo_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Demo App',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.0.sp,
                  color: Kolors.primaryText,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign in with Google',
                  style: GoogleFonts.justAnotherHand(
                      color: Kolors.primaryText,
                      fontSize: 25.0.sp,
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    fixedSize: Size(80.0.w, 6.0.h),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Kolors.primaryText),
                      borderRadius: BorderRadius.circular(1.0.w),
                    )))
          ],
        ),
      ),
    );
  }
}
