import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmSchedulingView extends StatefulWidget {
  const FsmSchedulingView({super.key});

  @override
  State<FsmSchedulingView> createState() => _FsmSchedulingViewState();
}

class _FsmSchedulingViewState extends State<FsmSchedulingView> {
  DateTime selectedDate = DateTime.now();
  int currentView = 0; // 0: Day, 1: Week, 2: Month
  
  List<Map<String, dynamic>> schedules = [
    {
      "id": "1",
      "title": "HVAC Maintenance",
      "client": "Office Complex A",
      "technician": "John Smith",
      "startTime": "09:00",
      "endTime": "12:00",
      "status": "Scheduled",
      "priority": "High",
      "location": "Downtown Building",
      "type": "Maintenance",
      "date": DateTime.now(),
    },
    {
      "id": "2",
      "title": "Plumbing Repair",
      "client": "Residential Unit B",
      "technician": "Mike Davis",
      "startTime": "14:00",
      "endTime": "16:00",
      "status": "In Progress",
      "priority": "Medium",
      "location": "Green Valley",
      "type": "Repair",
      "date": DateTime.now(),
    },
    {
      "id": "3",
      "title": "Electrical Installation",
      "client": "Factory C",
      "technician": "Sarah Johnson",
      "startTime": "08:00",
      "endTime": "17:00",
      "status": "Scheduled",
      "priority": "High",
      "location": "Industrial Zone",
      "type": "Installation",
      "date": DateTime.now().add(Duration(days: 1)),
    },
    {
      "id": "4",
      "title": "Security System Check",
      "client": "Mall D",
      "technician": "Emma Wilson",
      "startTime": "10:00",
      "endTime": "13:00",
      "status": "Completed",
      "priority": "Low",
      "location": "Shopping District",
      "type": "Inspection",
      "date": DateTime.now().subtract(Duration(days: 1)),
    }
  ];

  List<Map<String, dynamic>> technicians = [
    {"name": "John Smith", "status": "Available", "currentJobs": 2},
    {"name": "Mike Davis", "status": "Busy", "currentJobs": 3},
    {"name": "Sarah Johnson", "status": "Available", "currentJobs": 1},
    {"name": "Emma Wilson", "status": "Off Duty", "currentJobs": 0},
  ];

  bool showScheduleForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduling"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showScheduleForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildViewToggle(),
            _buildDateNavigation(),
            _buildTechnicianStatus(),
            _buildScheduleView(),
            if (showScheduleForm) _buildScheduleForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "View:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Row(
              spacing: spXs,
              children: [
                _buildViewButton("Day", 0),
                _buildViewButton("Week", 1),
                _buildViewButton("Month", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(String label, int index) {
    bool isSelected = currentView == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentView = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateNavigation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              selectedDate = selectedDate.subtract(Duration(days: 1));
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(Icons.chevron_left, color: primaryColor),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              children: [
                Text(
                  selectedDate.dMMMy,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  _getViewRangeText(),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              selectedDate = selectedDate.add(Duration(days: 1));
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(Icons.chevron_right, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  String _getViewRangeText() {
    switch (currentView) {
      case 0:
        return "Daily View";
      case 1:
        return "Weekly View";
      case 2:
        return "Monthly View";
      default:
        return "Daily View";
    }
  }

  Widget _buildTechnicianStatus() {
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
            "Technician Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: technicians.map((tech) => _buildTechStatusCard(tech)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStatusCard(Map<String, dynamic> technician) {
    Color statusColor = technician["status"] == "Available" ? successColor :
                       technician["status"] == "Busy" ? warningColor : disabledBoldColor;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: statusColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: statusColor.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              "${technician["name"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${technician["status"]}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "${technician["currentJobs"]} jobs",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleView() {
    List<Map<String, dynamic>> filteredSchedules = schedules.where((schedule) {
      DateTime scheduleDate = schedule["date"] as DateTime;
      if (currentView == 0) {
        return scheduleDate.day == selectedDate.day &&
               scheduleDate.month == selectedDate.month &&
               scheduleDate.year == selectedDate.year;
      } else if (currentView == 1) {
        int daysDiff = scheduleDate.difference(selectedDate).inDays;
        return daysDiff >= -3 && daysDiff <= 3;
      } else {
        return scheduleDate.month == selectedDate.month &&
               scheduleDate.year == selectedDate.year;
      }
    }).toList();

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
          Row(
            children: [
              Text(
                "Scheduled Jobs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredSchedules.length} jobs",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredSchedules.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.calendar_today, size: 48, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No schedules for this period",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              spacing: spSm,
              children: filteredSchedules.map((schedule) => _buildScheduleCard(schedule)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    Color statusColor = schedule["status"] == "Completed" ? successColor :
                       schedule["status"] == "In Progress" ? infoColor :
                       schedule["status"] == "Scheduled" ? warningColor : disabledBoldColor;

    Color priorityColor = schedule["priority"] == "High" ? dangerColor :
                         schedule["priority"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${schedule["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Client: ${schedule["client"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Technician: ${schedule["technician"]}",
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
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${schedule["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${schedule["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${schedule["startTime"]} - ${schedule["endTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${schedule["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${schedule["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleForm() {
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
          Row(
            children: [
              Text(
                "New Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showScheduleForm = false;
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          QTextField(
            label: "Job Title",
            value: "",
            onChanged: (value) {},
          ),
          QTextField(
            label: "Client Name",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Technician",
                  items: technicians.map((tech) => {
                    "label": "${tech["name"]}",
                    "value": "${tech["name"]}"
                  }).toList(),
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Schedule Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Job Type",
                  items: [
                    {"label": "Installation", "value": "Installation"},
                    {"label": "Maintenance", "value": "Maintenance"},
                    {"label": "Repair", "value": "Repair"},
                    {"label": "Inspection", "value": "Inspection"},
                  ],
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: TimeOfDay.now(),
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "End Time",
                  value: TimeOfDay.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QTextField(
            label: "Location",
            value: "",
            onChanged: (value) {},
          ),
          QMemoField(
            label: "Job Description",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showScheduleForm = false;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Create Schedule",
                  size: bs.sm,
                  onPressed: () {
                    ss("Schedule created successfully");
                    showScheduleForm = false;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
