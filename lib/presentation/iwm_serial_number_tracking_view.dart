import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSerialNumberTrackingView extends StatefulWidget {
  const IwmSerialNumberTrackingView({super.key});

  @override
  State<IwmSerialNumberTrackingView> createState() => _IwmSerialNumberTrackingViewState();
}

class _IwmSerialNumberTrackingViewState extends State<IwmSerialNumberTrackingView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedProduct = "all";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Sold", "value": "sold"},
    {"label": "Returned", "value": "returned"},
    {"label": "Defective", "value": "defective"},
  ];
  
  List<Map<String, dynamic>> productItems = [
    {"label": "All Products", "value": "all"},
    {"label": "iPhone 15 Pro", "value": "iphone15pro"},
    {"label": "Samsung Galaxy S24", "value": "galaxys24"},
    {"label": "MacBook Pro", "value": "macbook"},
    {"label": "Dell Laptop", "value": "dell"},
  ];
  
  List<Map<String, dynamic>> serialSummary = [
    {
      "title": "Total Serials",
      "value": 2847,
      "subtitle": "All Products",
      "icon": Icons.qr_code,
      "color": primaryColor
    },
    {
      "title": "Active",
      "value": 1523,
      "subtitle": "53% In Stock",
      "icon": Icons.verified,
      "color": successColor
    },
    {
      "title": "Sold",
      "value": 1124,
      "subtitle": "39% Revenue",
      "icon": Icons.trending_up,
      "color": infoColor
    },
    {
      "title": "Issues",
      "value": 200,
      "subtitle": "7% Attention",
      "icon": Icons.error,
      "color": dangerColor
    },
  ];
  
  List<Map<String, dynamic>> serialNumbers = [
    {
      "serialNumber": "IPH15P-2024-001234",
      "product": "iPhone 15 Pro",
      "sku": "IPH15P-128-BLU",
      "status": "Active",
      "location": "Warehouse A",
      "purchaseDate": "2024-01-15",
      "warrantyExpiry": "2025-01-15",
      "customer": null,
      "saleDate": null,
      "price": 999.0,
      "condition": "New"
    },
    {
      "serialNumber": "SGS24-2024-005678",
      "product": "Samsung Galaxy S24",
      "sku": "SGS24-256-BLK",
      "status": "Sold",
      "location": "Store B",
      "purchaseDate": "2024-01-20",
      "warrantyExpiry": "2025-01-20",
      "customer": "John Smith",
      "saleDate": "2024-02-10",
      "price": 799.0,
      "condition": "New"
    },
    {
      "serialNumber": "MBP16-2024-009876",
      "product": "MacBook Pro 16\"",
      "sku": "MBP16-512-SLV",
      "status": "Defective",
      "location": "Service Center",
      "purchaseDate": "2024-01-25",
      "warrantyExpiry": "2025-01-25",
      "customer": null,
      "saleDate": null,
      "price": 2399.0,
      "condition": "Defective"
    },
    {
      "serialNumber": "DLL-LAP-2024-112233",
      "product": "Dell Inspiron",
      "sku": "DLL-INS-15-BLK",
      "status": "Returned",
      "location": "Returns Dept",
      "purchaseDate": "2024-01-30",
      "warrantyExpiry": "2025-01-30",
      "customer": "Jane Doe",
      "saleDate": "2024-02-05",
      "price": 699.0,
      "condition": "Good"
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {"action": "Serial Added", "serial": "IPH15P-2024-001235", "product": "iPhone 15 Pro", "date": "2024-01-20", "user": "Admin"},
    {"action": "Serial Sold", "serial": "SGS24-2024-005679", "product": "Samsung Galaxy S24", "date": "2024-01-19", "user": "Sarah J."},
    {"action": "Status Updated", "serial": "MBP16-2024-009877", "product": "MacBook Pro", "date": "2024-01-18", "user": "Tech Support"},
    {"action": "Serial Returned", "serial": "DLL-LAP-2024-112234", "product": "Dell Inspiron", "date": "2024-01-17", "user": "Returns Dept"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Serial Number Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Serial Numbers", icon: Icon(Icons.qr_code)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSerialNumbersTab(),
        _buildHistoryTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(),
          _buildSerialSummary(),
          _buildStatusChart(),
          _buildRecentActivitiesList(),
        ],
      ),
    );
  }

  Widget _buildSerialNumbersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchFilters(),
          _buildSerialNumbersList(),
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
          _buildHistoryFilters(),
          _buildHistoryList(),
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
          _buildReportChart(),
          _buildExportOptions(),
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
                  label: "Add Serial",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.qr_code_scanner,
                  label: "Scan Serial",
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

  Widget _buildSerialSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Serial Number Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: serialSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
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
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChart() {
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
            "Serial Status Distribution",
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
                    Icons.donut_small,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Status Distribution Chart",
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

  Widget _buildRecentActivitiesList() {
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
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color actionColor = _getActionColor(activity["action"]);
    
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
              color: actionColor,
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
                      "${activity["action"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: actionColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${activity["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${activity["serial"]} • ${activity["product"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "By: ${activity["user"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
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

  Widget _buildSearchFilters() {
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
                  label: "Search Serial Numbers",
                  value: searchQuery,
                  hint: "Enter serial number...",
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
                  label: "Status",
                  items: statusItems,
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
                  label: "Product",
                  items: productItems,
                  value: selectedProduct,
                  onChanged: (value, label) {
                    selectedProduct = value;
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

  Widget _buildSerialNumbersList() {
    return Column(
      spacing: spSm,
      children: serialNumbers.map((serial) => _buildSerialCard(serial)).toList(),
    );
  }

  Widget _buildSerialCard(Map<String, dynamic> serial) {
    Color statusColor = _getStatusColor(serial["status"]);
    
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${serial["serialNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${serial["product"]} • ${serial["sku"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${serial["status"]}",
                  style: TextStyle(
                    color: statusColor,
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
                      "Location: ${serial["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Purchase: ${serial["purchaseDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (serial["customer"] != null)
                      Text(
                        "Customer: ${serial["customer"]}",
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
                    "\$${((serial["price"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${serial["condition"]}",
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
              Text(
                "Warranty: ${serial["warrantyExpiry"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                label: "Edit",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
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
            child: QTextField(
              label: "Search History",
              value: searchQuery,
              hint: "Enter serial or product...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            label: "Filter",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
      spacing: spSm,
      children: recentActivities.map((activity) => _buildHistoryCard(activity)).toList(),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> activity) {
    Color actionColor = _getActionColor(activity["action"]);
    
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
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: actionColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getActionIcon(activity["action"]),
              color: actionColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["serial"]} • ${activity["product"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "By: ${activity["user"]} • ${activity["date"]}",
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
              _buildReportOption("Status Report", Icons.pie_chart, "Serial status breakdown"),
              _buildReportOption("Warranty Report", Icons.shield, "Warranty expiry tracking"),
              _buildReportOption("Sales Report", Icons.trending_up, "Serial sales analysis"),
              _buildReportOption("Defect Report", Icons.bug_report, "Quality issues tracking"),
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

  Widget _buildReportChart() {
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
            "Serial Analytics",
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
                    Icons.analytics,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Analytics Chart",
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

  Widget _buildExportOptions() {
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
            "Export Options",
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

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case "serial added":
        return successColor;
      case "serial sold":
        return infoColor;
      case "status updated":
        return warningColor;
      case "serial returned":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case "serial added":
        return Icons.add_circle;
      case "serial sold":
        return Icons.sell;
      case "status updated":
        return Icons.update;
      case "serial returned":
        return Icons.keyboard_return;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "sold":
        return infoColor;
      case "returned":
        return warningColor;
      case "defective":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
