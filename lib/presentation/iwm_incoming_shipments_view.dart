import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmIncomingShipmentsView extends StatefulWidget {
  const IwmIncomingShipmentsView({super.key});

  @override
  State<IwmIncomingShipmentsView> createState() => _IwmIncomingShipmentsViewState();
}

class _IwmIncomingShipmentsViewState extends State<IwmIncomingShipmentsView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedCarrier = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Arrived", "value": "arrived"},
    {"label": "Unloading", "value": "unloading"},
    {"label": "Completed", "value": "completed"},
    {"label": "Delayed", "value": "delayed"},
  ];
  
  List<Map<String, dynamic>> carrierOptions = [
    {"label": "All Carriers", "value": "all"},
    {"label": "FedEx", "value": "fedex"},
    {"label": "UPS", "value": "ups"},
    {"label": "DHL", "value": "dhl"},
    {"label": "Local Transport", "value": "local"},
    {"label": "Own Fleet", "value": "own_fleet"},
  ];
  
  List<Map<String, dynamic>> shipments = [
    {
      "id": "SH-2024-0001",
      "trackingNumber": "TRK123456789",
      "carrier": "FedEx",
      "supplier": "ABC Manufacturing",
      "poNumbers": ["PO-2024-0001", "PO-2024-0002"],
      "scheduledDate": "2024-01-15",
      "scheduledTime": "10:00 AM",
      "actualArrival": "2024-01-15 10:15 AM",
      "status": "Unloading",
      "priority": "High",
      "totalPackages": 25,
      "processedPackages": 18,
      "dock": "Dock-A1",
      "driver": "John Driver",
      "driverPhone": "+1-234-567-8900",
      "vehicle": "Truck-001",
      "notes": "Fragile items - handle with care"
    },
    {
      "id": "SH-2024-0002",
      "trackingNumber": "TRK987654321",
      "carrier": "UPS",
      "supplier": "XYZ Components",
      "poNumbers": ["PO-2024-0003"],
      "scheduledDate": "2024-01-15",
      "scheduledTime": "02:00 PM",
      "actualArrival": "",
      "status": "In Transit",
      "priority": "Medium",
      "totalPackages": 15,
      "processedPackages": 0,
      "dock": "Dock-B2",
      "driver": "Sarah Transport",
      "driverPhone": "+1-234-567-8901",
      "vehicle": "Van-002",
      "notes": "Electronic components - temperature sensitive"
    },
    {
      "id": "SH-2024-0003",
      "trackingNumber": "TRK555444333",
      "carrier": "DHL",
      "supplier": "Tech Solutions Ltd",
      "poNumbers": ["PO-2024-0004", "PO-2024-0005"],
      "scheduledDate": "2024-01-16",
      "scheduledTime": "08:00 AM",
      "actualArrival": "",
      "status": "Scheduled",
      "priority": "Low",
      "totalPackages": 30,
      "processedPackages": 0,
      "dock": "Dock-C3",
      "driver": "Mike Logistics",
      "driverPhone": "+1-234-567-8902",
      "vehicle": "Truck-003",
      "notes": "Large packages - forklift required"
    },
    {
      "id": "SH-2024-0004",
      "trackingNumber": "TRK111222333",
      "carrier": "Local Transport",
      "supplier": "Global Suppliers",
      "poNumbers": ["PO-2024-0006"],
      "scheduledDate": "2024-01-14",
      "scheduledTime": "03:00 PM",
      "actualArrival": "",
      "status": "Delayed",
      "priority": "High",
      "totalPackages": 8,
      "processedPackages": 0,
      "dock": "Dock-A2",
      "driver": "Lisa Freight",
      "driverPhone": "+1-234-567-8903",
      "vehicle": "Truck-004",
      "notes": "Delayed due to traffic - ETA 5:00 PM"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Shipments",
      "value": 156,
      "subtitle": "This Month",
      "icon": Icons.local_shipping,
      "color": primaryColor
    },
    {
      "title": "Arrived Today",
      "value": 12,
      "subtitle": "Ready for Processing",
      "icon": Icons.done,
      "color": successColor
    },
    {
      "title": "In Transit",
      "value": 8,
      "subtitle": "On the Way",
      "icon": Icons.timeline,
      "color": infoColor
    },
    {
      "title": "Delayed",
      "value": 3,
      "subtitle": "Need Attention",
      "icon": Icons.warning,
      "color": dangerColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Incoming Shipments",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Shipments", icon: Icon(Icons.local_shipping)),
        Tab(text: "Tracking", icon: Icon(Icons.gps_fixed)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildShipmentsTab(),
        _buildTrackingTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryStats(),
          _buildTodaySchedule(),
          _buildDockStatus(),
        ],
      ),
    );
  }

  Widget _buildShipmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildShipmentsList(),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrackingTools(),
          _buildLiveTracking(),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Shipment Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: summaryStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySchedule() {
    List<Map<String, dynamic>> todayShipments = shipments.where((s) => 
      s["scheduledDate"] == "2024-01-15").toList();
    
    return Container(
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
          Row(
            children: [
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${todayShipments.length} shipments",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...todayShipments.map((shipment) => _buildScheduleItem(shipment)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> shipment) {
    Color statusColor = _getStatusColor(shipment["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${shipment["scheduledTime"]} - ${shipment["supplier"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${shipment["id"]} • ${shipment["carrier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Dock: ${shipment["dock"]} • ${shipment["totalPackages"]} packages",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${shipment["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDockStatus() {
    List<Map<String, dynamic>> docks = [
      {"name": "Dock-A1", "status": "Occupied", "shipment": "SH-2024-0001", "eta": "11:00 AM"},
      {"name": "Dock-A2", "status": "Available", "shipment": "", "eta": ""},
      {"name": "Dock-B1", "status": "Reserved", "shipment": "SH-2024-0002", "eta": "02:00 PM"},
      {"name": "Dock-B2", "status": "Available", "shipment": "", "eta": ""},
      {"name": "Dock-C1", "status": "Maintenance", "shipment": "", "eta": ""},
      {"name": "Dock-C2", "status": "Available", "shipment": "", "eta": ""},
    ];
    
    return Container(
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
            "Dock Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: docks.map((dock) => _buildDockCard(dock)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDockCard(Map<String, dynamic> dock) {
    Color statusColor = _getDockStatusColor(dock["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${dock["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${dock["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if ((dock["shipment"] as String).isNotEmpty) ...[
            Text(
              "Shipment: ${dock["shipment"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          if ((dock["eta"] as String).isNotEmpty) ...[
            Text(
              "ETA: ${dock["eta"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: QTextField(
                  label: "Search Shipments",
                  value: searchQuery,
                  hint: "ID, Tracking Number, Supplier...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Carrier",
                  items: carrierOptions,
                  value: selectedCarrier,
                  onChanged: (value, label) {
                    selectedCarrier = value;
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

  Widget _buildShipmentsList() {
    return Column(
      spacing: spSm,
      children: shipments.map((shipment) => _buildShipmentCard(shipment)).toList(),
    );
  }

  Widget _buildShipmentCard(Map<String, dynamic> shipment) {
    Color statusColor = _getStatusColor(shipment["status"]);
    Color priorityColor = _getPriorityColor(shipment["priority"]);
    double progress = (shipment["processedPackages"] as int) / (shipment["totalPackages"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${shipment["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${shipment["supplier"]} • ${shipment["carrier"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${shipment["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${shipment["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Tracking: ${shipment["trackingNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "PO: ${(shipment["poNumbers"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Scheduled: ${shipment["scheduledDate"]} ${shipment["scheduledTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((shipment["actualArrival"] as String).isNotEmpty) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Arrived: ${shipment["actualArrival"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (progress > 0) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Processing Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${shipment["processedPackages"]}/${shipment["totalPackages"]} packages",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Driver: ${shipment["driver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Vehicle: ${shipment["vehicle"]} • Dock: ${shipment["dock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Track",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if ((shipment["notes"] as String).isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.notes, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${shipment["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrackingTools() {
    return Container(
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
            "Tracking Tools",
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
              _buildTrackingCard("Track by Number", Icons.search, "Enter tracking number"),
              _buildTrackingCard("GPS Tracking", Icons.gps_fixed, "Real-time location"),
              _buildTrackingCard("ETA Calculator", Icons.schedule, "Estimate arrival time"),
              _buildTrackingCard("Route Optimizer", Icons.route, "Optimize routes"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, size: 32, color: primaryColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTracking() {
    return Container(
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
            "Live Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Live Tracking Map",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Real-time shipment locations",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return infoColor;
      case 'in transit':
        return warningColor;
      case 'arrived':
        return successColor;
      case 'unloading':
        return primaryColor;
      case 'completed':
        return successColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDockStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return successColor;
      case 'occupied':
        return warningColor;
      case 'reserved':
        return infoColor;
      case 'maintenance':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
