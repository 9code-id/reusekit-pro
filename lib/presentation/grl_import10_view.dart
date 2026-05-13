import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport10View extends StatefulWidget {
  @override
  State<GrlImport10View> createState() => _GrlImport10ViewState();
}

class _GrlImport10ViewState extends State<GrlImport10View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String scheduleName = "";
  String scheduleDescription = "";
  String importType = "CSV File";
  String frequency = "Daily";
  String startTime = "09:00";
  String timezone = "UTC";
  bool isActive = true;
  String dataSource = "";
  String targetTable = "";
  bool enableNotifications = true;
  String notificationEmail = "";
  
  List<Map<String, dynamic>> scheduledImports = [
    {
      "id": "SCH001",
      "name": "Daily Customer Sync",
      "description": "Synchronize customer data from CRM",
      "type": "Database",
      "frequency": "Daily",
      "time": "08:00",
      "status": "Active",
      "lastRun": DateTime.now().subtract(Duration(hours: 16)),
      "nextRun": DateTime.now().add(Duration(hours: 8)),
      "success": 156,
      "failures": 2,
      "timezone": "UTC",
    },
    {
      "id": "SCH002",
      "name": "Weekly Inventory Report",
      "description": "Import weekly inventory data",
      "type": "CSV File",
      "frequency": "Weekly",
      "time": "02:00",
      "status": "Active",
      "lastRun": DateTime.now().subtract(Duration(days: 3)),
      "nextRun": DateTime.now().add(Duration(days: 4)),
      "success": 23,
      "failures": 0,
      "timezone": "UTC",
    },
    {
      "id": "SCH003",
      "name": "Monthly Sales Import",
      "description": "Import monthly sales data from API",
      "type": "API",
      "frequency": "Monthly",
      "time": "23:00",
      "status": "Paused",
      "lastRun": DateTime.now().subtract(Duration(days: 28)),
      "nextRun": DateTime.now().add(Duration(days: 2)),
      "success": 12,
      "failures": 1,
      "timezone": "UTC",
    }
  ];

  List<Map<String, dynamic>> recentExecutions = [
    {
      "id": "EXE001",
      "scheduleId": "SCH001",
      "scheduleName": "Daily Customer Sync",
      "status": "Success",
      "startTime": DateTime.now().subtract(Duration(hours: 16)),
      "endTime": DateTime.now().subtract(Duration(hours: 16, minutes: -2)),
      "recordsProcessed": 1240,
      "errors": 0,
      "duration": "2m 15s",
    },
    {
      "id": "EXE002", 
      "scheduleId": "SCH002",
      "scheduleName": "Weekly Inventory Report",
      "status": "Success",
      "startTime": DateTime.now().subtract(Duration(days: 3)),
      "endTime": DateTime.now().subtract(Duration(days: 3, hours: -1)),
      "recordsProcessed": 850,
      "errors": 0,
      "duration": "45s",
    },
    {
      "id": "EXE003",
      "scheduleId": "SCH001",
      "scheduleName": "Daily Customer Sync",
      "status": "Failed",
      "startTime": DateTime.now().subtract(Duration(days: 1, hours: 8)),
      "endTime": DateTime.now().subtract(Duration(days: 1, hours: 8, minutes: -1)),
      "recordsProcessed": 0,
      "errors": 1,
      "duration": "30s",
    }
  ];

  List<Map<String, dynamic>> importTypeOptions = [
    {"label": "CSV File", "value": "CSV File"},
    {"label": "Excel File", "value": "Excel File"},
    {"label": "Database", "value": "Database"},
    {"label": "API Endpoint", "value": "API"},
    {"label": "FTP Server", "value": "FTP"},
    {"label": "Cloud Storage", "value": "Cloud"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Custom", "value": "Custom"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC", "value": "UTC"},
    {"label": "America/New_York", "value": "America/New_York"},
    {"label": "Europe/London", "value": "Europe/London"},
    {"label": "Asia/Tokyo", "value": "Asia/Tokyo"},
    {"label": "Australia/Sydney", "value": "Australia/Sydney"},
  ];

  void _createSchedule() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    final newSchedule = {
      "id": "SCH${DateTime.now().millisecondsSinceEpoch}",
      "name": scheduleName,
      "description": scheduleDescription,
      "type": importType,
      "frequency": frequency,
      "time": startTime,
      "status": "Active",
      "lastRun": null,
      "nextRun": _calculateNextRun(),
      "success": 0,
      "failures": 0,
      "timezone": timezone,
    };
    
    scheduledImports.add(newSchedule);
    
    // Reset form
    scheduleName = "";
    scheduleDescription = "";
    importType = "CSV File";
    frequency = "Daily";
    startTime = "09:00";
    timezone = "UTC";
    dataSource = "";
    targetTable = "";
    notificationEmail = "";
    
    loading = false;
    setState(() {});
    
    ss("Import schedule created successfully");
  }

  DateTime _calculateNextRun() {
    final now = DateTime.now();
    final timeOfDay = startTime.timeOfDay;
    var nextRun = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    
    if (nextRun.isBefore(now)) {
      nextRun = nextRun.add(Duration(days: 1));
    }
    
    switch (frequency) {
      case "Weekly":
        nextRun = nextRun.add(Duration(days: 7));
        break;
      case "Monthly":
        nextRun = DateTime(nextRun.year, nextRun.month + 1, nextRun.day, nextRun.hour, nextRun.minute);
        break;
    }
    
    return nextRun;
  }

  void _toggleSchedule(String scheduleId) {
    final index = scheduledImports.indexWhere((schedule) => schedule["id"] == scheduleId);
    if (index != -1) {
      scheduledImports[index]["status"] = 
          scheduledImports[index]["status"] == "Active" ? "Paused" : "Active";
      setState(() {});
      
      String status = scheduledImports[index]["status"];
      si("Schedule ${status.toLowerCase()}");
    }
  }

  void _runNow(String scheduleId) async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    final execution = {
      "id": "EXE${DateTime.now().millisecondsSinceEpoch}",
      "scheduleId": scheduleId,
      "scheduleName": scheduledImports.firstWhere((s) => s["id"] == scheduleId)["name"],
      "status": "Success",
      "startTime": DateTime.now(),
      "endTime": DateTime.now().add(Duration(minutes: 2)),
      "recordsProcessed": 1150,
      "errors": 0,
      "duration": "2m 00s",
    };
    
    recentExecutions.insert(0, execution);
    
    loading = false;
    setState(() {});
    
    ss("Schedule executed successfully");
  }

  void _deleteSchedule(String scheduleId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this schedule?");
    if (!isConfirmed) return;
    
    scheduledImports.removeWhere((schedule) => schedule["id"] == scheduleId);
    setState(() {});
    sw("Schedule deleted");
  }

  void _viewExecutionDetails(Map<String, dynamic> execution) {
    si("Viewing execution details for ${execution["id"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Scheduler"),
        actions: [
          Icon(
            Icons.schedule,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCreateScheduleSection(),
                  _buildActiveSchedulesSection(),
                  _buildRecentExecutionsSection(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildCreateScheduleSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_alarm,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Create New Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Schedule Name",
            value: scheduleName,
            hint: "Enter a descriptive name for this schedule",
            validator: Validator.required,
            onChanged: (value) {
              scheduleName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: scheduleDescription,
            hint: "Describe what this schedule does",
            onChanged: (value) {
              scheduleDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Import Type",
                  items: importTypeOptions,
                  value: importType,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    importType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Frequency",
                  items: frequencyOptions,
                  value: frequency,
                  onChanged: (value, label) {
                    frequency = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: startTime.timeOfDay,
                  onChanged: (value) {
                    startTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Timezone",
                  items: timezoneOptions,
                  value: timezone,
                  onChanged: (value, label) {
                    timezone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Data Source",
            value: dataSource,
            hint: "File path, database connection, or API endpoint",
            validator: Validator.required,
            onChanged: (value) {
              dataSource = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Target Table/Destination",
            value: targetTable,
            hint: "Where to import the data",
            validator: Validator.required,
            onChanged: (value) {
              targetTable = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Notifications",
                      "value": true,
                      "checked": enableNotifications,
                    }
                  ],
                  value: [
                    if (enableNotifications)
                      {"label": "Enable Notifications", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    enableNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (enableNotifications)
                Expanded(
                  child: QTextField(
                    label: "Notification Email",
                    value: notificationEmail,
                    hint: "admin@company.com",
                    validator: enableNotifications ? Validator.email : null,
                    onChanged: (value) {
                      notificationEmail = value;
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Schedule",
              size: bs.md,
              onPressed: _createSchedule,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSchedulesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Scheduled Imports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${scheduledImports.where((s) => s["status"] == "Active").length}/${scheduledImports.length} active",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (scheduledImports.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(
                    Icons.schedule,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No scheduled imports",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Create your first schedule to automate data imports",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...scheduledImports.map((schedule) => _buildScheduleCard(schedule)),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    Color statusColor = schedule["status"] == "Active" ? successColor : warningColor;
    IconData statusIcon = schedule["status"] == "Active" ? Icons.play_circle : Icons.pause_circle;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(100)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${schedule["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${schedule["type"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${schedule["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 16,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'toggle':
                      _toggleSchedule(schedule["id"]);
                      break;
                    case 'run':
                      _runNow(schedule["id"]);
                      break;
                    case 'delete':
                      _deleteSchedule(schedule["id"]);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(
                          schedule["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(schedule["status"] == "Active" ? "Pause" : "Activate"),
                      ],
                    ),
                  ),
                  if (schedule["status"] == "Active")
                    PopupMenuItem(
                      value: 'run',
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow, size: 16),
                          SizedBox(width: spXs),
                          Text("Run Now"),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16),
                        SizedBox(width: spXs),
                        Text("Delete"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildScheduleInfo("Frequency", "${schedule["frequency"]} at ${schedule["time"]}"),
              ),
              Expanded(
                child: _buildScheduleInfo("Success Rate", 
                    "${schedule["success"] + schedule["failures"] > 0 ? ((schedule["success"] as int) / (schedule["success"] + schedule["failures"]) * 100).toStringAsFixed(1) : '0'}%"),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildScheduleInfo("Last Run", 
                    schedule["lastRun"] != null ? "${(schedule["lastRun"] as DateTime).dMMMy}" : "Never"),
              ),
              Expanded(
                child: _buildScheduleInfo("Next Run", "${(schedule["nextRun"] as DateTime).dMMMy}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentExecutionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recent Executions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  si("Viewing all execution history");
                },
              ),
            ],
          ),
          ...recentExecutions.take(5).map((execution) => _buildExecutionCard(execution)),
        ],
      ),
    );
  }

  Widget _buildExecutionCard(Map<String, dynamic> execution) {
    Color statusColor = execution["status"] == "Success" ? successColor : dangerColor;
    IconData statusIcon = execution["status"] == "Success" ? Icons.check_circle : Icons.error;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${execution["scheduleName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${(execution["startTime"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${execution["recordsProcessed"]} records",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${execution["duration"]}",
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
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () => _viewExecutionDetails(execution),
          ),
        ],
      ),
    );
  }
}
