import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaStockReportView extends StatefulWidget {
  const ImaStockReportView({super.key});

  @override
  State<ImaStockReportView> createState() => _ImaStockReportViewState();
}

class _ImaStockReportViewState extends State<ImaStockReportView> {
  String selectedLocation = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String reportType = "Summary";
  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));
  DateTime toDate = DateTime.now();
  
  List<Map<String, dynamic>> locationList = [
    {"label": "All Locations", "value": ""},
    {"label": "Main Warehouse", "value": "WH001"},
    {"label": "Secondary Warehouse", "value": "WH002"},
    {"label": "Retail Store A", "value": "ST001"},
    {"label": "Retail Store B", "value": "ST002"},
    {"label": "Online Fulfillment", "value": "ON001"},
  ];
  
  List<Map<String, dynamic>> categoryList = [
    {"label": "All Categories", "value": ""},
    {"label": "Electronics", "value": "ELEC"},
    {"label": "Computer Hardware", "value": "COMP"},
    {"label": "Accessories", "value": "ACC"},
    {"label": "Peripherals", "value": "PER"},
    {"label": "Components", "value": "COMP"},
  ];
  
  List<Map<String, dynamic>> statusList = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Low Stock", "value": "low"},
    {"label": "Out of Stock", "value": "out"},
    {"label": "Overstocked", "value": "over"},
  ];
  
  List<Map<String, dynamic>> stockData = [
    {
      "itemCode": "LAP001",
      "itemName": "Laptop Computer",
      "category": "Electronics",
      "location": "Main Warehouse",
      "currentStock": 45,
      "minStock": 10,
      "maxStock": 100,
      "reorderLevel": 15,
      "unitValue": 450.00,
      "totalValue": 20250.00,
      "lastMovement": DateTime.now().subtract(Duration(days: 2)),
      "status": "Active",
      "supplier": "TechSupply Corp",
    },
    {
      "itemCode": "DES001",
      "itemName": "Desktop Computer",
      "category": "Electronics",
      "location": "Main Warehouse",
      "currentStock": 8,
      "minStock": 5,
      "maxStock": 50,
      "reorderLevel": 10,
      "unitValue": 380.00,
      "totalValue": 3040.00,
      "lastMovement": DateTime.now().subtract(Duration(days: 5)),
      "status": "Low Stock",
      "supplier": "Global Electronics",
    },
    {
      "itemCode": "MON001",
      "itemName": "Monitor 24 inch",
      "category": "Computer Hardware",
      "location": "Secondary Warehouse",
      "currentStock": 0,
      "minStock": 5,
      "maxStock": 80,
      "reorderLevel": 10,
      "unitValue": 180.00,
      "totalValue": 0.00,
      "lastMovement": DateTime.now().subtract(Duration(days: 10)),
      "status": "Out of Stock",
      "supplier": "Display Solutions",
    },
    {
      "itemCode": "KEY001",
      "itemName": "Keyboard Wireless",
      "category": "Accessories",
      "location": "Retail Store A",
      "currentStock": 125,
      "minStock": 20,
      "maxStock": 100,
      "reorderLevel": 30,
      "unitValue": 25.00,
      "totalValue": 3125.00,
      "lastMovement": DateTime.now().subtract(Duration(days: 1)),
      "status": "Overstocked",
      "supplier": "Asia Components Ltd",
    },
    {
      "itemCode": "MOU001",
      "itemName": "Mouse Optical",
      "category": "Accessories",
      "location": "Online Fulfillment",
      "currentStock": 35,
      "minStock": 15,
      "maxStock": 75,
      "reorderLevel": 20,
      "unitValue": 15.00,
      "totalValue": 525.00,
      "lastMovement": DateTime.now().subtract(Duration(hours: 8)),
      "status": "Active",
      "supplier": "Euro Parts Inc",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Report"),
        actions: [
          IconButton(
            onPressed: () {
              _exportReport();
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {
              _printReport();
            },
            icon: Icon(Icons.print),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportFilters(),
            _buildStockSummaryCards(),
            _buildStockAnalysisChart(),
            _buildStockDetailTable(),
            _buildStockAlerts(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildReportFilters() {
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
            "Report Filters",
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
                child: QDropdownField(
                  label: "Location",
                  items: locationList,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryList,
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
                  label: "Stock Status",
                  items: statusList,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "From Date",
                  value: fromDate,
                  onChanged: (value) {
                    fromDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "To Date",
                  value: toDate,
                  onChanged: (value) {
                    toDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Generate Report",
                size: bs.sm,
                icon: Icons.refresh,
                onPressed: () {
                  _generateReport();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStockSummaryCards() {
    final totalItems = stockData.length;
    final activeItems = stockData.where((item) => item["status"] == "Active").length;
    final lowStockItems = stockData.where((item) => item["status"] == "Low Stock").length;
    final outOfStockItems = stockData.where((item) => item["status"] == "Out of Stock").length;
    final totalValue = stockData.map((item) => item["totalValue"] as double).reduce((a, b) => a + b);
    
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Items",
          "$totalItems",
          Icons.inventory,
          primaryColor,
        ),
        _buildSummaryCard(
          "Active Stock",
          "$activeItems",
          Icons.check_circle,
          successColor,
        ),
        _buildSummaryCard(
          "Low Stock",
          "$lowStockItems",
          Icons.warning,
          warningColor,
        ),
        _buildSummaryCard(
          "Out of Stock",
          "$outOfStockItems",
          Icons.cancel,
          dangerColor,
        ),
        _buildSummaryCard(
          "Total Value",
          "\$${totalValue.toStringAsFixed(2)}",
          Icons.attach_money,
          infoColor,
        ),
        _buildSummaryCard(
          "Locations",
          "${locationList.length - 1}",
          Icons.location_on,
          secondaryColor,
        ),
      ],
    );
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
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
  
  Widget _buildStockAnalysisChart() {
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
            "Stock Level Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: QHorizontalScroll(
              children: stockData.map((item) {
                final currentStock = item["currentStock"] as int;
                final maxStock = item["maxStock"] as int;
                final reorderLevel = item["reorderLevel"] as int;
                final stockPercentage = (currentStock / maxStock) * 100;
                
                return Container(
                  width: 180,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["itemCode"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${item["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Text(
                            "Current",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$currentStock",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getStockLevelColor(item["status"]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "Reorder",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$reorderLevel",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      _buildStockLevelBar(stockPercentage, _getStockLevelColor(item["status"])),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStockLevelColor(item["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${item["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getStockLevelColor(item["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStockLevelBar(double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Stock Level",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            Spacer(),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStockDetailTable() {
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
            "Stock Detail Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: stockData.length,
            itemBuilder: (context, index) {
              final item = stockData[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
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
                                "Code: ${item["itemCode"]} | ${item["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStockLevelColor(item["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStockLevelColor(item["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStockMetric("Current Stock", "${item["currentStock"]}", primaryColor),
                        ),
                        Expanded(
                          child: _buildStockMetric("Min Stock", "${item["minStock"]}", warningColor),
                        ),
                        Expanded(
                          child: _buildStockMetric("Max Stock", "${item["maxStock"]}", successColor),
                        ),
                        Expanded(
                          child: _buildStockMetric("Reorder Level", "${item["reorderLevel"]}", infoColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
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
                                "${item["location"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Unit Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(item["unitValue"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Total Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(item["totalValue"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                        Text(
                          "Supplier: ${item["supplier"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Last Movement: ${(item["lastMovement"] as DateTime).dMMMy}",
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
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildStockMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
  
  Widget _buildStockAlerts() {
    final alerts = stockData.where((item) => 
      item["status"] == "Low Stock" || item["status"] == "Out of Stock" || item["status"] == "Overstocked"
    ).toList();
    
    if (alerts.isEmpty) {
      return Container();
    }
    
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
                Icons.warning,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Stock Alerts (${alerts.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStockLevelColor(alert["status"]).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: _getStockLevelColor(alert["status"]).withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getAlertIcon(alert["status"]),
                      color: _getStockLevelColor(alert["status"]),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alert["itemName"]} (${alert["itemCode"]})",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            _getAlertMessage(alert),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStockLevelColor(alert["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getStockLevelColor(alert["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Color _getStockLevelColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      case "Overstocked":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  IconData _getAlertIcon(String status) {
    switch (status) {
      case "Low Stock":
        return Icons.trending_down;
      case "Out of Stock":
        return Icons.cancel;
      case "Overstocked":
        return Icons.trending_up;
      default:
        return Icons.info;
    }
  }
  
  String _getAlertMessage(Map<String, dynamic> alert) {
    switch (alert["status"]) {
      case "Low Stock":
        return "Current stock (${alert["currentStock"]}) is below reorder level (${alert["reorderLevel"]})";
      case "Out of Stock":
        return "Item is completely out of stock";
      case "Overstocked":
        return "Current stock (${alert["currentStock"]}) exceeds maximum level (${alert["maxStock"]})";
      default:
        return "Stock level requires attention";
    }
  }
  
  void _generateReport() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Stock report generated successfully");
    });
  }
  
  void _exportReport() {
    showLoading();
    
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Stock report exported to Excel");
    });
  }
  
  void _printReport() {
    ss("Print dialog opened");
  }
}
