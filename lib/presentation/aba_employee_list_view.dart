import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaEmployeeListView extends StatefulWidget {
  const AbaEmployeeListView({super.key});

  @override
  State<AbaEmployeeListView> createState() => _AbaEmployeeListViewState();
}

class _AbaEmployeeListViewState extends State<AbaEmployeeListView> {
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String selectedPosition = "All";
  bool loading = false;

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Operations", "value": "Operations"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Probation", "value": "Probation"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Terminated", "value": "Terminated"},
  ];

  List<Map<String, dynamic>> positionItems = [
    {"label": "All", "value": "All"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Senior", "value": "Senior"},
    {"label": "Junior", "value": "Junior"},
    {"label": "Intern", "value": "Intern"},
    {"label": "Director", "value": "Director"},
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1-555-0123",
      "department": "Engineering",
      "position": "Senior Developer",
      "status": "Active",
      "salary": 95000.00,
      "hire_date": "2022-03-15",
      "manager": "Sarah Johnson",
      "location": "New York",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=man",
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "phone": "+1-555-0456",
      "department": "Engineering",
      "position": "Engineering Manager",
      "status": "Active",
      "salary": 125000.00,
      "hire_date": "2021-01-20",
      "manager": "Mike Chen",
      "location": "New York",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=woman",
    },
    {
      "id": "EMP003",
      "name": "Mike Chen",
      "email": "mike.chen@company.com",
      "phone": "+1-555-0789",
      "department": "Sales",
      "position": "Sales Director",
      "status": "Active",
      "salary": 140000.00,
      "hire_date": "2020-06-10",
      "manager": "David Brown",
      "location": "San Francisco",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=businessman",
    },
    {
      "id": "EMP004",
      "name": "Lisa Wong",
      "email": "lisa.wong@company.com",
      "phone": "+1-555-0321",
      "department": "HR",
      "position": "HR Specialist",
      "status": "On Leave",
      "salary": 65000.00,
      "hire_date": "2023-02-28",
      "manager": "Jennifer Davis",
      "location": "Chicago",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=woman",
    },
    {
      "id": "EMP005",
      "name": "David Brown",
      "email": "david.brown@company.com",
      "phone": "+1-555-0654",
      "department": "Marketing",
      "position": "Marketing Manager",
      "status": "Active",
      "salary": 85000.00,
      "hire_date": "2022-08-12",
      "manager": "Sarah Johnson",
      "location": "Los Angeles",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=professional",
    },
    {
      "id": "EMP006",
      "name": "Jennifer Davis",
      "email": "jennifer.davis@company.com",
      "phone": "+1-555-0987",
      "department": "Finance",
      "position": "Finance Director",
      "status": "Active",
      "salary": 115000.00,
      "hire_date": "2021-11-05",
      "manager": "CEO",
      "location": "New York",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=executive",
    },
    {
      "id": "EMP007",
      "name": "Robert Johnson",
      "email": "robert.johnson@company.com",
      "phone": "+1-555-0246",
      "department": "Engineering",
      "position": "Junior Developer",
      "status": "Probation",
      "salary": 65000.00,
      "hire_date": "2024-01-08",
      "manager": "John Smith",
      "location": "Remote",
      "avatar": "https://picsum.photos/60/60?random=7&keyword=developer",
    },
    {
      "id": "EMP008",
      "name": "Emily Wilson",
      "email": "emily.wilson@company.com",
      "phone": "+1-555-0135",
      "department": "Operations",
      "position": "Operations Manager",
      "status": "Active",
      "salary": 78000.00,
      "hire_date": "2022-12-01",
      "manager": "Jennifer Davis",
      "location": "Seattle",
      "avatar": "https://picsum.photos/60/60?random=8&keyword=manager",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Probation":
        return infoColor;
      case "Inactive":
        return disabledBoldColor;
      case "Terminated":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildSummaryCard() {
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
            "Employee Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Total", "248", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Active", "230", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("On Leave", "12", warningColor),
              ),
              Expanded(
                child: _buildSummaryItem("New Hires", "8", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
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
            "Filter Employees",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search employees...",
            value: searchQuery,
            hint: "Name, email, ID, or position",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
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
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Position Level",
            items: positionItems,
            value: selectedPosition,
            onChanged: (value, label) {
              selectedPosition = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(employee["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${employee["avatar"]}"),
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
                      "${employee["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["position"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["department"]} • ${employee["id"]}",
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
                  color: _getStatusColor(employee["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(employee["status"]).withAlpha(100),
                  ),
                ),
                child: Text(
                  "${employee["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(employee["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salary",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((employee["salary"] as double) / 1000).toStringAsFixed(0)}K",
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
                        "Location",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${employee["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
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
                        "Hire Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${employee["hire_date"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${employee["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${employee["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Manager: ${employee["manager"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(),
                  SizedBox(height: spMd),
                  _buildFilterSection(),
                  SizedBox(height: spMd),
                  Text(
                    "All Employees",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...employees.map((employee) => _buildEmployeeCard(employee)).toList(),
                ],
              ),
            ),
    );
  }
}
