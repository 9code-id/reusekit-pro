import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosEmployeeManagementView extends StatefulWidget {
  const PosEmployeeManagementView({super.key});

  @override
  State<PosEmployeeManagementView> createState() => _PosEmployeeManagementViewState();
}

class _PosEmployeeManagementViewState extends State<PosEmployeeManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedRole = "";

  List<Map<String, dynamic>> departments = [
    {
      "id": "1",
      "name": "Sales",
      "employeeCount": 12,
      "color": Colors.blue,
      "description": "Point of sale and customer service",
    },
    {
      "id": "2", 
      "name": "Kitchen",
      "employeeCount": 8,
      "color": Colors.orange,
      "description": "Food preparation and cooking",
    },
    {
      "id": "3",
      "name": "Management",
      "employeeCount": 3,
      "color": Colors.purple,
      "description": "Store management and administration",
    },
    {
      "id": "4",
      "name": "Delivery",
      "employeeCount": 6,
      "color": Colors.green,
      "description": "Order delivery and logistics",
    },
  ];

  List<Map<String, dynamic>> roles = [
    {
      "id": "1",
      "name": "Cashier",
      "department": "Sales",
      "employeeCount": 8,
      "permissions": ["pos_access", "customer_service", "basic_reports"],
      "hourlyRate": 15.50,
      "description": "Handle customer transactions and basic inquiries",
    },
    {
      "id": "2",
      "name": "Store Manager",
      "department": "Management", 
      "employeeCount": 2,
      "permissions": ["full_access", "employee_management", "financial_reports", "inventory_management"],
      "hourlyRate": 28.00,
      "description": "Overall store operations and staff management",
    },
    {
      "id": "3",
      "name": "Chef",
      "department": "Kitchen",
      "employeeCount": 3,
      "permissions": ["kitchen_access", "inventory_view", "menu_management"],
      "hourlyRate": 22.00,
      "description": "Food preparation and kitchen operations",
    },
    {
      "id": "4",
      "name": "Delivery Driver",
      "department": "Delivery",
      "employeeCount": 6,
      "permissions": ["delivery_access", "order_view", "customer_contact"],
      "hourlyRate": 14.00,
      "description": "Order delivery and customer interaction",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": "1",
      "type": "hire",
      "employeeName": "Sarah Johnson",
      "department": "Sales",
      "role": "Cashier",
      "timestamp": "2024-06-19T10:30:00",
      "details": "New employee hired",
    },
    {
      "id": "2",
      "type": "promotion",
      "employeeName": "Mike Chen",
      "department": "Kitchen", 
      "role": "Head Chef",
      "timestamp": "2024-06-18T14:20:00",
      "details": "Promoted from Chef to Head Chef",
    },
    {
      "id": "3",
      "type": "schedule",
      "employeeName": "Emma Davis",
      "department": "Sales",
      "role": "Cashier",
      "timestamp": "2024-06-18T09:15:00",
      "details": "Schedule updated for next week",
    },
    {
      "id": "4",
      "type": "training",
      "employeeName": "John Smith",
      "department": "Delivery", 
      "role": "Driver",
      "timestamp": "2024-06-17T16:45:00",
      "details": "Completed safety training",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Employee Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Roles", icon: Icon(Icons.badge)),
        Tab(text: "Activity", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildRolesTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOverviewStats(),
          _buildQuickActions(),
          _buildDepartmentSummary(),
        ],
      ),
    );
  }

  Widget _buildOverviewStats() {
    int totalEmployees = departments.fold(0, (sum, dept) => sum + (dept["employeeCount"] as int));
    int totalDepartments = departments.length;
    int totalRoles = roles.length;
    double avgHourlyRate = roles.fold(0.0, (sum, role) => sum + (role["hourlyRate"] as double)) / roles.length;

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
                "$totalEmployees",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Employees",
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
                Icons.business,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalDepartments",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Departments",
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
                Icons.badge,
                color: warningColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalRoles",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Job Roles",
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
                Icons.attach_money,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "\$${avgHourlyRate.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Avg Hourly Rate",
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
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Employee",
                  icon: Icons.person_add,
                  size: bs.md,
                  onPressed: () {
                    si("Opening add employee form");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Staff List",
                  icon: Icons.list,
                  size: bs.md,
                  onPressed: () {
                    si("Opening staff list");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Manage Shifts",
                  icon: Icons.schedule,
                  size: bs.md,
                  onPressed: () {
                    si("Opening shift management");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Role Permissions",
                  icon: Icons.security,
                  size: bs.md,
                  onPressed: () {
                    si("Opening role permissions");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Department Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...departments.map((department) => _buildDepartmentSummaryCard(department)),
      ],
    );
  }

  Widget _buildDepartmentSummaryCard(Map<String, dynamic> department) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: department["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (department["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.business,
              color: department["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${department["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${department["description"]}",
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
                "${department["employeeCount"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Employees",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDepartmentFilters(),
          _buildDepartmentsList(),
        ],
      ),
    );
  }

  Widget _buildDepartmentFilters() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search departments...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.add,
          size: bs.sm,
          onPressed: () {
            si("Opening add department dialog");
          },
        ),
      ],
    );
  }

  Widget _buildDepartmentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Departments",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...departments.map((department) => _buildDepartmentCard(department)),
      ],
    );
  }

  Widget _buildDepartmentCard(Map<String, dynamic> department) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: department["color"] as Color,
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
                  color: (department["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.business,
                  color: department["color"] as Color,
                  size: 30,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${department["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${department["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.group, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${department["employeeCount"]} employees",
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
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("Opening department options");
                },
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Employees",
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing employees in ${department["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRolesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRoleFilters(),
          _buildRolesList(),
        ],
      ),
    );
  }

  Widget _buildRoleFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search roles...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter by Department",
                items: [
                  {"label": "All Departments", "value": ""},
                  ...departments.map((dept) => {
                    "label": "${dept["name"]}",
                    "value": "${dept["name"]}",
                  }),
                ],
                value: selectedDepartment,
                onChanged: (value, label) {
                  selectedDepartment = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                si("Opening add role dialog");
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRolesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Job Roles",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...roles.map((role) => _buildRoleCard(role)),
      ],
    );
  }

  Widget _buildRoleCard(Map<String, dynamic> role) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.badge,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${role["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${role["department"]} Department",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${role["description"]}",
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
                  Text(
                    "\$${(role["hourlyRate"] as double).toStringAsFixed(2)}/hr",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${role["employeeCount"]} employees",
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
                onPressed: () {
                  si("Opening role options");
                },
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Permissions:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (role["permissions"] as List).map((permission) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$permission",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActivityStats(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildActivityStats() {
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
                Icons.person_add,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "3",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "New Hires This Month",
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
                Icons.trending_up,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "2",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Promotions",
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
                Icons.school,
                color: warningColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "5",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Training Completed",
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

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Recent Activities",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentActivities.map((activity) => _buildActivityItem(activity)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color iconColor = activity["type"] == "hire" ? successColor : 
                     activity["type"] == "promotion" ? infoColor : 
                     activity["type"] == "training" ? warningColor : primaryColor;
    
    IconData icon = activity["type"] == "hire" ? Icons.person_add : 
                   activity["type"] == "promotion" ? Icons.trending_up : 
                   activity["type"] == "training" ? Icons.school : Icons.schedule;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["employeeName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["department"]} • ${activity["role"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateTime.parse("${activity["timestamp"]}").dMMMy,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
