import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaQrScannerView extends StatefulWidget {
  const DlaQrScannerView({super.key});

  @override
  State<DlaQrScannerView> createState() => _DlaQrScannerViewState();
}

class _DlaQrScannerViewState extends State<DlaQrScannerView> {
  bool isScanning = false;
  bool flashEnabled = false;
  String scannedData = "";
  String scanType = "package";
  
  final List<Map<String, dynamic>> scanTypeOptions = [
    {"label": "Package QR", "value": "package"},
    {"label": "Address QR", "value": "address"},
    {"label": "Vehicle QR", "value": "vehicle"},
    {"label": "Driver ID", "value": "driver"},
  ];

  final List<Map<String, dynamic>> recentScans = [
    {
      "id": "PKG-240115-001",
      "type": "package",
      "timestamp": "2024-01-15 14:30",
      "status": "scanned",
      "address": "Jl. Sudirman No.123, Jakarta",
      "customer": "John Doe",
    },
    {
      "id": "PKG-240115-002", 
      "type": "package",
      "timestamp": "2024-01-15 13:45",
      "status": "delivered",
      "address": "Jl. Thamrin No.456, Jakarta",
      "customer": "Jane Smith",
    },
    {
      "id": "VHC-DRV-001",
      "type": "vehicle",
      "timestamp": "2024-01-15 08:00",
      "status": "assigned",
      "address": "Distribution Center",
      "customer": "Fleet Manager",
    },
  ];

  Widget _buildScannerInterface() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 80,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      isScanning ? "Scanning..." : "Tap to Start Scanning",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: spSm,
            right: spSm,
            child: QButton(
              icon: flashEnabled ? Icons.flash_on : Icons.flash_off,
              color: flashEnabled ? warningColor : disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                flashEnabled = !flashEnabled;
                setState(() {});
                si(flashEnabled ? "Flash enabled" : "Flash disabled");
              },
            ),
          ),
          Positioned(
            bottom: spSm,
            left: 0,
            right: 0,
            child: Center(
              child: QButton(
                label: isScanning ? "Stop Scanning" : "Start Scanning",
                color: isScanning ? dangerColor : successColor,
                size: bs.md,
                onPressed: () {
                  isScanning = !isScanning;
                  setState(() {});
                  if (isScanning) {
                    si("QR Scanner started");
                  } else {
                    si("QR Scanner stopped");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanTypeSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Scan Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Scan Type",
            items: scanTypeOptions,
            value: scanType,
            onChanged: (value, label) {
              scanType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanResult() {
    if (scannedData.isEmpty) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Scan Successful",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              scannedData,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "monospace",
                color: primaryColor,
              ),
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Process",
                  size: bs.sm,
                  onPressed: () {
                    ss("Processing scanned data");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Save",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Scan result saved");
                  },
                ),
              ),
              QButton(
                icon: Icons.clear,
                color: dangerColor,
                size: bs.sm,
                onPressed: () {
                  scannedData = "";
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScans() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Recent Scans",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  si("View all scan history");
                },
              ),
            ],
          ),
          ...recentScans.map((scan) => _buildScanItem(scan)),
        ],
      ),
    );
  }

  Widget _buildScanItem(Map<String, dynamic> scan) {
    Color statusColor = scan["status"] == "delivered" 
        ? successColor 
        : scan["status"] == "scanned" 
            ? warningColor 
            : primaryColor;
    
    IconData typeIcon = scan["type"] == "package" 
        ? Icons.inventory_2 
        : scan["type"] == "vehicle" 
            ? Icons.local_shipping 
            : Icons.qr_code;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(typeIcon, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${scan["id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${scan["customer"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${scan["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
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
              "${scan["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Scanner settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildScanTypeSelector(),
            _buildScannerInterface(),
            _buildScanResult(),
            _buildRecentScans(),
          ],
        ),
      ),
    );
  }
}
