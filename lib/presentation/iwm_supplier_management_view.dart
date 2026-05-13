import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSupplierManagementView extends StatefulWidget {
  const IwmSupplierManagementView({super.key});

  @override
  State<IwmSupplierManagementView> createState() => _IwmSupplierManagementViewState();
}

class _IwmSupplierManagementViewState extends State<IwmSupplierManagementView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedCategory = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Pending", "value": "pending"},
    {"label": "Suspended", "value": "suspended"},
    {"label": "Blacklisted", "value": "blacklisted"},
  ];
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Raw Materials", "value": "raw_materials"},
    {"label": "Components", "value": "components"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Services", "value": "services"},
    {"label": "Packaging", "value": "packaging"},
  ];
  
  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP-001",
      "name": "ABC Manufacturing Co.",
      "contact": "John Smith",
      "email": "john@abcmfg.com",
      "phone": "+1-234-567-8900",
      "address": "123 Industrial Ave, City, State",
      "category": "Raw Materials",
      "status": "Active",
      "rating": 4.8,
      "totalOrders": 156,
      "totalValue": 2850000.0,
      "onTimeDelivery": 94.5,
      "qualityScore": 98.2,
      "paymentTerms": "Net 30",
      "lastOrder": "2024-01-15",
      "contractStart": "2023-01-01",
      "contractEnd": "2024-12-31"
    },
    {
      "id": "SUP-002",
      "name": "XYZ Components Ltd.",
      "contact": "Sarah Johnson",
      "email": "sarah@xyzcomp.com",
      "phone": "+1-234-567-8901",
      "address": "456 Tech Park Blvd, City, State",
      "category": "Components",
      "status": "Active",
      "rating": 4.6,
      "totalOrders": 89,
      "totalValue": 1650000.0,
      "onTimeDelivery": 91.2,
      "qualityScore": 96.8,
      "paymentTerms": "Net 45",
      "lastOrder": "2024-01-14",
      "contractStart": "2023-06-01",
      "contractEnd": "2025-05-31"
    },
    {
      "id": "SUP-003",
      "name": "Tech Solutions Inc.",
      "contact": "Mike Davis",
      "email": "mike@techsol.com",
      "phone": "+1-234-567-8902",
      "address": "789 Innovation Dr, City, State",
      "category": "Equipment",
      "status": "Pending",
      "rating": 4.2,
      "totalOrders": 45,
      "totalValue": 890000.0,
      "onTimeDelivery": 87.3,
      "qualityScore": 94.1,
      "paymentTerms": "Net 60",
      "lastOrder": "2024-01-10",
      "contractStart": "2023-08-01",
      "contractEnd": "2024-07-31"
    },
    {
      "id": "SUP-004",
      "name": "Global Suppliers Group",
      "contact": "Lisa Wang",
      "email": "lisa@globalsup.com",
      "phone": "+1-234-567-8903",
      "address": "321 Commerce St, City, State",
      "category": "Services",
      "status": "Suspended",
      "rating": 3.8,
      "totalOrders": 23,
      "totalValue": 420000.0,
      "onTimeDelivery": 78.9,
      "qualityScore": 89.5,
      "paymentTerms": "Net 15",
      "lastOrder": "2023-12-20",
      "contractStart": "2023-03-01",
      "contractEnd": "2024-02-29"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Suppliers",
      "value": 248,
      "subtitle": "Registered",
      "icon": Icons.business,
      "color": primaryColor
    },
    {
      "title": "Active",
      "value": 186,
      "subtitle": "Currently Active",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Pending Review",
      "value": 15,
      "subtitle": "Need Approval",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Avg Rating",
      "value": 4.3,
      "subtitle": "Out of 5",
      "icon": Icons.star,
      "color": infoColor,
      "isRating": true
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "new_supplier",
      "supplier": "Tech Innovations Ltd.",
      "action": "New supplier registered",
      "date": "2024-01-15",
      "time": "10:30 AM"
    },
    {
      "type": "rating_update",
      "supplier": "ABC Manufacturing Co.",
      "action": "Rating updated to 4.8",
      "date": "2024-01-14",
      "time": "3:45 PM"
    },
    {
      "type": "contract_renewal",
      "supplier": "XYZ Components Ltd.",
      "action": "Contract renewed for 2 years",
      "date": "2024-01-13",
      "time": "11:20 AM"
    },
    {
      "type": "suspension",
      "supplier": "Global Suppliers Group",
      "action": "Supplier suspended",
      "date": "2024-01-12",
      "time": "2:15 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Supplier Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Suppliers", icon: Icon(Icons.business)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSuppliersTab(),
        _buildPerformanceTab(),
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
          _buildSummaryStats(),
          _buildQuickActions(),
          _buildTopSuppliers(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildSuppliersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildSuppliersList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceMetrics(),
          _buildPerformanceCharts(),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Supplier Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: summaryStats.map((stat) => _buildStatCard(stat)).toList(),
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
            stat["isRating"] == true 
                ? "${(stat["value"] as double).toStringAsFixed(1)}"
                : "${stat["value"]}",
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard("Add Supplier", Icons.add_business, "Register new supplier"),
              _buildActionCard("Bulk Import", Icons.upload, "Import supplier data"),
              _buildActionCard("Performance Review", Icons.assessment, "Review supplier performance"),
              _buildActionCard("Generate Report", Icons.report, "Create supplier report"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, size: 32, color: primaryColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSuppliers() {
    List<Map<String, dynamic>> topSuppliers = suppliers.where((s) => 
      s["status"] == "Active").take(3).toList();
    topSuppliers.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    
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
                "Top Performers",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "This Month",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...topSuppliers.map((supplier) => _buildTopSupplierCard(supplier)),
        ],
      ),
    );
  }

  Widget _buildTopSupplierCard(Map<String, dynamic> supplier) {
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${supplier["name"].toString().split(" ")[0][0]}${supplier["name"].toString().split(" ").length > 1 ? supplier["name"].toString().split(" ")[1][0] : ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${supplier["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${supplier["category"]} • ${supplier["totalOrders"]} orders",
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
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "${(supplier["rating"] as double).toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              Text(
                "\$${((supplier["totalValue"] as double) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
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
    Color activityColor = _getActivityColor(activity["type"]);
    IconData activityIcon = _getActivityIcon(activity["type"]);
    
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
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activityIcon,
              size: 16,
              color: activityColor,
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
                  "${activity["supplier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["date"]} ${activity["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
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
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Suppliers",
                  value: searchQuery,
                  hint: "Name, contact, email...",
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
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
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

  Widget _buildSuppliersList() {
    return Column(
      spacing: spSm,
      children: suppliers.map((supplier) => _buildSupplierCard(supplier)).toList(),
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    Color statusColor = _getStatusColor(supplier["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${supplier["name"].toString().split(" ")[0][0]}${supplier["name"].toString().split(" ").length > 1 ? supplier["name"].toString().split(" ")[1][0] : ""}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${supplier["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${supplier["id"]} • ${supplier["category"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                  "${supplier["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Contact: ${supplier["contact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Email: ${supplier["email"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Phone: ${supplier["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${supplier["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSupplierMetric("Rating", "${(supplier["rating"] as double).toStringAsFixed(1)}/5", warningColor),
              _buildSupplierMetric("Orders", "${supplier["totalOrders"]}", primaryColor),
              _buildSupplierMetric("Total Value", "\$${((supplier["totalValue"] as double) / 1000).toStringAsFixed(0)}K", successColor),
              _buildSupplierMetric("On-Time", "${(supplier["onTimeDelivery"] as double).toStringAsFixed(1)}%", infoColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Terms: ${supplier["paymentTerms"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last Order: ${supplier["lastOrder"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Contract: ${supplier["contractStart"]} - ${supplier["contractEnd"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierMetric(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
            children: [
              _buildMetricCard("Avg. Delivery Time", "3.2 days", successColor),
              _buildMetricCard("Quality Score", "95.8%", primaryColor),
              _buildMetricCard("Cost Savings", "\$125K", infoColor),
              _buildMetricCard("Contract Compliance", "98.2%", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
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
    );
  }

  Widget _buildPerformanceCharts() {
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
            "Performance Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
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
                    "Supplier Performance Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Rating trends and delivery performance",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return disabledBoldColor;
      case 'pending':
        return warningColor;
      case 'suspended':
        return dangerColor;
      case 'blacklisted':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityColor(String type) {
    switch (type.toLowerCase()) {
      case 'new_supplier':
        return successColor;
      case 'rating_update':
        return infoColor;
      case 'contract_renewal':
        return primaryColor;
      case 'suspension':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'new_supplier':
        return Icons.add_business;
      case 'rating_update':
        return Icons.star;
      case 'contract_renewal':
        return Icons.autorenew;
      case 'suspension':
        return Icons.block;
      default:
        return Icons.info;
    }
  }
}
