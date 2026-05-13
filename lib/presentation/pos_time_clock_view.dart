import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosTimeClockView extends StatefulWidget {
  const PosTimeClockView({super.key});

  @override
  State<PosTimeClockView> createState() => _PosTimeClockViewState();
}

class _PosTimeClockViewState extends State<PosTimeClockView> {
  bool isClockedIn = false;
  String currentTime = "";
  String clockInTime = "";
  String clockOutTime = "";
  double totalHours = 0.0;
  String currentDate = "";
  
  List<Map<String, dynamic>> timeEntries = [
    {
      "date": "2024-01-15",
      "clockIn": "08:00 AM",
      "clockOut": "05:00 PM",
      "hours": 9.0,
      "status": "completed"
    },
    {
      "date": "2024-01-14",
      "clockIn": "08:15 AM",
      "clockOut": "05:30 PM",
      "hours": 9.25,
      "status": "completed"
    },
    {
      "date": "2024-01-13",
      "clockIn": "07:45 AM",
      "clockOut": "04:45 PM",
      "hours": 9.0,
      "status": "completed"
    },
    {
      "date": "2024-01-12",
      "clockIn": "08:30 AM",
      "clockOut": "06:00 PM",
      "hours": 9.5,
      "status": "overtime"
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    currentDate = DateTime.now().dMMMy;
  }

  void _updateCurrentTime() {
    setState(() {
      currentTime = TimeOfDay.now().kkmm;
    });
  }

  void _clockIn() {
    setState(() {
      isClockedIn = true;
      clockInTime = TimeOfDay.now().kkmm;
    });
    ss("Clocked in successfully at $clockInTime");
  }

  void _clockOut() {
    setState(() {
      isClockedIn = false;
      clockOutTime = TimeOfDay.now().kkmm;
      totalHours = 8.5; // Calculate actual hours worked
    });
    ss("Clocked out successfully at $clockOutTime");
  }

  Widget _buildClockStatusCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: isClockedIn ? successColor.withAlpha(20) : primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: isClockedIn ? successColor : primaryColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isClockedIn ? Icons.schedule : Icons.access_time,
            size: 48,
            color: isClockedIn ? successColor : primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            isClockedIn ? "CLOCKED IN" : "CLOCKED OUT",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: isClockedIn ? successColor : primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            currentTime,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            currentDate,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if (isClockedIn && clockInTime.isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Started at $clockInTime",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildClockActions() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: isClockedIn ? "Clock Out" : "Clock In",
            icon: isClockedIn ? Icons.logout : Icons.login,
            size: bs.md,
            onPressed: isClockedIn ? _clockOut : _clockIn,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Clock In",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        clockInTime.isEmpty ? "--:--" : clockInTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Clock Out",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        clockOutTime.isEmpty ? "--:--" : clockOutTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        totalHours > 0 ? "${totalHours}h" : "--",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeHistory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Time Entries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to full history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: timeEntries.take(4).map((entry) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: entry["status"] == "overtime" ? warningColor : successColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateTime.parse(entry["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${entry["clockIn"]} - ${entry["clockOut"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${(entry["hours"] as double).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (entry["status"] == "overtime")
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OT",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Clock"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to time history
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _updateCurrentTime,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildClockStatusCard(),
            _buildClockActions(),
            _buildTodayStats(),
            _buildTimeHistory(),
          ],
        ),
      ),
    );
  }
}
