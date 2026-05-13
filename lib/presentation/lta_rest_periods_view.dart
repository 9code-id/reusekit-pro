import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRestPeriodsView extends StatefulWidget {
  const LtaRestPeriodsView({super.key});

  @override
  State<LtaRestPeriodsView> createState() => _LtaRestPeriodsViewState();
}

class _LtaRestPeriodsViewState extends State<LtaRestPeriodsView> {
  int selectedTabIndex = 0;
  String selectedPeriod = "today";
  String searchQuery = "";

  List<Map<String, dynamic>> drivers = [
    {
      "id": "D001",
      "name": "John Williams",
      "currentStatus": "On Break",
      "breakType": "Mandatory",
      "breakStart": "12:00",
      "breakDuration": 30,
      "remainingBreakTime": 15,
      "dailyBreaksTaken": 2,
      "requiredBreaks": 3,
      "nextBreakDue": "15:30",
      "weeklyRestHours": 34,
      "requiredWeeklyRest": 45,
      "lastLongRest": "2024-12-15 22:00",
      "consecutiveDays": 5
    },
    {
      "id": "D002",
      "name": "Sarah Johnson",
      "currentStatus": "Working",
      "breakType": null,
      "breakStart": null,
      "breakDuration": 0,
      "remainingBreakTime": 0,
      "dailyBreaksTaken": 1,
      "requiredBreaks": 3,
      "nextBreakDue": "16:00",
      "weeklyRestHours": 45,
      "requiredWeeklyRest": 45,
      "lastLongRest": "2024-12-14 18:00",
      "consecutiveDays": 4
    },
    {
      "id": "D003",
      "name": "Mike Chen",
      "currentStatus": "Long Rest",
      "breakType": "Weekly Rest",
      "breakStart": "06:00",
      "breakDuration": 720,
      "remainingBreakTime": 480,
      "dailyBreaksTaken": 0,
      "requiredBreaks": 0,
      "nextBreakDue": null,
      "weeklyRestHours": 48,
      "requiredWeeklyRest": 45,
      "lastLongRest": "2024-12-16 06:00",
      "consecutiveDays": 0
    },
    {
      "id": "D004",
      "name": "Emily Davis",
      "currentStatus": "Working",
      "breakType": null,
      "breakStart": null,
      "breakDuration": 0,
      "remainingBreakTime": 0,
      "dailyBreaksTaken": 3,
      "requiredBreaks": 3,
      "nextBreakDue": null,
      "weeklyRestHours": 28,
      "requiredWeeklyRest": 45,
      "lastLongRest": "2024-12-13 20:00",
      "consecutiveDays": 6
    }
  ];

  List<Map<String, dynamic>> breakHistory = [
    {
      "id": "B001",
      "driverId": "D001",
      "driverName": "John Williams",
      "date": "2024-12-16",
      "type": "Mandatory Break",
      "startTime": "10:00",
      "endTime": "10:15",
      "duration": 15,
      "status": "Completed",
      "location": "Rest Area A"
    },
    {
      "id": "B002",
      "driverId": "D001",
      "driverName": "John Williams",
      "date": "2024-12-16",
      "type": "Lunch Break",
      "startTime": "12:00",
      "endTime": "12:30",
      "duration": 30,
      "status": "Completed",
      "location": "Rest Area B"
    },
    {
      "id": "B003",
      "driverId": "D002",
      "driverName": "Sarah Johnson",
      "date": "2024-12-16",
      "type": "Mandatory Break",
      "startTime": "11:30",
      "endTime": "11:45",
      "duration": 15,
      "status": "Completed",
      "location": "Rest Area C"
    },
    {
      "id": "B004",
      "driverId": "D003",
      "driverName": "Mike Chen",
      "date": "2024-12-16",
      "type": "Weekly Rest",
      "startTime": "06:00",
      "endTime": null,
      "duration": 720,
      "status": "In Progress",
      "location": "Home Base"
    }
  ];

  List<Map<String, dynamic>> restViolations = [
    {
      "id": "RV001",
      "driverId": "D004",
      "driverName": "Emily Davis",
      "type": "Weekly Rest Deficit",
      "description": "Weekly rest hours below required minimum",
      "date": "2024-12-16",
      "severity": "High",
      "hoursDeficit": 17,
      "resolved": false
    },
    {
      "id": "RV002",
      "driverId": "D001",
      "driverName": "John Williams",
      "type": "Break Overdue",
      "description": "Mandatory break not taken within required timeframe",
      "date": "2024-12-15",
      "severity": "Medium",
      "hoursOverdue": 2,
      "resolved": true
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rest Periods",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Current", icon: Icon(Icons.bedtime)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Violations", icon: Icon(Icons.warning))
      ],
      tabChildren: [
        _buildCurrentTab(),
        _buildHistoryTab(),
        _buildViolationsTab()
      ],
    );
  }

  Widget _buildCurrentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRestOverview(),
          _buildDriverRestStatus()
        ],
      ),
    );
  }

  Widget _buildRestOverview() {
    int driversOnBreak = drivers.where((d) => d["currentStatus"] != "Working").length;
    int driversOverdue = drivers.where((d) => d["consecutiveDays"] > 6).length;
    double avgWeeklyRest = drivers
      .map((d) => d["weeklyRestHours"] as int)
      .reduce((a, b) => a + b) / drivers.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm]
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.bedtime, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Rest Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor
                )
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("On Break", "$driversOnBreak", successColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Rest Overdue", "$driversOverdue", dangerColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Avg Weekly Rest", "${avgWeeklyRest.toStringAsFixed(0)}h", infoColor)
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40))
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color
            )
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor
            )
          )
        ],
      ),
    );
  }

  Widget _buildDriverRestStatus() {
    return Column(
      spacing: spSm,
      children: drivers.map((driver) {
        Color statusColor = driver["currentStatus"] == "Working" ? primaryColor :
                          driver["currentStatus"] == "On Break" ? warningColor :
                          successColor;
        
        bool needsRest = (driver["consecutiveDays"] as int) > 5 || 
                        (driver["weeklyRestHours"] as int) < (driver["requiredWeeklyRest"] as int);
        
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(width: 4, color: statusColor)
            )
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${driver["currentStatus"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor
                      )
                    ),
                  ),
                  Spacer(),
                  if (needsRest)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning, size: 12, color: dangerColor),
                          SizedBox(width: spXs),
                          Text(
                            "Needs Rest",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: dangerColor
                            )
                          )
                        ],
                      ),
                    )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${driver["name"]}".split(" ").map((n) => n[0]).join(""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                      )
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${driver["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "ID: ${driver["id"]} • ${driver["consecutiveDays"]} consecutive days",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
              if (driver["currentStatus"] != "Working")
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: statusColor),
                      SizedBox(width: spXs),
                      Text(
                        "${driver["breakType"]} - Started: ${driver["breakStart"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor
                        )
                      ),
                      Spacer(),
                      Text(
                        "${driver["remainingBreakTime"]} min left",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor
                        )
                      )
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Daily Breaks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor
                              )
                            ),
                            Text(
                              "${driver["dailyBreaksTaken"]}/${driver["requiredBreaks"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                              )
                            )
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (driver["dailyBreaksTaken"] as int) / (driver["requiredBreaks"] as int).clamp(1, double.infinity),
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            (driver["dailyBreaksTaken"] as int) >= (driver["requiredBreaks"] as int) ? successColor : warningColor
                          ),
                          minHeight: 4,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weekly Rest",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor
                              )
                            ),
                            Text(
                              "${driver["weeklyRestHours"]}/${driver["requiredWeeklyRest"]}h",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                              )
                            )
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (driver["weeklyRestHours"] as int) / (driver["requiredWeeklyRest"] as int),
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            (driver["weeklyRestHours"] as int) >= (driver["requiredWeeklyRest"] as int) ? successColor : dangerColor
                          ),
                          minHeight: 4,
                        )
                      ],
                    ),
                  )
                ],
              ),
              if (driver["nextBreakDue"] != null)
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Next break due: ${driver["nextBreakDue"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor
                      )
                    ),
                    Spacer(),
                    Text(
                      "Last long rest: ${driver["lastLongRest"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor
                      )
                    )
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: driver["currentStatus"] == "Working" ? "Start Break" : "End Break",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "View Schedule",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryFilters(),
          _buildBreakHistory()
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm]
      ),
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search break history...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QDropdownField(
            label: "",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget _buildBreakHistory() {
    return Column(
      spacing: spSm,
      children: breakHistory.map((breakRecord) {
        Color statusColor = breakRecord["status"] == "Completed" ? successColor : primaryColor;
        Color typeColor = breakRecord["type"] == "Weekly Rest" ? infoColor :
                         breakRecord["type"] == "Lunch Break" ? warningColor :
                         primaryColor;
        
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm]
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${breakRecord["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: typeColor
                      )
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${breakRecord["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor
                      )
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${breakRecord["driverName"]}".split(" ").map((n) => n[0]).join(""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 12
                      )
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${breakRecord["driverName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "ID: ${breakRecord["driverId"]} • ${breakRecord["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 120,
                children: [
                  _buildHistoryMetric("Start Time", "${breakRecord["startTime"]}"),
                  _buildHistoryMetric("End Time", breakRecord["endTime"] ?? "In Progress"),
                  _buildHistoryMetric("Duration", "${breakRecord["duration"]} min"),
                  _buildHistoryMetric("Location", "${breakRecord["location"]}")
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryMetric(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm)
      ),
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor
            )
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor
            )
          )
        ],
      ),
    );
  }

  Widget _buildViolationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildViolationStats(),
          _buildViolationsList()
        ],
      ),
    );
  }

  Widget _buildViolationStats() {
    int totalViolations = restViolations.length;
    int resolvedViolations = restViolations.where((v) => v["resolved"] == true).length;
    int pendingViolations = totalViolations - resolvedViolations;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm]
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: warningColor),
              SizedBox(width: spSm),
              Text(
                "Rest Violations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor
                )
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildViolationCard("Total", "$totalViolations", dangerColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildViolationCard("Pending", "$pendingViolations", warningColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildViolationCard("Resolved", "$resolvedViolations", successColor)
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildViolationCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40))
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color
            )
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor
            )
          )
        ],
      ),
    );
  }

  Widget _buildViolationsList() {
    return Column(
      spacing: spSm,
      children: restViolations.map((violation) {
        Color severityColor = violation["severity"] == "High" ? dangerColor :
                            violation["severity"] == "Medium" ? warningColor :
                            infoColor;
        
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(width: 4, color: severityColor)
            )
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: severityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${violation["severity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: severityColor
                      )
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: (violation["resolved"] == true ? successColor : warningColor).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      violation["resolved"] == true ? "Resolved" : "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: violation["resolved"] == true ? successColor : warningColor
                      )
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${violation["driverName"]}".split(" ").map((n) => n[0]).join(""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 12
                      )
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${violation["driverName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "ID: ${violation["driverId"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${violation["type"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: severityColor
                    )
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${violation["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Date: ${violation["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor
                        )
                      ),
                      Spacer(),
                      if (violation["hoursDeficit"] != null)
                        Text(
                          "Deficit: ${violation["hoursDeficit"]}h",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor
                          )
                        ),
                      if (violation["hoursOverdue"] != null)
                        Text(
                          "Overdue: ${violation["hoursOverdue"]}h",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor
                          )
                        )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: violation["resolved"] == true ? "View Details" : "Resolve",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Generate Report",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
