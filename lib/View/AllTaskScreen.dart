import 'package:demo_app/Utils/Colors.dart';
import 'package:demo_app/View/AddTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  Box? box;
  int len = 0;
  List<Map<String, String>> _ourData = [];
  Future _openHiveBoxes() async {
    var b = await Hive.openBox('taskList');
    _ourData.clear();
    setState(() {
      box = b;
      len = b.length;
      for (int i = 0; i < len; i++) {
        _ourData.add({b.keyAt(i): b.get(b.keyAt(i))});
      }
    });

    return b;
  }

  @override
  void initState() {
    _openHiveBoxes();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _openHiveBoxes();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Kolors.primaryText,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Kolors.primaryText,
        centerTitle: true,
        title: Text(
          "Welcome John Doe",
          style: TextStyle(color: Kolors.primaryText, fontSize: 15.0.sp),
        ),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AddTaskScreen())));
          },
          icon: Icon(Icons.add)),
      body: FutureBuilder(
          future: _openHiveBoxes(),
          builder: (context, snapshot) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 3.0.h),
              itemCount: len,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0.h),
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key('${_ourData[index].values.first}'),
                  // '${_ourData[index].keys.first.hashCode * DateTime.now().microsecondsSinceEpoch}'),
                  background: const SizedBox(),
                  confirmDismiss: (DismissDirection direction) async {
                    return await dialogBoxForDismissConfimartion(
                        context, index);
                  },
                  secondaryBackground: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Delete',
                          style: GoogleFonts.justAnotherHand(
                              color: Kolors.primaryText,
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: 5.0.w,
                      )
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_ourData[index].keys.first}',
                          style: TextStyle(
                              color: Kolors.primaryText,
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_ourData[index].values.first}',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Future<bool?> dialogBoxForDismissConfimartion(
      BuildContext context, int index) {
    return showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => AlertDialog(
              buttonPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0.w)),
              content: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      'Delete?',
                      style: TextStyle(
                          color: Kolors.primaryText,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      'Are you sure you want to delete this task',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                          height: 3.0.h,
                          color: Kolors.primaryText,
                          width: 1,
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  box!.delete(box!.keyAt(index));
                                  _ourData.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Kolors.primaryText),
                    borderRadius: BorderRadius.circular(2.0.w)),
                height: 21.0.h,
                width: 10.0.h,
              ),
            ));
  }
}
