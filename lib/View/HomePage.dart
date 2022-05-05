import 'package:demo_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Kolors.primaryText,
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Kolors.primaryText,
        centerTitle: true,
        title: Text(
          "Welcome John Doe",
          style: TextStyle(color: Kolors.primaryText, fontSize: 15.0.sp),
        ),
      ),
    );
  }
}
