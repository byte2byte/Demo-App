import 'package:demo_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:sizer/sizer.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 1.0.h,
          ),
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snap) {
              final value = snap.data!;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value, hours: _isHours);
              return Column(
                children: <Widget>[
                  Container(
                    height: 25.0.h,
                    width: 25.0.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Kolors.primaryText, width: 1.5)),
                    child: Center(
                      child: Text(
                        displayTime,
                        style: TextStyle(
                            fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  },
                  child: SizedBox(
                    height: 6.0.h,
                    child: Image.asset(
                      "assets/play.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                  },
                  child: SizedBox(
                    height: 6.0.h,
                    child: Image.asset(
                      "assets/pause.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  },
                  child: SizedBox(
                    height: 6.0.h,
                    child: Image.asset(
                      "assets/stop.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
