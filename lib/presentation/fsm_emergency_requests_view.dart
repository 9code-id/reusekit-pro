import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEmergencyRequestsView extends StatefulWidget {
  const FsmEmergencyRequestsView({super.key});

  @override
  State<FsmEmergencyRequestsView> createState() => _FsmEmergencyRequestsViewState();
}

class _FsmEmergencyRequestsViewState extends State<FsmEmergencyRequestsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
  ];
  
  List<Map<String, dynamic>> emergencyRequests = [
    {
      "id": "ER001",
      "title": "Complete Power Outage",
      "customer": "Metro Hospital",
      "location": "ICU Ward - Building B",
      "priority": "critical",
      "status": "open",
      "created_at": "2024-01-15T09:15:00",
      "reported_by": "Dr. Sarah Wilson",
      "phone": "+1-555-0123",
      "description": "Total power failure in ICU ward affecting life support equipment. Backup generators running but limited capacity.",
      "estimated_resolution": "2 hours",
      "assigned_technician": "",
      "category": "Electrical",
      "impact": "High - Critical infrastructure affected",
      "response_time": "15 minutes",
    },
    {
      "id": "ER002",
      "title": "HVAC System Failure",
      "customer": "TechCorp Data Center",
      "location": "Server Room A",
      "priority": "high",
      "status": "assigned",
      "created_at": "2024-01-15T11:30:00",
      "reported_by": "Mike Johnson",
      "phone": "+1-555-0124",
      "description": "Air conditioning system completely down in main server room. Temperature rising rapidly.",
      "estimated_resolution": "4 hours",
      "assigned_technician": "John Smith",
      "category": "HVAC",
      "impact": "High - Server equipment at risk",
      "response_time": "30 minutes",
    },
    {
      "id": "ER003",
      "title": "Water Leak in Basement",
      "customer": "Office Plaza Tower",
      "location": "Basement Level - Storage Area",
      "priority": "medium",
      "status": "in_progress",
      "created_at": "2024-01-15T08:45:00",
      "reported_by": "Building Manager",
      "phone": "+1-555-0125",
      "description": "Major water leak from overhead pipes flooding basement storage area. Documents and equipment at risk.",
      "estimated_resolution": "3 hours",
      "assigned_technician": "Sarah Johnson",
      "category": "Plumbing",
      "impact": "Medium - Property damage risk",
      "response_time": "45 minutes",
    },
    {
      "id": "ER004",
      "title": "Elevator Stuck Between Floors",
      "customer": "Residential Complex",
      "location": "Building C - Elevator 2",
      "priority": "high",
      "status": "resolved",
      "created_at": "2024-01-14T16:20:00",
      "reported_by": "Security Guard",
      "phone": "+1-555-0126",
      "description": "Elevator stuck between 5th and 6th floor with 3 passengers inside. Emergency communication working.",
      "estimated_resolution": "1 hour",
      "assigned_technician": "Mike Wilson",
      "category": "Elevator",
      "impact": "High - People safety",
      "response_time": "10 minutes",
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return emergencyRequests.where((request) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${request["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "all" || request["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "all" || request["status"] == selectedStatus;
      
      return matchesSearch && matchesPriority && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return Color(0xFFDC2626);
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "open":
        return dangerColor;
      case "assigned":
        return warningColor;
      case "in_progress":
        return infoColor;
      case "resolved":
        return successColor;
      case "closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildEmergencyCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 6,
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${request["priority"]}").withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${request["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor("${request["priority"]}"),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${request["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
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
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${request["status"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${request["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${request["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${request["customer"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${request["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.red[100]!),
            ),
            child: Text(
              "${request["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.red[800],
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Reported by: ${request["reported_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${request["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.category,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${request["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "ETA: ${request["estimated_resolution"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if ("${request["assigned_technician"]}".isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.engineering,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Assigned to: ${request["assigned_technician"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to detail view
                  },
                ),
              ),
              SizedBox(width: spSm),
              if ("${request["status"]}" == "open")
                Expanded(
                  child: QButton(
                    label: "Assign",
                    size: bs.sm,
                    onPressed: () {
                      // Assign technician
                    },
                  ),
                ),
              if ("${request["status"]}" == "assigned")
                Expanded(
                  child: QButton(
                    label: "Start Work",
                    size: bs.sm,
                    onPressed: () {
                      // Start working on request
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emergency Dashboard",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Requests", "12", Icons.emergency, dangerColor),
              _buildStatCard("Critical", "1", Icons.warning, Color(0xFFDC2626)),
              _buildStatCard("In Progress", "3", Icons.build, warningColor),
              _buildStatCard("Avg Response", "25min", Icons.timer, infoColor),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Recent Emergencies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredRequests.take(3).map((request) => _buildEmergencyCard(request)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
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
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search emergency requests...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorityOptions,
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
                      items: statusOptions,
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredRequests.length,
            itemBuilder: (context, index) {
              return _buildEmergencyCard(filteredRequests[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Emergency Requests",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Requests", icon: Icon(Icons.emergency)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildRequestsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
