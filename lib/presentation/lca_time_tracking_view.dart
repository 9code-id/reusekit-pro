import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTimeTrackingView extends StatefulWidget {
  const LcaTimeTrackingView({super.key});

  @override
  State<LcaTimeTrackingView> createState() => _LcaTimeTrackingViewState();
}

class _LcaTimeTrackingViewState extends State<LcaTimeTrackingView> {
  bool isTracking = false;
  DateTime? startTime;
  Duration currentDuration = Duration.zero;
  String selectedClient = "";
  String selectedMatter = "";
  String description = "";
  String selectedCategory = "Legal Research";
  
  List<Map<String, dynamic>> activeTimers = [
    {
      "id": 1,
      "client": "TechCorp Industries",
      "matter": "Software License Review",
      "category": "Contract Review",
      "description": "Reviewing terms and conditions for enterprise software license",
      "startTime": DateTime.now().subtract(Duration(hours: 2, minutes: 15)),
      "attorney": "Sarah Wilson",
      "rate": 350.0,
    },
    {
      "id": 2,
      "client": "Johnson Corp",
      "matter": "Employment Dispute",
      "category": "Litigation",
      "description": "Preparing court documents and case research",
      "startTime": DateTime.now().subtract(Duration(minutes: 45)),
      "attorney": "Michael Davis",
      "rate": 425.0,
    },
  ];

  List<Map<String, dynamic>> recentEntries = [
    {
      "id": 1,
      "date": "2025-06-19",
      "client": "Smith Family Trust",
      "matter": "Estate Planning",
      "category": "Document Drafting",
      "description": "Drafted comprehensive will and trust documents",
      "duration": 2.5,
      "attorney": "Lisa Chen",
      "amount": 750.0,
      "billable": true,
    },
    {
      "id": 2,
      "date": "2025-06-19",
      "client": "Metro Construction",
      "matter": "Property Acquisition",
      "category": "Due Diligence",
      "description": "Conducted property document review and analysis",
      "duration": 3.0,
      "attorney": "David Rodriguez",
      "amount": 1125.0,
      "billable": true,
    },
    {
      "id": 3,
      "date": "2025-06-18",
      "client": "Healthcare Partners",
      "matter": "HIPAA Compliance",
      "category": "Compliance Review",
      "description": "Internal administrative meeting - non-billable",
      "duration": 1.0,
      "attorney": "Emily Taylor",
      "amount": 0.0,
      "billable": false,
    },
  ];

  List<Map<String, dynamic>> clientOptions = [
    {"label": "TechCorp Industries", "value": "TechCorp Industries"},
    {"label": "Johnson Corp", "value": "Johnson Corp"},
    {"label": "Smith Family Trust", "value": "Smith Family Trust"},
    {"label": "Metro Construction", "value": "Metro Construction"},
    {"label": "Healthcare Partners", "value": "Healthcare Partners"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Legal Research", "value": "Legal Research"},
    {"label": "Contract Review", "value": "Contract Review"},
    {"label": "Court Preparation", "value": "Court Preparation"},
    {"label": "Document Drafting", "value": "Document Drafting"},
    {"label": "Client Meeting", "value": "Client Meeting"},
    {"label": "Due Diligence", "value": "Due Diligence"},
    {"label": "Litigation", "value": "Litigation"},
    {"label": "Compliance Review", "value": "Compliance Review"},
    {"label": "Administration", "value": "Administration"},
  ];

  void _startTimer() {
    if (selectedClient.isEmpty) {
      se("Please select a client");
      return;
    }
    if (selectedMatter.isEmpty) {
      se("Please enter matter description");
      return;
    }

    setState(() {
      isTracking = true;
      startTime = DateTime.now();
      currentDuration = Duration.zero;
    });
    ss("Timer started");
  }

  void _stopTimer() {
    if (!isTracking) return;

    setState(() {
      isTracking = false;
      // Add to recent entries
      recentEntries.insert(0, {
        "id": recentEntries.length + 1,
        "date": DateTime.now().toString().split(' ')[0],
        "client": selectedClient,
        "matter": selectedMatter,
        "category": selectedCategory,
        "description": description.isEmpty ? "Time tracking entry" : description,
        "duration": currentDuration.inMinutes / 60.0,
        "attorney": "Current User",
        "amount": (currentDuration.inMinutes / 60.0) * 350.0,
        "billable": true,
      });
      startTime = null;
      currentDuration = Duration.zero;
    });
    ss("Time entry saved");
  }

  void _pauseTimer() {
    setState(() {
      isTracking = false;
    });
    ss("Timer paused");
  }

  void _resumeTimer() {
    setState(() {
      isTracking = true;
    });
    ss("Timer resumed");
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _buildCurrentTimer() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: isTracking ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isTracking ? Icons.timer : Icons.timer_off,
                color: isTracking ? successColor : disabledBoldColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                isTracking ? "Timer Running" : "Start New Timer",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: isTracking ? successColor : primaryColor,
                ),
              ),
              Spacer(),
              if (isTracking)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "ACTIVE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
            ],
          ),
          if (isTracking) ...[
            SizedBox(height: spMd),
            Text(
              _formatDuration(currentDuration),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "$selectedClient - $selectedMatter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              selectedCategory,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Pause",
                    size: bs.md,
                    onPressed: _pauseTimer,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Stop & Save",
                    size: bs.md,
                    onPressed: _stopTimer,
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: spMd),
            QDropdownField(
              label: "Client",
              items: clientOptions,
              value: selectedClient,
              onChanged: (value, label) {
                selectedClient = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Matter/Case",
              value: selectedMatter,
              hint: "Enter matter or case description",
              onChanged: (value) {
                selectedMatter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Description (Optional)",
              value: description,
              hint: "Add detailed description of work performed",
              onChanged: (value) {
                description = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Timer",
                size: bs.md,
                onPressed: _startTimer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveTimers() {
    if (activeTimers.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Timers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...activeTimers.map((timer) {
            Duration elapsed = DateTime.now().difference(timer["startTime"]);
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: warningColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${timer["matter"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${timer["client"]} • ${timer["attorney"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _formatDuration(elapsed),
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "\$${((elapsed.inMinutes / 60.0) * (timer["rate"] as double)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${timer["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${timer["category"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Stop",
                        size: bs.sm,
                        onPressed: () {
                          activeTimers.removeWhere((t) => t["id"] == timer["id"]);
                          setState(() {});
                          ss("Timer stopped");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentEntries() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Time Entries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recentEntries.take(5).map((entry) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: entry["billable"] ? successColor : disabledBoldColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry["matter"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${entry["client"]} • ${entry["attorney"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(entry["duration"] as double).toStringAsFixed(1)}h",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            entry["billable"] 
                                ? "\$${(entry["amount"] as double).currency}"
                                : "Non-Billable",
                            style: TextStyle(
                              fontSize: 12,
                              color: entry["billable"] ? successColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${entry["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${entry["category"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          ss("Edit time entry");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Simulate timer updates
    if (isTracking) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (isTracking && startTime != null) {
          setState(() {
            currentDuration = DateTime.now().difference(startTime!);
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracking"),
        actions: [
          QButton(
            icon: Icons.history,
            size: bs.sm,
            onPressed: () {
              ss("View time history");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              ss("Timer settings");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCurrentTimer(),
            if (activeTimers.isNotEmpty) ...[
              SizedBox(height: spMd),
              _buildActiveTimers(),
            ],
            _buildRecentEntries(),
          ],
        ),
      ),
    );
  }
}
