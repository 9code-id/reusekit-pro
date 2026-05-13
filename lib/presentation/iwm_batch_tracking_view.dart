import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmBatchTrackingView extends StatefulWidget {
  const IwmBatchTrackingView({super.key});

  @override
  State<IwmBatchTrackingView> createState() => _IwmBatchTrackingViewState();
}

class _IwmBatchTrackingViewState extends State<IwmBatchTrackingView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedProduct = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Expired", "value": "expired"},
    {"label": "Recalled", "value": "recalled"},
    {"label": "Quarantine", "value": "quarantine"},
  ];

  List<Map<String, dynamic>> productOptions = [
    {"label": "All Products", "value": "all"},
    {"label": "Wireless Headphones", "value": "headphones"},
    {"label": "Smart Watch", "value": "watch"},
    {"label": "Running Shoes", "value": "shoes"},
    {"label": "Cotton T-Shirt", "value": "shirt"},
  ];

  List<Map<String, dynamic>> batches = [
    {
      "id": "BATCH001",
      "batchNumber": "WH-2024-001-B001",
      "product": "Wireless Headphones",
      "sku": "WH-2024-001",
      "manufactureDate": "2024-01-10",
      "expiryDate": "2027-01-10",
      "quantity": 500,
      "soldQuantity": 125,
      "remainingQuantity": 375,
      "status": "active",
      "supplier": "TechSound Manufacturing",
      "qualityGrade": "A",
      "location": "Warehouse A, Section 1",
      "costPerUnit": 45.50,
      "notes": "High quality batch with premium packaging"
    },
    {
      "id": "BATCH002",
      "batchNumber": "SW-2024-002-B001",
      "product": "Smart Watch",
      "sku": "SW-2024-002",
      "manufactureDate": "2024-01-08",
      "expiryDate": "2026-01-08",
      "quantity": 300,
      "soldQuantity": 78,
      "remainingQuantity": 222,
      "status": "active",
      "supplier": "SmartTech Industries",
      "qualityGrade": "A+",
      "location": "Warehouse B, Section 2",
      "costPerUnit": 120.00,
      "notes": "Latest model with GPS tracking"
    },
    {
      "id": "BATCH003",
      "batchNumber": "RS-2024-003-B001",
      "product": "Running Shoes",
      "sku": "RS-2024-003",
      "manufactureDate": "2024-01-05",
      "expiryDate": "2025-01-05",
      "quantity": 200,
      "soldQuantity": 188,
      "remainingQuantity": 12,
      "status": "active",
      "supplier": "RunFast Sports",
      "qualityGrade": "B+",
      "location": "Warehouse A, Section 3",
      "costPerUnit": 35.00,
      "notes": "Limited edition blue color variant"
    },
    {
      "id": "BATCH004",
      "batchNumber": "CT-2023-004-B003",
      "product": "Cotton T-Shirt",
      "sku": "CT-2024-004",
      "manufactureDate": "2023-12-15",
      "expiryDate": "2024-12-15",
      "quantity": 1000,
      "soldQuantity": 850,
      "remainingQuantity": 150,
      "status": "expired",
      "supplier": "ComfortWear Textiles",
      "qualityGrade": "B",
      "location": "Warehouse C, Section 1",
      "costPerUnit": 8.50,
      "notes": "Cotton blend material, needs clearance"
    },
    {
      "id": "BATCH005",
      "batchNumber": "GT-2023-005-B002",
      "product": "Garden Tools Set",
      "sku": "GT-2024-005",
      "manufactureDate": "2023-11-20",
      "expiryDate": "2025-11-20",
      "quantity": 100,
      "soldQuantity": 45,
      "remainingQuantity": 55,
      "status": "recalled",
      "supplier": "GreenThumb Tools",
      "qualityGrade": "C",
      "location": "Warehouse D, Quarantine",
      "costPerUnit": 89.00,
      "notes": "Recalled due to safety concerns with handle"
    },
  ];

  List<Map<String, dynamic>> batchStats = [
    {
      "title": "Total Batches",
      "value": 287,
      "subtitle": "All Time",
      "icon": Icons.inventory_2,
      "color": primaryColor,
    },
    {
      "title": "Active Batches",
      "value": 234,
      "subtitle": "81% Active",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Expiring Soon",
      "value": 12,
      "subtitle": "Next 30 Days",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Recalled/Quarantine",
      "value": 8,
      "subtitle": "Need Review",
      "icon": Icons.block,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Batch Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Batches", icon: Icon(Icons.inventory_2)),
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildBatchesTab(),
        _buildTrackingTab(),
        _buildAnalyticsTab(),
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
          _buildBatchStats(),
          _buildQuickActions(),
          _buildRecentBatches(),
          _buildExpiryAlerts(),
        ],
      ),
    );
  }

  Widget _buildBatchesTab() {
    List<Map<String, dynamic>> filteredBatches = batches.where((batch) {
      bool statusMatch = selectedStatus == "all" || batch["status"] == selectedStatus;
      bool productMatch = selectedProduct == "all" || (batch["product"] as String).toLowerCase().contains(selectedProduct);
      bool searchMatch = searchQuery.isEmpty || 
          (batch["batchNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (batch["product"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (batch["supplier"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return statusMatch && productMatch && searchMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBatchFilters(),
          _buildBatchList(filteredBatches),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBatchCreator(),
          _buildBatchUpdater(),
          _buildMovementHistory(),
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
          _buildBatchAnalytics(),
          _buildQualityTrends(),
          _buildSupplierPerformance(),
        ],
      ),
    );
  }

  Widget _buildBatchStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: batchStats.map((stat) => _buildStatCard(stat)).toList(),
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
                  label: "Create Batch",
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Data",
                  icon: Icons.upload_file,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Report",
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Quality Check",
                  icon: Icons.verified,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBatches() {
    List<Map<String, dynamic>> recentBatches = batches.take(3).toList();
    
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
                child: Text(
                  "Recent Batches",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  selectedTab = 1;
                  setState(() {});
                },
              ),
            ],
          ),
          ...recentBatches.map((batch) => _buildRecentBatchItem(batch)),
        ],
      ),
    );
  }

  Widget _buildRecentBatchItem(Map<String, dynamic> batch) {
    Color statusColor = _getStatusColor(batch["status"]);
    Color gradeColor = _getGradeColor(batch["qualityGrade"]);
    
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
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.inventory_2,
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
                  "${batch["batchNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${batch["product"]} • ${batch["remainingQuantity"]}/${batch["quantity"]} left",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: gradeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Grade ${batch["qualityGrade"]}",
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: 11,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${batch["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryAlerts() {
    List<Map<String, dynamic>> expiringBatches = batches.where((batch) {
      if (batch["status"] != "active") return false;
      DateTime expiryDate = DateTime.parse(batch["expiryDate"]);
      DateTime now = DateTime.now();
      return expiryDate.difference(now).inDays <= 90; // Expiring in 90 days
    }).toList();
    
    if (expiringBatches.isEmpty) return SizedBox();
    
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
              Icon(Icons.warning, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Expiry Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ),
              QButton(
                label: "Action Required",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...expiringBatches.take(3).map((batch) => _buildExpiryAlertItem(batch)),
          if (expiringBatches.length > 3)
            Text(
              "And ${expiringBatches.length - 3} more expiring batches...",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpiryAlertItem(Map<String, dynamic> batch) {
    DateTime expiryDate = DateTime.parse(batch["expiryDate"]);
    DateTime now = DateTime.now();
    int daysLeft = expiryDate.difference(now).inDays;
    Color alertColor = daysLeft <= 30 ? dangerColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: alertColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: alertColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, color: alertColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${batch["batchNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${batch["product"]} • Expires in $daysLeft days",
                  style: TextStyle(
                    fontSize: 12,
                    color: alertColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Review",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBatchFilters() {
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
                child: Row(
                  children: [
                    Icon(Icons.search, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Search batches...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
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
                  label: "Product",
                  items: productOptions,
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

  Widget _buildBatchList(List<Map<String, dynamic>> batches) {
    return Column(
      spacing: spSm,
      children: batches.map((batch) => _buildBatchCard(batch)).toList(),
    );
  }

  Widget _buildBatchCard(Map<String, dynamic> batch) {
    Color statusColor = _getStatusColor(batch["status"]);
    Color gradeColor = _getGradeColor(batch["qualityGrade"]);
    double soldPercentage = (batch["soldQuantity"] as int) / (batch["quantity"] as int);
    
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: statusColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${batch["batchNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${batch["product"]} (${batch["sku"]})",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Supplier: ${batch["supplier"]}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${batch["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: gradeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Grade ${batch["qualityGrade"]}",
                      style: TextStyle(
                        color: gradeColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manufacture Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["manufactureDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expiry Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["soldQuantity"]}/${batch["quantity"]} sold (${(soldPercentage * 100).toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: soldPercentage,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                children: [
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          if (batch["notes"] != null && (batch["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                "${batch["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBatchCreator() {
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
            "Create New Batch",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Batch Number",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Product",
                  items: productOptions.where((p) => p["value"] != "all").toList(),
                  value: "headphones",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Manufacture Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Expiry Date",
                  value: DateTime.now().add(Duration(days: 1095)), // 3 years
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Supplier",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QButton(
            label: "Create Batch",
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBatchUpdater() {
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
            "Update Batch Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Batch Number",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                label: "Find",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "New Status",
                  items: statusOptions.where((s) => s["value"] != "all").toList(),
                  value: "active",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Quality Grade",
                  items: [
                    {"label": "A+", "value": "A+"},
                    {"label": "A", "value": "A"},
                    {"label": "B+", "value": "B+"},
                    {"label": "B", "value": "B"},
                    {"label": "C", "value": "C"},
                  ],
                  value: "A",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Update Notes",
            value: "",
            onChanged: (value) {},
          ),
          QButton(
            label: "Update Batch",
            icon: Icons.update,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMovementHistory() {
    List<Map<String, dynamic>> movements = [
      {"date": "2024-01-15", "action": "Stock Received", "batch": "WH-2024-001-B001", "quantity": 500, "location": "Warehouse A"},
      {"date": "2024-01-14", "action": "Quality Check", "batch": "WH-2024-001-B001", "quantity": 500, "location": "QC Department"},
      {"date": "2024-01-13", "action": "Batch Created", "batch": "WH-2024-001-B001", "quantity": 500, "location": "Production"},
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
            "Recent Movements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...movements.map((movement) => _buildMovementItem(movement)),
        ],
      ),
    );
  }

  Widget _buildMovementItem(Map<String, dynamic> movement) {
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
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.track_changes,
              color: primaryColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${movement["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${movement["batch"]} • ${movement["quantity"]} units",
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
                "${movement["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${movement["date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatchAnalytics() {
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
            "Batch Analytics",
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
                    Icons.analytics,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Batch Performance Analytics",
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

  Widget _buildQualityTrends() {
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
            "Quality Grade Distribution",
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
              _buildQualityCard("A+", 45, successColor),
              _buildQualityCard("A", 78, primaryColor),
              _buildQualityCard("B+", 32, infoColor),
              _buildQualityCard("B", 18, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualityCard(String grade, int count, Color color) {
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
            "Grade $grade",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "Batches",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierPerformance() {
    List<Map<String, dynamic>> suppliers = [
      {"name": "TechSound Manufacturing", "batches": 45, "avgGrade": "A", "onTimeDelivery": 98.5},
      {"name": "SmartTech Industries", "batches": 38, "avgGrade": "A+", "onTimeDelivery": 99.2},
      {"name": "RunFast Sports", "batches": 32, "avgGrade": "B+", "onTimeDelivery": 95.8},
      {"name": "ComfortWear Textiles", "batches": 28, "avgGrade": "B", "onTimeDelivery": 92.3},
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
            "Supplier Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...suppliers.map((supplier) => _buildSupplierItem(supplier)),
        ],
      ),
    );
  }

  Widget _buildSupplierItem(Map<String, dynamic> supplier) {
    Color gradeColor = _getGradeColor(supplier["avgGrade"]);
    double deliveryRate = supplier["onTimeDelivery"];
    Color deliveryColor = deliveryRate >= 95 ? successColor : deliveryRate >= 90 ? warningColor : dangerColor;
    
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
                  "${supplier["batches"]} batches • Avg Grade ${supplier["avgGrade"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: gradeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Grade ${supplier["avgGrade"]}",
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: deliveryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deliveryRate.toStringAsFixed(1)}% OTD",
                  style: TextStyle(
                    color: deliveryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "expired":
        return warningColor;
      case "recalled":
      case "quarantine":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case "A+":
        return successColor;
      case "A":
        return primaryColor;
      case "B+":
        return infoColor;
      case "B":
        return warningColor;
      case "C":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
