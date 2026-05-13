import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRouteManagementView extends StatefulWidget {
  const CmaRouteManagementView({super.key});

  @override
  State<CmaRouteManagementView> createState() => _CmaRouteManagementViewState();
}

class _CmaRouteManagementViewState extends State<CmaRouteManagementView> {
  int currentTab = 0;
  String selectedRoute = "";
  String selectedDriver = "";
  String routeName = "";
  String startLocation = "";
  String endLocation = "";
  String estimatedTime = "";
  String estimatedDistance = "";
  bool isOptimized = true;
  
  List<Map<String, dynamic>> routes = [
    {
      "id": "RT001",
      "name": "Downtown Express",
      "start": "Depot A",
      "end": "Business District",
      "distance": 45.2,
      "estimatedTime": "2h 15m",
      "driver": "John Smith",
      "vehicle": "TRK-001",
      "status": "Active",
      "efficiency": 87,
      "fuelCost": 125.50,
      "stops": 8,
      "completedTrips": 234,
      "rating": 4.8
    },
    {
      "id": "RT002", 
      "name": "Suburban Loop",
      "start": "Distribution Center",
      "end": "Residential Area",
      "distance": 62.8,
      "estimatedTime": "3h 45m",
      "driver": "Maria Garcia",
      "vehicle": "VAN-002",
      "status": "In Progress",
      "efficiency": 92,
      "fuelCost": 178.25,
      "stops": 12,
      "completedTrips": 156,
      "rating": 4.6
    },
    {
      "id": "RT003",
      "name": "Industrial Circuit",
      "start": "Manufacturing Plant",
      "end": "Port Terminal",
      "distance": 38.5,
      "estimatedTime": "1h 50m",
      "driver": "David Chen",
      "vehicle": "TRK-003",
      "status": "Scheduled",
      "efficiency": 84,
      "fuelCost": 98.75,
      "stops": 5,
      "completedTrips": 98,
      "rating": 4.9
    }
  ];

  List<Map<String, dynamic>> drivers = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Route Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Routes", icon: Icon(Icons.route)),
        Tab(text: "Create Route", icon: Icon(Icons.add_road)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveRoutesTab(),
        _buildCreateRouteTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildActiveRoutesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuickStats(),
          _buildRouteFilters(),
          _buildRoutesList(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Active Routes", "${routes.where((r) => r["status"] == "Active").length}", Icons.route, primaryColor),
        _buildStatCard("Total Distance", "${routes.fold(0.0, (sum, route) => sum + (route["distance"] as double)).toStringAsFixed(1)} km", Icons.straighten, successColor),
        _buildStatCard("Avg Efficiency", "${(routes.fold(0.0, (sum, route) => sum + (route["efficiency"] as int)) / routes.length).toStringAsFixed(1)}%", Icons.trending_up, infoColor),
        _buildStatCard("Total Fuel Cost", "\$${routes.fold(0.0, (sum, route) => sum + (route["fuelCost"] as double)).toStringAsFixed(2)}", Icons.local_gas_station, warningColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "+12%",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
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

  Widget _buildRouteFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Routes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Route",
                  items: routes.map((route) => {
                    "label": "${route["name"]}",
                    "value": "${route["id"]}",
                  }).toList(),
                  value: selectedRoute,
                  onChanged: (value, label) {
                    selectedRoute = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Select Driver",
                  items: drivers,
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

  Widget _buildRoutesList() {
    return Column(
      spacing: spSm,
      children: routes.map((route) => _buildRouteCard(route)).toList(),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    Color statusColor = route["status"] == "Active" ? successColor : 
                       route["status"] == "In Progress" ? warningColor : infoColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${route["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ID: ${route["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${route["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${route["start"]}",
                  style: TextStyle(color: primaryColor, fontSize: 12),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(20)],
                      ),
                    ),
                  ),
                ),
                Icon(Icons.flag, color: dangerColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${route["end"]}",
                  style: TextStyle(color: dangerColor, fontSize: 12),
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildRouteMetric("Distance", "${(route["distance"] as double).toStringAsFixed(1)} km", Icons.straighten),
              _buildRouteMetric("Time", "${route["estimatedTime"]}", Icons.access_time),
              _buildRouteMetric("Efficiency", "${route["efficiency"]}%", Icons.trending_up),
              _buildRouteMetric("Fuel Cost", "\$${(route["fuelCost"] as double).toStringAsFixed(2)}", Icons.local_gas_station),
            ],
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.person, color: primaryColor, size: 16),
              ),
              SizedBox(width: spSm),
              Text(
                "${route["driver"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${route["rating"]}",
                    style: TextStyle(
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateRouteTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Create New Route",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Route Name",
                  value: routeName,
                  hint: "Enter route name",
                  onChanged: (value) {
                    routeName = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Start Location",
                        value: startLocation,
                        hint: "Enter start point",
                        onChanged: (value) {
                          startLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "End Location",
                        value: endLocation,
                        hint: "Enter destination",
                        onChanged: (value) {
                          endLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Estimated Time",
                        value: estimatedTime,
                        hint: "e.g., 2h 30m",
                        onChanged: (value) {
                          estimatedTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Estimated Distance",
                        value: estimatedDistance,
                        hint: "e.g., 45.5 km",
                        onChanged: (value) {
                          estimatedDistance = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QDropdownField(
                  label: "Assign Driver",
                  items: drivers,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
                    setState(() {});
                  },
                ),

                QSwitch(
                  label: "Route Optimization",
                  items: [
                    {
                      "label": "Enable automatic route optimization",
                      "value": true,
                      "checked": isOptimized,
                    }
                  ],
                  value: [if (isOptimized) {"label": "Enable automatic route optimization", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    setState(() {
                      isOptimized = values.isNotEmpty;
                    });
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Route",
                    size: bs.md,
                    onPressed: () {
                      ss("Route created successfully!");
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceMetrics(),
          _buildEfficiencyChart(),
          _buildTopRoutes(),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildMetricTile("Average Speed", "42.5 km/h", Icons.speed, successColor),
              _buildMetricTile("On-Time Rate", "94.2%", Icons.schedule, infoColor),
              _buildMetricTile("Fuel Efficiency", "8.2 L/100km", Icons.eco, warningColor),
              _buildMetricTile("Customer Rating", "4.7/5", Icons.star, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Weekly Efficiency Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Route Efficiency Up 15%",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Compared to last week",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildTopRoutes() {
    List<Map<String, dynamic>> topRoutes = [...routes]
      ..sort((a, b) => (b["efficiency"] as int).compareTo(a["efficiency"] as int));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Top Performing Routes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...topRoutes.take(3).map((route) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.route, color: primaryColor, size: 20),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${route["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${route["driver"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${route["efficiency"]}%",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
