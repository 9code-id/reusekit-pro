import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRfidTrackingView extends StatefulWidget {
  const LtaRfidTrackingView({super.key});

  @override
  State<LtaRfidTrackingView> createState() => _LtaRfidTrackingViewState();
}

class _LtaRfidTrackingViewState extends State<LtaRfidTrackingView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedZone = "";
  bool isRfidReaderActive = false;
  int currentTab = 0;
  
  // Sample RFID tracking data
  List<Map<String, dynamic>> rfidTags = [
    {
      "id": "RFID-001",
      "tagId": "RF7F8A9B2C3D",
      "itemName": "High-Value Electronics Package",
      "orderId": "ORD-2024-001",
      "currentLocation": "Warehouse Zone A",
      "lastScanned": "2024-01-15 14:30:00",
      "status": "active",
      "batteryLevel": 85,
      "temperature": 22.5,
      "humidity": 45,
      "signalStrength": 92,
      "movementHistory": [
        {"location": "Loading Dock 1", "timestamp": "08:00"},
        {"location": "Security Check", "timestamp": "08:15"},
        {"location": "Warehouse Zone A", "timestamp": "08:30"},
      ],
      "alertsCount": 0,
      "customerName": "TechCorp Solutions"
    },
    {
      "id": "RFID-002",
      "tagId": "RF1E2F3G4H5I",
      "itemName": "Medical Equipment Shipment",
      "orderId": "ORD-2024-002",
      "currentLocation": "Cold Storage Zone",
      "lastScanned": "2024-01-15 13:45:00",
      "status": "warning",
      "batteryLevel": 15,
      "temperature": 4.2,
      "humidity": 60,
      "signalStrength": 78,
      "movementHistory": [
        {"location": "Receiving Dock", "timestamp": "07:00"},
        {"location": "Quality Control", "timestamp": "07:30"},
        {"location": "Cold Storage Zone", "timestamp": "08:00"},
      ],
      "alertsCount": 2,
      "customerName": "MediCare Systems"
    },
    {
      "id": "RFID-003",
      "tagId": "RF6J7K8L9M0N",
      "itemName": "Automotive Parts Container",
      "orderId": "ORD-2024-003",
      "currentLocation": "Loading Dock 3",
      "lastScanned": "2024-01-15 15:00:00",
      "status": "active",
      "batteryLevel": 67,
      "temperature": 25.1,
      "humidity": 40,
      "signalStrength": 88,
      "movementHistory": [
        {"location": "Warehouse Zone B", "timestamp": "09:00"},
        {"location": "Picking Area", "timestamp": "11:30"},
        {"location": "Loading Dock 3", "timestamp": "14:45"},
      ],
      "alertsCount": 0,
      "customerName": "AutoParts Express"
    },
    {
      "id": "RFID-004",
      "tagId": "RF2P3Q4R5S6T",
      "itemName": "Fragile Glassware Set",
      "orderId": "ORD-2024-004",
      "currentLocation": "Unknown",
      "lastScanned": "2024-01-15 10:20:00",
      "status": "lost",
      "batteryLevel": 0,
      "temperature": 0,
      "humidity": 0,
      "signalStrength": 0,
      "movementHistory": [
        {"location": "Fragile Items Zone", "timestamp": "06:00"},
        {"location": "Quality Check", "timestamp": "08:00"},
        {"location": "Unknown", "timestamp": "10:20"},
      ],
      "alertsCount": 5,
      "customerName": "Crystal Collections"
    },
    {
      "id": "RFID-005",
      "tagId": "RF7U8V9W0X1Y",
      "itemName": "Chemical Supplies Batch",
      "orderId": "ORD-2024-005",
      "currentLocation": "Hazmat Storage",
      "lastScanned": "2024-01-15 14:15:00",
      "status": "critical",
      "batteryLevel": 92,
      "temperature": 18.5,
      "humidity": 30,
      "signalStrength": 95,
      "movementHistory": [
        {"location": "Receiving Area", "timestamp": "05:00"},
        {"location": "Safety Inspection", "timestamp": "06:00"},
        {"location": "Hazmat Storage", "timestamp": "07:00"},
      ],
      "alertsCount": 1,
      "customerName": "ChemLab Industries"
    }
  ];

  // Zone coverage data
  List<Map<String, dynamic>> zoneData = [
    {
      "zone": "Warehouse Zone A",
      "activeTagsCount": 15,
      "totalCapacity": 25,
      "signalStrength": 94,
      "lastUpdate": "14:30"
    },
    {
      "zone": "Warehouse Zone B", 
      "activeTagsCount": 8,
      "totalCapacity": 20,
      "signalStrength": 87,
      "lastUpdate": "14:28"
    },
    {
      "zone": "Cold Storage Zone",
      "activeTagsCount": 12,
      "totalCapacity": 15,
      "signalStrength": 91,
      "lastUpdate": "14:32"
    },
    {
      "zone": "Loading Docks",
      "activeTagsCount": 6,
      "totalCapacity": 10,
      "signalStrength": 89,
      "lastUpdate": "14:35"
    }
  ];

  List<Map<String, dynamic>> get filteredTags {
    return rfidTags.where((tag) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${tag["tagId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${tag["itemName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${tag["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${tag["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus.isEmpty || tag["status"] == selectedStatus;
      bool matchesZone = selectedZone.isEmpty || "${tag["currentLocation"]}".contains(selectedZone);

      return matchesSearch && matchesStatus && matchesZone;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "warning":
        return warningColor;
      case "critical":
        return dangerColor;
      case "lost":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.radio_button_checked;
      case "warning":
        return Icons.warning;
      case "critical":
        return Icons.priority_high;
      case "lost":
        return Icons.signal_wifi_off;
      default:
        return Icons.help;
    }
  }

  void _toggleRfidReader() {
    setState(() {
      isRfidReaderActive = !isRfidReaderActive;
    });
    
    if (isRfidReaderActive) {
      // Simulate RFID reading
      Future.delayed(Duration(seconds: 3), () {
        if (mounted && isRfidReaderActive) {
          setState(() {
            isRfidReaderActive = false;
          });
          ss("RFID scan completed - 3 tags detected");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RFID Tracking System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Tag Tracking", icon: Icon(Icons.nfc)),
        Tab(text: "Zone Coverage", icon: Icon(Icons.map)),
      ],
      tabChildren: [
        _buildTagTrackingTab(),
        _buildZoneCoverageTab(),
      ],
    );
  }

  Widget _buildTagTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RFID Reader Control
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  isRfidReaderActive ? Icons.nfc : Icons.nfc_outlined,
                  size: 48,
                  color: isRfidReaderActive ? primaryColor : disabledBoldColor,
                ),
                SizedBox(height: spSm),
                Text(
                  isRfidReaderActive ? "RFID Reader Active" : "RFID Reader Standby",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isRfidReaderActive ? "Stop Scanning" : "Start Scanning",
                    size: bs.md,
                    onPressed: _toggleRfidReader,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search tags, items, orders...",
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
                  label: "Filter by Status",
                  items: [
                    {"label": "All Status", "value": ""},
                    {"label": "Active", "value": "active"},
                    {"label": "Warning", "value": "warning"},
                    {"label": "Critical", "value": "critical"},
                    {"label": "Lost", "value": "lost"},
                  ],
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
                  label: "Filter by Zone",
                  items: [
                    {"label": "All Zones", "value": ""},
                    {"label": "Warehouse A", "value": "Zone A"},
                    {"label": "Warehouse B", "value": "Zone B"},
                    {"label": "Cold Storage", "value": "Cold Storage"},
                    {"label": "Loading Docks", "value": "Loading Dock"},
                  ],
                  value: selectedZone,
                  onChanged: (value, label) {
                    selectedZone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Summary Cards
          Row(
            children: [
              _buildSummaryCard(
                "Total Tags", 
                "${rfidTags.length}", 
                Icons.nfc, 
                primaryColor
              ),
              SizedBox(width: spSm),
              _buildSummaryCard(
                "Active", 
                "${rfidTags.where((t) => t["status"] == "active").length}", 
                Icons.radio_button_checked, 
                successColor
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildSummaryCard(
                "Warnings", 
                "${rfidTags.where((t) => t["status"] == "warning").length}", 
                Icons.warning, 
                warningColor
              ),
              SizedBox(width: spSm),
              _buildSummaryCard(
                "Lost/Critical", 
                "${rfidTags.where((t) => t["status"] == "lost" || t["status"] == "critical").length}", 
                Icons.error, 
                dangerColor
              ),
            ],
          ),
          SizedBox(height: spLg),

          // RFID Tags List
          Text(
            "RFID Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...filteredTags.map((tag) => _buildTagCard(tag)).toList(),
        ],
      ),
    );
  }

  Widget _buildZoneCoverageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Zone Coverage Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...zoneData.map((zone) => _buildZoneCard(zone)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
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
      ),
    );
  }

  Widget _buildTagCard(Map<String, dynamic> tag) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: getStatusColor("${tag["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                getStatusIcon("${tag["status"]}"),
                color: getStatusColor("${tag["status"]}"),
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${tag["itemName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if ((tag["alertsCount"] as int) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${tag["alertsCount"]} Alert${(tag["alertsCount"] as int) > 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.nfc, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "Tag ID: ${tag["tagId"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order: ${tag["orderId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Customer: ${tag["customerName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${tag["currentLocation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.battery_full, size: 16, color: 
                           (tag["batteryLevel"] as int) > 50 ? successColor : 
                           (tag["batteryLevel"] as int) > 20 ? warningColor : dangerColor),
                      Text(
                        "${tag["batteryLevel"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 16, color: primaryColor),
                      Text(
                        "${tag["signalStrength"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          if (tag["status"] != "lost") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Temperature",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(tag["temperature"] as double).toStringAsFixed(1)}°C",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Humidity",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tag["humidity"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor("${tag["status"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${tag["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor("${tag["status"]}"),
                  ),
                ),
              ),
              Spacer(),
              QButton(
                label: "Track History",
                size: bs.sm,
                onPressed: () {
                  _showTrackingHistory(tag);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Handle more options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    double utilizationRate = (zone["activeTagsCount"] as int) / (zone["totalCapacity"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${zone["zone"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "Updated: ${zone["lastUpdate"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Tags: ${zone["activeTagsCount"]}/${zone["totalCapacity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: utilizationRate,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        utilizationRate > 0.8 ? dangerColor :
                        utilizationRate > 0.6 ? warningColor : successColor
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(utilizationRate * 100).toInt()}% Utilization",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 16, color: primaryColor),
                      Text(
                        " ${zone["signalStrength"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Signal Strength",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTrackingHistory(Map<String, dynamic> tag) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Movement History"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${tag["itemName"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text("Tag ID: ${tag["tagId"]}"),
              SizedBox(height: spSm),
              ...((tag["movementHistory"] as List).map((movement) => 
                Container(
                  padding: EdgeInsets.all(spXs),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${movement["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${movement["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ).toList()),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
