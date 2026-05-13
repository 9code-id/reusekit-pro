import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosStaffListView extends StatefulWidget {
  const PosStaffListView({super.key});

  @override
  State<PosStaffListView> createState() => _PosStaffListViewState();
}

class _PosStaffListViewState extends State<PosStaffListView> {
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedStatus = "";
  String selectedShift = "";

  List<Map<String, dynamic>> staff = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "phone": "+1 555-0123",
      "position": "Store Manager",
      "department": "Management",
      "employeeId": "EMP001",
      "hireDate": "2023-01-15",
      "status": "Active",
      "shift": "Morning",
      "hourlyRate": 28.00,
      "hoursWorked": 40,
      "avatar": "https://picsum.photos/100/100?random=1",
      "lastClockIn": "2024-06-19T08:00:00",
      "performance": 95,
      "isClocked": true,
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "email": "mike.chen@company.com",
      "phone": "+1 555-0124",
      "position": "Head Chef",
      "department": "Kitchen",
      "employeeId": "EMP002",
      "hireDate": "2023-03-20",
      "status": "Active",
      "shift": "Evening",
      "hourlyRate": 25.00,
      "hoursWorked": 38,
      "avatar": "https://picsum.photos/100/100?random=2",
      "lastClockIn": "2024-06-19T16:00:00",
      "performance": 92,
      "isClocked": true,
    },
    {
      "id": "3",
      "name": "Emma Davis",
      "email": "emma.davis@company.com",
      "phone": "+1 555-0125",
      "position": "Cashier",
      "department": "Sales",
      "employeeId": "EMP003",
      "hireDate": "2023-08-10",
      "status": "Active",
      "shift": "Morning",
      "hourlyRate": 16.50,
      "hoursWorked": 35,
      "avatar": "https://picsum.photos/100/100?random=3",
      "lastClockIn": "2024-06-19T09:00:00",
      "performance": 88,
      "isClocked": false,
    },
    {
      "id": "4",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1 555-0126",
      "position": "Delivery Driver",
      "department": "Delivery",
      "employeeId": "EMP004",
      "hireDate": "2023-11-05",
      "status": "Active",
      "shift": "All Day",
      "hourlyRate": 14.00,
      "hoursWorked": 42,
      "avatar": "https://picsum.photos/100/100?random=4",
      "lastClockIn": "2024-06-19T10:30:00",
      "performance": 90,
      "isClocked": true,
    },
    {
      "id": "5",
      "name": "Lisa Brown",
      "email": "lisa.brown@company.com",
      "phone": "+1 555-0127",
      "position": "Cashier",
      "department": "Sales",
      "employeeId": "EMP005",
      "hireDate": "2024-01-12",
      "status": "On Leave",
      "shift": "Evening",
      "hourlyRate": 15.50,
      "hoursWorked": 0,
      "avatar": "https://picsum.photos/100/100?random=5",
      "lastClockIn": "2024-06-15T14:00:00",
      "performance": 85,
      "isClocked": false,
    },
    {
      "id": "6",
      "name": "Alex Wilson",
      "email": "alex.wilson@company.com",
      "phone": "+1 555-0128",
      "position": "Cook",
      "department": "Kitchen",
      "employeeId": "EMP006",
      "hireDate": "2023-06-18",
      "status": "Active",
      "shift": "Morning",
      "hourlyRate": 18.00,
      "hoursWorked": 40,
      "avatar": "https://picsum.photos/100/100?random=6",
      "lastClockIn": "2024-06-19T07:30:00",
      "performance": 87,
      "isClocked": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff List"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              si("Opening add employee form");
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
            _buildSearchAndFilters(),
            _buildStaffStats(),
            _buildStaffList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search staff...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            QDropdownField(
              label: "Department",
              items: [
                {"label": "All Departments", "value": ""},
                {"label": "Management", "value": "Management"},
                {"label": "Kitchen", "value": "Kitchen"},
                {"label": "Sales", "value": "Sales"},
                {"label": "Delivery", "value": "Delivery"},
              ],
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Status",
              items: [
                {"label": "All Status", "value": ""},
                {"label": "Active", "value": "Active"},
                {"label": "On Leave", "value": "On Leave"},
                {"label": "Inactive", "value": "Inactive"},
              ],
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Shift",
              items: [
                {"label": "All Shifts", "value": ""},
                {"label": "Morning", "value": "Morning"},
                {"label": "Evening", "value": "Evening"},
                {"label": "Night", "value": "Night"},
                {"label": "All Day", "value": "All Day"},
              ],
              value: selectedShift,
              onChanged: (value, label) {
                selectedShift = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStaffStats() {
    int totalStaff = staff.length;
    int activeStaff = staff.where((s) => s["status"] == "Active").length;
    int clockedIn = staff.where((s) => s["isClocked"] == true).length;
    double totalHours = staff.fold(0.0, (sum, s) => sum + (s["hoursWorked"] as int).toDouble());

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.groups,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalStaff",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Staff",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$activeStaff",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Active Staff",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$clockedIn",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Clocked In",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.schedule,
                color: warningColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "${totalHours.toInt()}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Hours",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStaffList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Staff Members",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...staff.map((employee) => _buildStaffCard(employee)),
      ],
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> employee) {
    Color statusColor = employee["status"] == "Active" ? successColor : 
                       employee["status"] == "On Leave" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${employee["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${employee["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (employee["isClocked"]) ...[
                          SizedBox(width: spXs),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${employee["position"]} • ${employee["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${employee["employeeId"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${employee["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${employee["shift"]} Shift",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showEmployeeOptions(employee),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.email,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["email"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 35,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.phone,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["phone"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 35,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(employee["hourlyRate"] as double).toStringAsFixed(2)}/hr",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 35,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["hoursWorked"]}h",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Performance: ${employee["performance"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledOutlineBorderColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (employee["performance"] as int) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: (employee["performance"] as int) >= 90 ? successColor : 
                                     (employee["performance"] as int) >= 70 ? warningColor : dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Hire Date",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      DateTime.parse("${employee["hireDate"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing profile for ${employee["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEmployeeOptions(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${employee["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Position: ${employee["position"]}"),
            Text("Department: ${employee["department"]}"),
            Text("Employee ID: ${employee["employeeId"]}"),
            Text("Hourly Rate: \$${(employee["hourlyRate"] as double).toStringAsFixed(2)}"),
            Text("Hours This Week: ${employee["hoursWorked"]}"),
            Text("Performance: ${employee["performance"]}%"),
            Text("Status: ${employee["status"]}"),
            if (employee["isClocked"]) ...[
              Text("Currently Clocked In", style: TextStyle(color: successColor)),
            ] else ...[
              Text("Currently Clocked Out", style: TextStyle(color: dangerColor)),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  si("Opening edit form for ${employee["name"]}");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Schedule",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  si("Opening schedule for ${employee["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
