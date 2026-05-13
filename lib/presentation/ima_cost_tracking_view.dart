import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaCostTrackingView extends StatefulWidget {
  const ImaCostTrackingView({super.key});

  @override
  State<ImaCostTrackingView> createState() => _ImaCostTrackingViewState();
}

class _ImaCostTrackingViewState extends State<ImaCostTrackingView> {
  List<Map<String, dynamic>> costTrackingData = [
    {
      "itemName": "Raw Material A",
      "category": "Raw Materials",
      "currentCost": 125.50,
      "previousCost": 120.00,
      "variance": 5.50,
      "variancePercent": 4.58,
      "supplier": "Supplier ABC",
      "lastUpdated": "2024-06-15",
      "status": "Increased",
      "quantity": 500,
      "totalValue": 62750.00,
    },
    {
      "itemName": "Component B",
      "category": "Components",
      "currentCost": 89.25,
      "previousCost": 95.00,
      "variance": -5.75,
      "variancePercent": -6.05,
      "supplier": "Tech Supplies Ltd",
      "lastUpdated": "2024-06-14",
      "status": "Decreased",
      "quantity": 300,
      "totalValue": 26775.00,
    },
    {
      "itemName": "Packaging Material",
      "category": "Packaging",
      "currentCost": 12.80,
      "previousCost": 12.80,
      "variance": 0.00,
      "variancePercent": 0.00,
      "supplier": "Package Pro",
      "lastUpdated": "2024-06-16",
      "status": "Stable",
      "quantity": 1000,
      "totalValue": 12800.00,
    },
    {
      "itemName": "Electronic Module",
      "category": "Electronics",
      "currentCost": 245.00,
      "previousCost": 230.00,
      "variance": 15.00,
      "variancePercent": 6.52,
      "supplier": "Electronics Hub",
      "lastUpdated": "2024-06-13",
      "status": "Increased",
      "quantity": 150,
      "totalValue": 36750.00,
    },
    {
      "itemName": "Labor Cost/Hour",
      "category": "Labor",
      "currentCost": 45.00,
      "previousCost": 42.50,
      "variance": 2.50,
      "variancePercent": 5.88,
      "supplier": "Internal",
      "lastUpdated": "2024-06-16",
      "status": "Increased",
      "quantity": 800,
      "totalValue": 36000.00,
    },
  ];

  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  String searchQuery = "";
  bool sortAscending = true;
  String sortBy = "itemName";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Components", "value": "Components"},
    {"label": "Packaging", "value": "Packaging"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Labor", "value": "Labor"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Increased", "value": "Increased"},
    {"label": "Decreased", "value": "Decreased"},
    {"label": "Stable", "value": "Stable"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Cost tracking report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildCostTrackingTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    double totalValue = costTrackingData.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));
    double avgVariance = costTrackingData.fold(0.0, (sum, item) => sum + (item["variance"] as double)) / costTrackingData.length;
    int increasedItems = costTrackingData.where((item) => item["status"] == "Increased").length;
    int decreasedItems = costTrackingData.where((item) => item["status"] == "Decreased").length;

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Value",
          "\$${(totalValue).currency}",
          Icons.account_balance_wallet,
          primaryColor,
        ),
        _buildSummaryCard(
          "Avg Variance",
          "${avgVariance >= 0 ? '+' : ''}\$${(avgVariance).toStringAsFixed(2)}",
          Icons.trending_up,
          avgVariance >= 0 ? dangerColor : successColor,
        ),
        _buildSummaryCard(
          "Cost Increases",
          "${increasedItems}",
          Icons.arrow_upward,
          dangerColor,
        ),
        _buildSummaryCard(
          "Cost Decreases",
          "${decreasedItems}",
          Icons.arrow_downward,
          successColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.analytics,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters & Search",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Items",
                  value: searchQuery,
                  hint: "Search by item name or supplier",
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
                onPressed: () {
                  _applyFilters();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    _applyFilters();
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
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostTrackingTable() {
    List<Map<String, dynamic>> filteredData = _getFilteredData();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Cost Tracking Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredData.length} items",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              return _buildCostTrackingItem(item, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCostTrackingItem(Map<String, dynamic> item, int index) {
    Color statusColor = _getStatusColor(item["status"]);
    bool isVariancePositive = (item["variance"] as double) >= 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["itemName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${(item["currentCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  "Previous Cost",
                  "\$${(item["previousCost"] as double).toStringAsFixed(2)}",
                  Icons.history,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  "Variance",
                  "${isVariancePositive ? '+' : ''}\$${(item["variance"] as double).toStringAsFixed(2)}",
                  isVariancePositive ? Icons.trending_up : Icons.trending_down,
                  color: isVariancePositive ? dangerColor : successColor,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  "Quantity",
                  "${item["quantity"]}",
                  Icons.inventory,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Supplier: ${item["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Updated: ${item["lastUpdated"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Total: \$${(item["totalValue"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color ?? primaryColor,
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
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> filtered = costTrackingData;

    if (selectedCategory != "All Categories") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    if (selectedStatus != "All Status") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        item["itemName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Increased":
        return dangerColor;
      case "Decreased":
        return successColor;
      case "Stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _applyFilters() {
    setState(() {});
  }
}
