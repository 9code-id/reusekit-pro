import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosRolePermissionsView extends StatefulWidget {
  const PosRolePermissionsView({super.key});

  @override
  State<PosRolePermissionsView> createState() => _PosRolePermissionsViewState();
}

class _PosRolePermissionsViewState extends State<PosRolePermissionsView> {
  String searchQuery = "";
  String selectedRole = "";
  
  List<Map<String, dynamic>> roleFilterItems = [
    {"label": "All Roles", "value": ""},
    {"label": "Manager", "value": "manager"},
    {"label": "Assistant Manager", "value": "assistant_manager"},
    {"label": "Cashier", "value": "cashier"},
    {"label": "Server", "value": "server"},
    {"label": "Chef", "value": "chef"},
    {"label": "Barista", "value": "barista"},
  ];

  List<Map<String, dynamic>> roles = [
    {
      "id": "1",
      "name": "Store Manager",
      "description": "Full access to all store operations",
      "employees": 2,
      "permissions": [
        "Sales Management",
        "Employee Management", 
        "Inventory Control",
        "Reports & Analytics",
        "Financial Management",
        "System Settings"
      ],
      "color": Colors.red,
      "level": "Executive"
    },
    {
      "id": "2", 
      "name": "Assistant Manager",
      "description": "Supervised access to daily operations",
      "employees": 3,
      "permissions": [
        "Sales Management",
        "Employee Scheduling",
        "Inventory Control", 
        "Customer Service",
        "Daily Reports"
      ],
      "color": Colors.orange,
      "level": "Management"
    },
    {
      "id": "3",
      "name": "Cashier",
      "description": "Point of sale and payment processing",
      "employees": 8,
      "permissions": [
        "Process Sales",
        "Handle Payments",
        "Customer Service",
        "Product Information",
        "Basic Reporting"
      ],
      "color": Colors.blue,
      "level": "Operational"
    },
    {
      "id": "4",
      "name": "Kitchen Staff",
      "description": "Food preparation and kitchen operations",
      "employees": 6,
      "permissions": [
        "Order Management",
        "Food Preparation",
        "Inventory Check",
        "Kitchen Equipment",
        "Quality Control"
      ],
      "color": Colors.green,
      "level": "Operational"
    },
    {
      "id": "5",
      "name": "Server",
      "description": "Customer service and order taking",
      "employees": 12,
      "permissions": [
        "Take Orders",
        "Customer Service",
        "Table Management",
        "Payment Processing",
        "Menu Information"
      ],
      "color": Colors.purple,
      "level": "Service"
    },
    {
      "id": "6",
      "name": "Barista",
      "description": "Beverage preparation and service",
      "employees": 4,
      "permissions": [
        "Beverage Preparation",
        "Equipment Operation",
        "Customer Service",
        "Inventory Check",
        "Quality Control"
      ],
      "color": Colors.brown,
      "level": "Service"
    },
  ];

  List<Map<String, dynamic>> get filteredRoles {
    return roles.where((role) {
      bool matchesSearch = role["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          role["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesRole = selectedRole.isEmpty || role["name"].toString().toLowerCase().contains(selectedRole.toLowerCase());
      return matchesSearch && matchesRole;
    }).toList();
  }

  void _showRoleDetails(Map<String, dynamic> role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${role["name"]} Permissions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${role["description"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            Divider(),
            Text(
              "Permissions:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fsH6,
              ),
            ),
            ...((role["permissions"] as List).map((permission) => 
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: (role["color"] as Color),
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "$permission",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        actions: [
          QButton(
            label: "Edit Permissions",
            size: bs.sm,
            onPressed: () {
              back();
              _editRolePermissions(role);
            },
          ),
          QButton(
            label: "Close", 
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _editRolePermissions(Map<String, dynamic> role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ${role["name"]} Permissions"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select permissions for this role:",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spSm),
              ...["Sales Management", "Employee Management", "Inventory Control", "Reports & Analytics", "Financial Management", "System Settings", "Customer Service", "Order Management", "Kitchen Operations"].map((permission) =>
                CheckboxListTile(
                  title: Text(permission),
                  value: (role["permissions"] as List).contains(permission),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        (role["permissions"] as List).add(permission);
                      } else {
                        (role["permissions"] as List).remove(permission);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Role permissions updated successfully");
            },
          ),
          QButton(
            label: "Cancel",
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _createNewRole() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Role"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Role Name",
              value: "",
              onChanged: (value) {},
            ),
            QMemoField(
              label: "Description",
              value: "",
              onChanged: (value) {},
            ),
            QDropdownField(
              label: "Access Level",
              items: [
                {"label": "Executive", "value": "executive"},
                {"label": "Management", "value": "management"},
                {"label": "Operational", "value": "operational"},
                {"label": "Service", "value": "service"},
              ],
              value: "",
              onChanged: (value, label) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Create Role",
            size: bs.sm,
            onPressed: () {
              back();
              ss("New role created successfully");
            },
          ),
          QButton(
            label: "Cancel",
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Role & Permissions"),
        actions: [
          QButton(
            label: "New Role",
            size: bs.sm,
            onPressed: _createNewRole,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              width: double.infinity,
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
                    label: "Search Roles",
                    value: searchQuery,
                    hint: "Search by role name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Filter by Role",
                    items: roleFilterItems,
                    value: selectedRole,
                    onChanged: (value, label) {
                      selectedRole = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Overview Stats
            ResponsiveGridView(
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
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        size: 40,
                        color: primaryColor,
                      ),
                      Text(
                        "${roles.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Roles",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
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
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.people,
                        size: 40,
                        color: successColor,
                      ),
                      Text(
                        "${roles.fold(0, (sum, role) => sum + (role["employees"] as int))}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Employees",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
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
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.security,
                        size: 40,
                        color: warningColor,
                      ),
                      Text(
                        "${roles.expand((role) => role["permissions"] as List).toSet().length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Permissions",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Roles List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Role Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredRoles.map((role) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: role["color"] as Color,
                          ),
                        ),
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (role["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.admin_panel_settings,
                              color: role["color"] as Color,
                              size: 24,
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
                                      "${role["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (role["color"] as Color).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${role["level"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: role["color"] as Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${role["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${role["employees"]} employees",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.security,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(role["permissions"] as List).length} permissions",
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
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            children: [
                              QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () => _showRoleDetails(role),
                              ),
                              QButton(
                                label: "Edit",
                                color: warningColor,
                                size: bs.sm,
                                onPressed: () => _editRolePermissions(role),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
