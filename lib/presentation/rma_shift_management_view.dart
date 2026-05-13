import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaShiftManagementView extends StatefulWidget {
  const RmaShiftManagementView({super.key});

  @override
  State<RmaShiftManagementView> createState() => _RmaShiftManagementViewState();
}

class _RmaShiftManagementViewState extends State<RmaShiftManagementView> {
  String selectedFilter = "All";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showOnlyUncovered = false;

  // Mock shift data
  List<Map<String, dynamic>> shiftsData = [
    {
      "id": "SH001",
      "name": "Morning Kitchen",
      "department": "Kitchen",
      "type": "Regular",
      "startTime": "06:00",
      "endTime": "14:00",
      "duration": 8,
      "requiredStaff": 4,
      "assignedStaff": 4,
      "status": "Fully Staffed",
      "positions": [
        {"role": "Head Chef", "required": 1, "assigned": 1, "staff": ["Sarah Johnson"]},
        {"role": "Sous Chef", "required": 1, "assigned": 1, "staff": ["Emma Wilson"]},
        {"role": "Line Cook", "required": 2, "assigned": 2, "staff": ["David Brown", "Lisa Garcia"]},
      ],
      "date": "2024-12-18",
      "hourlyBudget": 112.50,
      "actualCost": 112.50,
      "priority": "High",
      "notes": "Peak breakfast service period",
    },
    {
      "id": "SH002", 
      "name": "Evening Service",
      "department": "Service",
      "type": "Regular",
      "startTime": "14:00",
      "endTime": "22:00",
      "duration": 8,
      "requiredStaff": 6,
      "assignedStaff": 5,
      "status": "Understaffed",
      "positions": [
        {"role": "Floor Manager", "required": 1, "assigned": 1, "staff": ["Alex Thompson"]},
        {"role": "Server", "required": 4, "assigned": 3, "staff": ["Mike Chen", "Rachel Kim", "Tom Wilson"]},
        {"role": "Host", "required": 1, "assigned": 1, "staff": ["Jenny Martinez"]},
      ],
      "date": "2024-12-18",
      "hourlyBudget": 144.00,
      "actualCost": 120.00,
      "priority": "High",
      "notes": "Dinner rush - need additional server",
    },
    {
      "id": "SH003",
      "name": "Night Cleaning",
      "department": "Cleaning",
      "type": "Regular",
      "startTime": "22:00",
      "endTime": "06:00",
      "duration": 8,
      "requiredStaff": 2,
      "assignedStaff": 2,
      "status": "Fully Staffed",
      "positions": [
        {"role": "Cleaner", "required": 2, "assigned": 2, "staff": ["Carlos Lopez", "Maria Santos"]},
      ],
      "date": "2024-12-18",
      "hourlyBudget": 96.00,
      "actualCost": 96.00,
      "priority": "Medium",
      "notes": "Deep cleaning and prep for next day",
    },
    {
      "id": "SH004",
      "name": "Weekend Brunch",
      "department": "Kitchen",
      "type": "Special",
      "startTime": "09:00",
      "endTime": "15:00",
      "duration": 6,
      "requiredStaff": 5,
      "assignedStaff": 3,
      "status": "Critical",
      "positions": [
        {"role": "Brunch Chef", "required": 1, "assigned": 0, "staff": []},
        {"role": "Prep Cook", "required": 2, "assigned": 1, "staff": ["James Wilson"]},
        {"role": "Line Cook", "required": 2, "assigned": 2, "staff": ["Sarah Miller", "Kevin Davis"]},
      ],
      "date": "2024-12-21",
      "hourlyBudget": 165.00,
      "actualCost": 108.00,
      "priority": "Critical",
      "notes": "Special weekend brunch service - urgently needs brunch chef",
    },
    {
      "id": "SH005",
      "name": "Management Office",
      "department": "Management",
      "type": "Regular",
      "startTime": "08:00",
      "endTime": "16:00",
      "duration": 8,
      "requiredStaff": 2,
      "assignedStaff": 2,
      "status": "Fully Staffed",
      "positions": [
        {"role": "General Manager", "required": 1, "assigned": 1, "staff": ["Robert Anderson"]},
        {"role": "Assistant Manager", "required": 1, "assigned": 1, "staff": ["Susan Taylor"]},
      ],
      "date": "2024-12-18",
      "hourlyBudget": 200.00,
      "actualCost": 200.00,
      "priority": "Medium",
      "notes": "Administrative duties and coordination",
    },
  ];

  List<String> departments = ["All", "Kitchen", "Service", "Cleaning", "Management"];
  List<String> statuses = ["All", "Fully Staffed", "Understaffed", "Critical", "Overstaffed"];
  List<String> filters = ["All", "Today", "Tomorrow", "This Week", "Special Shifts"];

  List<Map<String, dynamic>> get filteredShifts {
    return shiftsData.where((shift) {
      bool matchesDepartment = selectedDepartment == "All" || 
          (shift["department"] as String) == selectedDepartment;
      
      bool matchesStatus = selectedStatus == "All" || 
          (shift["status"] as String) == selectedStatus;
      
      bool matchesSearch = searchQuery.isEmpty || 
          (shift["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesUncovered = !showOnlyUncovered || 
          (shift["assignedStaff"] as int) < (shift["requiredStaff"] as int);

      return matchesDepartment && matchesStatus && matchesSearch && matchesUncovered;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Fully Staffed":
        return successColor;
      case "Understaffed":
        return warningColor;
      case "Critical":
        return dangerColor;
      case "Overstaffed":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getShiftTypeIcon(String type) {
    switch (type) {
      case "Regular":
        return "🕐";
      case "Special":
        return "⭐";
      case "Overtime":
        return "⏰";
      case "Emergency":
        return "🚨";
      default:
        return "📅";
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalShifts = shiftsData.length;
    final fullyStaffed = shiftsData.where((s) => (s["status"] as String) == "Fully Staffed").length;
    final understaffed = shiftsData.where((s) => (s["status"] as String) == "Understaffed").length;
    final critical = shiftsData.where((s) => (s["status"] as String) == "Critical").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create shift
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show menu options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overview Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Today's Shift Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$totalShifts",
                                style: TextStyle(
                                  fontSize: 24,
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Staffed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$fullyStaffed",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Under",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$understaffed",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
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
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Critical",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$critical",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
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
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Shifts",
                    value: searchQuery,
                    hint: "Enter shift name...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departments.map((dept) => {
                            "label": dept,
                            "value": dept,
                          }).toList(),
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statuses.map((status) => {
                            "label": status,
                            "value": status,
                          }).toList(),
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Uncovered Shifts Only",
                              "value": true,
                              "checked": showOnlyUncovered,
                            }
                          ],
                          value: [
                            if (showOnlyUncovered)
                              {
                                "label": "Uncovered Shifts Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              showOnlyUncovered = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Shifts List
            ...filteredShifts.map((shift) {
              final positions = shift["positions"] as List;
              final coveragePercentage = ((shift["assignedStaff"] as int) / (shift["requiredStaff"] as int) * 100).round();

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: (shift["status"] as String) == "Critical"
                      ? Border.all(color: dangerColor, width: 2)
                      : null,
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Shift Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getStatusColor(shift["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getShiftTypeIcon(shift["type"] as String),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${shift["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(shift["priority"] as String),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${shift["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${shift["department"]} • ${shift["startTime"]} - ${shift["endTime"]} (${shift["duration"]}h)",
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

                    // Staffing Progress
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Staffing: ${shift["assignedStaff"]}/${shift["requiredStaff"]} ($coveragePercentage%)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(shift["status"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${shift["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: coveragePercentage / 100,
                          backgroundColor: disabledColor.withAlpha(30),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getStatusColor(shift["status"] as String),
                          ),
                        ),
                      ],
                    ),

                    // Position Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: positions.map<Widget>((position) {
                          final positionMap = position as Map<String, dynamic>;
                          final staffList = positionMap["staff"] as List;
                          final isFilled = (positionMap["assigned"] as int) >= (positionMap["required"] as int);
                          
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${positionMap["role"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${positionMap["assigned"]}/${positionMap["required"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isFilled ? successColor : dangerColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(
                                isFilled ? Icons.check_circle : Icons.warning,
                                size: 16,
                                color: isFilled ? successColor : dangerColor,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

                    // Cost Information
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
                                  "Budget",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(shift["hourlyBudget"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Actual",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(shift["actualCost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
                              color: (shift["actualCost"] as double) <= (shift["hourlyBudget"] as double)
                                  ? successColor.withAlpha(10)
                                  : dangerColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Variance",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${((shift["actualCost"] as double) - (shift["hourlyBudget"] as double)) >= 0 ? '+' : ''}\$${(((shift["actualCost"] as double) - (shift["hourlyBudget"] as double)).abs()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: (shift["actualCost"] as double) <= (shift["hourlyBudget"] as double)
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Notes
                    if ((shift["notes"] as String).isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "📝 ${shift["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to shift details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Assign Staff",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to staff assignment
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new shift
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
