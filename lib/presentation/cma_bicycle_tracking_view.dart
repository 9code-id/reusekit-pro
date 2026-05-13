import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaBicycleTrackingView extends StatefulWidget {
  const CmaBicycleTrackingView({super.key});

  @override
  State<CmaBicycleTrackingView> createState() => _CmaBicycleTrackingViewState();
}

class _CmaBicycleTrackingViewState extends State<CmaBicycleTrackingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";
  String selectedLocation = "";
  String bicycleName = "";
  String bicycleModel = "";
  String bicycleType = "";
  String serialNumber = "";
  String location = "";
  String description = "";
  bool isTracking = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Available", "value": "available"},
    {"label": "In Use", "value": "in_use"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Lost", "value": "lost"},
    {"label": "Damaged", "value": "damaged"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Mountain Bike", "value": "mountain"},
    {"label": "Road Bike", "value": "road"},
    {"label": "Hybrid", "value": "hybrid"},
    {"label": "Electric", "value": "electric"},
    {"label": "BMX", "value": "bmx"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": ""},
    {"label": "Downtown Station", "value": "downtown"},
    {"label": "University Campus", "value": "university"},
    {"label": "Park Avenue", "value": "park_avenue"},
    {"label": "Shopping Mall", "value": "mall"},
    {"label": "Train Station", "value": "train_station"},
  ];

  List<Map<String, dynamic>> bicycles = [
    {
      "id": 1,
      "name": "Trek Mountain Pro",
      "model": "Trek 820",
      "type": "Mountain Bike",
      "serialNumber": "TRK820001",
      "status": "Available",
      "location": "Downtown Station",
      "lastSeen": "2024-01-15 14:30",
      "batteryLevel": null,
      "totalDistance": 2540.5,
      "lastRide": "2024-01-14 16:45",
      "maintenanceDate": "2024-01-10",
      "gpsLat": 40.7128,
      "gpsLng": -74.0060,
      "currentUser": null,
      "condition": "Excellent"
    },
    {
      "id": 2,
      "name": "City Cruiser E-Bike",
      "model": "Rad Power RadCity",
      "type": "Electric",
      "serialNumber": "RAD2024001",
      "status": "In Use",
      "location": "University Campus",
      "lastSeen": "2024-01-15 15:45",
      "batteryLevel": 78,
      "totalDistance": 1890.2,
      "lastRide": "2024-01-15 15:45",
      "maintenanceDate": "2024-01-12",
      "gpsLat": 40.7589,
      "gpsLng": -73.9851,
      "currentUser": "John Smith",
      "condition": "Good"
    },
    {
      "id": 3,
      "name": "Speed Demon Road",
      "model": "Giant TCR Advanced",
      "type": "Road Bike",
      "serialNumber": "GNT2024003",
      "status": "Maintenance",
      "location": "Park Avenue",
      "lastSeen": "2024-01-13 09:20",
      "batteryLevel": null,
      "totalDistance": 4250.8,
      "lastRide": "2024-01-13 09:20",
      "maintenanceDate": "2024-01-13",
      "gpsLat": 40.7831,
      "gpsLng": -73.9712,
      "currentUser": null,
      "condition": "Needs Repair"
    },
    {
      "id": 4,
      "name": "Urban Hybrid Plus",
      "model": "Cannondale Quick",
      "type": "Hybrid",
      "serialNumber": "CND2024004",
      "status": "Available",
      "location": "Shopping Mall",
      "lastSeen": "2024-01-15 12:15",
      "batteryLevel": null,
      "totalDistance": 1456.3,
      "lastRide": "2024-01-15 11:30",
      "maintenanceDate": "2024-01-08",
      "gpsLat": 40.7505,
      "gpsLng": -73.9934,
      "currentUser": null,
      "condition": "Good"
    },
  ];

  List<Map<String, dynamic>> activeRides = [
    {
      "id": 1,
      "bicycleId": 2,
      "bicycleName": "City Cruiser E-Bike",
      "user": "John Smith",
      "startTime": "2024-01-15 15:45",
      "startLocation": "University Campus",
      "currentLocation": "Central Park",
      "distance": 3.2,
      "duration": "1h 25m",
      "batteryUsed": 22,
      "speed": 18.5
    },
    {
      "id": 2,
      "bicycleId": 5,
      "bicycleName": "Quick Commuter",
      "user": "Sarah Johnson",
      "startTime": "2024-01-15 16:20",
      "startLocation": "Train Station",
      "currentLocation": "Business District",
      "distance": 2.8,
      "duration": "45m",
      "batteryUsed": null,
      "speed": 22.1
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "ride_ended",
      "bicycleName": "Trek Mountain Pro",
      "user": "Mike Davis",
      "time": "2024-01-15 14:30",
      "location": "Downtown Station",
      "details": "Ride completed - 5.2km in 35 minutes"
    },
    {
      "type": "maintenance",
      "bicycleName": "Speed Demon Road",
      "user": "System",
      "time": "2024-01-15 13:00",
      "location": "Park Avenue",
      "details": "Maintenance required - Brake adjustment needed"
    },
    {
      "type": "ride_started",
      "bicycleName": "City Cruiser E-Bike",
      "user": "John Smith",
      "time": "2024-01-15 15:45",
      "location": "University Campus",
      "details": "New ride started - Battery at 78%"
    },
  ];

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildStatsGrid(),
          _buildActiveRidesSection(),
          _buildBicycleStatusSection(),
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Bicycles", "45", Icons.pedal_bike, primaryColor),
        _buildStatCard("Available", "28", Icons.check_circle, successColor),
        _buildStatCard("In Use", "12", Icons.directions_bike, infoColor),
        _buildStatCard("Maintenance", "3", Icons.build, warningColor),
        _buildStatCard("Active Rides", "12", Icons.navigation, primaryColor),
        _buildStatCard("Total Distance", "15,847 km", Icons.route, successColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRidesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bike,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Active Rides",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${activeRides.length} Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          ...activeRides.map((ride) => _buildActiveRideCard(ride)),
        ],
      ),
    );
  }

  Widget _buildActiveRideCard(Map<String, dynamic> ride) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: infoColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.person_pin_circle,
                  color: infoColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${ride["user"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${ride["bicycleName"]}",
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
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "${ride["duration"]}",
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
          Row(
            spacing: spMd,
            children: [
              _buildRideMetric("Distance", "${ride["distance"]} km", Icons.route),
              _buildRideMetric("Speed", "${ride["speed"]} km/h", Icons.speed),
              if (ride["batteryUsed"] != null)
                _buildRideMetric("Battery", "${ride["batteryUsed"]}% used", Icons.battery_3_bar),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRideMetric(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 16,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
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
        ),
      ),
    );
  }

  Widget _buildBicycleStatusSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.pedal_bike,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Bicycle Status Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatusCard("Available", "28", successColor, Icons.check_circle),
              _buildStatusCard("In Use", "12", infoColor, Icons.directions_bike),
              _buildStatusCard("Maintenance", "3", warningColor, Icons.build),
              _buildStatusCard("Lost/Damaged", "2", dangerColor, Icons.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recentActivity.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color typeColor = _getActivityColor(activity["type"]);
    IconData typeIcon = _getActivityIcon(activity["type"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: typeColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: typeColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${activity["bicycleName"]} - ${activity["user"]}",
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
              ],
            ),
          ),
          Text(
            "${activity["time"].substring(11, 16)}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: typeColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "ride_started":
        return infoColor;
      case "ride_ended":
        return successColor;
      case "maintenance":
        return warningColor;
      case "lost":
      case "damaged":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "ride_started":
        return Icons.play_arrow;
      case "ride_ended":
        return Icons.stop;
      case "maintenance":
        return Icons.build;
      case "lost":
        return Icons.location_off;
      case "damaged":
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildBicycleGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          QTextField(
            label: "Search bicycles",
            value: searchQuery,
            hint: "Enter bicycle name, model, or serial number",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
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
                  label: "Type",
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationOptions,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Add Bicycle",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () => _showAddBicycleDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBicycleGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: bicycles.map((bicycle) => _buildBicycleCard(bicycle)).toList(),
    );
  }

  Widget _buildBicycleCard(Map<String, dynamic> bicycle) {
    Color statusColor = _getBicycleStatusColor(bicycle["status"]);

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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getBicycleIcon(bicycle["type"]),
                  color: statusColor,
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${bicycle["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${bicycle["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${bicycle["model"]} • ${bicycle["type"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Serial: ${bicycle["serialNumber"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontFamily: 'monospace',
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 14,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${bicycle["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          if (bicycle["batteryLevel"] != null)
            Row(
              children: [
                Icon(
                  Icons.battery_charging_full,
                  color: bicycle["batteryLevel"] > 20 ? successColor : dangerColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Text(
                  "${bicycle["batteryLevel"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: bicycle["batteryLevel"] > 20 ? successColor : dangerColor,
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Icon(
                Icons.route,
                color: disabledBoldColor,
                size: 14,
              ),
              SizedBox(width: spXs),
              Text(
                "${(bicycle["totalDistance"] as double).toStringAsFixed(1)} km",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spXs,
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _showBicycleDetails(bicycle),
                ),
              ),
              Expanded(
                child: QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _showEditBicycleDialog(bicycle),
                ),
              ),
              if (bicycle["status"] == "Available")
                Expanded(
                  child: QButton(
                    icon: Icons.location_searching,
                    color: infoColor,
                    size: bs.sm,
                    onPressed: () => _trackBicycle(bicycle),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getBicycleStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "In Use":
        return infoColor;
      case "Maintenance":
        return warningColor;
      case "Lost":
      case "Damaged":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getBicycleIcon(String type) {
    switch (type) {
      case "Mountain Bike":
        return Icons.terrain;
      case "Road Bike":
        return Icons.pedal_bike;
      case "Electric":
        return Icons.electric_bike;
      case "Hybrid":
        return Icons.directions_bike;
      case "BMX":
        return Icons.sports_motorsports;
      default:
        return Icons.pedal_bike;
    }
  }

  void _showAddBicycleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Bicycle"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              QTextField(
                label: "Bicycle Name",
                value: bicycleName,
                onChanged: (value) {
                  bicycleName = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Model",
                      value: bicycleModel,
                      onChanged: (value) {
                        bicycleModel = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Type",
                      items: typeOptions.skip(1).toList(),
                      value: bicycleType,
                      onChanged: (value, label) {
                        bicycleType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Serial Number",
                value: serialNumber,
                onChanged: (value) {
                  serialNumber = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Initial Location",
                items: locationOptions.skip(1).toList(),
                value: location,
                onChanged: (value, label) {
                  location = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: description,
                hint: "Additional details about the bicycle",
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Bicycle",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Bicycle added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showBicycleDetails(Map<String, dynamic> bicycle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bicycle Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "${bicycle["name"]}",
                style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
              ),
              Text("${bicycle["model"]} • ${bicycle["type"]}"),
              Divider(),
              _buildDetailRow("Serial Number", "${bicycle["serialNumber"]}"),
              _buildDetailRow("Status", "${bicycle["status"]}"),
              _buildDetailRow("Location", "${bicycle["location"]}"),
              _buildDetailRow("Condition", "${bicycle["condition"]}"),
              _buildDetailRow("Total Distance", "${(bicycle["totalDistance"] as double).toStringAsFixed(1)} km"),
              _buildDetailRow("Last Ride", "${bicycle["lastRide"]}"),
              _buildDetailRow("Last Maintenance", "${bicycle["maintenanceDate"]}"),
              if (bicycle["batteryLevel"] != null)
                _buildDetailRow("Battery Level", "${bicycle["batteryLevel"]}%"),
              if (bicycle["currentUser"] != null)
                _buildDetailRow("Current User", "${bicycle["currentUser"]}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Track Location",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _trackBicycle(bicycle);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(": "),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
    );
  }

  void _showEditBicycleDialog(Map<String, dynamic> bicycle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Bicycle"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Text(
                "Editing ${bicycle["name"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions.skip(1).toList(),
                value: bicycle["status"].toLowerCase().replaceAll(" ", "_"),
                onChanged: (value, label) {},
              ),
              QDropdownField(
                label: "Location",
                items: locationOptions.skip(1).toList(),
                value: bicycle["location"].toLowerCase().replaceAll(" ", "_"),
                onChanged: (value, label) {},
              ),
              QMemoField(
                label: "Notes",
                value: "",
                hint: "Add maintenance notes or updates",
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Bicycle",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Bicycle updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _trackBicycle(Map<String, dynamic> bicycle) {
    ss("Tracking ${bicycle["name"]} - GPS coordinates: ${bicycle["gpsLat"]}, ${bicycle["gpsLng"]}");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Bicycle Tracking System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Bicycle Management", icon: Icon(Icons.pedal_bike)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManagementTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
