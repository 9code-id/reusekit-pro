import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmShiftManagementView extends StatefulWidget {
  const CrmShiftManagementView({super.key});

  @override
  State<CrmShiftManagementView> createState() => _CrmShiftManagementViewState();
}

class _CrmShiftManagementViewState extends State<CrmShiftManagementView> {
  String selectedDepartment = "All Departments";
  String selectedShift = "All Shifts";
  String selectedDate = DateTime.now().toString().split(' ')[0];
  int currentTab = 0;
  
  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Customer Service", "value": "Customer Service"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Billing", "value": "Billing"},
    {"label": "Management", "value": "Management"},
  ];

  List<Map<String, dynamic>> shiftOptions = [
    {"label": "All Shifts", "value": "All Shifts"},
    {"label": "Morning (6AM-2PM)", "value": "Morning"},
    {"label": "Afternoon (2PM-10PM)", "value": "Afternoon"},
    {"label": "Night (10PM-6AM)", "value": "Night"},
  ];

  List<Map<String, dynamic>> shifts = [
    {
      "id": "shift_001",
      "name": "Morning Customer Service",
      "department": "Customer Service",
      "time": "6:00 AM - 2:00 PM",
      "date": "2024-12-30",
      "required_agents": 8,
      "assigned_agents": 7,
      "present_agents": 6,
      "shift_lead": "Sarah Johnson",
      "status": "Understaffed",
      "agents": [
        {"name": "Sarah Johnson", "role": "Shift Lead", "status": "Present", "check_in": "5:55 AM"},
        {"name": "Michael Chen", "role": "Senior Agent", "status": "Present", "check_in": "6:02 AM"},
        {"name": "Emily Davis", "role": "Agent", "status": "Present", "check_in": "6:00 AM"},
        {"name": "David Wilson", "role": "Agent", "status": "Present", "check_in": "6:15 AM"},
        {"name": "Lisa Zhang", "role": "Agent", "status": "Present", "check_in": "6:08 AM"},
        {"name": "Robert Brown", "role": "Agent", "status": "Present", "check_in": "6:12 AM"},
        {"name": "Jennifer Lopez", "role": "Agent", "status": "Absent", "check_in": null},
        {"name": "Alex Thompson", "role": "Agent", "status": "Not Assigned", "check_in": null},
      ],
    },
    {
      "id": "shift_002",
      "name": "Afternoon Technical Support",
      "department": "Technical Support",
      "time": "2:00 PM - 10:00 PM",
      "date": "2024-12-30",
      "required_agents": 6,
      "assigned_agents": 6,
      "present_agents": 5,
      "shift_lead": "Chris Anderson",
      "status": "Nearly Full",
      "agents": [
        {"name": "Chris Anderson", "role": "Shift Lead", "status": "Present", "check_in": "1:55 PM"},
        {"name": "Nicole White", "role": "Senior Agent", "status": "Present", "check_in": "2:00 PM"},
        {"name": "Kevin Lee", "role": "Agent", "status": "Present", "check_in": "2:05 PM"},
        {"name": "Amanda Taylor", "role": "Agent", "status": "Present", "check_in": "2:10 PM"},
        {"name": "Jason Moore", "role": "Agent", "status": "Present", "check_in": "2:03 PM"},
        {"name": "Rachel Green", "role": "Agent", "status": "Late", "check_in": null},
      ],
    },
    {
      "id": "shift_003",
      "name": "Night Sales Team",
      "department": "Sales",
      "time": "10:00 PM - 6:00 AM",
      "date": "2024-12-30",
      "required_agents": 4,
      "assigned_agents": 4,
      "present_agents": 4,
      "shift_lead": "Tom Wilson",
      "status": "Fully Staffed",
      "agents": [
        {"name": "Tom Wilson", "role": "Shift Lead", "status": "Present", "check_in": "9:58 PM"},
        {"name": "Linda Johnson", "role": "Senior Agent", "status": "Present", "check_in": "10:00 PM"},
        {"name": "Mark Davis", "role": "Agent", "status": "Present", "check_in": "10:05 PM"},
        {"name": "Karen Smith", "role": "Agent", "status": "Present", "check_in": "9:55 PM"},
      ],
    },
    {
      "id": "shift_004",
      "name": "Morning Sales Team",
      "department": "Sales",
      "time": "6:00 AM - 2:00 PM",
      "date": "2024-12-30",
      "required_agents": 5,
      "assigned_agents": 5,
      "present_agents": 4,
      "shift_lead": "Maria Garcia",
      "status": "Nearly Full",
      "agents": [
        {"name": "Maria Garcia", "role": "Shift Lead", "status": "Present", "check_in": "5:50 AM"},
        {"name": "Daniel Martinez", "role": "Senior Agent", "status": "Present", "check_in": "6:00 AM"},
        {"name": "Jessica Brown", "role": "Agent", "status": "Present", "check_in": "6:05 AM"},
        {"name": "Ryan Taylor", "role": "Agent", "status": "Present", "check_in": "6:10 AM"},
        {"name": "Stephanie Wilson", "role": "Agent", "status": "Sick Leave", "check_in": null},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredShifts {
    return shifts.where((shift) {
      bool matchesDepartment = selectedDepartment == "All Departments" || 
                             shift["department"] == selectedDepartment;
      bool matchesShift = selectedShift == "All Shifts" || 
                        shift["time"].toString().contains(_getShiftTimeRange(selectedShift));
      bool matchesDate = shift["date"] == selectedDate;
      
      return matchesDepartment && matchesShift && matchesDate;
    }).toList();
  }

  String _getShiftTimeRange(String shiftType) {
    switch (shiftType) {
      case "Morning":
        return "6:00 AM";
      case "Afternoon":
        return "2:00 PM";
      case "Night":
        return "10:00 PM";
      default:
        return "";
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Fully Staffed":
        return successColor;
      case "Nearly Full":
        return warningColor;
      case "Understaffed":
        return dangerColor;
      case "Present":
        return successColor;
      case "Late":
        return warningColor;
      case "Absent":
      case "Sick Leave":
        return dangerColor;
      case "Not Assigned":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> shift) {
    List<Map<String, dynamic>> agents = List<Map<String, dynamic>>.from(shift["agents"]);
    int presentCount = agents.where((agent) => agent["status"] == "Present").length;
    int requiredCount = shift["required_agents"] as int;
    double attendance = presentCount / requiredCount;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                      "${shift["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${shift["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${shift["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${shift["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor("${shift["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "$presentCount / $requiredCount",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor("${shift["status"]}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shift Lead",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${shift["shift_lead"]}",
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
                SizedBox(height: spSm),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: attendance,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getStatusColor("${shift["status"]}"),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(attendance * 100).toStringAsFixed(0)}% attendance",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Team Members",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...agents.map((agent) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getStatusColor("${agent["status"]}"),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${agent["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${agent["role"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${agent["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${agent["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor("${agent["status"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (agent["check_in"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          "${agent["check_in"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )),
          SizedBox(height: spSm),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Manage Shift",
                  size: bs.sm,
                  onPressed: () {
                    ss("Managing shift: ${shift["name"]}");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    ss("Viewing shift details");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalShifts = filteredShifts.length;
    int totalRequired = filteredShifts.fold(0, (sum, shift) => sum + (shift["required_agents"] as int));
    int totalPresent = filteredShifts.fold(0, (sum, shift) => sum + (shift["present_agents"] as int));
    int fullyStaffed = filteredShifts.where((shift) => shift["status"] == "Fully Staffed").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Creating new shift");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Date Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: QDatePicker(
                label: "Select Date",
                value: DateTime.parse(selectedDate),
                onChanged: (value) {
                  selectedDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Total Shifts",
                  "$totalShifts",
                  "Scheduled today",
                  Icons.schedule,
                  primaryColor,
                ),
                _buildStatCard(
                  "Attendance Rate",
                  totalRequired > 0 ? "${((totalPresent / totalRequired) * 100).toStringAsFixed(0)}%" : "0%",
                  "$totalPresent / $totalRequired agents",
                  Icons.people,
                  successColor,
                ),
                _buildStatCard(
                  "Fully Staffed",
                  "$fullyStaffed",
                  "of $totalShifts shifts",
                  Icons.check_circle,
                  infoColor,
                ),
                _buildStatCard(
                  "Coverage Issues",
                  "${totalShifts - fullyStaffed}",
                  "Need attention",
                  Icons.warning,
                  warningColor,
                ),
              ],
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departments,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Shift Time",
                          items: shiftOptions,
                          value: selectedShift,
                          onChanged: (value, label) {
                            selectedShift = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Shift",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Creating new shift schedule");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Attendance",
                          icon: Icons.how_to_reg,
                          size: bs.sm,
                          onPressed: () {
                            ss("Managing attendance");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Time Reports",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            ss("Generating time reports");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Schedule Template",
                          icon: Icons.event_note,
                          size: bs.sm,
                          onPressed: () {
                            ss("Managing schedule templates");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Shifts List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Today's Shifts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredShifts.length} shifts",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...filteredShifts.map((shift) => _buildShiftCard(shift)),
                if (filteredShifts.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 48,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No shifts scheduled",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Create a new shift or adjust your filters",
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
            ),
          ],
        ),
      ),
    );
  }
}
