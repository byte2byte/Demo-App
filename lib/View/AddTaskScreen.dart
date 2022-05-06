import 'dart:developer';

import 'package:demo_app/Utils/Colors.dart';
import 'package:demo_app/Utils/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'HomePage.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _taskNameTEC = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final f = DateFormat('yyyy/MM/dd hh:mm a');
  String _taskTxt = '';

  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String _dateTimeTxt = 'Date and Time';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  } // Method to select date

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
    setState(() {
      if (time != null) {
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, time.hour, time.minute);
        _dateTimeTxt = f.format(selectedDate);
      }
    });
  }

  /// Method to select time after selection of date

  @override
  void dispose() {
    _taskNameTEC.dispose();
    super.dispose();
  }

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
          "Add Task",
          style: TextStyle(color: Kolors.primaryText, fontSize: 15.0.sp),
        ),
      ),
      body: Column(
        children: [
          kSizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: TextFormField(
              controller: _taskNameTEC,
              onChanged: (str) {
                setState(() {
                  _taskTxt = str;
                });
              },
              cursorColor: Kolors.primaryText,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.0.w),
                hintText: "Task Name",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp,
                    color: Kolors.primaryText),
                border: kBorderDecoration(),
                enabledBorder: kBorderDecoration(),
                focusedBorder: kBorderDecoration(),
              ),
            ),
          ),
          kSizedBox(),
          InkWell(
            onTap: () {
              _selectDate(context).whenComplete(() {
                _selectTime(context);
              });
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
              padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.0.w),
              child: Text(
                _dateTimeTxt,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp,
                    color: Kolors.primaryText),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0.w),
                  border: Border.all(color: Kolors.primaryText, width: 0.5)),
            ),
          ),
          kSizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _taskTxt.length > 1 &&
                            _dateTimeTxt != 'Date and Time'
                        ? ElevatedButton(
                            onPressed: () async {
                              final taskList = await Hive.openBox('taskList');
                              if (taskList.isEmpty) {
                                taskList.clear();
                              }
                              taskList.put(_taskNameTEC.text, _dateTimeTxt);
                              var box = Hive.box('len');
                              int len = box.get('lenOfTaskList');
                              log('${taskList.length}',
                                  name: 'Lenght of taskList');
                              box.put('lenOfTaskList', len + 1);
                            },
                            child: Text(
                              'Save',
                              style: bttnTextStyle(),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Save',
                              style:
                                  bttnTextStyle().copyWith(color: Colors.grey),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          )),
                SizedBox(
                  width: 5.0.w,
                ),
                Expanded(
                  child: _taskTxt.length > 1 && _dateTimeTxt != 'Date and Time'
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _taskNameTEC.clear();
                              _taskTxt = '';
                              _dateTimeTxt = 'Date and Time';
                            });
                          },
                          child: Text(
                            'Clear',
                            style: bttnTextStyle(),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Kolors.primaryText, width: 0.6),
                                borderRadius: BorderRadius.circular(1.0.w),
                              )),
                        )
                      : ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Clear',
                            style: bttnTextStyle().copyWith(color: Colors.grey),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Kolors.primaryText, width: 0.6),
                                borderRadius: BorderRadius.circular(1.0.w),
                              )),
                        ),
                )
              ],
            ),
          ),
          kSizedBox(),
        ],
      ),
    );
  }
}
