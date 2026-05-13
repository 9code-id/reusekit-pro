import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomMaintenanceView extends StatefulWidget {
  const HhaRoomMaintenanceView({super.key});

  @override
  State<HhaRoomMaintenanceView> createState() => _HhaRoomMaintenanceViewState();
}

class _HhaRoomMaintenanceViewState extends State<HhaRoomMaintenanceView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedCategory = "All";

  final List<Map<String, dynamic>> maintenanceRequests = [
    {
      "id": "MR001",
      "room": "101",
      "title": "Air Conditioning Not Working",
      "category": "HVAC",
      "priority": "High",
      "status": "In Progress",
      "reportedBy": "John Smith",
      "assignedTo": "Mike Johnson",
      "reportedDate": "2024-01-15",
      "estimatedCompletion": "2024-01-16",
      "description": "AC unit in room 101 is not cooling properly. Guest complained about warm temperature.",
      "cost": 150.00,
    },
    {
      "id": "MR002",
      "room": "203",
      "title": "Leaky Faucet in Bathroom",
      "category": "Plumbing",
      "priority": "Medium",
      "status": "Pending",
      "reportedBy": "Sarah Davis",  
      "assignedTo": "Tom Wilson",
      "reportedDate": "2024-01-14",
      "estimatedCompletion": "2024-01-17",
      "description": "Bathroom sink faucet is dripping continuously.",
      "cost": 75.00,
    },
    {
      "id": "MR003",
      "room": "305",
      "title": "Broken Light Fixture",
      "category": "Electrical",
      "priority": "Low",
      "status": "Completed",
      "reportedBy": "Mike Chen",
      "assignedTo": "Alex Brown",
      "reportedDate": "2024-01-13",
      "estimatedCompletion": "2024-01-14",
      "description": "Ceiling light fixture in bedroom is not working.",
      "cost": 45.00,
    },
    {
      "id": "MR004",
      "room": "412",
      "title": "Door Lock Malfunction",
      "category": "Security",
      "priority": "High",
      "status": "In Progress",
      "reportedBy": "Lisa Johnson",
      "assignedTo": "David Lee",
      "reportedDate": "2024-01-15",
      "estimatedCompletion": "2024-01-16",
      "description": "Electronic door lock is not responding to key cards.",
      "cost": 200.00,
    },
    {
      "id": "MR005",
      "room": "507",
      "title": "TV Not Working",
      "category": "Electronics",
      "priority": "Medium",
      "status": "Scheduled",
      "reportedBy": "Emma Wilson",
      "assignedTo": "Chris Garcia",
      "reportedDate": "2024-01-16",
      "estimatedCompletion": "2024-01-18",
      "description": "Television in room not turning on, no display.",
      "cost": 120.00,
    },
  ];

  final List<Map<String, dynamic>> maintenanceStaff = [
    {
      "id": "ST001",
      "name": "Mike Johnson",
      "specialization": "HVAC",
      "status": "Available",
      "activeJobs": 2,
      "phone": "+1 555-0101",
      "rating": 4.8,
    },
    {
      "id": "ST002", 
      "name": "Tom Wilson",
      "specialization": "Plumbing",
      "status": "Busy",
      "activeJobs": 3,
      "phone": "+1 555-0102",
      "rating": 4.6,
    },
    {
      "id": "ST003",
      "name": "Alex Brown",
      "specialization": "Electrical",
      "status": "Available",
      "activeJobs": 1,
      "phone": "+1 555-0103",
      "rating": 4.9,
    },
    {
      "id": "ST004",
      "name": "David Lee",
      "specialization": "Security",
      "status": "On Leave",
      "activeJobs": 0,
      "phone": "+1 555-0104",
      "rating": 4.7,
    },
  ];

  final List<Map<String, dynamic>> maintenanceSupplies = [
    {
      "item": "Air Filter",
      "category": "HVAC",
      "stock": 25,
      "minStock": 10,
      "unit": "pieces",
      "cost": 15.00,
    },
    {
      "item": "Faucet Gasket",
      "category": "Plumbing", 
      "stock": 45,
      "minStock": 20,
      "unit": "pieces",
      "cost": 3.50,
    },
    {
      "item": "LED Bulbs",
      "category": "Electrical",
      "stock": 8,
      "minStock": 15,
      "unit": "pieces",
      "cost": 12.00,
    },
    {
      "item": "Door Handle",
      "category": "Hardware",
      "stock": 12,
      "minStock": 5,
      "unit": "pieces",
      "cost": 35.00,
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return maintenanceRequests.where((request) {
      bool matchesSearch = request["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          request["room"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPriority = selectedPriority == "All" || request["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || request["category"] == selectedCategory;
      
      return matchesSearch && matchesPriority && matchesStatus && matchesCategory;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Scheduled":
        return warningColor;
      case "Pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Maintenance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.build)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
        Tab(text: "Supplies", icon: Icon(Icons.inventory)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildStaffTab(),
        _buildSuppliesTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Requests", "${maintenanceRequests.length}", Icons.build, primaryColor),
              _buildSummaryCard("In Progress", "${maintenanceRequests.where((r) => r["status"] == "In Progress").length}", Icons.work, infoColor),
              _buildSummaryCard("Pending", "${maintenanceRequests.where((r) => r["status"] == "Pending").length}", Icons.schedule, warningColor),
              _buildSummaryCard("High Priority", "${maintenanceRequests.where((r) => r["priority"] == "High").length}", Icons.priority_high, dangerColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search
                QTextField(
                  label: "Search Requests",
                  value: searchQuery,
                  hint: "Search by title or room number",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "High", "value": "High"},
                          {"label": "Medium", "value": "Medium"},
                          {"label": "Low", "value": "Low"},
                        ],
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Pending", "value": "Pending"},
                          {"label": "In Progress", "value": "In Progress"},
                          {"label": "Scheduled", "value": "Scheduled"},
                          {"label": "Completed", "value": "Completed"},
                        ],
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Maintenance Requests List
          ...filteredRequests.map((request) {
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
                    color: _getPriorityColor("${request["priority"]}"),
                  ),
                ),
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
                            Row(
                              children: [
                                Text(
                                  "Room ${request["room"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${request["priority"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${request["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor("${request["priority"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${request["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${request["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${request["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${request["status"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "${request["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Assigned to: ${request["assignedTo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${request["estimatedCompletion"]}",
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
                      Text(
                        "Cost: \$${((request["cost"] as double).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening maintenance request details");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Staff Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Staff", "${maintenanceStaff.length}", Icons.people, primaryColor),
              _buildSummaryCard("Available", "${maintenanceStaff.where((s) => s["status"] == "Available").length}", Icons.check_circle, successColor),
              _buildSummaryCard("Busy", "${maintenanceStaff.where((s) => s["status"] == "Busy").length}", Icons.work, warningColor),
              _buildSummaryCard("Avg Rating", "4.7", Icons.star, infoColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Staff List
          ...maintenanceStaff.map((staff) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${staff["name"]}".split(" ").map((n) => n[0]).join(""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${staff["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${staff["specialization"]} • ${staff["activeJobs"]} active jobs",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "${staff["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: staff["status"] == "Available" 
                              ? successColor.withAlpha(20)
                              : staff["status"] == "Busy"
                                  ? warningColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${staff["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: staff["status"] == "Available" 
                                ? successColor
                                : staff["status"] == "Busy"
                                    ? warningColor
                                    : disabledBoldColor,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      QButton(
                        label: "Contact",
                        size: bs.sm,
                        onPressed: () {
                          si("Calling ${staff["name"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSuppliesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Supplies Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Items", "${maintenanceSupplies.length}", Icons.inventory, primaryColor),
              _buildSummaryCard("Low Stock", "${maintenanceSupplies.where((s) => (s["stock"] as int) <= (s["minStock"] as int)).length}", Icons.warning, dangerColor),
              _buildSummaryCard("Well Stocked", "${maintenanceSupplies.where((s) => (s["stock"] as int) > (s["minStock"] as int)).length}", Icons.check, successColor),
              _buildSummaryCard("Total Value", "\$${((maintenanceSupplies.fold(0.0, (sum, item) => sum + ((item["stock"] as int) * (item["cost"] as double)))).toDouble()).currency}", Icons.attach_money, infoColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Supplies List
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
                Text(
                  "Inventory Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...maintenanceSupplies.map((supply) {
                  bool isLowStock = (supply["stock"] as int) <= (supply["minStock"] as int);
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isLowStock ? dangerColor.withAlpha(10) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isLowStock ? dangerColor.withAlpha(40) : Colors.grey.withAlpha(40),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${supply["item"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isLowStock) ...[
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.warning,
                                      color: dangerColor,
                                      size: 16,
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${supply["category"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${supply["stock"]} ${supply["unit"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isLowStock ? dangerColor : successColor,
                              ),
                            ),
                            Text(
                              "Min: ${supply["minStock"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${((supply["cost"] as double).toDouble()).currency}/unit",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Report Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Completed This Month", "24", Icons.check_circle, successColor),
              _buildSummaryCard("Average Response Time", "2.5 hrs", Icons.schedule, infoColor),
              _buildSummaryCard("Total Cost This Month", "\$3,250", Icons.attach_money, warningColor),
              _buildSummaryCard("Customer Satisfaction", "94%", Icons.star, primaryColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Charts and Analytics
          Container(
            width: double.infinity,
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
                  "Maintenance Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Detailed maintenance reports and analytics would be displayed here with charts showing:",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "• Request trends by category",
                    "• Staff performance metrics",
                    "• Cost analysis and budget tracking",
                    "• Response time statistics",
                    "• Guest satisfaction scores",
                    "• Equipment reliability data",
                  ].map((item) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  )).toList(),
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Detailed Report",
                    size: bs.md,
                    onPressed: () {
                      ss("Generating comprehensive maintenance report");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
