import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobileAppView extends StatefulWidget {
  const IwmMobileAppView({super.key});

  @override
  State<IwmMobileAppView> createState() => _IwmMobileAppViewState();
}

class _IwmMobileAppViewState extends State<IwmMobileAppView> {
  int currentIndex = 0;
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Scan Item",
      "subtitle": "Barcode scanner",
      "icon": Icons.qr_code_scanner,
      "color": primaryColor,
      "route": "scan"
    },
    {
      "title": "Receive Goods",
      "subtitle": "Incoming inventory",
      "icon": Icons.inventory,
      "color": successColor,
      "route": "receive"
    },
    {
      "title": "Pick Items",
      "subtitle": "Order fulfillment",
      "icon": Icons.shopping_cart,
      "color": warningColor,
      "route": "pick"
    },
    {
      "title": "Check Inventory",
      "subtitle": "Stock levels",
      "icon": Icons.storage,
      "color": infoColor,
      "route": "inventory"
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "Scan",
      "item": "Laptop Dell XPS 13",
      "quantity": 1,
      "location": "A-01-01",
      "user": "John Smith",
      "timestamp": "2024-01-15 14:30",
      "status": "completed"
    },
    {
      "type": "Receive",
      "item": "Office Chair Ergonomic",
      "quantity": 5,
      "location": "B-02-03",
      "user": "Sarah Johnson",
      "timestamp": "2024-01-15 13:45",
      "status": "completed"
    },
    {
      "type": "Pick",
      "item": "Wireless Mouse",
      "quantity": 3,
      "location": "C-01-05",
      "user": "Mike Chen",
      "timestamp": "2024-01-15 12:20",
      "status": "in_progress"
    },
  ];

  List<Map<String, dynamic>> inventorySummary = [
    {"title": "Total Items", "value": "2,456", "change": "+12%", "icon": Icons.inventory_2, "color": primaryColor},
    {"title": "Low Stock", "value": "23", "change": "-5%", "icon": Icons.warning, "color": warningColor},
    {"title": "Out of Stock", "value": "8", "change": "+2", "icon": Icons.error, "color": dangerColor},
    {"title": "Pending Orders", "value": "45", "change": "+18%", "icon": Icons.pending_actions, "color": infoColor},
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "IWM Mobile",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: "Scan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          label: "Inventory",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      children: [
        _buildDashboardTab(),
        _buildScanTab(),
        _buildInventoryTab(),
        _buildReportsTab(),
        _buildSettingsTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(),
          _buildInventorySummaryCards(),
          _buildQuickActionsGrid(),
          _buildRecentActivitiesSection(),
        ],
      ),
    );
  }

  Widget _buildScanTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScanSection(),
          _buildScanHistory(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInventorySearch(),
          _buildInventoryFilters(),
          _buildInventoryList(),
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
          _buildReportsOverview(),
          _buildQuickReports(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfile(),
          _buildAppSettings(),
          _buildSyncSettings(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back, John!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Today • January 15, 2024",
            style: TextStyle(
              color: Colors.white.withAlpha(200),
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 16),
              SizedBox(width: spXs),
              Text(
                "Main Warehouse - Floor 1",
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: inventorySummary.map((summary) => _buildSummaryCard(summary)).toList(),
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                "${summary["change"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "${summary["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
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
      onTap: () => _handleQuickAction(action["route"]),
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
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (action["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                action["icon"],
                color: action["color"],
                size: 32,
              ),
            ),
            Text(
              "${action["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${action["subtitle"]}",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesSection() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...recentActivities.map((activity) => _buildActivityCard(activity)),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color statusColor = _getStatusColor(activity["status"]);
    IconData typeIcon = _getTypeIcon(activity["type"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["type"]}: ${activity["item"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Qty: ${activity["quantity"]} • Location: ${activity["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["user"]} • ${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${activity["status"].toString().replaceAll('_', ' ')}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor, style: BorderStyle.solid, width: 2),
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
                  "Tap to Start Scanning",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Point camera at barcode or QR code",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.camera_alt,
                  label: "Camera Scan",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.keyboard,
                  label: "Manual Entry",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanHistory() {
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
        ...recentActivities.where((activity) => activity["type"] == "Scan").map((scan) => _buildActivityCard(scan)),
      ],
    );
  }

  Widget _buildInventorySearch() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search inventory...",
            value: searchQuery,
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
    );
  }

  Widget _buildInventoryFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All Items", true),
        _buildFilterChip("Low Stock", false),
        _buildFilterChip("Out of Stock", false),
        _buildFilterChip("Recently Added", false),
        _buildFilterChip("High Value", false),
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

  Widget _buildInventoryList() {
    List<Map<String, dynamic>> items = [
      {"name": "Laptop Dell XPS 13", "sku": "LT-001", "stock": 25, "location": "A-01-01", "status": "In Stock"},
      {"name": "Office Chair Ergonomic", "sku": "CH-002", "stock": 5, "location": "B-02-03", "status": "Low Stock"},
      {"name": "Wireless Mouse", "sku": "MS-003", "stock": 0, "location": "C-01-05", "status": "Out of Stock"},
    ];

    return Column(
      spacing: spSm,
      children: items.map((item) => _buildInventoryItem(item)).toList(),
    );
  }

  Widget _buildInventoryItem(Map<String, dynamic> item) {
    Color statusColor = _getStockStatusColor(item["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "SKU: ${item["sku"]} • Location: ${item["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Stock: ${item["stock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["status"]}",
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
          ),
          QButton(
            icon: Icons.visibility,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReportsOverview() {
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
            "Reports Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Generate and view inventory reports on the go",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReports() {
    List<Map<String, dynamic>> reports = [
      {"title": "Stock Levels", "icon": Icons.inventory, "color": primaryColor},
      {"title": "Low Stock Alert", "icon": Icons.warning, "color": warningColor},
      {"title": "Recent Movements", "icon": Icons.swap_horiz, "color": successColor},
      {"title": "Location Summary", "icon": Icons.location_on, "color": infoColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: reports.map((report) => _buildReportCard(report)).toList(),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (report["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                report["icon"],
                color: report["color"],
                size: 24,
              ),
            ),
            Text(
              "${report["title"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("https://picsum.photos/60/60?random=1&keyword=person"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Smith",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Warehouse Operator",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "ID: EMP001 • Shift: Morning",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    List<Map<String, dynamic>> settings = [
      {"title": "Notifications", "subtitle": "Push notifications", "icon": Icons.notifications},
      {"title": "Scanner Settings", "subtitle": "Camera and barcode", "icon": Icons.qr_code_scanner},
      {"title": "Language", "subtitle": "English", "icon": Icons.language},
      {"title": "Help & Support", "subtitle": "Get help", "icon": Icons.help},
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "App Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...settings.map((setting) => _buildSettingItem(setting)),
      ],
    );
  }

  Widget _buildSettingItem(Map<String, dynamic> setting) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                setting["icon"],
                color: primaryColor,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${setting["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${setting["subtitle"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: disabledColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSettings() {
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
            "Data Sync",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.sync, color: successColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Last sync: 2 minutes ago",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Sync Now",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String route) {
    switch (route) {
      case "scan":
        ss("Opening scanner...");
        break;
      case "receive":
        ss("Opening receiving module...");
        break;
      case "pick":
        ss("Opening picking module...");
        break;
      case "inventory":
        ss("Opening inventory check...");
        break;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStockStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return successColor;
      case 'low stock':
        return warningColor;
      case 'out of stock':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'scan':
        return Icons.qr_code_scanner;
      case 'receive':
        return Icons.inventory;
      case 'pick':
        return Icons.shopping_cart;
      default:
        return Icons.inventory_2;
    }
  }
}
