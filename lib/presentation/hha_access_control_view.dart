import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAccessControlView extends StatefulWidget {
  const HhaAccessControlView({super.key});

  @override
  State<HhaAccessControlView> createState() => _HhaAccessControlViewState();
}

class _HhaAccessControlViewState extends State<HhaAccessControlView> {
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedAccessLevel = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Administration", "value": "admin"},
    {"label": "Medical Staff", "value": "medical"},
    {"label": "Nursing", "value": "nursing"},
    {"label": "Security", "value": "security"},
    {"label": "IT Department", "value": "it"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Visitors", "value": "visitors"},
  ];

  List<Map<String, dynamic>> accessLevelOptions = [
    {"label": "All", "value": "All"},
    {"label": "Level 1 - Basic", "value": "level1"},
    {"label": "Level 2 - Standard", "value": "level2"},
    {"label": "Level 3 - Elevated", "value": "level3"},
    {"label": "Level 4 - High Security", "value": "level4"},
    {"label": "Level 5 - Maximum", "value": "level5"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Suspended", "value": "suspended"},
    {"label": "Expired", "value": "expired"},
    {"label": "Pending", "value": "pending"},
    {"label": "Revoked", "value": "revoked"},
  ];

  List<Map<String, dynamic>> accessUsers = [
    {
      "id": "USR001",
      "employeeId": "EMP-2024-0156",
      "name": "Dr. Sarah Mitchell",
      "department": "Medical Staff",
      "position": "Chief of Cardiology",
      "accessLevel": "Level 4 - High Security",
      "status": "Active",
      "cardNumber": "54-7892-1156",
      "issueDate": "2024-01-15",
      "expiryDate": "2025-01-15",
      "lastAccess": "2024-12-15 16:45",
      "accessCount": 1256,
      "authorizedAreas": [
        "Main Hospital - All Floors",
        "Cardiology Department", 
        "ICU Units",
        "Operating Rooms",
        "Administrative Offices",
        "Parking Garage"
      ],
      "restrictedAreas": [
        "Pharmacy Vault",
        "IT Server Room",
        "Security Control Room"
      ],
      "recentActivity": [
        {"time": "16:45", "location": "Cardiology Lab", "action": "Entry"},
        {"time": "14:30", "location": "ICU-3", "action": "Entry"},
        {"time": "12:15", "location": "Main Lobby", "action": "Entry"},
        {"time": "08:00", "location": "Parking Garage", "action": "Entry"}
      ],
      "supervisorApproval": "Dr. James Peterson - Chief Medical Officer",
      "emergencyContact": "555-0123",
      "notes": "Department head with extensive access privileges",
      "biometricEnabled": true,
      "pinEnabled": true,
      "photoId": "photo_001.jpg",
    },
    {
      "id": "USR002",
      "employeeId": "EMP-2024-0298",
      "name": "Nurse Jennifer Liu",
      "department": "Nursing",
      "position": "ICU Supervisor",
      "accessLevel": "Level 3 - Elevated",
      "status": "Active",
      "cardNumber": "54-7892-1189",
      "issueDate": "2024-03-20",
      "expiryDate": "2025-03-20",
      "lastAccess": "2024-12-15 16:20",
      "accessCount": 894,
      "authorizedAreas": [
        "Main Hospital - Floors 1-4",
        "ICU Units",
        "Emergency Department",
        "Patient Rooms",
        "Nursing Stations",
        "Break Rooms"
      ],
      "restrictedAreas": [
        "Operating Rooms",
        "Pharmacy Vault",
        "Administrative Offices",
        "IT Server Room",
        "Security Control Room"
      ],
      "recentActivity": [
        {"time": "16:20", "location": "ICU-2", "action": "Entry"},
        {"time": "15:45", "location": "Nursing Station 3F", "action": "Entry"},
        {"time": "13:30", "location": "Break Room", "action": "Entry"},
        {"time": "11:15", "location": "Patient Room 304", "action": "Entry"}
      ],
      "supervisorApproval": "Mary Johnson - Director of Nursing",
      "emergencyContact": "555-0456",
      "notes": "ICU supervisor with elevated patient care access",
      "biometricEnabled": true,
      "pinEnabled": false,
      "photoId": "photo_002.jpg",
    },
    {
      "id": "USR003",
      "employeeId": "SEC-2024-0012",
      "name": "Mark Wilson",
      "department": "Security",
      "position": "Security Officer",
      "accessLevel": "Level 5 - Maximum",
      "status": "Active",
      "cardNumber": "54-7892-1201",
      "issueDate": "2024-02-10",
      "expiryDate": "2025-02-10",
      "lastAccess": "2024-12-15 16:50",
      "accessCount": 2156,
      "authorizedAreas": [
        "All Hospital Areas",
        "Security Control Room",
        "IT Server Room",
        "Pharmacy Vault",
        "Operating Rooms",
        "Administrative Offices",
        "Parking Areas",
        "Utility Rooms"
      ],
      "restrictedAreas": [],
      "recentActivity": [
        {"time": "16:50", "location": "Security Control Room", "action": "Entry"},
        {"time": "15:30", "location": "Pharmacy Vault", "action": "Entry"},
        {"time": "14:15", "location": "Main Lobby", "action": "Patrol"},
        {"time": "12:00", "location": "Parking Garage", "action": "Patrol"}
      ],
      "supervisorApproval": "John Davidson - Security Manager",
      "emergencyContact": "555-0789",
      "notes": "Security officer with full facility access for safety purposes",
      "biometricEnabled": true,
      "pinEnabled": true,
      "photoId": "photo_003.jpg",
    },
    {
      "id": "USR004",
      "employeeId": "IT-2024-0045",
      "name": "Sarah Chen",
      "department": "IT Department",
      "position": "Network Administrator",
      "accessLevel": "Level 4 - High Security",
      "status": "Active",
      "cardNumber": "54-7892-1234",
      "issueDate": "2024-05-15",
      "expiryDate": "2025-05-15",
      "lastAccess": "2024-12-15 15:30",
      "accessCount": 567,
      "authorizedAreas": [
        "Main Hospital - All Floors",
        "IT Server Room",
        "Network Closets",
        "Administrative Offices",
        "Parking Garage"
      ],
      "restrictedAreas": [
        "Pharmacy Vault",
        "Operating Rooms",
        "Patient Rooms",
        "Security Control Room"
      ],
      "recentActivity": [
        {"time": "15:30", "location": "IT Server Room", "action": "Entry"},
        {"time": "14:00", "location": "Network Closet 3F", "action": "Entry"},
        {"time": "11:45", "location": "Administrative Office", "action": "Entry"},
        {"time": "09:00", "location": "Main Lobby", "action": "Entry"}
      ],
      "supervisorApproval": "Robert Davis - IT Director",
      "emergencyContact": "555-0234",
      "notes": "IT staff with network infrastructure access",
      "biometricEnabled": false,
      "pinEnabled": true,
      "photoId": "photo_004.jpg",
    },
    {
      "id": "USR005",
      "employeeId": "MAINT-2024-0023",
      "name": "David Thompson",
      "department": "Maintenance",
      "position": "Facilities Technician",
      "accessLevel": "Level 3 - Elevated",
      "status": "Active",
      "cardNumber": "54-7892-1267",
      "issueDate": "2024-04-01",
      "expiryDate": "2025-04-01",
      "lastAccess": "2024-12-15 14:15",
      "accessCount": 1834,
      "authorizedAreas": [
        "Main Hospital - All Floors",
        "Utility Rooms",
        "Mechanical Rooms",
        "Maintenance Shop",
        "Parking Areas",
        "Loading Dock"
      ],
      "restrictedAreas": [
        "Pharmacy Vault",
        "IT Server Room",
        "Security Control Room",
        "Patient Rooms (during occupied hours)"
      ],
      "recentActivity": [
        {"time": "14:15", "location": "Mechanical Room B1", "action": "Entry"},
        {"time": "12:30", "location": "Utility Room 2F", "action": "Entry"},
        {"time": "10:45", "location": "Maintenance Shop", "action": "Entry"},
        {"time": "08:30", "location": "Loading Dock", "action": "Entry"}
      ],
      "supervisorApproval": "Jennifer Wong - Facilities Manager",
      "emergencyContact": "555-0567",
      "notes": "Maintenance staff with facility access for repairs",
      "biometricEnabled": false,
      "pinEnabled": true,
      "photoId": "photo_005.jpg",
    },
    {
      "id": "USR006",
      "employeeId": "TEMP-2024-0189",
      "name": "Dr. Michael Chen",
      "department": "Medical Staff",
      "position": "Visiting Cardiologist",
      "accessLevel": "Level 2 - Standard",
      "status": "Expired",
      "cardNumber": "54-7892-1301",
      "issueDate": "2024-11-01",
      "expiryDate": "2024-12-01",
      "lastAccess": "2024-11-30 17:00",
      "accessCount": 45,
      "authorizedAreas": [
        "Main Hospital - Floors 1-3",
        "Cardiology Department",
        "Patient Rooms",
        "Main Lobby",
        "Parking Garage"
      ],
      "restrictedAreas": [
        "ICU Units",
        "Operating Rooms",
        "Administrative Offices",
        "IT Server Room",
        "Security Control Room",
        "Pharmacy Vault"
      ],
      "recentActivity": [
        {"time": "17:00", "location": "Main Lobby", "action": "Exit"},
        {"time": "16:30", "location": "Cardiology Lab", "action": "Entry"},
        {"time": "14:00", "location": "Patient Room 203", "action": "Entry"},
        {"time": "09:00", "location": "Main Lobby", "action": "Entry"}
      ],
      "supervisorApproval": "Dr. Sarah Mitchell - Chief of Cardiology",
      "emergencyContact": "555-0890",
      "notes": "Temporary access for visiting specialist - EXPIRED",
      "biometricEnabled": false,
      "pinEnabled": true,
      "photoId": "photo_006.jpg",
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return accessUsers.where((user) {
      bool matchesSearch = user["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          user["employeeId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          user["cardNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "All" || user["department"].toString().toLowerCase().replaceAll(" ", "") == selectedDepartment.replaceAll("_", "");
      bool matchesAccessLevel = selectedAccessLevel == "All" || user["accessLevel"].toString().toLowerCase().contains(selectedAccessLevel.replaceAll("level", "level "));
      bool matchesStatus = selectedStatus == "All" || user["status"].toString().toLowerCase() == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesAccessLevel && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'suspended':
        return warningColor;
      case 'expired':
        return dangerColor;
      case 'pending':
        return infoColor;
      case 'revoked':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAccessLevelColor(String level) {
    if (level.contains("Level 1")) return successColor;
    if (level.contains("Level 2")) return infoColor;
    if (level.contains("Level 3")) return warningColor;
    if (level.contains("Level 4")) return dangerColor;
    if (level.contains("Level 5")) return primaryColor;
    return disabledBoldColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Access Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Add new user
            },
          ),
          IconButton(
            icon: Icon(Icons.badge),
            onPressed: () {
              // Card management
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Access Control Overview
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Total Users",
                  "${accessUsers.length}",
                  primaryColor,
                  Icons.people,
                ),
                _buildOverviewCard(
                  "Active Users",
                  "${accessUsers.where((u) => u["status"] == "Active").length}",
                  successColor,
                  Icons.check_circle,
                ),
                _buildOverviewCard(
                  "Expired Cards",
                  "${accessUsers.where((u) => u["status"] == "Expired").length}",
                  dangerColor,
                  Icons.credit_card_off,
                ),
                _buildOverviewCard(
                  "High Security",
                  "${accessUsers.where((u) => u["accessLevel"].toString().contains("Level 4") || u["accessLevel"].toString().contains("Level 5")).length}",
                  warningColor,
                  Icons.security,
                ),
                _buildOverviewCard(
                  "Access Events Today",
                  "${accessUsers.fold<int>(0, (sum, u) => sum + (u["recentActivity"] as List).where((a) => a["time"].toString().startsWith("16") || a["time"].toString().startsWith("15") || a["time"].toString().startsWith("14")).length)}",
                  infoColor,
                  Icons.login,
                ),
                _buildOverviewCard(
                  "Biometric Enabled",
                  "${accessUsers.where((u) => u["biometricEnabled"] == true).length}",
                  successColor,
                  Icons.fingerprint,
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Search & Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QTextField(
                    label: "Search Users",
                    value: searchQuery,
                    hint: "Search by name, employee ID, or card number",
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
                          items: departmentOptions,
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
                          label: "Access Level",
                          items: accessLevelOptions,
                          value: selectedAccessLevel,
                          onChanged: (value, label) {
                            selectedAccessLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Access Users List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Access Control Users",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredUsers.length} users found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredUsers.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: _getAccessLevelColor("${user["accessLevel"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: _getAccessLevelColor("${user["accessLevel"]}"),
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: _getAccessLevelColor("${user["accessLevel"]}"),
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
                                            "${user["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor("${user["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${user["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${user["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${user["position"]} - ${user["department"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "ID: ${user["employeeId"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "•",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "Card: ${user["cardNumber"]}",
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getAccessLevelColor("${user["accessLevel"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${user["accessLevel"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getAccessLevelColor("${user["accessLevel"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (user["biometricEnabled"] == true) ...[
                                          Icon(
                                            Icons.fingerprint,
                                            size: 14,
                                            color: successColor,
                                          ),
                                          SizedBox(width: 2),
                                        ],
                                        if (user["pinEnabled"] == true) ...[
                                          Icon(
                                            Icons.pin,
                                            size: 14,
                                            color: infoColor,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Last: ${user["lastAccess"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.login,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${user["accessCount"]} total",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.date_range,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Expires: ${user["expiryDate"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.room,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${(user["authorizedAreas"] as List).length} areas",
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
                                ],
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border(
                                  left: BorderSide(
                                    color: infoColor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Recent Activity",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  ...((user["recentActivity"] as List).take(3).map((activity) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${activity["time"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: infoColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${activity["location"]} (${activity["action"]})",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: infoColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: _getActionLabel("${user["status"]}"),
                                    size: bs.sm,
                                    onPressed: () {
                                      _performAction(user);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.history,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View access history
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // More options
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
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
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
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
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return "Manage Access";
      case 'suspended':
        return "Reactivate";
      case 'expired':
        return "Renew Card";
      case 'pending':
        return "Approve";
      case 'revoked':
        return "Restore Access";
      default:
        return "View Details";
    }
  }

  void _performAction(Map<String, dynamic> user) {
    String status = "${user["status"]}";
    String action = _getActionLabel(status);
    ss("$action performed for ${user["name"]}");
  }
}
