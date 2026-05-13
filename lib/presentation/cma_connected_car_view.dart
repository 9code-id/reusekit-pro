import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaConnectedCarView extends StatefulWidget {
  const CmaConnectedCarView({super.key});

  @override
  State<CmaConnectedCarView> createState() => _CmaConnectedCarViewState();
}

class _CmaConnectedCarViewState extends State<CmaConnectedCarView> {
  String selectedVehicle = "VH001";
  bool wifiConnected = true;
  bool bluetoothConnected = true;
  bool cellularConnected = true;
  String wifiSignal = "Excellent";
  String dataUsage = "2.3";
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "label": "Honda Civic - ABC123",
      "value": "VH001",
    },
    {
      "id": "VH002", 
      "label": "Toyota Camry - XYZ789",
      "value": "VH002",
    },
    {
      "id": "VH003",
      "label": "BMW X5 - DEF456", 
      "value": "VH003",
    }
  ];

  List<Map<String, dynamic>> connectedDevices = [
    {
      "name": "iPhone 15 Pro",
      "type": "Phone",
      "connection": "Bluetooth",
      "status": "Connected",
      "battery": 87,
      "lastConnected": "2024-06-19 14:30"
    },
    {
      "name": "Samsung Galaxy Buds",
      "type": "Audio",
      "connection": "Bluetooth", 
      "status": "Connected",
      "battery": 65,
      "lastConnected": "2024-06-19 14:25"
    },
    {
      "name": "Apple Watch Series 9",
      "type": "Wearable",
      "connection": "Bluetooth",
      "status": "Disconnected",
      "battery": 42,
      "lastConnected": "2024-06-19 12:15"
    },
    {
      "name": "Garmin DashCam",
      "type": "Camera",
      "connection": "WiFi",
      "status": "Connected", 
      "battery": null,
      "lastConnected": "2024-06-19 14:30"
    }
  ];

  List<Map<String, dynamic>> availableNetworks = [
    {
      "name": "CarWiFi_ABC123",
      "type": "Vehicle Hotspot",
      "signal": "Excellent",
      "secured": true,
      "connected": true
    },
    {
      "name": "Starbucks_WiFi",
      "type": "Public WiFi",
      "signal": "Good",
      "secured": false,
      "connected": false
    },
    {
      "name": "HomeNetwork_5G",
      "type": "Home WiFi", 
      "signal": "Weak",
      "secured": true,
      "connected": false
    },
    {
      "name": "ATT_4G_LTE",
      "type": "Cellular",
      "signal": "Excellent",
      "secured": true,
      "connected": true
    }
  ];

  List<Map<String, dynamic>> appServices = [
    {
      "name": "Spotify",
      "category": "Music",
      "status": "Active",
      "dataUsed": "245 MB",
      "icon": Icons.music_note
    },
    {
      "name": "Google Maps",
      "category": "Navigation", 
      "status": "Active",
      "dataUsed": "180 MB",
      "icon": Icons.map
    },
    {
      "name": "Android Auto",
      "category": "Integration",
      "status": "Connected",
      "dataUsed": "95 MB",
      "icon": Icons.phone_android
    },
    {
      "name": "Weather App",
      "category": "Information",
      "status": "Background",
      "dataUsed": "12 MB", 
      "icon": Icons.cloud
    },
    {
      "name": "Tesla App",
      "category": "Vehicle Control",
      "status": "Standby",
      "dataUsed": "8 MB",
      "icon": Icons.electric_car
    }
  ];

  List<Map<String, dynamic>> connectionHistory = [
    {
      "timestamp": "2024-06-19 14:30",
      "device": "iPhone 15 Pro",
      "action": "Connected",
      "type": "Bluetooth"
    },
    {
      "timestamp": "2024-06-19 14:25",
      "device": "Samsung Galaxy Buds",
      "action": "Connected", 
      "type": "Bluetooth"
    },
    {
      "timestamp": "2024-06-19 12:15",
      "device": "Apple Watch Series 9", 
      "action": "Disconnected",
      "type": "Bluetooth"
    },
    {
      "timestamp": "2024-06-19 10:45",
      "device": "CarWiFi_ABC123",
      "action": "Network Connected",
      "type": "WiFi"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connected Car"),
        actions: [
          IconButton(
            icon: Icon(Icons.wifi_find),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Vehicle Selection
            Container(
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
                      Icon(Icons.directions_car, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Vehicle Selection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Select Vehicle",
                    items: vehicles,
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Connection Status Overview
            Container(
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
                      Icon(Icons.signal_cellular_alt, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Connection Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: wifiConnected ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: wifiConnected ? successColor.withAlpha(30) : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wifi,
                                color: wifiConnected ? successColor : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "WiFi",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                wifiConnected ? wifiSignal : "Disconnected",
                                style: TextStyle(
                                  color: wifiConnected ? successColor : disabledBoldColor,
                                  fontSize: 10,
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
                            color: bluetoothConnected ? infoColor.withAlpha(10) : disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: bluetoothConnected ? infoColor.withAlpha(30) : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.bluetooth,
                                color: bluetoothConnected ? infoColor : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Bluetooth",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                bluetoothConnected ? "2 Devices" : "Off",
                                style: TextStyle(
                                  color: bluetoothConnected ? infoColor : disabledBoldColor,
                                  fontSize: 10,
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
                            color: cellularConnected ? warningColor.withAlpha(10) : disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: cellularConnected ? warningColor.withAlpha(30) : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.signal_cellular_4_bar,
                                color: cellularConnected ? warningColor : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Cellular",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                cellularConnected ? "4G LTE" : "No Signal",
                                style: TextStyle(
                                  color: cellularConnected ? warningColor : disabledBoldColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data Usage (This Month)",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${dataUsage} GB",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Connected Devices
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.devices, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Connected Devices",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ...connectedDevices.map((device) {
                    Color statusColor = device["status"] == "Connected" ? successColor : disabledBoldColor;
                    Color connectionColor = device["connection"] == "Bluetooth" ? infoColor : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: connectionColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              device["connection"] == "Bluetooth" ? Icons.bluetooth : Icons.wifi,
                              color: connectionColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${device["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${device["status"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${device["type"]} • ${device["connection"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    if (device["battery"] != null)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.battery_full,
                                            color: device["battery"] > 20 ? successColor : dangerColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${device["battery"]}%",
                                            style: TextStyle(
                                              color: device["battery"] > 20 ? successColor : dangerColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Last: ${device["lastConnected"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Available Networks
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.network_wifi, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Available Networks",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      QButton(
                        icon: Icons.refresh,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ...availableNetworks.map((network) {
                    Color signalColor = successColor;
                    if (network["signal"] == "Good") signalColor = warningColor;
                    if (network["signal"] == "Weak") signalColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: network["connected"] ? successColor.withAlpha(10) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: network["connected"] ? successColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            network["type"] == "Cellular" ? Icons.signal_cellular_4_bar : Icons.wifi,
                            color: network["connected"] ? successColor : signalColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${network["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (network["secured"])
                                          Icon(
                                            Icons.lock,
                                            color: disabledBoldColor,
                                            size: 14,
                                          ),
                                        if (network["connected"])
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "Connected",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${network["type"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Signal: ${network["signal"]}",
                                      style: TextStyle(
                                        color: signalColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (!network["connected"])
                            QButton(
                              icon: Icons.link,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Connected Apps & Services
            Container(
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
                      Icon(Icons.apps, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Connected Apps & Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...appServices.map((app) {
                    Color statusColor = successColor;
                    if (app["status"] == "Background") statusColor = warningColor;
                    if (app["status"] == "Standby") statusColor = disabledBoldColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              app["icon"] as IconData,
                              color: statusColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${app["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${app["status"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${app["category"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Data: ${app["dataUsed"]}",
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Connection History
            Container(
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
                      Icon(Icons.history, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Connection History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...connectionHistory.take(4).map((event) {
                    Color actionColor = event["action"] == "Connected" ? successColor : warningColor;
                    Color typeColor = event["type"] == "Bluetooth" ? infoColor : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: actionColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: actionColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: actionColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${event["device"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: typeColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${event["type"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${event["timestamp"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "${event["action"]}",
                                      style: TextStyle(
                                        color: actionColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Scan Devices",
                    icon: Icons.search,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Network Settings",
                    icon: Icons.settings,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
