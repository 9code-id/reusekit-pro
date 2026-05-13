import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaMobileScannerView extends StatefulWidget {
  const ImaMobileScannerView({super.key});

  @override
  State<ImaMobileScannerView> createState() => _ImaMobileScannerViewState();
}

class _ImaMobileScannerViewState extends State<ImaMobileScannerView> {
  String searchQuery = "";
  String selectedDevice = "All";
  String selectedApp = "All";
  String selectedStatus = "All";
  String selectedLocation = "All";
  bool isConnected = true;
  String scanMode = "Barcode";
  int totalScansToday = 0;

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "All Devices", "value": "All"},
    {"label": "iPhone 13 Pro", "value": "iPhone 13 Pro"},
    {"label": "Samsung Galaxy S23", "value": "Samsung Galaxy S23"},
    {"label": "iPad Pro 11\"", "value": "iPad Pro 11\""},
    {"label": "Xiaomi 12T Pro", "value": "Xiaomi 12T Pro"},
  ];

  List<Map<String, dynamic>> appOptions = [
    {"label": "All Apps", "value": "All"},
    {"label": "Inventory Scanner", "value": "Inventory Scanner"},
    {"label": "Warehouse Pro", "value": "Warehouse Pro"},
    {"label": "QR Master", "value": "QR Master"},
    {"label": "Barcode Expert", "value": "Barcode Expert"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Online", "value": "Online"},
    {"label": "Offline", "value": "Offline"},
    {"label": "Scanning", "value": "Scanning"},
    {"label": "Idle", "value": "Idle"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Warehouse B", "value": "Warehouse B"},
    {"label": "Store Front", "value": "Store Front"},
    {"label": "Loading Dock", "value": "Loading Dock"},
  ];

  List<Map<String, dynamic>> mobileDevices = [
    {
      "id": "MOB001",
      "deviceName": "iPhone 13 Pro",
      "userName": "John Smith",
      "userRole": "Warehouse Manager",
      "appName": "Inventory Scanner",
      "appVersion": "v2.1.3",
      "location": "Warehouse A",
      "status": "Scanning",
      "lastScan": "30 seconds ago",
      "batteryLevel": 78,
      "scansToday": 156,
      "accuracy": 98.5,
      "networkSignal": "Excellent",
      "gpsEnabled": true,
      "cameraPermission": true,
      "connectionType": "WiFi",
      "lastSync": "2 minutes ago",
      "assignedArea": "Section A1-A5",
    },
    {
      "id": "MOB002",
      "deviceName": "Samsung Galaxy S23",
      "userName": "Sarah Johnson",
      "userRole": "Stock Clerk",
      "appName": "Warehouse Pro",
      "appVersion": "v1.8.7",
      "location": "Store Front",
      "status": "Online",
      "lastScan": "5 minutes ago",
      "batteryLevel": 65,
      "scansToday": 89,
      "accuracy": 96.2,
      "networkSignal": "Good",
      "gpsEnabled": true,
      "cameraPermission": true,
      "connectionType": "4G",
      "lastSync": "1 minute ago",
      "assignedArea": "Retail Floor",
    },
    {
      "id": "MOB003",
      "deviceName": "iPad Pro 11\"",
      "userName": "Mike Wilson",
      "userRole": "Inventory Supervisor",
      "appName": "QR Master",
      "appVersion": "v3.0.1",
      "location": "Loading Dock",
      "status": "Idle",
      "lastScan": "15 minutes ago",
      "batteryLevel": 42,
      "scansToday": 234,
      "accuracy": 99.1,
      "networkSignal": "Strong",
      "gpsEnabled": true,
      "cameraPermission": true,
      "connectionType": "WiFi",
      "lastSync": "30 seconds ago",
      "assignedArea": "Receiving Bay",
    },
    {
      "id": "MOB004",
      "deviceName": "Xiaomi 12T Pro",
      "userName": "Lisa Chen",
      "userRole": "Quality Inspector",
      "appName": "Barcode Expert",
      "appVersion": "v2.5.4",
      "location": "Warehouse B",
      "status": "Offline",
      "lastScan": "2 hours ago",
      "batteryLevel": 15,
      "scansToday": 67,
      "accuracy": 94.8,
      "networkSignal": "Weak",
      "gpsEnabled": false,
      "cameraPermission": true,
      "connectionType": "4G",
      "lastSync": "45 minutes ago",
      "assignedArea": "Section B1-B3",
    },
    {
      "id": "MOB005",
      "deviceName": "iPhone 13 Pro",
      "userName": "David Brown",
      "userRole": "Shift Lead",
      "appName": "Inventory Scanner",
      "appVersion": "v2.1.3",
      "location": "Warehouse A",
      "status": "Scanning",
      "lastScan": "1 minute ago",
      "batteryLevel": 89,
      "scansToday": 198,
      "accuracy": 97.9,
      "networkSignal": "Excellent",
      "gpsEnabled": true,
      "cameraPermission": true,
      "connectionType": "WiFi",
      "lastSync": "15 seconds ago",
      "assignedArea": "Section A6-A10",
    },
    {
      "id": "MOB006",
      "deviceName": "Samsung Galaxy S23",
      "userName": "Emma Davis",
      "userRole": "Stock Clerk",
      "appName": "Warehouse Pro",
      "appVersion": "v1.8.7",
      "location": "Store Front",
      "status": "Online",
      "lastScan": "8 minutes ago",
      "batteryLevel": 55,
      "scansToday": 123,
      "accuracy": 95.7,
      "networkSignal": "Good",
      "gpsEnabled": true,
      "cameraPermission": true,
      "connectionType": "WiFi",
      "lastSync": "3 minutes ago",
      "assignedArea": "Customer Service",
    },
  ];

  List<Map<String, dynamic>> get filteredDevices {
    return mobileDevices.where((device) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${device["deviceName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${device["userName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${device["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${device["appName"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDevice = selectedDevice == "All" || "${device["deviceName"]}" == selectedDevice;
      bool matchesApp = selectedApp == "All" || "${device["appName"]}" == selectedApp;
      bool matchesStatus = selectedStatus == "All" || "${device["status"]}" == selectedStatus;
      bool matchesLocation = selectedLocation == "All" || "${device["location"]}" == selectedLocation;
      
      return matchesSearch && matchesDevice && matchesApp && matchesStatus && matchesLocation;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scanning":
        return successColor;
      case "Online":
        return infoColor;
      case "Idle":
        return warningColor;
      case "Offline":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSignalColor(String signal) {
    switch (signal) {
      case "Excellent":
      case "Strong":
        return successColor;
      case "Good":
        return infoColor;
      case "Weak":
        return warningColor;
      default:
        return dangerColor;
    }
  }

  void _showDeviceActions(Map<String, dynamic> device) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${device["deviceName"]} - ${device["userName"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildActionItem(Icons.message, "Send Message", () {}),
            _buildActionItem(Icons.location_on, "View Location", () {}),
            _buildActionItem(Icons.sync, "Force Sync", () {}),
            _buildActionItem(Icons.restart_alt, "Restart App", () {}),
            _buildActionItem(Icons.settings, "Remote Settings", () {}),
            _buildActionItem(Icons.analytics, "View Analytics", () {}),
            _buildActionItem(Icons.history, "Scan History", () {}),
            _buildActionItem(Icons.assignment, "Assign Task", () {}),
            _buildActionItem(Icons.notifications, "Send Alert", () {}),
            _buildActionItem(Icons.block, "Disable Device", () {}, color: dangerColor),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? primaryColor,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: color ?? primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        back();
        onTap();
      },
    );
  }

  Widget _buildSummaryCard() {
    int totalDevices = mobileDevices.length;
    int onlineDevices = mobileDevices.where((d) => d["status"] == "Online" || d["status"] == "Scanning").length;
    int offlineDevices = mobileDevices.where((d) => d["status"] == "Offline").length;
    int totalScans = mobileDevices.fold(0, (sum, d) => sum + (d["scansToday"] as int));

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
          Text(
            "Mobile Device Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem("Total Devices", "$totalDevices", Icons.phone_android, primaryColor),
              ),
              Expanded(
                child: _buildMetricItem("Online", "$onlineDevices", Icons.check_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem("Offline", "$offlineDevices", Icons.error, dangerColor),
              ),
              Expanded(
                child: _buildMetricItem("Total Scans", "$totalScans", Icons.qr_code_scanner, infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    Color statusColor = _getStatusColor("${device["status"]}");
    Color signalColor = _getSignalColor("${device["networkSignal"]}");
    int batteryLevel = device["batteryLevel"] as int;
    Color batteryColor = batteryLevel > 50 ? successColor : batteryLevel > 20 ? warningColor : dangerColor;
    double accuracy = device["accuracy"] as double;
    Color accuracyColor = accuracy > 95 ? successColor : accuracy > 90 ? warningColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${device["deviceName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${device["userName"]} • ${device["userRole"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${device["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildInfoChip(Icons.apps, "${device["appName"]}", primaryColor),
              SizedBox(width: spSm),
              _buildInfoChip(Icons.location_on, "${device["location"]}", infoColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Scans", "${device["scansToday"]}", Icons.qr_code_scanner),
              ),
              Expanded(
                child: _buildStatItem("Battery", "$batteryLevel%", Icons.battery_full, color: batteryColor),
              ),
              Expanded(
                child: _buildStatItem("Accuracy", "${accuracy.toStringAsFixed(1)}%", Icons.precision_manufacturing, color: accuracyColor),
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
                    Row(
                      children: [
                        Icon(
                          device["gpsEnabled"] ? Icons.gps_fixed : Icons.gps_off,
                          size: 14,
                          color: device["gpsEnabled"] ? successColor : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "GPS ${device["gpsEnabled"] ? "Enabled" : "Disabled"}",
                          style: TextStyle(
                            fontSize: 12,
                            color: device["gpsEnabled"] ? successColor : dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.signal_cellular_alt,
                          size: 14,
                          color: signalColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${device["networkSignal"]} ${device["connectionType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: signalColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Last Sync: ${device["lastSync"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showDeviceActions(device),
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          if ("${device["assignedArea"]}" != "null")
            Container(
              margin: EdgeInsets.only(top: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.assignment,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Assigned Area: ${device["assignedArea"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, {Color? color}) {
    Color itemColor = color ?? primaryColor;
    return Column(
      children: [
        Icon(
          icon,
          color: itemColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: itemColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Scanner"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(Icons.sync),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Search devices...",
              value: searchQuery,
              hint: "Search by device, user, or app name",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Device",
                    items: deviceOptions,
                    value: selectedDevice,
                    onChanged: (value, label) {
                      selectedDevice = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "App",
                    items: appOptions,
                    value: selectedApp,
                    onChanged: (value, label) {
                      selectedApp = value;
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
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildSummaryCard(),
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "Mobile Devices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredDevices.length} devices",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...filteredDevices.map((device) => _buildDeviceCard(device)),
            if (filteredDevices.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No mobile devices found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or add new mobile devices",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new mobile device
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
