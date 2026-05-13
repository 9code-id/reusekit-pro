import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaScannerView extends StatefulWidget {
  const ImaScannerView({super.key});

  @override
  State<ImaScannerView> createState() => _ImaScannerViewState();
}

class _ImaScannerViewState extends State<ImaScannerView> {
  String searchQuery = "";
  String selectedScanType = "All";
  String selectedStatus = "All";
  String selectedLocation = "All";
  String selectedDate = "Today";
  bool isCameraActive = true;
  String lastScannedCode = "";
  String scanMode = "Barcode";

  List<Map<String, dynamic>> scanTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Barcode", "value": "Barcode"},
    {"label": "QR Code", "value": "QR Code"},
    {"label": "RFID", "value": "RFID"},
    {"label": "Data Matrix", "value": "Data Matrix"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Error", "value": "Error"},
    {"label": "Offline", "value": "Offline"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Warehouse B", "value": "Warehouse B"},
    {"label": "Store Front", "value": "Store Front"},
    {"label": "Loading Dock", "value": "Loading Dock"},
  ];

  List<Map<String, dynamic>> dateOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> scannerDevices = [
    {
      "id": "SCN001",
      "name": "Handheld Scanner 1",
      "type": "Barcode",
      "location": "Warehouse A",
      "status": "Active",
      "lastScan": "2 minutes ago",
      "batteryLevel": 85,
      "scanCount": 247,
      "errorRate": 0.2,
      "signal": "Strong",
      "model": "Honeywell 1900g",
      "firmware": "v2.1.5",
    },
    {
      "id": "SCN002",
      "name": "Mobile Scanner 2",
      "type": "QR Code",
      "location": "Store Front",
      "status": "Active",
      "lastScan": "5 minutes ago",
      "batteryLevel": 72,
      "scanCount": 189,
      "errorRate": 0.5,
      "signal": "Good",
      "model": "Zebra TC21",
      "firmware": "v1.8.3",
    },
    {
      "id": "SCN003",
      "name": "RFID Reader 1",
      "type": "RFID",
      "location": "Loading Dock",
      "status": "Paused",
      "lastScan": "15 minutes ago",
      "batteryLevel": 45,
      "scanCount": 156,
      "errorRate": 1.2,
      "signal": "Weak",
      "model": "Impinj R700",
      "firmware": "v3.0.1",
    },
    {
      "id": "SCN004",
      "name": "Fixed Scanner 3",
      "type": "Data Matrix",
      "location": "Warehouse B",
      "status": "Error",
      "lastScan": "1 hour ago",
      "batteryLevel": 0,
      "scanCount": 98,
      "errorRate": 5.8,
      "signal": "None",
      "model": "Cognex DMR-8600",
      "firmware": "v2.5.7",
    },
    {
      "id": "SCN005",
      "name": "Handheld Scanner 4",
      "type": "Barcode",
      "location": "Warehouse A",
      "status": "Active",
      "lastScan": "1 minute ago",
      "batteryLevel": 91,
      "scanCount": 324,
      "errorRate": 0.1,
      "signal": "Excellent",
      "model": "Datalogic QBT2131",
      "firmware": "v1.9.2",
    },
    {
      "id": "SCN006",
      "name": "Mobile Scanner 5",
      "type": "QR Code",
      "location": "Store Front",
      "status": "Offline",
      "lastScan": "2 hours ago",
      "batteryLevel": 15,
      "scanCount": 67,
      "errorRate": 2.1,
      "signal": "None",
      "model": "Honeywell CT60",
      "firmware": "v2.0.4",
    },
  ];

  List<Map<String, dynamic>> get filteredScanners {
    return scannerDevices.where((scanner) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${scanner["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${scanner["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${scanner["model"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedScanType == "All" || "${scanner["type"]}" == selectedScanType;
      bool matchesStatus = selectedStatus == "All" || "${scanner["status"]}" == selectedStatus;
      bool matchesLocation = selectedLocation == "All" || "${scanner["location"]}" == selectedLocation;
      
      return matchesSearch && matchesType && matchesStatus && matchesLocation;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Error":
        return dangerColor;
      case "Offline":
        return disabledBoldColor;
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

  void _showScannerActions(Map<String, dynamic> scanner) {
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
              "${scanner["name"]} - ${scanner["id"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildActionItem(Icons.play_arrow, "Start Scanning", () {}),
            _buildActionItem(Icons.pause, "Pause Scanner", () {}),
            _buildActionItem(Icons.stop, "Stop Scanner", () {}),
            _buildActionItem(Icons.refresh, "Reset Scanner", () {}),
            _buildActionItem(Icons.settings, "Configure Settings", () {}),
            _buildActionItem(Icons.update, "Update Firmware", () {}),
            _buildActionItem(Icons.analytics, "View Analytics", () {}),
            _buildActionItem(Icons.history, "Scan History", () {}),
            _buildActionItem(Icons.battery_charging_full, "Battery Status", () {}),
            _buildActionItem(Icons.delete, "Remove Scanner", () {}, color: dangerColor),
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
    int totalScanners = scannerDevices.length;
    int activeScanners = scannerDevices.where((s) => s["status"] == "Active").length;
    int errorScanners = scannerDevices.where((s) => s["status"] == "Error").length;
    double avgBattery = scannerDevices.fold(0.0, (sum, s) => sum + (s["batteryLevel"] as int)) / totalScanners;

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
            "Scanner Overview",
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
                child: _buildMetricItem("Total Scanners", "$totalScanners", Icons.scanner, primaryColor),
              ),
              Expanded(
                child: _buildMetricItem("Active", "$activeScanners", Icons.check_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem("Errors", "$errorScanners", Icons.error, dangerColor),
              ),
              Expanded(
                child: _buildMetricItem("Avg Battery", "${avgBattery.toInt()}%", Icons.battery_full, 
                  avgBattery > 50 ? successColor : avgBattery > 20 ? warningColor : dangerColor),
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

  Widget _buildScannerCard(Map<String, dynamic> scanner) {
    Color statusColor = _getStatusColor("${scanner["status"]}");
    Color signalColor = _getSignalColor("${scanner["signal"]}");
    int batteryLevel = scanner["batteryLevel"] as int;
    Color batteryColor = batteryLevel > 50 ? successColor : batteryLevel > 20 ? warningColor : dangerColor;

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
                      "${scanner["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${scanner["id"]} • ${scanner["model"]}",
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
                  "${scanner["status"]}",
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
              _buildInfoChip(Icons.category, "${scanner["type"]}", primaryColor),
              SizedBox(width: spSm),
              _buildInfoChip(Icons.location_on, "${scanner["location"]}", infoColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Scans", "${scanner["scanCount"]}", Icons.qr_code_scanner),
              ),
              Expanded(
                child: _buildStatItem("Battery", "$batteryLevel%", Icons.battery_full, color: batteryColor),
              ),
              Expanded(
                child: _buildStatItem("Signal", "${scanner["signal"]}", Icons.signal_cellular_alt, color: signalColor),
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
                      "Last Scan: ${scanner["lastScan"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Error Rate: ${scanner["errorRate"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: (scanner["errorRate"] as double) > 2.0 ? dangerColor : successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showScannerActions(scanner),
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
        title: Text("Scanner Management"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.refresh),
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
              label: "Search scanners...",
              value: searchQuery,
              hint: "Search by name, ID, or model",
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
                    label: "Type",
                    items: scanTypes,
                    value: selectedScanType,
                    onChanged: (value, label) {
                      selectedScanType = value;
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
            SizedBox(height: spSm),
            Row(
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: dateOptions,
                    value: selectedDate,
                    onChanged: (value, label) {
                      selectedDate = value;
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
                  "Active Scanners",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredScanners.length} devices",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...filteredScanners.map((scanner) => _buildScannerCard(scanner)),
            if (filteredScanners.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.scanner,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No scanners found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or add new scanners",
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
          // Add new scanner
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
