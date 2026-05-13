import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSupplierListView extends StatefulWidget {
  const IwmSupplierListView({super.key});

  @override
  State<IwmSupplierListView> createState() => _IwmSupplierListViewState();
}

class _IwmSupplierListViewState extends State<IwmSupplierListView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedRegion = "all";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Raw Materials", "value": "raw_materials"},
    {"label": "Components", "value": "components"},
    {"label": "Packaging", "value": "packaging"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Services", "value": "services"},
  ];
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Suspended", "value": "suspended"},
    {"label": "Inactive", "value": "inactive"},
  ];
  
  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia Pacific", "value": "asia_pacific"},
    {"label": "Latin America", "value": "latin_america"},
  ];

  List<Map<String, dynamic>> supplierSummary = [
    {
      "title": "Total Suppliers",
      "value": 234,
      "subtitle": "Active Partners",
      "icon": Icons.business,
      "color": primaryColor
    },
    {
      "title": "Active",
      "value": 198,
      "subtitle": "84.6% Active",
      "icon": Icons.verified,
      "color": successColor
    },
    {
      "title": "Pending Review",
      "value": 12,
      "subtitle": "New Applications",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Suspended",
      "value": 24,
      "subtitle": "Need Attention",
      "icon": Icons.block,
      "color": dangerColor
    },
  ];

  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP-001",
      "name": "Global Materials Inc.",
      "category": "Raw Materials",
      "contact": "John Smith",
      "email": "john@globalmaterials.com",
      "phone": "+1-555-0123",
      "address": "123 Industrial Ave, Detroit, MI",
      "country": "USA",
      "region": "North America",
      "status": "Active",
      "rating": 4.8,
      "totalOrders": 145,
      "totalValue": 2450000.0,
      "lastOrder": "2024-01-10",
      "joinDate": "2022-03-15",
      "performanceScore": 94,
      "onTimeDelivery": 96,
      "qualityScore": 92,
      "certifications": ["ISO 9001", "ISO 14001"],
      "paymentTerms": "Net 30",
      "creditLimit": 500000.0,
      "logo": "https://picsum.photos/60/60?random=1&keyword=company"
    },
    {
      "id": "SUP-002",
      "name": "TechComponents Ltd",
      "category": "Components",
      "contact": "Sarah Johnson",
      "email": "sarah@techcomponents.co.uk",
      "phone": "+44-20-1234-5678",
      "address": "45 Tech Park, London, UK",
      "country": "United Kingdom",
      "region": "Europe",
      "status": "Active",
      "rating": 4.6,
      "totalOrders": 89,
      "totalValue": 1890000.0,
      "lastOrder": "2024-01-08",
      "joinDate": "2021-11-20",
      "performanceScore": 89,
      "onTimeDelivery": 94,
      "qualityScore": 88,
      "certifications": ["CE", "RoHS"],
      "paymentTerms": "Net 45",
      "creditLimit": 350000.0,
      "logo": "https://picsum.photos/60/60?random=2&keyword=technology"
    },
    {
      "id": "SUP-003",
      "name": "Asia Pacific Packaging",
      "category": "Packaging",
      "contact": "Li Wei",
      "email": "liwei@appackaging.com.sg",
      "phone": "+65-6123-4567",
      "address": "78 Industrial Rd, Singapore",
      "country": "Singapore",
      "region": "Asia Pacific",
      "status": "Active",
      "rating": 4.4,
      "totalOrders": 67,
      "totalValue": 890000.0,
      "lastOrder": "2024-01-05",
      "joinDate": "2023-01-10",
      "performanceScore": 87,
      "onTimeDelivery": 91,
      "qualityScore": 85,
      "certifications": ["FSC", "PEFC"],
      "paymentTerms": "Net 30",
      "creditLimit": 200000.0,
      "logo": "https://picsum.photos/60/60?random=3&keyword=packaging"
    },
    {
      "id": "SUP-004",
      "name": "Industrial Equipment Co",
      "category": "Equipment",
      "contact": "Maria Rodriguez",
      "email": "maria@indequip.com",
      "phone": "+1-713-555-0189",
      "address": "567 Equipment Blvd, Houston, TX",
      "country": "USA",
      "region": "North America",
      "status": "Pending",
      "rating": 4.2,
      "totalOrders": 23,
      "totalValue": 1200000.0,
      "lastOrder": "2023-12-28",
      "joinDate": "2023-09-15",
      "performanceScore": 82,
      "onTimeDelivery": 88,
      "qualityScore": 81,
      "certifications": ["UL", "CSA"],
      "paymentTerms": "Net 60",
      "creditLimit": 400000.0,
      "logo": "https://picsum.photos/60/60?random=4&keyword=equipment"
    },
    {
      "id": "SUP-005",
      "name": "Euro Services Group",
      "category": "Services",
      "contact": "Hans Mueller",
      "email": "hans@euroservices.de",
      "phone": "+49-30-12345678",
      "address": "12 Service Str, Berlin, Germany",
      "country": "Germany",
      "region": "Europe",
      "status": "Suspended",
      "rating": 3.8,
      "totalOrders": 45,
      "totalValue": 650000.0,
      "lastOrder": "2023-11-15",
      "joinDate": "2022-07-08",
      "performanceScore": 74,
      "onTimeDelivery": 82,
      "qualityScore": 76,
      "certifications": ["ISO 27001"],
      "paymentTerms": "Net 30",
      "creditLimit": 150000.0,
      "logo": "https://picsum.photos/60/60?random=5&keyword=services"
    },
  ];

  List<Map<String, dynamic>> get filteredSuppliers {
    return suppliers.where((supplier) {
      bool matchesSearch = searchQuery.isEmpty ||
          supplier["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          supplier["contact"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          supplier["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || supplier["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || supplier["status"].toString().toLowerCase() == selectedStatus;
      bool matchesRegion = selectedRegion == "all" || supplier["region"] == selectedRegion;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesRegion;
    }).toList();
  }

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
          _buildSupplierSummary(),
          _buildQuickActions(),
          _buildRecentActivity(),
          _buildTopPerformers(),
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
          _buildSearchAndFilters(),
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
          _buildPerformanceChart(),
          _buildPerformanceRankings(),
        ],
      ),
    );
  }

  Widget _buildSupplierSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Supplier Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: supplierSummary.map((summary) => _buildSummaryCard(summary)).toList(),
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
                  label: "Add Supplier",
                  icon: Icons.add_business,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Data",
                  icon: Icons.upload_file,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Report",
                  icon: Icons.download,
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

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {"action": "New Supplier", "supplier": "Global Materials Inc.", "time": "2 hours ago", "status": "pending"},
      {"action": "Order Completed", "supplier": "TechComponents Ltd", "time": "5 hours ago", "status": "completed"},
      {"action": "Rating Updated", "supplier": "Asia Pacific Packaging", "time": "1 day ago", "status": "updated"},
      {"action": "Contract Renewed", "supplier": "Industrial Equipment Co", "time": "2 days ago", "status": "renewed"},
    ];

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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color statusColor = _getActivityStatusColor(activity["status"]);
    
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
              color: statusColor,
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
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }

  Widget _buildTopPerformers() {
    List<Map<String, dynamic>> topPerformers = suppliers.where((s) => s["status"] == "Active").toList()
      ..sort((a, b) => (b["performanceScore"] as int).compareTo(a["performanceScore"] as int));
    
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
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topPerformers.take(3).map((supplier) => _buildTopPerformerItem(supplier)),
        ],
      ),
    );
  }

  Widget _buildTopPerformerItem(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${supplier["logo"]}"),
                fit: BoxFit.cover,
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
                  "Score: ${supplier["performanceScore"]}% • ${supplier["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "★ ${supplier["rating"]}",
              style: TextStyle(
                color: successColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
                  label: "Search suppliers...",
                  value: searchQuery,
                  hint: "Name, contact, or category",
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
                  label: "Region",
                  items: regionItems,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
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
      children: [
        Row(
          children: [
            Text(
              "Suppliers (${filteredSuppliers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Add New",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredSuppliers.map((supplier) => _buildSupplierCard(supplier)),
      ],
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    Color statusColor = _getStatusColor(supplier["status"]);
    
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${supplier["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${supplier["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
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
                    Text(
                      "${supplier["category"]} • ${supplier["region"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${supplier["contact"]} • ${supplier["email"]}",
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
          Row(
            children: [
              Expanded(
                child: _buildMetricItem("Rating", "★ ${supplier["rating"]}", successColor),
              ),
              Expanded(
                child: _buildMetricItem("Orders", "${supplier["totalOrders"]}", primaryColor),
              ),
              Expanded(
                child: _buildMetricItem("Value", "\$${((supplier["totalValue"] as double) / 1000).toStringAsFixed(0)}K", infoColor),
              ),
              Expanded(
                child: _buildMetricItem("Performance", "${supplier["performanceScore"]}%", warningColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Last Order: ${supplier["lastOrder"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
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

  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics() {
    List<Map<String, dynamic>> metrics = [
      {"title": "Avg Rating", "value": "4.5", "subtitle": "★ Rating", "color": successColor},
      {"title": "On-Time Delivery", "value": "92%", "subtitle": "Performance", "color": primaryColor},
      {"title": "Quality Score", "value": "88%", "subtitle": "Average", "color": infoColor},
      {"title": "Response Time", "value": "2.3h", "subtitle": "Avg Response", "color": warningColor},
    ];

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
          children: metrics.map((metric) => _buildMetricCard(metric)).toList(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: metric["color"],
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

  Widget _buildPerformanceChart() {
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
            "Performance Trends",
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
                    "Performance Chart",
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

  Widget _buildPerformanceRankings() {
    List<Map<String, dynamic>> rankings = suppliers.where((s) => s["status"] == "Active").toList()
      ..sort((a, b) => (b["performanceScore"] as int).compareTo(a["performanceScore"] as int));

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
            "Performance Rankings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...rankings.take(5).toList().asMap().map((index, supplier) => MapEntry(index, _buildRankingItem(index + 1, supplier))).values,
        ],
      ),
    );
  }

  Widget _buildRankingItem(int rank, Map<String, dynamic> supplier) {
    Color rankColor = rank <= 3 ? successColor : primaryColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: rankColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: rankColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: rankColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "$rank",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${supplier["logo"]}"),
                fit: BoxFit.cover,
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
                  "Score: ${supplier["performanceScore"]}% • Rating: ${supplier["rating"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${supplier["performanceScore"]}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: rankColor,
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
      case 'pending':
        return warningColor;
      case 'suspended':
      case 'inactive':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'updated':
        return infoColor;
      case 'renewed':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
