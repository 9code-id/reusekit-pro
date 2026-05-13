import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaBarcodeScannerView extends StatefulWidget {
  const DlaBarcodeScannerView({super.key});

  @override
  State<DlaBarcodeScannerView> createState() => _DlaBarcodeScannerViewState();
}

class _DlaBarcodeScannerViewState extends State<DlaBarcodeScannerView> {
  bool isScanning = false;
  bool flashEnabled = false;
  String lastScannedCode = "";
  String selectedScanType = "Package";
  
  List<Map<String, dynamic>> scanTypes = [
    {"label": "Package", "value": "Package"},
    {"label": "Inventory", "value": "Inventory"},
    {"label": "Warehouse", "value": "Warehouse"},
    {"label": "Vehicle", "value": "Vehicle"},
  ];

  List<Map<String, dynamic>> scanHistory = [
    {
      "code": "DLA123456789",
      "type": "Package",
      "result": "Package found: Electronics Shipment",
      "timestamp": "2024-01-15 14:30:25",
      "status": "Success",
      "icon": Icons.inventory_2,
    },
    {
      "code": "WH001-A-15",
      "type": "Warehouse",
      "result": "Warehouse Zone A, Section 15",
      "timestamp": "2024-01-15 13:45:12",
      "status": "Success",
      "icon": Icons.warehouse,
    },
    {
      "code": "VH-TRK-001",
      "type": "Vehicle",
      "result": "Truck TRK-001 - Available",
      "timestamp": "2024-01-15 12:20:08",
      "status": "Success",
      "icon": Icons.local_shipping,
    },
    {
      "code": "INV789456123",
      "type": "Inventory",
      "result": "Laptop - Dell XPS 13",
      "timestamp": "2024-01-15 11:15:45",
      "status": "Success",
      "icon": Icons.computer,
    },
    {
      "code": "INVALID123",
      "type": "Package",
      "result": "Invalid barcode format",
      "timestamp": "2024-01-15 10:30:22",
      "status": "Error",
      "icon": Icons.error,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Package Lookup",
      "subtitle": "Scan package barcode",
      "icon": Icons.inventory_2,
      "color": Colors.blue,
      "type": "Package",
    },
    {
      "title": "Inventory Check",
      "subtitle": "Scan product barcode",
      "icon": Icons.qr_code,
      "color": Colors.green,
      "type": "Inventory",
    },
    {
      "title": "Location Scan",
      "subtitle": "Scan warehouse location",
      "icon": Icons.warehouse,
      "color": Colors.orange,
      "type": "Warehouse",
    },
    {
      "title": "Vehicle ID",
      "subtitle": "Scan vehicle barcode",
      "icon": Icons.local_shipping,
      "color": Colors.purple,
      "type": "Vehicle",
    },
  ];

  void _startScanning() async {
    isScanning = true;
    setState(() {});

    // Simulate scanning process
    await Future.delayed(Duration(seconds: 3));

    // Generate random barcode
    String scannedCode = _generateRandomBarcode();
    lastScannedCode = scannedCode;
    
    isScanning = false;
    setState(() {});

    _processScanResult(scannedCode);
  }

  void _stopScanning() {
    isScanning = false;
    setState(() {});
  }

  void _toggleFlash() {
    flashEnabled = !flashEnabled;
    setState(() {});
    si(flashEnabled ? "Flash enabled" : "Flash disabled");
  }

  String _generateRandomBarcode() {
    switch (selectedScanType) {
      case "Package":
        return "DLA${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
      case "Inventory":
        return "INV${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
      case "Warehouse":
        return "WH001-B-${(DateTime.now().millisecondsSinceEpoch % 99).toString().padLeft(2, '0')}";
      case "Vehicle":
        return "VH-TRK-${(DateTime.now().millisecondsSinceEpoch % 999).toString().padLeft(3, '0')}";
      default:
        return "UNK${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    }
  }

  void _processScanResult(String code) {
    String result = "";
    String status = "Success";
    IconData icon = Icons.check_circle;

    switch (selectedScanType) {
      case "Package":
        if (code.startsWith("DLA")) {
          result = "Package found: Electronics Shipment";
          icon = Icons.inventory_2;
        } else {
          result = "Invalid package barcode";
          status = "Error";
          icon = Icons.error;
        }
        break;
      case "Inventory":
        if (code.startsWith("INV")) {
          result = "Product: Gaming Laptop - High Performance";
          icon = Icons.computer;
        } else {
          result = "Product not found in inventory";
          status = "Error";
          icon = Icons.error;
        }
        break;
      case "Warehouse":
        if (code.startsWith("WH")) {
          result = "Warehouse Zone B, Section ${code.split('-').last}";
          icon = Icons.warehouse;
        } else {
          result = "Invalid warehouse location code";
          status = "Error";
          icon = Icons.error;
        }
        break;
      case "Vehicle":
        if (code.startsWith("VH")) {
          result = "Vehicle ${code.split('-').last} - Available for assignment";
          icon = Icons.local_shipping;
        } else {
          result = "Vehicle not found in fleet";
          status = "Error";
          icon = Icons.error;
        }
        break;
    }

    // Add to scan history
    scanHistory.insert(0, {
      "code": code,
      "type": selectedScanType,
      "result": result,
      "timestamp": DateTime.now().toString().substring(0, 19),
      "status": status,
      "icon": icon,
    });

    setState(() {});

    if (status == "Success") {
      ss("Scan successful: $result");
    } else {
      se("Scan failed: $result");
    }
  }

  void _manualCodeEntry() async {
    String manualCode = "";
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Manual Code Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Enter Code Manually",
              value: manualCode,
              hint: "Type or paste barcode here",
              onChanged: (value) {
                manualCode = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Process",
            size: bs.sm,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (result == true && manualCode.isNotEmpty) {
      lastScannedCode = manualCode;
      _processScanResult(manualCode);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return successColor;
      case 'error':
        return dangerColor;
      case 'warning':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard),
            onPressed: _manualCodeEntry,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scan Type Selection
            Container(
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
                    "Scan Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Select Scan Type",
                    items: scanTypes,
                    value: selectedScanType,
                    onChanged: (value, label) {
                      selectedScanType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Scanner Interface
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Camera Preview Area
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isScanning ? Colors.black : Colors.grey[200],
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isScanning ? primaryColor : disabledOutlineBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isScanning) ...[
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Scanning animation corners
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(color: primaryColor, width: 4),
                                              left: BorderSide(color: primaryColor, width: 4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(color: primaryColor, width: 4),
                                              right: BorderSide(color: primaryColor, width: 4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: primaryColor, width: 4),
                                              left: BorderSide(color: primaryColor, width: 4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: primaryColor, width: 4),
                                              right: BorderSide(color: primaryColor, width: 4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Scanning line
                                      Center(
                                        child: Container(
                                          width: 180,
                                          height: 2,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spMd),
                                Text(
                                  "Scanning for $selectedScanType...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ] else ...[
                                Icon(
                                  Icons.qr_code_scanner,
                                  size: 80,
                                  color: disabledColor,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Position barcode in the frame",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        // Flash button
                        if (isScanning)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: _toggleFlash,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: flashEnabled 
                                      ? Colors.yellow[600] 
                                      : Colors.black.withAlpha(128),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  flashEnabled ? Icons.flash_on : Icons.flash_off,
                                  color: flashEnabled ? Colors.black : Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Control Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isScanning ? "Stop Scanning" : "Start Scanning",
                          icon: isScanning ? Icons.stop : Icons.qr_code_scanner,
                          onPressed: isScanning ? _stopScanning : _startScanning,
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.keyboard,
                        size: bs.sm,
                        onPressed: _manualCodeEntry,
                      ),
                    ],
                  ),

                  if (lastScannedCode.isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(51)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Scanned Code",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  lastScannedCode,
                                  style: TextStyle(
                                    fontSize: 14,
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
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: quickActions.map((action) {
                      return GestureDetector(
                        onTap: () {
                          selectedScanType = "${action["type"]}";
                          setState(() {});
                          si("Scan type changed to ${action["type"]}");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: selectedScanType == action["type"]
                                  ? (action["color"] as Color)
                                  : (action["color"] as Color).withAlpha(51),
                              width: selectedScanType == action["type"] ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                action["icon"] as IconData,
                                color: action["color"] as Color,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${action["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: action["color"] as Color,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${action["subtitle"]}",
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Scan History
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Scan History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          scanHistory.clear();
                          setState(() {});
                          si("Scan history cleared");
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  if (scanHistory.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No scan history yet",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...scanHistory.take(5).map((scan) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getStatusColor("${scan["status"]}").withAlpha(51),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${scan["status"]}").withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                scan["icon"] as IconData,
                                color: _getStatusColor("${scan["status"]}"),
                                size: 20,
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
                                        "${scan["code"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${scan["status"]}").withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${scan["type"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: _getStatusColor("${scan["status"]}"),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${scan["result"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
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
                          ],
                        ),
                      );
                    }).toList(),

                  if (scanHistory.length > 5)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          si("View all scan history");
                        },
                        child: Text(
                          "View All (${scanHistory.length} total)",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
