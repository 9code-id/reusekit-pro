import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaTimerView extends StatefulWidget {
  const FwaTimerView({super.key});

  @override
  State<FwaTimerView> createState() => _FwaTimerViewState();
}

class _FwaTimerViewState extends State<FwaTimerView> {
  int currentTab = 0;
  
  // Stopwatch variables
  int stopwatchSeconds = 0;
  bool stopwatchRunning = false;
  
  // Countdown timer variables
  int countdownMinutes = 5;
  int countdownSeconds = 0;
  int totalCountdownSeconds = 300; // 5 minutes
  int remainingSeconds = 300;
  bool countdownRunning = false;
  
  // Interval timer variables
  int workMinutes = 0;
  int workSeconds = 45;
  int restMinutes = 0;
  int restSeconds = 15;
  int intervals = 8;
  int currentInterval = 1;
  bool intervalRunning = false;
  bool isWorkPhase = true;
  int intervalRemainingSeconds = 45;

  // Round timer variables
  int roundDuration = 3; // minutes
  int rounds = 5;
  int restBetweenRounds = 1; // minute
  int currentRound = 1;
  bool roundRunning = false;
  bool isRoundActive = true; // true for round, false for rest
  int roundRemainingSeconds = 180; // 3 minutes

  String get formattedStopwatch {
    int minutes = (stopwatchSeconds / 60).floor();
    int seconds = stopwatchSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String get formattedCountdown {
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String get formattedInterval {
    int minutes = (intervalRemainingSeconds / 60).floor();
    int seconds = intervalRemainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String get formattedRound {
    int minutes = (roundRemainingSeconds / 60).floor();
    int seconds = roundRemainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Timer"),
      ),
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: currentTab,
        tabs: [
          Tab(text: "Stopwatch", icon: Icon(Icons.timer)),
          Tab(text: "Countdown", icon: Icon(Icons.timer_off)),
          Tab(text: "Interval", icon: Icon(Icons.repeat)),
          Tab(text: "Round", icon: Icon(Icons.sports_mma)),
        ],
        tabChildren: [
          // Stopwatch Tab
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Stopwatch",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spLg),
                        Text(
                          formattedStopwatch,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(height: spLg),
                        Row(
                          spacing: spMd,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QButton(
                              label: stopwatchRunning ? "Pause" : "Start",
                              size: bs.md,
                              onPressed: () {
                                stopwatchRunning = !stopwatchRunning;
                                setState(() {});
                                if (stopwatchRunning) {
                                  ss("Stopwatch started");
                                } else {
                                  sw("Stopwatch paused");
                                }
                              },
                            ),
                            QButton(
                              label: "Reset",
                              size: bs.md,
                              onPressed: () {
                                stopwatchRunning = false;
                                stopwatchSeconds = 0;
                                setState(() {});
                                si("Stopwatch reset");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
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
                              label: "Lap Time",
                              size: bs.sm,
                              onPressed: () {
                                if (stopwatchRunning) {
                                  si("Lap: $formattedStopwatch");
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Save Time",
                              size: bs.sm,
                              onPressed: () {
                                if (stopwatchSeconds > 0) {
                                  ss("Time saved: $formattedStopwatch");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Countdown Tab
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Time Setup
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
                        "Set Countdown Time",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: QNumberField(
                              label: "Minutes",
                              value: countdownMinutes.toString(),
                              onChanged: (value) {
                                countdownMinutes = int.tryParse(value) ?? 0;
                                totalCountdownSeconds = (countdownMinutes * 60) + countdownSeconds;
                                remainingSeconds = totalCountdownSeconds;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Seconds",
                              value: countdownSeconds.toString(),
                              onChanged: (value) {
                                countdownSeconds = int.tryParse(value) ?? 0;
                                if (countdownSeconds >= 60) {
                                  countdownSeconds = 59;
                                }
                                totalCountdownSeconds = (countdownMinutes * 60) + countdownSeconds;
                                remainingSeconds = totalCountdownSeconds;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                countdownMinutes = 1;
                                countdownSeconds = 0;
                                totalCountdownSeconds = 60;
                                remainingSeconds = 60;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "1 min",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                countdownMinutes = 5;
                                countdownSeconds = 0;
                                totalCountdownSeconds = 300;
                                remainingSeconds = 300;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "5 min",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                countdownMinutes = 10;
                                countdownSeconds = 0;
                                totalCountdownSeconds = 600;
                                remainingSeconds = 600;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "10 min",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Countdown Display
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Countdown Timer",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spLg),
                        Text(
                          formattedCountdown,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: remainingSeconds <= 10 ? dangerColor : primaryColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(height: spSm),
                        if (totalCountdownSeconds > 0)
                          Container(
                            width: 200,
                            child: LinearProgressIndicator(
                              value: remainingSeconds / totalCountdownSeconds,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                remainingSeconds <= 10 ? dangerColor : primaryColor
                              ),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        SizedBox(height: spLg),
                        Row(
                          spacing: spMd,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QButton(
                              label: countdownRunning ? "Pause" : "Start",
                              size: bs.md,
                              onPressed: () {
                                if (totalCountdownSeconds > 0) {
                                  countdownRunning = !countdownRunning;
                                  setState(() {});
                                  if (countdownRunning) {
                                    ss("Countdown started");
                                  } else {
                                    sw("Countdown paused");
                                  }
                                }
                              },
                            ),
                            QButton(
                              label: "Reset",
                              size: bs.md,
                              onPressed: () {
                                countdownRunning = false;
                                remainingSeconds = totalCountdownSeconds;
                                setState(() {});
                                si("Countdown reset");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Interval Tab
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Interval Setup
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
                        "Interval Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: QNumberField(
                              label: "Work (sec)",
                              value: workSeconds.toString(),
                              onChanged: (value) {
                                workSeconds = int.tryParse(value) ?? 45;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Rest (sec)",
                              value: restSeconds.toString(),
                              onChanged: (value) {
                                restSeconds = int.tryParse(value) ?? 15;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QNumberField(
                        label: "Number of Intervals",
                        value: intervals.toString(),
                        onChanged: (value) {
                          intervals = int.tryParse(value) ?? 8;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                // Interval Display
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isWorkPhase ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            isWorkPhase ? "WORK" : "REST",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          formattedInterval,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: isWorkPhase ? successColor : warningColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Interval $currentInterval of $intervals",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spLg),
                        Row(
                          spacing: spMd,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QButton(
                              label: intervalRunning ? "Pause" : "Start",
                              size: bs.md,
                              onPressed: () {
                                intervalRunning = !intervalRunning;
                                setState(() {});
                                if (intervalRunning) {
                                  ss("Interval training started");
                                } else {
                                  sw("Interval training paused");
                                }
                              },
                            ),
                            QButton(
                              label: "Reset",
                              size: bs.md,
                              onPressed: () {
                                intervalRunning = false;
                                currentInterval = 1;
                                isWorkPhase = true;
                                intervalRemainingSeconds = workSeconds;
                                setState(() {});
                                si("Interval training reset");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Round Tab
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Round Setup
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
                        "Round Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: QNumberField(
                              label: "Round Duration (min)",
                              value: roundDuration.toString(),
                              onChanged: (value) {
                                roundDuration = int.tryParse(value) ?? 3;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Rest (min)",
                              value: restBetweenRounds.toString(),
                              onChanged: (value) {
                                restBetweenRounds = int.tryParse(value) ?? 1;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QNumberField(
                        label: "Number of Rounds",
                        value: rounds.toString(),
                        onChanged: (value) {
                          rounds = int.tryParse(value) ?? 5;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                // Round Display
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isRoundActive ? dangerColor : infoColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            isRoundActive ? "ROUND $currentRound" : "REST",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          formattedRound,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: isRoundActive ? dangerColor : infoColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Round $currentRound of $rounds",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spLg),
                        Row(
                          spacing: spMd,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QButton(
                              label: roundRunning ? "Pause" : "Start",
                              size: bs.md,
                              onPressed: () {
                                roundRunning = !roundRunning;
                                setState(() {});
                                if (roundRunning) {
                                  ss("Round timer started");
                                } else {
                                  sw("Round timer paused");
                                }
                              },
                            ),
                            QButton(
                              label: "Reset",
                              size: bs.md,
                              onPressed: () {
                                roundRunning = false;
                                currentRound = 1;
                                isRoundActive = true;
                                roundRemainingSeconds = roundDuration * 60;
                                setState(() {});
                                si("Round timer reset");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        onInit: (tabController) {
          // Optional: Access to TabController
        },
      ),
    );
  }
}
