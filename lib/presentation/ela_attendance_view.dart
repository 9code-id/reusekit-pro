import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAttendanceView extends StatefulWidget {
  const ElaAttendanceView({super.key});

  @override
  State<ElaAttendanceView> createState() => _ElaAttendanceViewState();
}

class _ElaAttendanceViewState extends State<ElaAttendanceView> {
  String selectedClass = "Advanced Calculus";
  DateTime selectedDate = DateTime.now();
  String attendanceStatus = "In Progress";
  
  List<Map<String, dynamic>> classOptions = [
    {"label": "Advanced Calculus", "value": "Advanced Calculus"},
    {"label": "Quantum Physics", "value": "Quantum Physics"},
    {"label": "Organic Chemistry", "value": "Organic Chemistry"},
    {"label": "Cell Biology", "value": "Cell Biology"},
    {"label": "Linear Algebra", "value": "Linear Algebra"},
  ];

  List<Map<String, dynamic>> attendanceRecords = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@student.edu",
      "studentId": "STU001",
      "status": "Present",
      "joinTime": DateTime.now().subtract(Duration(minutes: 45)),
      "leaveTime": null,
      "duration": 45,
      "lateMinutes": 0,
      "avatarUrl": "https://picsum.photos/100/100?random=1",
      "participationScore": 95,
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "email": "bob@student.edu",
      "studentId": "STU002",
      "status": "Present",
      "joinTime": DateTime.now().subtract(Duration(minutes: 40)),
      "leaveTime": null,
      "duration": 40,
      "lateMinutes": 5,
      "avatarUrl": "https://picsum.photos/100/100?random=2",
      "participationScore": 88,
    },
    {
      "id": 3,
      "name": "Carol Davis",
      "email": "carol@student.edu",
      "studentId": "STU003",
      "status": "Absent",
      "joinTime": null,
      "leaveTime": null,
      "duration": 0,
      "lateMinutes": 0,
      "avatarUrl": "https://picsum.photos/100/100?random=3",
      "participationScore": 0,
    },
    {
      "id": 4,
      "name": "David Wilson",
      "email": "david@student.edu",
      "studentId": "STU004",
      "status": "Left Early",
      "joinTime": DateTime.now().subtract(Duration(minutes: 30)),
      "leaveTime": DateTime.now().subtract(Duration(minutes: 10)),
      "duration": 20,
      "lateMinutes": 0,
      "avatarUrl": "https://picsum.photos/100/100?random=4",
      "participationScore": 65,
    },
    {
      "id": 5,
      "name": "Emma Brown",
      "email": "emma@student.edu",
      "studentId": "STU005",
      "status": "Late",
      "joinTime": DateTime.now().subtract(Duration(minutes: 25)),
      "leaveTime": null,
      "duration": 25,
      "lateMinutes": 20,
      "avatarUrl": "https://picsum.photos/100/100?random=5",
      "participationScore": 72,
    },
    {
      "id": 6,
      "name": "Frank Miller",
      "email": "frank@student.edu",
      "studentId": "STU006",
      "status": "Present",
      "joinTime": DateTime.now().subtract(Duration(minutes: 43)),
      "leaveTime": null,
      "duration": 43,
      "lateMinutes": 2,
      "avatarUrl": "https://picsum.photos/100/100?random=6",
      "participationScore": 91,
    },
  ];

  Map<String, int> attendanceStats = {
    "total": 6,
    "present": 3,
    "absent": 1,
    "late": 1,
    "leftEarly": 1,
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present":
        return successColor;
      case "Absent":
        return dangerColor;
      case "Late":
        return warningColor;
      case "Left Early":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildAttendanceOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Attendance Overview",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(attendanceStatus).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  attendanceStatus,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(attendanceStatus),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Students", "${attendanceStats["total"]}", Icons.people, primaryColor),
              _buildStatCard("Present", "${attendanceStats["present"]}", Icons.check_circle, successColor),
              _buildStatCard("Absent", "${attendanceStats["absent"]}", Icons.cancel, dangerColor),
              _buildStatCard("Late", "${attendanceStats["late"]}", Icons.schedule, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(76)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Class",
                  items: classOptions,
                  value: selectedClass,
                  onChanged: (value, label) {
                    selectedClass = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Date",
                  value: selectedDate,
                  onChanged: (value) {
                    selectedDate = value;
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

  Widget _buildAttendanceList() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Text(
                "Student Attendance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  ss("Attendance report exported");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {
                  ss("Attendance report printed");
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...attendanceRecords.map((record) => _buildAttendanceCard(record)),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(Map<String, dynamic> record) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${record["status"]}"),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${record["avatarUrl"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${record["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ID: ${record["studentId"]} • ${record["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${record["status"]}").withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${record["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          if ("${record["status"]}" != "Absent") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.login,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: 4),
                Text(
                  "Join: ${record["joinTime"] != null ? (record["joinTime"] as DateTime).kkmm : 'N/A'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                if (record["leaveTime"] != null) ...[
                  Icon(
                    Icons.logout,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Leave: ${(record["leaveTime"] as DateTime).kkmm}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                Spacer(),
                Text(
                  "Duration: ${record["duration"]}min",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                if ((record["lateMinutes"] as int) > 0) ...[
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${record["lateMinutes"]}min late",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Icon(
                  Icons.star,
                  size: 16,
                  color: warningColor,
                ),
                SizedBox(width: 4),
                Text(
                  "Participation: ${record["participationScore"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () {
                    _showAttendanceDetails(record);
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard(
                "Mark All Present",
                Icons.check_circle,
                successColor,
                () => ss("All students marked as present"),
              ),
              _buildActionCard(
                "Take Attendance",
                Icons.how_to_reg,
                primaryColor,
                () => ss("Attendance taking started"),
              ),
              _buildActionCard(
                "Send Reminders",
                Icons.notifications,
                warningColor,
                () => ss("Attendance reminders sent"),
              ),
              _buildActionCard(
                "Generate Report",
                Icons.assessment,
                infoColor,
                () => ss("Attendance report generated"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(76)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAttendanceDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${record["name"]} - Attendance Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Student ID: ${record["studentId"]}"),
            Text("Email: ${record["email"]}"),
            Text("Status: ${record["status"]}"),
            if (record["joinTime"] != null)
              Text("Join Time: ${(record["joinTime"] as DateTime).dMMMykkmm}"),
            if (record["leaveTime"] != null)
              Text("Leave Time: ${(record["leaveTime"] as DateTime).dMMMykkmm}"),
            Text("Duration: ${record["duration"]} minutes"),
            if ((record["lateMinutes"] as int) > 0)
              Text("Late by: ${record["lateMinutes"]} minutes"),
            Text("Participation Score: ${record["participationScore"]}%"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              back();
              _markAttendance(record);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _markAttendance(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Attendance"),
        content: Text("Change attendance status for ${record["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Attendance updated for ${record["name"]}");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Attendance"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              ss("QR attendance scanner opened");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAttendanceOverview(),
            SizedBox(height: spMd),
            _buildAttendanceFilters(),
            SizedBox(height: spMd),
            _buildQuickActions(),
            SizedBox(height: spMd),
            _buildAttendanceList(),
          ],
        ),
      ),
    );
  }
}
