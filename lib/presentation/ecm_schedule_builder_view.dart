import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmScheduleBuilderView extends StatefulWidget {
  const EcmScheduleBuilderView({super.key});

  @override
  State<EcmScheduleBuilderView> createState() => _EcmScheduleBuilderViewState();
}

class _EcmScheduleBuilderViewState extends State<EcmScheduleBuilderView> {
  String scheduleName = "";
  String selectedTemplate = "Blank";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  bool enableBreaks = true;
  String breakDuration = "15";
  bool enableLunch = true;
  String lunchDuration = "60";
  
  List<Map<String, dynamic>> templateOptions = [
    {"label": "Blank Schedule", "value": "Blank"},
    {"label": "Conference Template", "value": "Conference"},
    {"label": "Workshop Series", "value": "Workshop"},
    {"label": "Business Meeting", "value": "Business"},
    {"label": "Educational Event", "value": "Education"},
  ];

  List<Map<String, dynamic>> breakDurationOptions = [
    {"label": "10 minutes", "value": "10"},
    {"label": "15 minutes", "value": "15"},
    {"label": "20 minutes", "value": "20"},
    {"label": "30 minutes", "value": "30"},
  ];

  List<Map<String, dynamic>> lunchDurationOptions = [
    {"label": "30 minutes", "value": "30"},
    {"label": "45 minutes", "value": "45"},
    {"label": "60 minutes", "value": "60"},
    {"label": "90 minutes", "value": "90"},
  ];

  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": "1",
      "title": "Registration & Welcome Coffee",
      "description": "Check-in and networking with welcome refreshments",
      "start_time": "08:00",
      "end_time": "09:00",
      "type": "logistics",
      "location": "Main Lobby",
      "capacity": 500,
      "resources": ["Audio/Visual", "Catering"],
      "is_break": false,
      "is_editable": true,
      "order": 1
    },
    {
      "id": "2",
      "title": "Opening Keynote",
      "description": "Welcome address and conference overview",
      "start_time": "09:00",
      "end_time": "10:00",
      "type": "presentation",
      "location": "Main Auditorium",
      "capacity": 1000,
      "resources": ["Audio/Visual", "Live Streaming"],
      "is_break": false,
      "is_editable": true,
      "order": 2
    },
    {
      "id": "3",
      "title": "Coffee Break",
      "description": "Networking break with refreshments",
      "start_time": "10:00",
      "end_time": "10:15",
      "type": "break",
      "location": "Exhibition Area",
      "capacity": 800,
      "resources": ["Catering"],
      "is_break": true,
      "is_editable": false,
      "order": 3
    },
    {
      "id": "4",
      "title": "Technical Workshop: AI in Development",
      "description": "Hands-on workshop exploring AI tools for developers",
      "start_time": "10:15",
      "end_time": "11:45",
      "type": "workshop",
      "location": "Tech Lab",
      "capacity": 50,
      "resources": ["Computers", "Audio/Visual", "Internet"],
      "is_break": false,
      "is_editable": true,
      "order": 4
    },
    {
      "id": "5",
      "title": "Lunch Break",
      "description": "Networking lunch with sponsors",
      "start_time": "12:00",
      "end_time": "13:00",
      "type": "lunch",
      "location": "Grand Ballroom",
      "capacity": 1200,
      "resources": ["Catering", "Audio/Visual"],
      "is_break": true,
      "is_editable": false,
      "order": 5
    },
  ];

  List<Map<String, dynamic>> savedSchedules = [
    {
      "id": "1",
      "name": "Tech Conference 2024",
      "template": "Conference",
      "created_date": "2024-01-10",
      "last_modified": "2024-01-14",
      "days": 3,
      "sessions": 24,
      "status": "Draft"
    },
    {
      "id": "2",
      "name": "Product Launch Event",
      "template": "Business",
      "created_date": "2024-01-08",
      "last_modified": "2024-01-12",
      "days": 1,
      "sessions": 8,
      "status": "Published"
    },
    {
      "id": "3",
      "name": "Training Workshop Series",
      "template": "Workshop",
      "created_date": "2024-01-05",
      "last_modified": "2024-01-10",
      "days": 2,
      "sessions": 12,
      "status": "Active"
    },
  ];

  final formKey = GlobalKey<FormState>();

  String _getTypeIcon(String type) {
    switch (type) {
      case "presentation":
        return "mic";
      case "workshop":
        return "build";
      case "break":
        return "coffee";
      case "lunch":
        return "restaurant";
      case "logistics":
        return "event";
      default:
        return "schedule";
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "presentation":
        return primaryColor;
      case "workshop":
        return successColor;
      case "break":
        return warningColor;
      case "lunch":
        return infoColor;
      case "logistics":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  void _addNewScheduleItem() async {
    // Show dialog to add new schedule item
    ss("Add new session dialog would open here");
  }

  void _editScheduleItem(Map<String, dynamic> item) {
    if (item["is_editable"]) {
      ss("Edit session dialog would open for: ${item["title"]}");
    } else {
      sw("This session cannot be edited as it's a system-generated break");
    }
  }

  void _deleteScheduleItem(String itemId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this session?");
    if (isConfirmed) {
      scheduleItems.removeWhere((item) => item["id"] == itemId);
      setState(() {});
      ss("Session deleted successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Builder"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Schedule saved successfully!");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_view_day,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Build Your Event Schedule",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Create and customize your event timeline",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Schedule Configuration Section
              Container(
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
                      "Schedule Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Schedule Name",
                      value: scheduleName,
                      hint: "Enter event schedule name",
                      validator: Validator.required,
                      onChanged: (value) {
                        scheduleName = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Template",
                      items: templateOptions,
                      value: selectedTemplate,
                      onChanged: (value, label) {
                        selectedTemplate = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Start Date",
                            value: startDate,
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "End Date",
                            value: endDate,
                            onChanged: (value) {
                              endDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Enable Breaks",
                                "value": true,
                                "checked": enableBreaks,
                              }
                            ],
                            value: [
                              if (enableBreaks)
                                {
                                  "label": "Enable Breaks",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              enableBreaks = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        if (enableBreaks) ...[
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Break Duration",
                              items: breakDurationOptions,
                              value: breakDuration,
                              onChanged: (value, label) {
                                breakDuration = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Enable Lunch",
                                "value": true,
                                "checked": enableLunch,
                              }
                            ],
                            value: [
                              if (enableLunch)
                                {
                                  "label": "Enable Lunch",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              enableLunch = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        if (enableLunch) ...[
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Lunch Duration",
                              items: lunchDurationOptions,
                              value: lunchDuration,
                              onChanged: (value, label) {
                                lunchDuration = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Schedule Timeline Section
              Container(
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
                      children: [
                        Icon(
                          Icons.timeline,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Schedule Timeline",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 36,
                          height: 36,
                          child: QButton(
                            icon: Icons.add,
                            size: bs.sm,
                            onPressed: _addNewScheduleItem,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...List.generate(scheduleItems.length, (index) {
                      final item = scheduleItems[index];
                      final itemColor = _getTypeColor(item["type"]);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timeline indicator
                            Column(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: itemColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                if (index < scheduleItems.length - 1)
                                  Container(
                                    width: 2,
                                    height: 60,
                                    color: itemColor.withAlpha(50),
                                  ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: itemColor.withAlpha(5),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: itemColor.withAlpha(30),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${item["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: itemColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${item["type"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,
                                              color: itemColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${item["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${item["start_time"]} - ${item["end_time"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.location_on,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${item["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Capacity: ${item["capacity"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () => _editScheduleItem(item),
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: item["is_editable"] 
                                                  ? primaryColor.withAlpha(20)
                                                  : disabledColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 12,
                                              color: item["is_editable"] 
                                                  ? primaryColor
                                                  : disabledColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        GestureDetector(
                                          onTap: () => _deleteScheduleItem(item["id"]),
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: dangerColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              Icons.delete,
                                              size: 12,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if ((item["resources"] as List).isNotEmpty) ...[
                                      SizedBox(height: spXs),
                                      Wrap(
                                        spacing: spXs,
                                        runSpacing: spXs,
                                        children: (item["resources"] as List).map((resource) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "$resource",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: infoColor,
                                              ),
                                            ),
                                          );
                                        }).toList().cast<Widget>(),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Saved Schedules Section
              Container(
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
                      children: [
                        Icon(
                          Icons.folder,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Saved Schedules",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...List.generate(savedSchedules.length, (index) {
                      final schedule = savedSchedules[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_note,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${schedule["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${schedule["days"]} days • ${schedule["sessions"]} sessions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Modified ${DateTime.parse(schedule["last_modified"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: schedule["status"] == "Published"
                                    ? successColor.withAlpha(20)
                                    : schedule["status"] == "Active"
                                        ? primaryColor.withAlpha(20)
                                        : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${schedule["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: schedule["status"] == "Published"
                                      ? successColor
                                      : schedule["status"] == "Active"
                                          ? primaryColor
                                          : warningColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.more_vert,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Schedule",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Schedule saved successfully!");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
