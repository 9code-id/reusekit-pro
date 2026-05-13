import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTimerView extends StatefulWidget {
  const PmaTimerView({super.key});

  @override
  State<PmaTimerView> createState() => _PmaTimerViewState();
}

class _PmaTimerViewState extends State<PmaTimerView> {
  bool isRunning = false;
  bool isPaused = false;
  String currentTime = "00:00:00";
  String selectedProject = "E-commerce Platform";
  String selectedTask = "Frontend Development";
  String taskDescription = "";
  
  List<Map<String, dynamic>> projectOptions = [
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "Mobile App Development", "value": "Mobile App Development"},
    {"label": "Website Redesign", "value": "Website Redesign"},
    {"label": "API Integration", "value": "API Integration"},
    {"label": "Database Migration", "value": "Database Migration"},
    {"label": "Internal Tools", "value": "Internal Tools"},
  ];
  
  List<Map<String, dynamic>> taskOptions = [
    {"label": "Frontend Development", "value": "Frontend Development"},
    {"label": "Backend Development", "value": "Backend Development"},
    {"label": "UI/UX Design", "value": "UI/UX Design"},
    {"label": "Code Review", "value": "Code Review"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Client Meeting", "value": "Client Meeting"},
    {"label": "Team Meeting", "value": "Team Meeting"},
    {"label": "Bug Fixing", "value": "Bug Fixing"},
    {"label": "Research", "value": "Research"},
  ];
  
  List<Map<String, dynamic>> timerHistory = [
    {
      "id": 1,
      "project": "E-commerce Platform",
      "task": "Frontend Development",
      "duration": "2h 15m",
      "startTime": "09:00",
      "endTime": "11:15",
      "date": "2025-06-19",
      "description": "Implemented product listing page",
      "status": "completed"
    },
    {
      "id": 2,
      "project": "Mobile App Development",
      "task": "UI/UX Design",
      "duration": "1h 30m",
      "startTime": "13:30",
      "endTime": "15:00",
      "date": "2025-06-19",
      "description": "Created wireframes for profile screen",
      "status": "completed"
    },
    {
      "id": 3,
      "project": "API Integration",
      "task": "Backend Development",
      "duration": "3h 45m",
      "startTime": "10:00",
      "endTime": "13:45",
      "date": "2025-06-18",
      "description": "Implemented authentication endpoints",
      "status": "completed"
    },
    {
      "id": 4,
      "project": "Website Redesign",
      "task": "Client Meeting",
      "duration": "1h 00m",
      "startTime": "15:30",
      "endTime": "16:30",
      "date": "2025-06-18",
      "description": "Project requirements discussion",
      "status": "completed"
    }
  ];
  
  String todayTotal = "7h 45m";
  String weekTotal = "38h 30m";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildTimerDisplay(),
            _buildProjectSelection(),
            _buildTimerControls(),
            _buildTodaySummary(),
            _buildTimerHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerDisplay() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border.all(
          color: isRunning ? (isPaused ? warningColor : successColor) : disabledColor,
          width: 3,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isRunning ? (isPaused ? warningColor : successColor) : disabledColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                isRunning ? (isPaused ? "PAUSED" : "RUNNING") : "STOPPED",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isRunning ? (isPaused ? warningColor : successColor) : disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Text(
            currentTime,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontFamily: 'monospace',
            ),
          ),
          
          if (isRunning || selectedProject.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Text(
                    selectedProject,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    selectedTask,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Current Task",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectOptions,
                  value: selectedProject,
                  onChanged: (value, label) {
                    if (!isRunning || isPaused) {
                      selectedProject = value;
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Task",
                  items: taskOptions,
                  value: selectedTask,
                  onChanged: (value, label) {
                    if (!isRunning || isPaused) {
                      selectedTask = value;
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Task Description (Optional)",
            value: taskDescription,
            hint: "What are you working on?",
            onChanged: (value) {
              if (!isRunning || isPaused) {
                taskDescription = value;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimerControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          if (!isRunning) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Timer",
                icon: Icons.play_arrow,
                size: bs.md,
                onPressed: _startTimer,
              ),
            ),
          ] else if (isPaused) ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Resume",
                    icon: Icons.play_arrow,
                    color: successColor,
                    size: bs.md,
                    onPressed: _resumeTimer,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Stop",
                    icon: Icons.stop,
                    color: dangerColor,
                    size: bs.md,
                    onPressed: _stopTimer,
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Pause",
                    icon: Icons.pause,
                    color: warningColor,
                    size: bs.md,
                    onPressed: _pauseTimer,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Stop",
                    icon: Icons.stop,
                    color: dangerColor,
                    size: bs.md,
                    onPressed: _stopTimer,
                  ),
                ),
              ],
            ),
          ],
          
          // Quick Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  "Break",
                  Icons.coffee,
                  warningColor,
                  () => _startBreak(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Meeting",
                  Icons.group,
                  infoColor,
                  () => _startMeeting(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Reset",
                  Icons.refresh,
                  disabledBoldColor,
                  () => _resetTimer(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySummary() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Today",
            todayTotal,
            Icons.today,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "This Week",
            weekTotal,
            Icons.date_range,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Sessions",
            "${timerHistory.length}",
            Icons.timer,
            infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Active",
            isRunning ? "Yes" : "No",
            Icons.play_circle,
            isRunning ? successColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerHistory() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Recent Sessions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
          ),
          ...timerHistory.take(4).map((session) => _buildHistoryItem(session)).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> session) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${session["project"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${session["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${session["task"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                if (session["description"] != null && session["description"].toString().isNotEmpty)
                  Text(
                    "${session["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${session["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${session["startTime"]} - ${session["endTime"]}",
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
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _continueSession(session),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    if (selectedProject.isEmpty || selectedTask.isEmpty) {
      se("Please select a project and task");
      return;
    }
    
    isRunning = true;
    isPaused = false;
    currentTime = "00:00:01";
    setState(() {});
    ss("Timer started");
  }

  void _pauseTimer() {
    isPaused = true;
    setState(() {});
    si("Timer paused");
  }

  void _resumeTimer() {
    isPaused = false;
    setState(() {});
    ss("Timer resumed");
  }

  void _stopTimer() {
    isRunning = false;
    isPaused = false;
    currentTime = "00:00:00";
    setState(() {});
    ss("Timer stopped and time entry saved");
  }

  void _resetTimer() {
    isRunning = false;
    isPaused = false;
    currentTime = "00:00:00";
    setState(() {});
    si("Timer reset");
  }

  void _startBreak() {
    selectedProject = "Break";
    selectedTask = "Coffee Break";
    taskDescription = "Taking a short break";
    _startTimer();
  }

  void _startMeeting() {
    selectedTask = "Team Meeting";
    taskDescription = "Team standup meeting";
    _startTimer();
  }

  void _continueSession(Map<String, dynamic> session) {
    selectedProject = session["project"];
    selectedTask = session["task"];
    taskDescription = session["description"] ?? "";
    setState(() {});
    si("Session details loaded. Ready to start timer.");
  }
}
