import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTemperatureMonitoringView extends StatefulWidget {
  const RfsTemperatureMonitoringView({super.key});

  @override
  State<RfsTemperatureMonitoringView> createState() => _RfsTemperatureMonitoringViewState();
}

class _RfsTemperatureMonitoringViewState extends State<RfsTemperatureMonitoringView> {
  String searchQuery = "";
  String selectedZone = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All", "value": "All"},
    {"label": "Kitchen", "value": "Kitchen"},
    {"label": "Cold Storage", "value": "Cold Storage"},
    {"label": "Serving Area", "value": "Serving Area"},
    {"label": "Pantry", "value": "Pantry"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Warning", "value": "Warning"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Offline", "value": "Offline"},
  ];

  List<Map<String, dynamic>> temperatureData = [
    {
      "id": "TM001",
      "sensorName": "Main Refrigerator",
      "zone": "Cold Storage",
      "currentTemp": 38,
      "targetTemp": 40,
      "minTemp": 32,
      "maxTemp": 45,
      "status": "Normal",
      "lastUpdate": "2025-06-19T14:55:00",
      "batteryLevel": 85,
      "trend": "stable",
      "alertCount": 0,
      "history": [36, 37, 38, 39, 38, 37, 38],
      "location": "Section A"
    },
    {
      "id": "TM002",
      "sensorName": "Freezer Unit 1",
      "zone": "Cold Storage",
      "currentTemp": 8,
      "targetTemp": 0,
      "minTemp": -5,
      "maxTemp": 5,
      "status": "Warning",
      "lastUpdate": "2025-06-19T14:54:00",
      "batteryLevel": 65,
      "trend": "rising",
      "alertCount": 2,
      "history": [0, 2, 4, 6, 7, 8, 8],
      "location": "Section B"
    },
    {
      "id": "TM003",
      "sensorName": "Grill Station",
      "zone": "Kitchen",
      "currentTemp": 185,
      "targetTemp": 180,
      "minTemp": 170,
      "maxTemp": 190,
      "status": "Normal",
      "lastUpdate": "2025-06-19T14:55:00",
      "batteryLevel": 92,
      "trend": "stable",
      "alertCount": 0,
      "history": [178, 180, 182, 185, 184, 185, 185],
      "location": "Station 1"
    },
    {
      "id": "TM004",
      "sensorName": "Food Warmer",
      "zone": "Serving Area",
      "currentTemp": 155,
      "targetTemp": 160,
      "minTemp": 150,
      "maxTemp": 170,
      "status": "Warning",
      "lastUpdate": "2025-06-19T14:53:00",
      "batteryLevel": 78,
      "trend": "falling",
      "alertCount": 1,
      "history": [162, 160, 158, 157, 155, 154, 155],
      "location": "Counter 2"
    },
    {
      "id": "TM005",
      "sensorName": "Dry Storage",
      "zone": "Pantry",
      "currentTemp": 72,
      "targetTemp": 70,
      "minTemp": 65,
      "maxTemp": 75,
      "status": "Normal",
      "lastUpdate": "2025-06-19T14:55:00",
      "batteryLevel": 88,
      "trend": "stable",
      "alertCount": 0,
      "history": [70, 71, 72, 71, 70, 72, 72],
      "location": "Room A"
    },
    {
      "id": "TM006",
      "sensorName": "Oven Thermometer",
      "zone": "Kitchen",
      "currentTemp": 0,
      "targetTemp": 350,
      "minTemp": 300,
      "maxTemp": 400,
      "status": "Offline",
      "lastUpdate": "2025-06-19T13:30:00",
      "batteryLevel": 12,
      "trend": "offline",
      "alertCount": 5,
      "history": [350, 352, 0, 0, 0, 0, 0],
      "location": "Station 3"
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    return temperatureData.where((data) {
      bool matchesSearch = "${data["sensorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${data["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesZone = selectedZone == "All" || data["zone"] == selectedZone;
      bool matchesStatus = selectedStatus == "All" || data["status"] == selectedStatus;
      
      return matchesSearch && matchesZone && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Normal": return successColor;
      case "Warning": return warningColor;
      case "Critical": return dangerColor;
      case "Offline": return disabledColor;
      default: return disabledColor;
    }
  }

  Color getTrendColor(String trend) {
    switch (trend) {
      case "rising": return dangerColor;
      case "falling": return warningColor;
      case "stable": return successColor;
      case "offline": return disabledColor;
      default: return disabledColor;
    }
  }

  IconData getTrendIcon(String trend) {
    switch (trend) {
      case "rising": return Icons.trending_up;
      case "falling": return Icons.trending_down;
      case "stable": return Icons.trending_flat;
      case "offline": return Icons.signal_wifi_off;
      default: return Icons.trending_flat;
    }
  }

  bool isTemperatureInRange(Map<String, dynamic> sensor) {
    int currentTemp = sensor["currentTemp"] as int;
    int minTemp = sensor["minTemp"] as int;
    int maxTemp = sensor["maxTemp"] as int;
    return currentTemp >= minTemp && currentTemp <= maxTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Monitoring"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Sensors",
                    value: searchQuery,
                    hint: "Search by sensor name or ID...",
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Zone",
                    items: zoneOptions,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
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

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${temperatureData.where((data) => data["status"] == "Normal").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Normal",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${temperatureData.where((data) => data["status"] == "Warning").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Warning",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${temperatureData.where((data) => data["status"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Critical",
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

            // Temperature Sensors List
            ...filteredData.map((sensor) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getStatusColor("${sensor["status"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: getStatusColor("${sensor["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: getStatusColor("${sensor["status"]}").withAlpha(100),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thermostat,
                                    color: getStatusColor("${sensor["status"]}"),
                                    size: 20,
                                  ),
                                  Text(
                                    "${sensor["currentTemp"]}°",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: getStatusColor("${sensor["status"]}"),
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
                                      Expanded(
                                        child: Text(
                                          "${sensor["sensorName"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: getStatusColor("${sensor["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          border: Border.all(
                                            color: getStatusColor("${sensor["status"]}").withAlpha(100),
                                          ),
                                        ),
                                        child: Text(
                                          "${sensor["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: getStatusColor("${sensor["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "ID: ${sensor["id"]} • ${sensor["zone"]} • ${sensor["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        getTrendIcon("${sensor["trend"]}"),
                                        size: 14,
                                        color: getTrendColor("${sensor["trend"]}"),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${sensor["trend"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: getTrendColor("${sensor["trend"]}"),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(Icons.battery_std, size: 14, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${sensor["batteryLevel"]}%",
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
                          ],
                        ),

                        SizedBox(height: spSm),

                        // Temperature Range Display
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Min",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${sensor["minTemp"]}°F",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Target",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${sensor["targetTemp"]}°F",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Max",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${sensor["maxTemp"]}°F",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Current",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${sensor["currentTemp"]}°F",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isTemperatureInRange(sensor) ? successColor : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        if ((sensor["alertCount"] as int) > 0) ...[
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: dangerColor.withAlpha(50)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.warning, color: dangerColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${sensor["alertCount"]} alert(s) in the last 24 hours",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Last Update: ${DateTime.parse("${sensor["lastUpdate"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "History",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Settings",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
