import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaRestTimerView extends StatefulWidget {
  const FwaRestTimerView({super.key});

  @override
  State<FwaRestTimerView> createState() => _FwaRestTimerViewState();
}

class _FwaRestTimerViewState extends State<FwaRestTimerView> {
  int restSeconds = 60; // Default 1 minute rest
  int remainingSeconds = 60;
  bool isRunning = false;
  bool isCompleted = false;

  List<int> presetTimes = [30, 45, 60, 90, 120, 180]; // seconds

  String get formattedTime {
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  double get progress {
    if (restSeconds == 0) return 0;
    return 1 - (remainingSeconds / restSeconds);
  }

  String get progressText {
    return "${((progress * 100).toInt())}%";
  }

  void startTimer() {
    if (remainingSeconds > 0) {
      isRunning = true;
      isCompleted = false;
      setState(() {});
      ss("Rest timer started");
    }
  }

  void pauseTimer() {
    isRunning = false;
    setState(() {});
    sw("Rest timer paused");
  }

  void resetTimer() {
    isRunning = false;
    isCompleted = false;
    remainingSeconds = restSeconds;
    setState(() {});
    si("Rest timer reset");
  }

  void addTime(int seconds) {
    remainingSeconds += seconds;
    restSeconds += seconds;
    setState(() {});
    si("Added ${seconds}s to rest timer");
  }

  void completeRest() {
    isRunning = false;
    isCompleted = true;
    remainingSeconds = 0;
    setState(() {});
    ss("Rest complete! Ready for next set");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Timer"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('Timer Settings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Preset Rest Times
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Rest Times",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: presetTimes.map((time) {
                      bool isSelected = restSeconds == time;
                      return GestureDetector(
                        onTap: () {
                          if (!isRunning) {
                            restSeconds = time;
                            remainingSeconds = time;
                            isCompleted = false;
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${(time / 60).floor()}:${(time % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                time < 60 ? "${time}s" : "${(time / 60).floor()}min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Main Timer Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spLg,
                children: [
                  // Status Indicator
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isCompleted ? successColor :
                             isRunning ? warningColor :
                             primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      isCompleted ? "REST COMPLETE" :
                      isRunning ? "RESTING" :
                      "READY TO REST",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? Colors.white :
                               isRunning ? Colors.white :
                               primaryColor,
                      ),
                    ),
                  ),

                  // Circular Progress
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor :
                            remainingSeconds <= 10 ? dangerColor :
                            isRunning ? warningColor :
                            primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? successColor :
                                     remainingSeconds <= 10 ? dangerColor :
                                     primaryColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            progressText,
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Timer Controls
                  if (!isCompleted)
                    Row(
                      spacing: spMd,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QButton(
                          label: isRunning ? "Pause" : "Start",
                          size: bs.md,
                          onPressed: () {
                            if (isRunning) {
                              pauseTimer();
                            } else {
                              startTimer();
                            }
                          },
                        ),
                        QButton(
                          label: "Reset",
                          size: bs.md,
                          onPressed: resetTimer,
                        ),
                        QButton(
                          label: "Skip",
                          size: bs.md,
                          onPressed: completeRest,
                        ),
                      ],
                    )
                  else
                    Row(
                      spacing: spMd,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QButton(
                          label: "Start Next Set",
                          size: bs.md,
                          onPressed: () {
                            back();
                          },
                        ),
                        QButton(
                          label: "Rest Again",
                          size: bs.md,
                          onPressed: resetTimer,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Quick Actions
            if (!isCompleted && isRunning)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "+15s",
                            size: bs.sm,
                            onPressed: () => addTime(15),
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "+30s",
                            size: bs.sm,
                            onPressed: () => addTime(30),
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "+60s",
                            size: bs.sm,
                            onPressed: () => addTime(60),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Rest Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Rest Period Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Stay hydrated - drink water during rest periods",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Keep moving lightly to prevent stiffness",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Focus on deep breathing to recover faster",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Use rest time to prepare mentally for the next set",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rest Time Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Rest Times",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Strength Training",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "2-3 minutes",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Hypertrophy (Muscle Building)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "60-90 seconds",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Endurance Training",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "30-60 seconds",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Power Training",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "3-5 minutes",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
