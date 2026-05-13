import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaLuggageServiceView extends StatefulWidget {
  const HhaLuggageServiceView({super.key});

  @override
  State<HhaLuggageServiceView> createState() => _HhaLuggageServiceViewState();
}

class _HhaLuggageServiceViewState extends State<HhaLuggageServiceView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedType = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Requested", "value": "Requested"},
    {"label": "Collected", "value": "Collected"},
    {"label": "Stored", "value": "Stored"},
    {"label": "Delivered", "value": "Delivered"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Check-in Storage", "value": "Check-in Storage"},
    {"label": "Check-out Pickup", "value": "Check-out Pickup"},
    {"label": "Concierge Hold", "value": "Concierge Hold"},
    {"label": "Lost & Found", "value": "Lost & Found"},
  ];

  List<Map<String, dynamic>> luggageStats = [
    {
      "title": "Active Requests",
      "value": 28,
      "icon": Icons.luggage,
      "color": primaryColor,
    },
    {
      "title": "In Storage",
      "value": 15,
      "icon": Icons.inventory,
      "color": warningColor,
    },
    {
      "title": "Ready for Pickup",
      "value": 8,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Storage Capacity",
      "value": 85,
      "icon": Icons.storage,
      "color": infoColor,
      "percentage": true,
    },
  ];

  List<Map<String, dynamic>> luggageRequests = [
    {
      "id": "LUG001",
      "roomNumber": "204",
      "guestName": "Alice Johnson",
      "type": "Check-in Storage",
      "status": "Requested",
      "requestTime": "10:30 AM",
      "itemCount": 3,
      "location": "Storage A-12",
      "priority": "Normal",
      "description": "2 suitcases, 1 backpack",
      "specialNotes": "Handle with care - fragile items inside",
    },
    {
      "id": "LUG002",
      "roomNumber": "156",
      "guestName": "Robert Smith",
      "type": "Check-out Pickup",
      "status": "Stored",
      "requestTime": "08:15 AM",
      "itemCount": 2,
      "location": "Storage B-05",
      "priority": "Express",
      "description": "1 large suitcase, 1 garment bag",
      "specialNotes": null,
    },
    {
      "id": "LUG003",
      "roomNumber": "301",
      "guestName": "Emma Davis",
      "type": "Concierge Hold",
      "status": "Collected",
      "requestTime": "09:45 AM",
      "itemCount": 1,
      "location": "Concierge Desk",
      "priority": "Normal",
      "description": "Shopping bags from mall",
      "specialNotes": "Guest will pick up after dinner",
    },
    {
      "id": "LUG004",
      "roomNumber": "089",
      "guestName": "Mike Wilson",
      "type": "Check-in Storage",
      "status": "Delivered",
      "requestTime": "07:30 AM",
      "itemCount": 4,
      "location": "Storage A-08",
      "priority": "Normal",
      "description": "2 suitcases, 2 duffel bags",
      "specialNotes": "Family vacation luggage",
    },
    {
      "id": "LUG005",
      "roomNumber": null,
      "guestName": "Unknown",
      "type": "Lost & Found",
      "status": "Stored",
      "requestTime": "Yesterday",
      "itemCount": 1,
      "location": "Lost & Found",
      "priority": "Low",
      "description": "Black laptop bag",
      "specialNotes": "Found in lobby area",
    },
  ];

  List<Map<String, dynamic>> storageAreas = [
    {
      "name": "Storage Area A",
      "capacity": 50,
      "occupied": 32,
      "available": 18,
      "location": "Ground Floor",
      "type": "General Storage",
    },
    {
      "name": "Storage Area B",
      "capacity": 30,
      "occupied": 18,
      "available": 12,
      "location": "Basement",
      "type": "Long-term Storage",
    },
    {
      "name": "Concierge Hold",
      "capacity": 20,
      "occupied": 8,
      "available": 12,
      "location": "Lobby",
      "type": "Quick Access",
    },
    {
      "name": "Lost & Found",
      "capacity": 15,
      "occupied": 3,
      "available": 12,
      "location": "Security Office",
      "type": "Lost Items",
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return luggageRequests.where((request) {
      bool statusMatch = selectedStatus == "All" || request["status"] == selectedStatus;
      bool typeMatch = selectedType == "All" || request["type"] == selectedType;
      return statusMatch && typeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Luggage Service",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.list)),
        Tab(text: "Storage", icon: Icon(Icons.inventory)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildStorageTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: luggageStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 28,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      stat["percentage"] == true 
                          ? "${stat["value"]}%"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          // Filters
          Row(
            spacing: spSm,
            children: [
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
              Expanded(
                child: QDropdownField(
                  label: "Service Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "New Request",
                  size: bs.sm,
                  onPressed: () {
                    ss("Creating new luggage request");
                  },
                ),
              ),
              QButton(
                icon: Icons.qr_code_scanner,
                size: bs.sm,
                onPressed: () {
                  ss("Scanning luggage QR code");
                },
              ),
            ],
          ),
          
          // Requests List
          Row(
            children: [
              Text(
                "Luggage Requests",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredRequests.length} requests",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: filteredRequests.map((request) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(request["status"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${request["id"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if (request["roomNumber"] != null)
                                Text(
                                  "Room ${request["roomNumber"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                              Row(
                                children: [
                                  Text(
                                    "${request["guestName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (request["priority"] == "Express")
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "EXPRESS",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${request["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(request["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(request["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Items: ${request["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${request["itemCount"]} pieces",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Requested: ${request["requestTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.location_on,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${request["location"]}",
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
                    
                    if (request["specialNotes"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${request["specialNotes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        if (request["status"] == "Requested")
                          Expanded(
                            child: QButton(
                              label: "Collect",
                              size: bs.sm,
                              onPressed: () {
                                ss("Collecting luggage ${request["id"]}");
                              },
                            ),
                          ),
                        if (request["status"] == "Collected")
                          Expanded(
                            child: QButton(
                              label: "Store",
                              size: bs.sm,
                              onPressed: () {
                                ss("Storing luggage ${request["id"]}");
                              },
                            ),
                          ),
                        if (request["status"] == "Stored")
                          Expanded(
                            child: QButton(
                              label: "Deliver",
                              size: bs.sm,
                              onPressed: () {
                                ss("Delivering luggage ${request["id"]}");
                              },
                            ),
                          ),
                        QButton(
                          icon: Icons.qr_code,
                          size: bs.sm,
                          onPressed: () {
                            ss("Viewing QR code for ${request["id"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${request["id"]}");
                          },
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
    );
  }

  Widget _buildStorageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Storage Areas",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: storageAreas.map((area) {
              double occupancyRate = ((area["occupied"] as int) / (area["capacity"] as int)) * 100;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.inventory,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${area["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${area["location"]} • ${area["type"]}",
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Occupancy",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${area["occupied"]}/${area["capacity"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${occupancyRate.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getOccupancyColor(occupancyRate),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: occupancyRate / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getOccupancyColor(occupancyRate),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    
                    Text(
                      "${area["available"]} spaces available",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Luggage Service Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Service Metrics",
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
                    _buildMetricCard("Average Processing Time", "12 minutes", Icons.timer, successColor),
                    _buildMetricCard("Customer Satisfaction", "96%", Icons.star, warningColor),
                    _buildMetricCard("Daily Requests", "28", Icons.luggage, infoColor),
                    _buildMetricCard("Storage Utilization", "64%", Icons.storage, primaryColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Requested":
        return warningColor;
      case "Collected":
        return infoColor;
      case "Stored":
        return primaryColor;
      case "Delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getOccupancyColor(double percentage) {
    if (percentage >= 90) return dangerColor;
    if (percentage >= 70) return warningColor;
    if (percentage >= 50) return infoColor;
    return successColor;
  }
}
