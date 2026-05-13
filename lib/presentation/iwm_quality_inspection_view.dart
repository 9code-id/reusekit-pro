import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmQualityInspectionView extends StatefulWidget {
  const IwmQualityInspectionView({super.key});

  @override
  State<IwmQualityInspectionView> createState() => _IwmQualityInspectionViewState();
}

class _IwmQualityInspectionViewState extends State<IwmQualityInspectionView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Passed", "value": "passed"},
    {"label": "Failed", "value": "failed"},
    {"label": "On Hold", "value": "on_hold"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Receiving", "value": "receiving"},
    {"label": "Random", "value": "random"},
    {"label": "Batch", "value": "batch"},
    {"label": "Return", "value": "return"},
  ];
  
  List<Map<String, dynamic>> inspections = [
    {
      "id": "QI-2024-0001",
      "itemCode": "ITM-001",
      "itemName": "Industrial Bearing",
      "supplier": "ABC Manufacturing",
      "receiptId": "GR-2024-0001",
      "inspectionDate": "2024-01-15",
      "inspector": "John Smith",
      "status": "Passed",
      "type": "Receiving",
      "quantity": 100,
      "passedQty": 98,
      "failedQty": 2,
      "defectRate": 2.0,
      "notes": "2 units with minor scratches, within tolerance",
      "priority": "High",
      "location": "QC-Area-01"
    },
    {
      "id": "QI-2024-0002",
      "itemCode": "ITM-002",
      "itemName": "Electronic Component",
      "supplier": "XYZ Components",
      "receiptId": "GR-2024-0002",
      "inspectionDate": "2024-01-14",
      "inspector": "Sarah Johnson",
      "status": "In Progress",
      "type": "Batch",
      "quantity": 500,
      "passedQty": 0,
      "failedQty": 0,
      "defectRate": 0.0,
      "notes": "Inspection in progress, estimated completion in 2 hours",
      "priority": "Medium",
      "location": "QC-Area-02"
    },
    {
      "id": "QI-2024-0003",
      "itemCode": "ITM-003",
      "itemName": "Steel Plate",
      "supplier": "Tech Solutions Ltd",
      "receiptId": "GR-2024-0003",
      "inspectionDate": "2024-01-13",
      "inspector": "Mike Davis",
      "status": "Failed",
      "type": "Random",
      "quantity": 25,
      "passedQty": 18,
      "failedQty": 7,
      "defectRate": 28.0,
      "notes": "Material hardness below specification",
      "priority": "High",
      "location": "QC-Area-01"
    },
    {
      "id": "QI-2024-0004",
      "itemCode": "ITM-004",
      "itemName": "Plastic Housing",
      "supplier": "Global Suppliers",
      "receiptId": "GR-2024-0004",
      "inspectionDate": "2024-01-12",
      "inspector": "Lisa Wang",
      "status": "Pending",
      "type": "Receiving",
      "quantity": 200,
      "passedQty": 0,
      "failedQty": 0,
      "defectRate": 0.0,
      "notes": "Awaiting inspector assignment",
      "priority": "Low",
      "location": "Pending-Area"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Inspections",
      "value": 342,
      "subtitle": "This Month",
      "icon": Icons.assignment,
      "color": primaryColor
    },
    {
      "title": "Pass Rate",
      "value": 94.5,
      "subtitle": "Quality Score",
      "icon": Icons.check_circle,
      "color": successColor,
      "isPercentage": true
    },
    {
      "title": "Pending",
      "value": 15,
      "subtitle": "Need Inspection",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Failed Items",
      "value": 28,
      "subtitle": "This Week",
      "icon": Icons.error,
      "color": dangerColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Quality Inspection",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inspections", icon: Icon(Icons.assignment)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInspectionsTab(),
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
          _buildSummaryStats(),
          _buildQuickActions(),
          _buildRecentInspections(),
          _buildQualityTrends(),
        ],
      ),
    );
  }

  Widget _buildInspectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildInspectionsList(),
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
          _buildQualityMetrics(),
          _buildDefectAnalysis(),
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
          "Inspection Summary",
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
            stat["isPercentage"] == true 
                ? "${(stat["value"] as double).toStringAsFixed(1)}%"
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
              _buildActionCard("New Inspection", Icons.add_task, "Start quality check"),
              _buildActionCard("Random Sample", Icons.shuffle, "Select random items"),
              _buildActionCard("Batch Inspect", Icons.inventory, "Inspect by batch"),
              _buildActionCard("Generate Report", Icons.report, "Quality report"),
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
              label: "Start",
              size: bs.sm,
              onPressed: () {},
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
                  label: "Search Inspections",
                  value: searchQuery,
                  hint: "ID, Item Code, Inspector...",
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
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildInspectionsList() {
    return Column(
      spacing: spSm,
      children: inspections.map((inspection) => _buildInspectionCard(inspection)).toList(),
    );
  }

  Widget _buildRecentInspections() {
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
            "Recent Inspections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...inspections.take(3).map((inspection) => _buildInspectionCard(inspection)),
        ],
      ),
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    Color statusColor = _getStatusColor(inspection["status"]);
    Color priorityColor = _getPriorityColor(inspection["priority"]);
    Color typeColor = _getTypeColor(inspection["type"]);
    
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${inspection["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${inspection["itemCode"]} - ${inspection["itemName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${inspection["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${inspection["type"]}",
                      style: TextStyle(
                        color: typeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                      "${inspection["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity: ${inspection["quantity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if ((inspection["passedQty"] as int) > 0 || (inspection["failedQty"] as int) > 0)
                            Text(
                              "Passed: ${inspection["passedQty"]} | Failed: ${inspection["failedQty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if ((inspection["defectRate"] as double) > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (inspection["defectRate"] as double) > 10 
                              ? dangerColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(inspection["defectRate"] as double).toStringAsFixed(1)}% defect",
                          style: TextStyle(
                            color: (inspection["defectRate"] as double) > 10 
                                ? dangerColor
                                : warningColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inspector: ${inspection["inspector"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${inspection["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Date: ${inspection["inspectionDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if ((inspection["notes"] as String).isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.notes, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${inspection["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            "Quality Trends",
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
                    "Quality Trends Chart",
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

  Widget _buildQualityMetrics() {
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
            "Quality Metrics",
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
              _buildMetricCard("Overall Pass Rate", "94.5%", successColor),
              _buildMetricCard("Avg. Inspection Time", "2.3 hrs", infoColor),
              _buildMetricCard("First Pass Yield", "91.2%", primaryColor),
              _buildMetricCard("Defect Rate", "5.5%", dangerColor),
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

  Widget _buildDefectAnalysis() {
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
            "Defect Analysis",
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
                    "Defect Analysis Chart",
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'in progress':
        return infoColor;
      case 'passed':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'on hold':
        return primaryColor;
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

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'receiving':
        return primaryColor;
      case 'random':
        return infoColor;
      case 'batch':
        return warningColor;
      case 'return':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
