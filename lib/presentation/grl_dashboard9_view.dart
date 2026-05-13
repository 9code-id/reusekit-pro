import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard9View extends StatefulWidget {
  @override
  State<GrlDashboard9View> createState() => _GrlDashboard9ViewState();
}

class _GrlDashboard9ViewState extends State<GrlDashboard9View> {
  bool loading = false;
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> healthMetrics = [
    {"metric": "Total Patients", "value": 2847, "change": 15.3, "icon": Icons.people},
    {"metric": "Appointments Today", "value": 42, "change": 8.7, "icon": Icons.calendar_today},
    {"metric": "Bed Occupancy", "value": 78.5, "change": -5.2, "icon": Icons.bed, "unit": "%"},
    {"metric": "Staff On Duty", "value": 156, "change": 3.1, "icon": Icons.medical_services},
  ];

  List<Map<String, dynamic>> patientData = [
    {"name": "John Smith", "age": 45, "condition": "Hypertension", "room": "A-201", "doctor": "Dr. Johnson", "status": "Stable", "admitted": "2024-01-10", "avatar": "https://picsum.photos/50/50?random=1&keyword=man"},
    {"name": "Sarah Davis", "age": 32, "condition": "Diabetes", "room": "B-105", "doctor": "Dr. Williams", "status": "Critical", "admitted": "2024-01-12", "avatar": "https://picsum.photos/50/50?random=2&keyword=woman"},
    {"name": "Michael Brown", "age": 58, "condition": "Heart Disease", "room": "C-304", "doctor": "Dr. Anderson", "status": "Stable", "admitted": "2024-01-08", "avatar": "https://picsum.photos/50/50?random=3&keyword=man"},
    {"name": "Lisa Wilson", "age": 28, "condition": "Pregnancy", "room": "D-202", "doctor": "Dr. Thompson", "status": "Good", "admitted": "2024-01-14", "avatar": "https://picsum.photos/50/50?random=4&keyword=woman"},
    {"name": "Robert Garcia", "age": 67, "condition": "Pneumonia", "room": "A-105", "doctor": "Dr. Martinez", "status": "Recovering", "admitted": "2024-01-11", "avatar": "https://picsum.photos/50/50?random=5&keyword=man"},
  ];

  List<Map<String, dynamic>> appointmentData = [
    {"time": "09:00", "patient": "Emma Taylor", "doctor": "Dr. Johnson", "type": "Consultation", "status": "Scheduled", "duration": 30},
    {"time": "09:30", "patient": "James Wilson", "doctor": "Dr. Williams", "type": "Check-up", "status": "In Progress", "duration": 45},
    {"time": "10:15", "patient": "Maria Rodriguez", "doctor": "Dr. Anderson", "type": "Surgery", "status": "Scheduled", "duration": 120},
    {"time": "11:00", "patient": "David Lee", "doctor": "Dr. Thompson", "type": "Consultation", "status": "Completed", "duration": 30},
    {"time": "11:30", "patient": "Jennifer Brown", "doctor": "Dr. Martinez", "type": "Follow-up", "status": "Scheduled", "duration": 20},
  ];

  List<Map<String, dynamic>> departmentStats = [
    {"department": "Emergency", "patients": 156, "capacity": 200, "staff": 24, "utilization": 78.0},
    {"department": "ICU", "patients": 28, "capacity": 32, "staff": 18, "utilization": 87.5},
    {"department": "Surgery", "patients": 45, "capacity": 60, "staff": 32, "utilization": 75.0},
    {"department": "Maternity", "patients": 22, "capacity": 30, "staff": 15, "utilization": 73.3},
    {"department": "Pediatrics", "patients": 38, "capacity": 50, "staff": 20, "utilization": 76.0},
  ];

  List<Map<String, dynamic>> medicalInventory = [
    {"item": "Surgical Masks", "current": 2500, "minimum": 1000, "unit": "pieces", "status": "Good"},
    {"item": "Ventilators", "current": 8, "minimum": 12, "unit": "units", "status": "Low"},
    {"item": "Blood Bags (O+)", "current": 45, "minimum": 50, "unit": "bags", "status": "Low"},
    {"item": "Antibiotics", "current": 850, "minimum": 500, "unit": "vials", "status": "Good"},
    {"item": "PPE Suits", "current": 120, "minimum": 200, "unit": "suits", "status": "Critical"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Inpatients", "value": "Inpatients"},
    {"label": "Outpatients", "value": "Outpatients"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "ICU", "value": "ICU"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Dashboard"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.emergency,
              size: bs.sm,
              onPressed: () {
                sw("Emergency protocol activated");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            Row(
              children: [
                Text(
                  "Category:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Health Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                String displayValue;
                if (metric.containsKey("unit")) {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(1)}${metric["unit"]}";
                } else {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(0)}";
                }
                
                return _buildMetricCard(
                  metric["metric"],
                  displayValue,
                  metric["icon"],
                  primaryColor,
                  "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                );
              }).toList(),
            ),

            // Patient Overview
            Container(
              padding: EdgeInsets.all(spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Patients",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening patient management system");
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
                  Column(
                    spacing: spSm,
                    children: patientData.map((patient) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getPatientStatusColor(patient["status"]),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${patient["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
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
                                        "${patient["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${patient["age"]})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getPatientStatusColor(patient["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${patient["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPatientStatusColor(patient["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${patient["condition"]} • Room ${patient["room"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${patient["doctor"]} • Admitted: ${patient["admitted"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.medical_information,
                              size: bs.sm,
                              onPressed: () {
                                si("Opening medical record for ${patient["name"]}");
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Today's Appointments
            Container(
              padding: EdgeInsets.all(spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Appointments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening appointment scheduler");
                        },
                        child: Text(
                          "Schedule",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: appointmentData.map((appointment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Column(
                                children: [
                                  Text(
                                    "${appointment["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${appointment["duration"]}min",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${appointment["patient"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${appointment["doctor"]} • ${appointment["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getAppointmentStatusColor(appointment["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${appointment["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getAppointmentStatusColor(appointment["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Department Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: departmentStats.map((dept) {
                      IconData deptIcon;
                      Color deptColor;
                      
                      switch (dept["department"]) {
                        case "Emergency":
                          deptIcon = Icons.emergency;
                          deptColor = dangerColor;
                          break;
                        case "ICU":
                          deptIcon = Icons.healing;
                          deptColor = warningColor;
                          break;
                        case "Surgery":
                          deptIcon = Icons.medical_services;
                          deptColor = primaryColor;
                          break;
                        case "Maternity":
                          deptIcon = Icons.pregnant_woman;
                          deptColor = successColor;
                          break;
                        case "Pediatrics":
                          deptIcon = Icons.child_care;
                          deptColor = infoColor;
                          break;
                        default:
                          deptIcon = Icons.local_hospital;
                          deptColor = primaryColor;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: deptColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  deptIcon,
                                  color: deptColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${dept["department"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${dept["patients"]}/${dept["capacity"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: deptColor,
                              ),
                            ),
                            Text(
                              "Patients",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (dept["utilization"] as double) / 100,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: deptColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Staff: ${dept["staff"]} • ${(dept["utilization"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Medical Inventory
            Container(
              padding: EdgeInsets.all(spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Medical Inventory",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening inventory management");
                        },
                        child: Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: medicalInventory.map((item) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getInventoryStatusColor(item["status"]),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _getInventoryStatusColor(item["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.inventory,
                                color: _getInventoryStatusColor(item["status"]),
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["item"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Min: ${item["minimum"]} ${item["unit"]}",
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
                                Text(
                                  "${item["current"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getInventoryStatusColor(item["status"]),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getInventoryStatusColor(item["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getInventoryStatusColor(item["status"]),
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
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Patient Admission",
                    icon: Icons.person_add,
                    size: bs.md,
                    onPressed: () {
                      si("Opening patient admission form");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Emergency Alert",
                    icon: Icons.warning,
                    size: bs.md,
                    onPressed: () {
                      sw("Emergency alert system activated");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : 
                        change.startsWith('-') ? (title == "Bed Occupancy" ? successColor.withAlpha(20) : dangerColor.withAlpha(20)) : 
                        warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : 
                          change.startsWith('-') ? (title == "Bed Occupancy" ? successColor : dangerColor) : 
                          warningColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPatientStatusColor(String status) {
    switch (status) {
      case "Stable":
        return successColor;
      case "Good":
        return primaryColor;
      case "Critical":
        return dangerColor;
      case "Recovering":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAppointmentStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getInventoryStatusColor(String status) {
    switch (status) {
      case "Good":
        return successColor;
      case "Low":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
