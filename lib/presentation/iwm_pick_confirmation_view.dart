import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPickConfirmationView extends StatefulWidget {
  const IwmPickConfirmationView({super.key});

  @override
  State<IwmPickConfirmationView> createState() => _IwmPickConfirmationViewState();
}

class _IwmPickConfirmationViewState extends State<IwmPickConfirmationView> {
  int selectedTab = 0;
  String selectedFilter = "pending";
  String scanMode = "barcode";
  bool autoConfirm = true;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "Pending Confirmation", "value": "pending"},
    {"label": "Partially Confirmed", "value": "partial"},
    {"label": "Completed", "value": "completed"},
    {"label": "All Items", "value": "all"},
  ];
  
  List<Map<String, dynamic>> scanModes = [
    {"label": "Barcode Scanning", "value": "barcode"},
    {"label": "Manual Entry", "value": "manual"},
    {"label": "Batch Confirmation", "value": "batch"},
  ];
  
  List<Map<String, dynamic>> pendingConfirmations = [
    {
      "pickId": "PCK-2024-001",
      "orderId": "ORD-10001",
      "picker": "John Smith",
      "totalItems": 12,
      "confirmedItems": 0,
      "status": "Pending",
      "priority": "High",
      "timeStarted": "09:30 AM",
      "estimatedCompletion": "10:15 AM",
      "items": [
        {"sku": "PROD-001", "name": "Wireless Headphones", "quantity": 2, "picked": 2, "confirmed": 0, "location": "A-01-15"},
        {"sku": "PROD-002", "name": "Smartphone Case", "quantity": 5, "picked": 5, "confirmed": 0, "location": "B-02-08"},
        {"sku": "PROD-003", "name": "USB Cable", "quantity": 3, "picked": 3, "confirmed": 0, "location": "C-01-22"},
        {"sku": "PROD-004", "name": "Power Bank", "quantity": 2, "picked": 2, "confirmed": 0, "location": "A-03-07"},
      ]
    },
    {
      "pickId": "PCK-2024-002",
      "orderId": "ORD-10002",
      "picker": "Sarah Wilson",
      "totalItems": 8,
      "confirmedItems": 6,
      "status": "Partial",
      "priority": "Medium",
      "timeStarted": "10:00 AM",
      "estimatedCompletion": "10:30 AM",
      "items": [
        {"sku": "PROD-005", "name": "Bluetooth Speaker", "quantity": 1, "picked": 1, "confirmed": 1, "location": "D-01-10"},
        {"sku": "PROD-006", "name": "Gaming Mouse", "quantity": 3, "picked": 3, "confirmed": 3, "location": "E-02-15"},
        {"sku": "PROD-007", "name": "Keyboard", "quantity": 2, "picked": 2, "confirmed": 2, "location": "E-01-20"},
        {"sku": "PROD-008", "name": "Monitor Stand", "quantity": 2, "picked": 2, "confirmed": 0, "location": "F-03-05"},
      ]
    },
  ];
  
  List<Map<String, dynamic>> recentConfirmations = [
    {"pickId": "PCK-2024-003", "orderId": "ORD-10003", "items": 15, "confirmedAt": "11:45 AM", "confirmedBy": "Mike Johnson"},
    {"pickId": "PCK-2024-004", "orderId": "ORD-10004", "items": 8, "confirmedAt": "11:30 AM", "confirmedBy": "Lisa Chen"},
    {"pickId": "PCK-2024-005", "orderId": "ORD-10005", "items": 22, "confirmedAt": "11:15 AM", "confirmedBy": "David Brown"},
  ];
  
  List<Map<String, dynamic>> confirmationMetrics = [
    {
      "title": "Pending Items",
      "value": 42,
      "subtitle": "Awaiting Confirmation",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Accuracy Rate",
      "value": 98.5,
      "subtitle": "Today's Performance",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Avg Time",
      "value": 2.3,
      "subtitle": "Minutes per Item",
      "icon": Icons.timer,
      "color": primaryColor
    },
    {
      "title": "Error Rate",
      "value": 1.5,
      "subtitle": "Discrepancies Found",
      "icon": Icons.error_outline,
      "color": dangerColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pick Confirmation",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "Scanner", icon: Icon(Icons.qr_code_scanner)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildScannerTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildConfirmationMetrics(),
          _buildPendingList(),
        ],
      ),
    );
  }

  Widget _buildScannerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScannerSettings(),
          _buildScannerInterface(),
          _buildCurrentPick(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceMetrics(),
          _buildAccuracyChart(),
          _buildRecentConfirmations(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Filter Status",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Confirmation Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: confirmationMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
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
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            metric["title"] == "Accuracy Rate" || metric["title"] == "Avg Time" || metric["title"] == "Error Rate" 
                ? "${metric["value"]}${metric["title"] == "Accuracy Rate" ? "%" : metric["title"] == "Avg Time" ? " min" : "%"}" 
                : "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Pending Confirmations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...pendingConfirmations.map((pick) => _buildPickCard(pick)),
      ],
    );
  }

  Widget _buildPickCard(Map<String, dynamic> pick) {
    Color statusColor = _getStatusColor(pick["status"]);
    Color priorityColor = _getPriorityColor(pick["priority"]);
    double progress = (pick["confirmedItems"] as int) / (pick["totalItems"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${pick["pickId"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${pick["orderId"]} • Picker: ${pick["picker"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${pick["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${pick["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${pick["confirmedItems"]}/${pick["totalItems"]} items confirmed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                label: "Confirm",
                size: bs.sm,
                onPressed: () => _showConfirmationDialog(pick),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "Started: ${pick["timeStarted"]} • ETA: ${pick["estimatedCompletion"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScannerSettings() {
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
            "Scanner Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Scan Mode",
                  items: scanModes,
                  value: scanMode,
                  onChanged: (value, label) {
                    scanMode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto Confirm",
                      "value": true,
                      "checked": autoConfirm,
                    }
                  ],
                  value: [if (autoConfirm) {"label": "Auto Confirm", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    setState(() {
                      autoConfirm = values.isNotEmpty;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScannerInterface() {
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
          Text(
            "Barcode Scanner",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50), width: 2, style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  size: 64,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Position barcode within the frame",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Tap to activate camera",
                  style: TextStyle(
                    color: disabledBoldColor,
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
                  label: "Start Camera",
                  icon: Icons.camera_alt,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Manual Entry",
                  icon: Icons.keyboard,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPick() {
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
            "Current Pick Session",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Pick ID: PCK-2024-001",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "8/12 confirmed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Next Item: Wireless Headphones",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Location: A-01-15",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
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
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: confirmationMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildAccuracyChart() {
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
            "Accuracy Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Accuracy Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentConfirmations() {
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
            "Recent Confirmations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentConfirmations.map((confirmation) => _buildConfirmationItem(confirmation)),
        ],
      ),
    );
  }

  Widget _buildConfirmationItem(Map<String, dynamic> confirmation) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusXs),
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
                      "${confirmation["pickId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${confirmation["confirmedAt"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Order: ${confirmation["orderId"]} • ${confirmation["items"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Confirmed by ${confirmation["confirmedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
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

  void _showConfirmationDialog(Map<String, dynamic> pick) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Confirm Pick Items",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${pick["pickId"]} - ${pick["orderId"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Container(
                height: 200,
                child: Column(
                  children: (pick["items"] as List<Map<String, dynamic>>).map((item) => 
                    Container(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "SKU: ${item["sku"]} • Qty: ${item["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            (item["confirmed"] as int) > 0 ? Icons.check_circle : Icons.pending,
                            color: (item["confirmed"] as int) > 0 ? successColor : warningColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Confirm All",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Pick items confirmed successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'partial':
        return infoColor;
      case 'completed':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
