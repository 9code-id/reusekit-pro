import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderStatusView extends StatefulWidget {
  const FsmWorkOrderStatusView({super.key});

  @override
  State<FsmWorkOrderStatusView> createState() => _FsmWorkOrderStatusViewState();
}

class _FsmWorkOrderStatusViewState extends State<FsmWorkOrderStatusView> {
  String selectedFilter = "All";
  String searchQuery = "";
  int selectedTab = 0;

  // Mock data for work order statuses
  List<Map<String, dynamic>> workOrderStatuses = [
    {
      "id": "WO-001",
      "title": "HVAC System Maintenance",
      "customer": "ABC Corporation",
      "technician": "John Smith",
      "status": "In Progress",
      "priority": "High",
      "progress": 65,
      "startDate": "2024-01-15",
      "estimatedCompletion": "2024-01-16",
      "lastUpdate": "2024-01-15 14:30",
      "location": "Building A - Floor 3",
      "equipment": "HVAC Unit #001",
      "nextAction": "Complete electrical connections",
      "timeSpent": "4.5 hours",
      "estimatedTime": "7 hours",
      "statusHistory": [
        {"status": "Created", "timestamp": "2024-01-15 08:00", "user": "System"},
        {"status": "Assigned", "timestamp": "2024-01-15 08:30", "user": "Manager"},
        {"status": "In Progress", "timestamp": "2024-01-15 09:00", "user": "John Smith"},
      ]
    },
    {
      "id": "WO-002",
      "title": "Electrical Panel Inspection",
      "customer": "XYZ Industries",
      "technician": "Sarah Johnson",
      "status": "Pending",
      "priority": "Medium",
      "progress": 0,
      "startDate": "2024-01-16",
      "estimatedCompletion": "2024-01-16",
      "lastUpdate": "2024-01-15 16:45",
      "location": "Warehouse B",
      "equipment": "Main Electrical Panel",
      "nextAction": "Schedule site visit",
      "timeSpent": "0 hours",
      "estimatedTime": "3 hours",
      "statusHistory": [
        {"status": "Created", "timestamp": "2024-01-15 16:45", "user": "Customer"},
        {"status": "Pending", "timestamp": "2024-01-15 16:45", "user": "System"},
      ]
    },
    {
      "id": "WO-003",
      "title": "Plumbing Repair - Emergency",
      "customer": "Downtown Office Complex",
      "technician": "Mike Wilson",
      "status": "Completed",
      "priority": "Critical",
      "progress": 100,
      "startDate": "2024-01-14",
      "estimatedCompletion": "2024-01-14",
      "lastUpdate": "2024-01-14 18:00",
      "location": "Basement Level",
      "equipment": "Main Water Line",
      "nextAction": "Follow-up inspection scheduled",
      "timeSpent": "6 hours",
      "estimatedTime": "5 hours",
      "statusHistory": [
        {"status": "Created", "timestamp": "2024-01-14 10:00", "user": "Customer"},
        {"status": "Assigned", "timestamp": "2024-01-14 10:15", "user": "Dispatcher"},
        {"status": "In Progress", "timestamp": "2024-01-14 11:00", "user": "Mike Wilson"},
        {"status": "Completed", "timestamp": "2024-01-14 18:00", "user": "Mike Wilson"},
      ]
    },
    {
      "id": "WO-004",
      "title": "Generator Maintenance",
      "customer": "Metro Hospital",
      "technician": "David Brown",
      "status": "On Hold",
      "priority": "Medium",
      "progress": 25,
      "startDate": "2024-01-15",
      "estimatedCompletion": "2024-01-17",
      "lastUpdate": "2024-01-15 12:00",
      "location": "Generator Room",
      "equipment": "Backup Generator #3",
      "nextAction": "Waiting for replacement parts",
      "timeSpent": "2 hours",
      "estimatedTime": "8 hours",
      "statusHistory": [
        {"status": "Created", "timestamp": "2024-01-14 14:00", "user": "Maintenance Team"},
        {"status": "Assigned", "timestamp": "2024-01-14 14:30", "user": "Manager"},
        {"status": "In Progress", "timestamp": "2024-01-15 08:00", "user": "David Brown"},
        {"status": "On Hold", "timestamp": "2024-01-15 12:00", "user": "David Brown"},
      ]
    },
    {
      "id": "WO-005",
      "title": "Fire Safety System Check",
      "customer": "City Mall",
      "technician": "Lisa Anderson",
      "status": "Scheduled",
      "priority": "High",
      "progress": 0,
      "startDate": "2024-01-17",
      "estimatedCompletion": "2024-01-17",
      "lastUpdate": "2024-01-15 10:00",
      "location": "All Floors",
      "equipment": "Fire Alarm System",
      "nextAction": "Pre-inspection preparation",
      "timeSpent": "0 hours",
      "estimatedTime": "4 hours",
      "statusHistory": [
        {"status": "Created", "timestamp": "2024-01-15 10:00", "user": "Safety Officer"},
        {"status": "Scheduled", "timestamp": "2024-01-15 10:00", "user": "System"},
      ]
    },
  ];

  List<Map<String, dynamic>> statusCategories = [
    {"label": "All", "count": 5, "color": primaryColor},
    {"label": "Pending", "count": 1, "color": warningColor},
    {"label": "In Progress", "count": 1, "color": infoColor},
    {"label": "On Hold", "count": 1, "color": disabledColor},
    {"label": "Completed", "count": 1, "color": successColor},
    {"label": "Scheduled", "count": 1, "color": secondaryColor},
  ];

  List<Map<String, dynamic>> get filteredWorkOrders {
    List<Map<String, dynamic>> filtered = workOrderStatuses;

    if (selectedFilter != "All") {
      filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["customer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["technician"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return disabledColor;
      case "Scheduled":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Work Order Status",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Status Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Live Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildStatusOverviewTab(),
        _buildLiveTrackingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildStatusOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Bar
          QTextField(
            label: "Search work orders...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Status Filter Categories
          Container(
            height: 120,
            child: QHorizontalScroll(
              children: statusCategories.map((category) {
                bool isSelected = selectedFilter == category["label"];
                return GestureDetector(
                  onTap: () {
                    selectedFilter = category["label"];
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? category["color"] : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: category["color"],
                        width: 2,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${category["count"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : category["color"],
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          category["label"],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : category["color"],
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Work Orders List
          ...filteredWorkOrders.map((order) => _buildWorkOrderCard(order)),
        ],
      ),
    );
  }

  Widget _buildWorkOrderCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: getStatusColor(order["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["id"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      order["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: getStatusColor(order["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  order["status"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: getStatusColor(order["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Progress Bar
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${order["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (order["progress"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: getStatusColor(order["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          order["technician"],
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.business, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          order["customer"],
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            order["location"],
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: getPriorityColor(order["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  order["priority"],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: getPriorityColor(order["priority"]),
                  ),
                ),
              ),
            ],
          ),

          // Time Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Action",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        order["nextAction"],
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Time Spent",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      order["timeSpent"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showOrderDetails(order),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.timeline,
                size: bs.sm,
                onPressed: () => _showStatusHistory(order),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () => _showUpdateDialog(order),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Real-time Updates Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.live_tv, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Live Tracking",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Real-time updates from field technicians",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          // Active Work Orders Map
          ...workOrderStatuses
              .where((order) => order["status"] == "In Progress")
              .map((order) => _buildLiveTrackingCard(order)),

          // Recent Updates Timeline
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
                  "Recent Updates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildRecentUpdates(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTrackingCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header with live indicator
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order["id"],
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
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      order["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          // Technician Location
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order["technician"]} - On Site",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        order["location"],
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Last seen: 2 min ago",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Progress and ETA
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress: ${order["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (order["progress"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: successColor,
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
                    "ETA",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "16:30",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Contact Technician",
                  size: bs.sm,
                  icon: Icons.phone,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.map,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentUpdates() {
    List<Map<String, dynamic>> updates = [
      {
        "time": "14:30",
        "order": "WO-001",
        "message": "Started electrical connections phase",
        "technician": "John Smith",
        "type": "progress"
      },
      {
        "time": "13:15",
        "order": "WO-004",
        "message": "Work on hold - waiting for parts",
        "technician": "David Brown",
        "type": "issue"
      },
      {
        "time": "12:45",
        "order": "WO-003",
        "message": "Work order completed successfully",
        "technician": "Mike Wilson",
        "type": "completed"
      },
      {
        "time": "11:30",
        "order": "WO-002",
        "message": "New work order assigned",
        "technician": "Sarah Johnson",
        "type": "assigned"
      },
    ];

    return updates.map((update) {
      Color typeColor = update["type"] == "progress" ? infoColor :
                       update["type"] == "issue" ? warningColor :
                       update["type"] == "completed" ? successColor : primaryColor;

      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: typeColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: typeColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                update["type"] == "progress" ? Icons.trending_up :
                update["type"] == "issue" ? Icons.warning :
                update["type"] == "completed" ? Icons.check :
                Icons.assignment,
                size: 12,
                color: Colors.white,
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
                        update["order"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: typeColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        update["time"],
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    update["message"],
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    update["technician"],
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Status Distribution Chart
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
                  "Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...statusCategories.where((cat) => cat["label"] != "All").map((category) {
                  double percentage = ((category["count"] as int) / 5) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category["label"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${percentage.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: category["color"],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: category["color"],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Average Completion Time", "4.2 hours", Icons.timer, successColor),
              _buildMetricCard("On-Time Completion", "89%", Icons.schedule, infoColor),
              _buildMetricCard("First-Time Fix Rate", "76%", Icons.build, warningColor),
              _buildMetricCard("Customer Satisfaction", "4.6/5", Icons.star, primaryColor),
            ],
          ),

          // Technician Performance
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
                  "Technician Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildTechnicianPerformanceList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
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
    );
  }

  List<Widget> _buildTechnicianPerformanceList() {
    List<Map<String, dynamic>> technicians = [
      {"name": "John Smith", "completed": 12, "avgTime": "3.8h", "rating": 4.8},
      {"name": "Sarah Johnson", "completed": 8, "avgTime": "4.1h", "rating": 4.6},
      {"name": "Mike Wilson", "completed": 15, "avgTime": "3.2h", "rating": 4.9},
      {"name": "David Brown", "completed": 6, "avgTime": "5.1h", "rating": 4.3},
      {"name": "Lisa Anderson", "completed": 9, "avgTime": "4.0h", "rating": 4.7},
    ];

    return technicians.map((tech) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tech["name"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${tech["completed"]} completed • ${tech["avgTime"]} avg",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${tech["rating"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    )).toList();
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    //navigateTo(FsmWorkOrderDetailView(order: order))
  }

  void _showStatusHistory(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Status History - ${order["id"]}"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: (order["statusHistory"] as List).map((history) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history["status"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "by ${history["user"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    history["timestamp"],
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(Map<String, dynamic> order) {
    String statusUpdate = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Status Update"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Status Update",
              value: statusUpdate,
              hint: "Enter update message...",
              onChanged: (value) => statusUpdate = value,
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Send Update",
            size: bs.sm,
            onPressed: () {
              if (statusUpdate.isNotEmpty) {
                ss("Status update sent successfully!");
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
