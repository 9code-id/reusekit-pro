import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobileScanningView extends StatefulWidget {
  const IwmMobileScanningView({super.key});

  @override
  State<IwmMobileScanningView> createState() => _IwmMobileScanningViewState();
}

class _IwmMobileScanningViewState extends State<IwmMobileScanningView> {
  int selectedTab = 0;
  String scannedCode = "";
  String manualCode = "";
  bool isScanning = false;
  bool flashOn = false;
  String selectedScanType = "barcode";
  
  List<Map<String, dynamic>> scanTypes = [
    {"label": "Barcode", "value": "barcode"},
    {"label": "QR Code", "value": "qr"},
    {"label": "Data Matrix", "value": "datamatrix"},
  ];
  
  List<Map<String, dynamic>> scanHistory = [
    {
      "code": "123456789012",
      "type": "Barcode",
      "item": "Laptop Dell XPS 13",
      "location": "A-01-01",
      "timestamp": "2024-01-15 14:30:25",
      "action": "Inventory Check",
      "user": "John Smith",
      "status": "success"
    },
    {
      "code": "QR-987654321",
      "type": "QR Code",
      "item": "Office Chair Ergonomic",
      "location": "B-02-03",
      "timestamp": "2024-01-15 13:45:10",
      "action": "Receive Goods",
      "user": "Sarah Johnson",
      "status": "success"
    },
    {
      "code": "456789123456",
      "type": "Barcode",
      "item": "Wireless Mouse",
      "location": "C-01-05",
      "timestamp": "2024-01-15 12:20:15",
      "action": "Pick Item",
      "user": "Mike Chen",
      "status": "success"
    },
    {
      "code": "UNKNOWN123",
      "type": "Barcode",
      "item": "Unknown Item",
      "location": "-",
      "timestamp": "2024-01-15 11:30:45",
      "action": "Inventory Check",
      "user": "John Smith",
      "status": "error"
    },
  ];
  
  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Inventory Check",
      "subtitle": "Check item details",
      "icon": Icons.inventory_2,
      "color": primaryColor,
      "action": "check"
    },
    {
      "title": "Receive Item",
      "subtitle": "Add to inventory",
      "icon": Icons.add_box,
      "color": successColor,
      "action": "receive"
    },
    {
      "title": "Pick Item",
      "subtitle": "Remove from stock",
      "icon": Icons.remove_circle,
      "color": warningColor,
      "action": "pick"
    },
    {
      "title": "Move Item",
      "subtitle": "Change location",
      "icon": Icons.swap_horiz,
      "color": infoColor,
      "action": "move"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mobile Scanning",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Scanner", icon: Icon(Icons.qr_code_scanner)),
        Tab(text: "Manual Entry", icon: Icon(Icons.keyboard)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildScannerTab(),
        _buildManualEntryTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildScannerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScannerControls(),
          _buildCameraView(),
          _buildScanResult(),
          _buildQuickActionsGrid(),
        ],
      ),
    );
  }

  Widget _buildManualEntryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildManualEntryForm(),
          _buildRecentScans(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryStats(),
          _buildHistoryFilters(),
          _buildScanHistoryList(),
        ],
      ),
    );
  }

  Widget _buildScannerControls() {
    return Container(
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
              Expanded(
                child: QDropdownField(
                  label: "Scan Type",
                  items: scanTypes,
                  value: selectedScanType,
                  onChanged: (value, label) {
                    selectedScanType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: flashOn ? Icons.flash_on : Icons.flash_off,
                size: bs.sm,
                onPressed: () {
                  flashOn = !flashOn;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: isScanning ? Icons.stop : Icons.play_arrow,
                  label: isScanning ? "Stop Scanning" : "Start Scanning",
                  size: bs.md,
                  onPressed: () => _toggleScanning(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.camera_alt,
                size: bs.md,
                onPressed: () => _captureImage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          // Camera preview placeholder
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Scanning overlay
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isScanning ? primaryColor : Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 64,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    isScanning ? "Scanning..." : "Point camera at code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Flash indicator
          if (flashOn)
            Positioned(
              top: spSm,
              right: spSm,
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.flash_on, color: Colors.black, size: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScanResult() {
    if (scannedCode.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.qr_code_2,
              size: 48,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No code scanned yet",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
            ),
            Text(
              "Start scanning to see results here",
              style: TextStyle(
                color: disabledColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Scan Successful",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Scanned Code:",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  scannedCode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Item: Laptop Dell XPS 13",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Location: A-01-01 • Stock: 25 units",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
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
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return Column(
      spacing: spSm,
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
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () => _handleQuickAction(action["action"]),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: (action["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                action["icon"],
                color: action["color"],
                size: 24,
              ),
            ),
            Text(
              "${action["title"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${action["subtitle"]}",
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

  Widget _buildManualEntryForm() {
    return Container(
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
          Text(
            "Manual Code Entry",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Enter barcode or QR code",
            value: manualCode,
            onChanged: (value) {
              manualCode = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Code Type",
            items: scanTypes,
            value: selectedScanType,
            onChanged: (value, label) {
              selectedScanType = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Process Code",
                  size: bs.md,
                  onPressed: () => _processManualCode(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () => _clearManualCode(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScans() {
    List<Map<String, dynamic>> recentScans = scanHistory.take(3).toList();

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Scans",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentScans.map((scan) => _buildScanHistoryCard(scan)),
      ],
    );
  }

  Widget _buildHistoryStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Today", "value": "12", "subtitle": "Scans", "icon": Icons.today, "color": primaryColor},
      {"title": "Success Rate", "value": "95%", "subtitle": "Accuracy", "icon": Icons.check_circle, "color": successColor},
      {"title": "Failed", "value": "2", "subtitle": "Retries needed", "icon": Icons.error, "color": dangerColor},
      {"title": "Average", "value": "1.2s", "subtitle": "Scan time", "icon": Icons.speed, "color": infoColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All", true),
        _buildFilterChip("Today", false),
        _buildFilterChip("Success", false),
        _buildFilterChip("Failed", false),
        _buildFilterChip("Barcode", false),
        _buildFilterChip("QR Code", false),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: isSelected ? primaryColor : disabledOutlineBorderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : disabledBoldColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildScanHistoryList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scan History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...scanHistory.map((scan) => _buildScanHistoryCard(scan)),
      ],
    );
  }

  Widget _buildScanHistoryCard(Map<String, dynamic> scan) {
    Color statusColor = scan["status"] == "success" ? successColor : dangerColor;
    IconData statusIcon = scan["status"] == "success" ? Icons.check_circle : Icons.error;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${scan["code"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${scan["type"]} • ${scan["action"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${scan["timestamp"].toString().split(' ')[1]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          if (scan["item"] != "Unknown Item")
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${scan["item"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  if (scan["location"] != "-")
                    Text(
                      "Location: ${scan["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.person, size: 14, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${scan["user"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              if (scan["status"] == "success")
                QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () {},
                )
              else
                QButton(
                  label: "Retry",
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleScanning() {
    isScanning = !isScanning;
    setState(() {});
    
    if (isScanning) {
      ss("Scanner started");
      // Simulate scanning after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        if (isScanning) {
          scannedCode = "123456789012";
          isScanning = false;
          setState(() {});
          ss("Code scanned successfully");
        }
      });
    } else {
      ss("Scanner stopped");
    }
  }

  void _captureImage() {
    ss("Image captured");
  }

  void _processManualCode() {
    if (manualCode.isEmpty) {
      se("Please enter a code");
      return;
    }
    
    scannedCode = manualCode;
    setState(() {});
    ss("Code processed successfully");
  }

  void _clearManualCode() {
    manualCode = "";
    setState(() {});
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "check":
        ss("Opening inventory check...");
        break;
      case "receive":
        ss("Opening receive goods...");
        break;
      case "pick":
        ss("Opening pick item...");
        break;
      case "move":
        ss("Opening move item...");
        break;
    }
  }
}
