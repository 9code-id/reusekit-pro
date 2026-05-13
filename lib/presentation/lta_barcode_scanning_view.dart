import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaBarcodeScanningView extends StatefulWidget {
  const LtaBarcodeScanningView({super.key});

  @override
  State<LtaBarcodeScanningView> createState() => _LtaBarcodeScanningViewState();
}

class _LtaBarcodeScanningViewState extends State<LtaBarcodeScanningView> {
  String searchQuery = "";
  String selectedScanType = "";
  String selectedStatus = "";
  bool isScannerActive = false;
  String scannedCode = "";
  
  // Sample scan history data
  List<Map<String, dynamic>> scanHistory = [
    {
      "id": "SCAN-001",
      "barcode": "123456789012",
      "itemName": "Samsung Galaxy S24",
      "scanType": "pickup",
      "timestamp": "2024-01-15 10:30:00",
      "status": "verified",
      "location": "Warehouse A-101",
      "scannedBy": "John Smith",
      "orderId": "ORD-2024-001",
      "quantity": 1,
      "weight": 0.5
    },
    {
      "id": "SCAN-002", 
      "barcode": "987654321098",
      "itemName": "Apple MacBook Pro",
      "scanType": "delivery",
      "timestamp": "2024-01-15 11:45:00",
      "status": "pending",
      "location": "Truck TRK-001",
      "scannedBy": "Mike Johnson",
      "orderId": "ORD-2024-002",
      "quantity": 1,
      "weight": 2.1
    },
    {
      "id": "SCAN-003",
      "barcode": "456789123456",
      "itemName": "Office Chair Set",
      "scanType": "inventory",
      "timestamp": "2024-01-15 09:15:00",
      "status": "verified",
      "location": "Warehouse B-205",
      "scannedBy": "Sarah Wilson",
      "orderId": "ORD-2024-003",
      "quantity": 6,
      "weight": 45.0
    },
    {
      "id": "SCAN-004",
      "barcode": "789123456789",
      "itemName": "Electronics Bundle",
      "scanType": "pickup",
      "timestamp": "2024-01-15 08:20:00",
      "status": "error",
      "location": "Dock 3",
      "scannedBy": "David Brown",
      "orderId": "ORD-2024-004",
      "quantity": 3,
      "weight": 8.5
    },
    {
      "id": "SCAN-005",
      "barcode": "321654987321",
      "itemName": "Home Appliances",
      "scanType": "delivery",
      "timestamp": "2024-01-15 12:00:00",
      "status": "verified",
      "location": "Customer Site",
      "scannedBy": "Emily Davis",
      "orderId": "ORD-2024-005",
      "quantity": 2,
      "weight": 25.3
    }
  ];

  List<Map<String, dynamic>> get filteredScans {
    return scanHistory.where((scan) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${scan["barcode"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${scan["itemName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${scan["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesScanType = selectedScanType.isEmpty || scan["scanType"] == selectedScanType;
      bool matchesStatus = selectedStatus.isEmpty || scan["status"] == selectedStatus;

      return matchesSearch && matchesScanType && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "verified":
        return successColor;
      case "pending":
        return warningColor;
      case "error":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "verified":
        return Icons.check_circle;
      case "pending":
        return Icons.access_time;
      case "error":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  IconData getScanTypeIcon(String scanType) {
    switch (scanType) {
      case "pickup":
        return Icons.input;
      case "delivery":
        return Icons.output;
      case "inventory":
        return Icons.inventory;
      default:
        return Icons.qr_code_scanner;
    }
  }

  void _startScanning() {
    setState(() {
      isScannerActive = true;
    });
    
    // Simulate scanning process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        scannedCode = "123456789012";
        isScannerActive = false;
      });
      _showScanResult();
    });
  }

  void _showScanResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Scan Result"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Barcode: $scannedCode"),
            SizedBox(height: spSm),
            Text("Item: Samsung Galaxy S24"),
            Text("Order: ORD-2024-001"),
            Text("Status: Verified"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add to scan history
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanning"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scanner Section
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
                    isScannerActive ? Icons.qr_code_scanner : Icons.camera_alt,
                    size: 64,
                    color: isScannerActive ? primaryColor : disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    isScannerActive ? "Scanning..." : "Ready to Scan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  if (scannedCode.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Last Scanned: $scannedCode",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                  ],
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isScannerActive ? "Scanning..." : "Start Scanning",
                      size: bs.md,
                      onPressed: isScannerActive ? null : _startScanning,
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
                    label: "Search scans, items, orders...",
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
                    label: "Filter by Type",
                    items: [
                      {"label": "All Types", "value": ""},
                      {"label": "Pickup", "value": "pickup"},
                      {"label": "Delivery", "value": "delivery"},
                      {"label": "Inventory", "value": "inventory"},
                    ],
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
                    label: "Filter by Status",
                    items: [
                      {"label": "All Status", "value": ""},
                      {"label": "Verified", "value": "verified"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Error", "value": "error"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
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
                  "Total Scans", 
                  "${scanHistory.length}", 
                  Icons.qr_code_scanner, 
                  primaryColor
                ),
                SizedBox(width: spSm),
                _buildSummaryCard(
                  "Verified", 
                  "${scanHistory.where((s) => s["status"] == "verified").length}", 
                  Icons.check_circle, 
                  successColor
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                _buildSummaryCard(
                  "Pending", 
                  "${scanHistory.where((s) => s["status"] == "pending").length}", 
                  Icons.access_time, 
                  warningColor
                ),
                SizedBox(width: spSm),
                _buildSummaryCard(
                  "Errors", 
                  "${scanHistory.where((s) => s["status"] == "error").length}", 
                  Icons.error, 
                  dangerColor
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Scan History
            Text(
              "Recent Scans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredScans.map((scan) => _buildScanCard(scan)).toList(),
          ],
        ),
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

  Widget _buildScanCard(Map<String, dynamic> scan) {
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
            color: getStatusColor("${scan["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                getScanTypeIcon("${scan["scanType"]}"),
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${scan["itemName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor("${scan["status"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${scan["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor("${scan["status"]}"),
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
            child: Text(
              "Barcode: ${scan["barcode"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
                fontFamily: 'monospace',
              ),
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
                      "Order: ${scan["orderId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${scan["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Scanned by: ${scan["scannedBy"]}",
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
                children: [
                  Text(
                    "Qty: ${scan["quantity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Weight: ${(scan["weight"] as double).toStringAsFixed(1)} kg",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${scan["timestamp"]}".substring(0, 16),
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${scan["scanType"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  // Handle view details
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {
                  // Handle print barcode
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
