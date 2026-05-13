import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDriverTrackingView extends StatefulWidget {
  const LtaDriverTrackingView({super.key});

  @override
  State<LtaDriverTrackingView> createState() => _LtaDriverTrackingViewState();
}

class _LtaDriverTrackingViewState extends State<LtaDriverTrackingView> {
  int currentTab = 0;
  String selectedTimeFilter = "today";
  String selectedDriver = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> timeFilterOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> driverOptions = [
    {"label": "All Drivers", "value": "all"},
    {"label": "John Smith", "value": "john"},
    {"label": "Mike Johnson", "value": "mike"},
    {"label": "Sarah Wilson", "value": "sarah"},
  ];

  List<Map<String, dynamic>> activeDrivers = [
    {
      "id": "1",
      "name": "John Smith",
      "vehicle": "Truck-001",
      "status": "On Route",
      "location": "Downtown Area",
      "speed": 45,
      "destination": "Warehouse B",
      "eta": "14:30",
      "progress": 0.7,
      "lastUpdate": "2 mins ago",
      "phone": "+1234567890",
      "image": "https://picsum.photos/60/60?random=1&keyword=driver"
    },
    {
      "id": "2",
      "name": "Mike Johnson",
      "vehicle": "Van-003",
      "status": "Loading",
      "location": "Main Depot",
      "speed": 0,
      "destination": "Client Site A",
      "eta": "15:45",
      "progress": 0.1,
      "lastUpdate": "5 mins ago",
      "phone": "+1234567891",
      "image": "https://picsum.photos/60/60?random=2&keyword=driver"
    },
    {
      "id": "3",
      "name": "Sarah Wilson",
      "vehicle": "Truck-005",
      "status": "Delivered",
      "location": "Industrial Zone",
      "speed": 0,
      "destination": "Return to Base",
      "eta": "16:20",
      "progress": 1.0,
      "lastUpdate": "1 min ago",
      "phone": "+1234567892",
      "image": "https://picsum.photos/60/60?random=3&keyword=driver"
    },
    {
      "id": "4",
      "name": "David Brown",
      "vehicle": "Van-007",
      "status": "Break",
      "location": "Rest Area",
      "speed": 0,
      "destination": "Customer Location",
      "eta": "17:00",
      "progress": 0.4,
      "lastUpdate": "8 mins ago",
      "phone": "+1234567893",
      "image": "https://picsum.photos/60/60?random=4&keyword=driver"
    },
  ];

  List<Map<String, dynamic>> driverHistory = [
    {
      "id": "1",
      "name": "John Smith",
      "date": "2024-06-15",
      "routes": 3,
      "distance": "245 km",
      "deliveries": 8,
      "rating": 4.8,
      "efficiency": 92
    },
    {
      "id": "2",
      "name": "Mike Johnson",
      "date": "2024-06-15",
      "routes": 2,
      "distance": "180 km",
      "deliveries": 5,
      "rating": 4.6,
      "efficiency": 88
    },
    {
      "id": "3",
      "name": "Sarah Wilson",
      "date": "2024-06-15",
      "routes": 4,
      "distance": "320 km",
      "deliveries": 12,
      "rating": 4.9,
      "efficiency": 95
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'on route':
        return successColor;
      case 'loading':
        return warningColor;
      case 'delivered':
        return infoColor;
      case 'break':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Driver Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Live Tracking", icon: Icon(Icons.location_on)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildLiveTrackingTab(),
        _buildHistoryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildLiveTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildLiveMap(),
          _buildActiveDriversList(),
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
                  label: "Search driver or vehicle...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Filter",
                  items: timeFilterOptions,
                  value: selectedTimeFilter,
                  onChanged: (value, label) {
                    selectedTimeFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Driver",
                  items: driverOptions,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
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

  Widget _buildLiveMap() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[100]!,
                  Colors.green[100]!,
                ],
              ),
            ),
          ),
          // Mock driver locations
          ...activeDrivers.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> driver = entry.value;
            
            return Positioned(
              left: 50.0 + (index * 60.0),
              top: 80.0 + (index * 40.0),
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor("${driver["status"]}"),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${driver["vehicle"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          Positioned(
            top: spSm,
            right: spSm,
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, size: 16, color: primaryColor),
                  SizedBox(width: spXs),
                  Text(
                    "Live",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
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

  Widget _buildActiveDriversList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Active Drivers (${activeDrivers.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: activeDrivers.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final driver = activeDrivers[index];
              return Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${driver["image"]}"),
                          fit: BoxFit.cover,
                        ),
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
                                "${driver["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${driver["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${driver["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor("${driver["status"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${driver["vehicle"]} • ${driver["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${driver["destination"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "ETA: ${driver["eta"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (driver["progress"] as num).toDouble(),
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(successColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      children: [
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling ${driver["name"]}...");
                          },
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening chat with ${driver["name"]}");
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
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search history...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: timeFilterOptions,
                    value: selectedTimeFilter,
                    onChanged: (value, label) {
                      selectedTimeFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.history, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Driver History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: driverHistory.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final history = driverHistory[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${history["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${history["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${(history["efficiency"] as num)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: _buildHistoryStatItem(
                                  "Routes",
                                  "${history["routes"]}",
                                  Icons.route,
                                ),
                              ),
                              Expanded(
                                child: _buildHistoryStatItem(
                                  "Distance",
                                  "${history["distance"]}",
                                  Icons.straighten,
                                ),
                              ),
                              Expanded(
                                child: _buildHistoryStatItem(
                                  "Deliveries",
                                  "${history["deliveries"]}",
                                  Icons.local_shipping,
                                ),
                              ),
                              Expanded(
                                child: _buildHistoryStatItem(
                                  "Rating",
                                  "${history["rating"]}",
                                  Icons.star,
                                ),
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
    );
  }

  Widget _buildHistoryStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard(
                "Total Drivers",
                "24",
                Icons.people,
                successColor,
                "+8% from last month",
              ),
              _buildAnalyticsCard(
                "Active Now",
                "18",
                Icons.location_on,
                warningColor,
                "75% utilization",
              ),
              _buildAnalyticsCard(
                "Avg Speed",
                "42 km/h",
                Icons.speed,
                infoColor,
                "Within safe limits",
              ),
              _buildAnalyticsCard(
                "Efficiency",
                "91%",
                Icons.trending_up,
                primaryColor,
                "+3% improvement",
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.bar_chart, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Performance Metrics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.analytics,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Performance Chart",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Driver efficiency over time",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
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
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                size: 16,
                color: successColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }
}
