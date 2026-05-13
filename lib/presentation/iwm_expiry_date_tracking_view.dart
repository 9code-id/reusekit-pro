import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmExpiryDateTrackingView extends StatefulWidget {
  const IwmExpiryDateTrackingView({super.key});

  @override
  State<IwmExpiryDateTrackingView> createState() => _IwmExpiryDateTrackingViewState();
}

class _IwmExpiryDateTrackingViewState extends State<IwmExpiryDateTrackingView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedWarning = "all";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Pharmaceuticals", "value": "pharma"},
    {"label": "Cosmetics", "value": "cosmetics"},
    {"label": "Electronics", "value": "electronics"},
  ];
  
  List<Map<String, dynamic>> warningItems = [
    {"label": "All Products", "value": "all"},
    {"label": "Expired", "value": "expired"},
    {"label": "Expiring Soon", "value": "expiring"},
    {"label": "Critical (7 Days)", "value": "critical"},
    {"label": "Warning (30 Days)", "value": "warning"},
  ];
  
  List<Map<String, dynamic>> expiryStats = [
    {
      "title": "Total Products",
      "value": 5842,
      "subtitle": "All Categories",
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "title": "Expired",
      "value": 127,
      "subtitle": "Need Action",
      "icon": Icons.dangerous,
      "color": dangerColor
    },
    {
      "title": "Expiring Soon",
      "value": 256,
      "subtitle": "Next 30 Days",
      "icon": Icons.warning,
      "color": warningColor
    },
    {
      "title": "Safe Stock",
      "value": 5459,
      "subtitle": "93% Healthy",
      "icon": Icons.check_circle,
      "color": successColor
    },
  ];
  
  List<Map<String, dynamic>> products = [
    {
      "name": "Organic Milk 1L",
      "sku": "MLK-ORG-1000",
      "category": "Food & Beverages",
      "batchNumber": "BTH-2024-001",
      "expiryDate": "2024-01-25",
      "daysLeft": -2,
      "quantity": 48,
      "location": "Warehouse A",
      "supplier": "Dairy Fresh Co.",
      "status": "Expired",
      "alertLevel": "critical"
    },
    {
      "name": "Pain Relief Tablets",
      "sku": "PRT-500MG",
      "category": "Pharmaceuticals",
      "batchNumber": "BTH-2024-002",
      "expiryDate": "2024-01-28",
      "daysLeft": 5,
      "quantity": 120,
      "location": "Pharmacy Store",
      "supplier": "PharmaCorp",
      "status": "Critical",
      "alertLevel": "critical"
    },
    {
      "name": "Face Cream 50ml",
      "sku": "FC-ANT-50",
      "category": "Cosmetics",
      "batchNumber": "BTH-2024-003",
      "expiryDate": "2024-02-15",
      "daysLeft": 23,
      "quantity": 75,
      "location": "Beauty Section",
      "supplier": "Beauty Plus",
      "status": "Warning",
      "alertLevel": "warning"
    },
    {
      "name": "Smartphone Battery",
      "sku": "BAT-SM-4000",
      "category": "Electronics",
      "batchNumber": "BTH-2024-004",
      "expiryDate": "2025-01-22",
      "daysLeft": 365,
      "quantity": 200,
      "location": "Electronics Warehouse",
      "supplier": "TechSupply Ltd",
      "status": "Safe",
      "alertLevel": "safe"
    },
  ];
  
  List<Map<String, dynamic>> expiryAlerts = [
    {"product": "Organic Milk 1L", "batch": "BTH-2024-001", "daysLeft": -2, "quantity": 48, "severity": "expired"},
    {"product": "Pain Relief Tablets", "batch": "BTH-2024-002", "daysLeft": 5, "quantity": 120, "severity": "critical"},
    {"product": "Vitamin C Tablets", "batch": "BTH-2024-005", "daysLeft": 12, "quantity": 89, "severity": "critical"},
    {"product": "Face Cream 50ml", "batch": "BTH-2024-003", "daysLeft": 23, "quantity": 75, "severity": "warning"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expiry Date Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Products", icon: Icon(Icons.inventory)),
        Tab(text: "Alerts", icon: Icon(Icons.notification_important)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildProductsTab(),
        _buildAlertsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(),
          _buildExpiryStats(),
          _buildExpiryChart(),
          _buildUrgentAlerts(),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductFilters(),
          _buildProductsList(),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAlertSettings(),
          _buildAlertsList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportOptions(),
          _buildTrendChart(),
          _buildExportSection(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.add,
                  label: "Add Product",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.notifications,
                  label: "Set Alert",
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

  Widget _buildExpiryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Expiry Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: expiryStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryChart() {
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
            "Expiry Distribution",
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
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Expiry Distribution Chart",
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

  Widget _buildUrgentAlerts() {
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
              Text(
                "Urgent Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${expiryAlerts.length}",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ...expiryAlerts.take(4).map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor = _getSeverityColor(alert["severity"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: severityColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: severityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["product"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Batch: ${alert["batch"]} • Qty: ${alert["quantity"]}",
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
                "${(alert["daysLeft"] as int) < 0 ? 'Expired' : '${alert["daysLeft"]} days'}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: severityColor,
                ),
              ),
              Text(
                _getSeverityText(alert["severity"]),
                style: TextStyle(
                  fontSize: 12,
                  color: severityColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductFilters() {
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
                child: QTextField(
                  label: "Search Products",
                  value: searchQuery,
                  hint: "Enter product name or SKU...",
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Warning Level",
                  items: warningItems,
                  value: selectedWarning,
                  onChanged: (value, label) {
                    selectedWarning = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return Column(
      spacing: spSm,
      children: products.map((product) => _buildProductCard(product)).toList(),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    Color alertColor = _getAlertColor(product["alertLevel"]);
    bool isExpired = (product["daysLeft"] as int) < 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: alertColor.withAlpha(50),
          width: isExpired ? 2 : 1,
        ),
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
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${product["sku"]} • ${product["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: alertColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${product["status"]}",
                  style: TextStyle(
                    color: alertColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                      "Batch: ${product["batchNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${product["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Supplier: ${product["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Qty: ${product["quantity"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${product["expiryDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                isExpired ? Icons.dangerous : Icons.schedule,
                color: alertColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                isExpired ? "Expired ${-(product["daysLeft"] as int)} days ago" : "${product["daysLeft"]} days left",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: alertColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                label: "Manage",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSettings() {
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
            "Alert Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAlertSetting("Critical Alert", "7 days", dangerColor),
              _buildAlertSetting("Warning Alert", "30 days", warningColor),
              _buildAlertSetting("Info Alert", "60 days", infoColor),
              _buildAlertSetting("Email Alerts", "Enabled", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSetting(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications,
            color: color,
            size: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Configure",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      spacing: spSm,
      children: expiryAlerts.map((alert) => _buildDetailedAlertCard(alert)).toList(),
    );
  }

  Widget _buildDetailedAlertCard(Map<String, dynamic> alert) {
    Color severityColor = _getSeverityColor(alert["severity"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: severityColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getSeverityIcon(alert["severity"]),
              color: severityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["product"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Batch: ${alert["batch"]} • Quantity: ${alert["quantity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${(alert["daysLeft"] as int) < 0 ? 'Expired ${-(alert["daysLeft"] as int)} days ago' : 'Expires in ${alert["daysLeft"]} days'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.manage_search,
            label: "Handle",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReportOptions() {
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
            "Report Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildReportOption("Expiry Report", Icons.calendar_today, "Full expiry tracking"),
              _buildReportOption("Category Report", Icons.category, "By product category"),
              _buildReportOption("Supplier Report", Icons.business, "By supplier analysis"),
              _buildReportOption("Alert History", Icons.history, "Alert tracking history"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportOption(String title, IconData icon, String description) {
    return Container(
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
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
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
            "Expiry Trends",
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
                    "Expiry Trends Chart",
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

  Widget _buildExportSection() {
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
            "Export Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.file_download,
                  label: "Export CSV",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.picture_as_pdf,
                  label: "Export PDF",
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

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "expired":
        return dangerColor;
      case "critical":
        return dangerColor;
      case "warning":
        return warningColor;
      case "safe":
        return successColor;
      default:
        return primaryColor;
    }
  }

  String _getSeverityText(String severity) {
    switch (severity.toLowerCase()) {
      case "expired":
        return "EXPIRED";
      case "critical":
        return "CRITICAL";
      case "warning":
        return "WARNING";
      case "safe":
        return "SAFE";
      default:
        return "UNKNOWN";
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity.toLowerCase()) {
      case "expired":
        return Icons.dangerous;
      case "critical":
        return Icons.warning;
      case "warning":
        return Icons.schedule;
      case "safe":
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  Color _getAlertColor(String alertLevel) {
    switch (alertLevel.toLowerCase()) {
      case "critical":
        return dangerColor;
      case "warning":
        return warningColor;
      case "safe":
        return successColor;
      default:
        return primaryColor;
    }
  }
}
