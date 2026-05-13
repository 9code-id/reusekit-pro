import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmComplianceTrackingView extends StatefulWidget {
  const EcmComplianceTrackingView({super.key});

  @override
  State<EcmComplianceTrackingView> createState() => _EcmComplianceTrackingViewState();
}

class _EcmComplianceTrackingViewState extends State<EcmComplianceTrackingView> {
  String selectedTimeframe = "This Year";
  String selectedDepartment = "All Departments";
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
  ];
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Emergency Medicine", "value": "Emergency Medicine"},
    {"label": "Surgery", "value": "Surgery"},
    {"label": "Nursing", "value": "Nursing"},
    {"label": "Pediatrics", "value": "Pediatrics"},
    {"label": "Cardiology", "value": "Cardiology"},
  ];

  List<Map<String, dynamic>> complianceData = [
    {
      "department": "Emergency Medicine",
      "totalStaff": 45,
      "compliantStaff": 42,
      "complianceRate": 93.3,
      "requiredHours": 40,
      "completedHours": 1680,
      "pendingCerts": 3,
      "expiringSoon": 5,
      "color": successColor,
    },
    {
      "department": "Surgery",
      "totalStaff": 32,
      "compliantStaff": 28,
      "complianceRate": 87.5,
      "requiredHours": 40,
      "completedHours": 1120,
      "pendingCerts": 4,
      "expiringSoon": 2,
      "color": warningColor,
    },
    {
      "department": "Nursing", 
      "totalStaff": 78,
      "compliantStaff": 75,
      "complianceRate": 96.2,
      "requiredHours": 30,
      "completedHours": 2250,
      "pendingCerts": 2,
      "expiringSoon": 8,
      "color": successColor,
    },
    {
      "department": "Pediatrics",
      "totalStaff": 25,
      "compliantStaff": 20,
      "complianceRate": 80.0,
      "requiredHours": 35,
      "completedHours": 700,
      "pendingCerts": 5,
      "expiringSoon": 3,
      "color": dangerColor,
    },
    {
      "department": "Cardiology",
      "totalStaff": 18,
      "compliantStaff": 17,
      "complianceRate": 94.4,
      "requiredHours": 45,
      "completedHours": 765,
      "pendingCerts": 1,
      "expiringSoon": 2,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "compliance_achieved",
      "department": "Nursing",
      "staff": "Sarah Johnson, RN",
      "description": "Completed BLS certification renewal",
      "timestamp": "2024-06-18T14:30:00",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "type": "certification_expiring",
      "department": "Surgery",
      "staff": "Dr. Michael Chen",
      "description": "ACLS certification expires in 15 days",
      "timestamp": "2024-06-18T12:15:00",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "type": "non_compliance",
      "department": "Pediatrics",
      "staff": "Lisa Rodriguez, RN",
      "description": "Failed to complete required CE hours",
      "timestamp": "2024-06-18T09:45:00",
      "icon": Icons.error,
      "color": dangerColor,
    },
    {
      "type": "compliance_achieved",
      "department": "Emergency Medicine",
      "staff": "James Wilson, MD",
      "description": "Completed Advanced Trauma Life Support",
      "timestamp": "2024-06-17T16:20:00",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "type": "reminder_sent",
      "department": "Cardiology",
      "staff": "Dr. Amanda Foster",
      "description": "Reminder sent for upcoming certification deadline",
      "timestamp": "2024-06-17T11:30:00",
      "icon": Icons.notifications,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> get filteredComplianceData {
    if (selectedDepartment == "All Departments") {
      return complianceData;
    }
    return complianceData.where((dept) => dept["department"] == selectedDepartment).toList();
  }

  Color _getComplianceColor(double rate) {
    if (rate >= 95) return successColor;
    if (rate >= 85) return warningColor;
    return dangerColor;
  }

  Widget _buildComplianceCard(Map<String, dynamic> department) {
    double complianceRate = department["complianceRate"] as double;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getComplianceColor(complianceRate),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Department Header
          Row(
            children: [
              Expanded(
                child: Text(
                  "${department["department"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getComplianceColor(complianceRate).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${complianceRate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getComplianceColor(complianceRate),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Progress Bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: complianceRate / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: _getComplianceColor(complianceRate),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Staff Statistics
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Compliant Staff",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${department["compliantStaff"]}/${department["totalStaff"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      "CE Hours",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${department["completedHours"]}h",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pending Certs",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${department["pendingCerts"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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
                      "Expiring Soon",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${department["expiringSoon"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to department details
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.assignment,
                size: bs.sm,
                onPressed: () {
                  // Generate report
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    DateTime timestamp = DateTime.parse(activity["timestamp"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (activity["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"] as IconData,
              size: 20,
              color: activity["color"] as Color,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["staff"]} - ${activity["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${timestamp.dMMMy} at ${TimeOfDay.fromDateTime(timestamp).kkmm}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double overallCompliance = filteredComplianceData.isEmpty 
        ? 0.0 
        : filteredComplianceData.map((d) => d["complianceRate"] as double).reduce((a, b) => a + b) / filteredComplianceData.length;
    
    int totalStaff = filteredComplianceData.fold(0, (sum, dept) => sum + (dept["totalStaff"] as int));
    int compliantStaff = filteredComplianceData.fold(0, (sum, dept) => sum + (dept["compliantStaff"] as int));
    int totalPending = filteredComplianceData.fold(0, (sum, dept) => sum + (dept["pendingCerts"] as int));
    int totalExpiring = filteredComplianceData.fold(0, (sum, dept) => sum + (dept["expiringSoon"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Compliance Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Overview Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildOverviewCard(
                  "Overall Compliance", 
                  "${overallCompliance.toStringAsFixed(1)}%", 
                  "$compliantStaff of $totalStaff staff",
                  _getComplianceColor(overallCompliance), 
                  Icons.assignment_turned_in
                ),
                _buildOverviewCard(
                  "Pending Certifications", 
                  "$totalPending", 
                  "Awaiting completion",
                  warningColor, 
                  Icons.pending
                ),
                _buildOverviewCard(
                  "Expiring Soon", 
                  "$totalExpiring", 
                  "Within 30 days",
                  dangerColor, 
                  Icons.schedule
                ),
                _buildOverviewCard(
                  "Total Staff", 
                  "$totalStaff", 
                  "Across all departments",
                  primaryColor, 
                  Icons.people
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Department Compliance
            Text(
              "Department Compliance",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            if (filteredComplianceData.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No data available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredComplianceData.map((department) => _buildComplianceCard(department)),
            
            SizedBox(height: spLg),
            
            // Recent Activities
            Row(
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to all activities
                  },
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            ...recentActivities.take(5).map((activity) => _buildActivityItem(activity)),
          ],
        ),
      ),
    );
  }
}
