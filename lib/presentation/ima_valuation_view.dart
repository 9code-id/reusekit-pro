import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaValuationView extends StatefulWidget {
  const ImaValuationView({super.key});

  @override
  State<ImaValuationView> createState() => _ImaValuationViewState();
}

class _ImaValuationViewState extends State<ImaValuationView> {
  String selectedMethod = "Weighted Average";
  String selectedPeriod = "Current Month";
  bool showDetailedView = false;

  List<Map<String, dynamic>> inventoryItems = [
    {
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "category": "Raw Materials",
      "quantity": 500,
      "unitCost": 12.50,
      "totalValue": 6250.00,
      "fifoValue": 6125.00,
      "lifoValue": 6375.00,
      "weightedAvgValue": 6250.00,
      "marketValue": 6000.00,
      "lastUpdated": "2024-06-18",
      "location": "Warehouse A",
      "supplier": "Steel Corp",
      "reorderLevel": 100,
      "maxLevel": 1000,
    },
    {
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "category": "Components",
      "quantity": 250,
      "unitCost": 45.75,
      "totalValue": 11437.50,
      "fifoValue": 11250.00,
      "lifoValue": 11625.00,
      "weightedAvgValue": 11437.50,
      "marketValue": 11700.00,
      "lastUpdated": "2024-06-17",
      "location": "Warehouse B",
      "supplier": "Electronics Inc",
      "reorderLevel": 50,
      "maxLevel": 500,
    },
    {
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "category": "Packaging",
      "quantity": 1000,
      "unitCost": 2.25,
      "totalValue": 2250.00,
      "fifoValue": 2200.00,
      "lifoValue": 2300.00,
      "weightedAvgValue": 2250.00,
      "marketValue": 2100.00,
      "lastUpdated": "2024-06-16",
      "location": "Warehouse C",
      "supplier": "Package Solutions",
      "reorderLevel": 200,
      "maxLevel": 2000,
    },
    {
      "itemCode": "FIN004",
      "itemName": "Aluminum Sheet",
      "category": "Finished Goods",
      "quantity": 150,
      "unitCost": 85.00,
      "totalValue": 12750.00,
      "fifoValue": 12600.00,
      "lifoValue": 12900.00,
      "weightedAvgValue": 12750.00,
      "marketValue": 13000.00,
      "lastUpdated": "2024-06-18",
      "location": "Production Floor",
      "supplier": "Metal Works",
      "reorderLevel": 30,
      "maxLevel": 300,
    },
    {
      "itemCode": "TOL005",
      "itemName": "Precision Drill Bit",
      "category": "Tools",
      "quantity": 75,
      "unitCost": 125.00,
      "totalValue": 9375.00,
      "fifoValue": 9300.00,
      "lifoValue": 9450.00,
      "weightedAvgValue": 9375.00,
      "marketValue": 9500.00,
      "lastUpdated": "2024-06-15",
      "location": "Tool Room",
      "supplier": "Tool Masters",
      "reorderLevel": 15,
      "maxLevel": 150,
    },
  ];

  List<Map<String, dynamic>> methodItems = [
    {"label": "Weighted Average", "value": "Weighted Average"},
    {"label": "FIFO", "value": "FIFO"},
    {"label": "LIFO", "value": "LIFO"},
    {"label": "Market Value", "value": "Market Value"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Current Month", "value": "Current Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Current Quarter", "value": "Current Quarter"},
    {"label": "Last Quarter", "value": "Last Quarter"},
    {"label": "Current Year", "value": "Current Year"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Valuation"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showValuationSettings();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Valuation report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildValuationSummary(),
            SizedBox(height: spLg),
            _buildMethodComparison(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildInventoryValuationTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildValuationSummary() {
    double totalValue = _getTotalValueByMethod(selectedMethod);
    double marketValue = inventoryItems.fold(0.0, (sum, item) => sum + (item["marketValue"] as double));
    double variance = totalValue - marketValue;
    double variancePercent = (variance / marketValue) * 100;

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Valuation",
          "\$${(totalValue).currency}",
          Icons.account_balance,
          primaryColor,
          selectedMethod,
        ),
        _buildSummaryCard(
          "Market Value",
          "\$${(marketValue).currency}",
          Icons.trending_up,
          infoColor,
          "Current market price",
        ),
        _buildSummaryCard(
          "Variance",
          "${variance >= 0 ? '+' : ''}\$${(variance).toStringAsFixed(2)}",
          Icons.compare_arrows,
          variance >= 0 ? successColor : dangerColor,
          "${variancePercent >= 0 ? '+' : ''}${variancePercent.toStringAsFixed(1)}%",
        ),
        _buildSummaryCard(
          "Total Items",
          "${inventoryItems.length}",
          Icons.inventory,
          warningColor,
          "Unique SKUs",
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
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
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spMd),
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodComparison() {
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
            "Valuation Method Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildMethodComparisonItem("Weighted Average", _getTotalValueByMethod("Weighted Average"), primaryColor),
          _buildMethodComparisonItem("FIFO", _getTotalValueByMethod("FIFO"), successColor),
          _buildMethodComparisonItem("LIFO", _getTotalValueByMethod("LIFO"), warningColor),
          _buildMethodComparisonItem("Market Value", _getTotalValueByMethod("Market Value"), infoColor),
        ],
      ),
    );
  }

  Widget _buildMethodComparisonItem(String method, double value, Color color) {
    double maxValue = _getTotalValueByMethod("Market Value");
    double percentage = value / maxValue;
    bool isSelected = method == selectedMethod;

    return GestureDetector(
      onTap: () {
        selectedMethod = method;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(30) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? color : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    method,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? color : primaryColor,
                    ),
                  ),
                ),
                Text(
                  "\$${(value).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? color : primaryColor,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: spXs),
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 16,
                  ),
                ],
              ],
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: color.withAlpha(50),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
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
            "Valuation Settings",
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
                  label: "Valuation Method",
                  items: methodItems,
                  value: selectedMethod,
                  onChanged: (value, label) {
                    selectedMethod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Detailed View",
                      "value": true,
                      "checked": showDetailedView,
                    }
                  ],
                  value: [
                    if (showDetailedView)
                      {
                        "label": "Show Detailed View",
                        "value": true,
                        "checked": true,
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetailedView = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Refresh Data",
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  ss("Valuation data refreshed");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryValuationTable() {
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
                  "Inventory Valuation Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Method: $selectedMethod",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: inventoryItems.length,
            itemBuilder: (context, index) {
              final item = inventoryItems[index];
              return _buildValuationItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildValuationItem(Map<String, dynamic> item) {
    double currentValue = _getItemValueByMethod(item, selectedMethod);
    double marketValue = item["marketValue"] as double;
    double variance = currentValue - marketValue;
    bool isAboveMarket = variance > 0;

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
                    Row(
                      children: [
                        Text(
                          "${item["itemCode"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(currentValue).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        isAboveMarket ? Icons.trending_up : Icons.trending_down,
                        color: isAboveMarket ? dangerColor : successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${isAboveMarket ? '+' : ''}\$${variance.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isAboveMarket ? dangerColor : successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildValueMetric(
                  "Quantity",
                  "${item["quantity"]}",
                  Icons.inventory,
                ),
              ),
              Expanded(
                child: _buildValueMetric(
                  "Unit Cost",
                  "\$${(item["unitCost"] as double).toStringAsFixed(2)}",
                  Icons.attach_money,
                ),
              ),
              Expanded(
                child: _buildValueMetric(
                  "Market Value",
                  "\$${(marketValue).currency}",
                  Icons.price_check,
                ),
              ),
            ],
          ),
          if (showDetailedView) ...[
            SizedBox(height: spMd),
            _buildDetailedValuation(item),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location: ${item["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Supplier: ${item["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Updated: ${item["lastUpdated"]}",
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

  Widget _buildValueMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
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
                color: primaryColor,
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

  Widget _buildDetailedValuation(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Valuation Methods Comparison",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMethodValue("FIFO", item["fifoValue"] as double),
              ),
              Expanded(
                child: _buildMethodValue("LIFO", item["lifoValue"] as double),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildMethodValue("Weighted Avg", item["weightedAvgValue"] as double),
              ),
              Expanded(
                child: _buildMethodValue("Market", item["marketValue"] as double),
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
                      "Reorder Level: ${item["reorderLevel"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Max Level: ${item["maxLevel"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStockStatusColor(item).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStockStatus(item),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStockStatusColor(item),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodValue(String method, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          method,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${(value).currency}",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  double _getTotalValueByMethod(String method) {
    return inventoryItems.fold(0.0, (sum, item) {
      return sum + _getItemValueByMethod(item, method);
    });
  }

  double _getItemValueByMethod(Map<String, dynamic> item, String method) {
    switch (method) {
      case "FIFO":
        return item["fifoValue"] as double;
      case "LIFO":
        return item["lifoValue"] as double;
      case "Weighted Average":
        return item["weightedAvgValue"] as double;
      case "Market Value":
        return item["marketValue"] as double;
      default:
        return item["totalValue"] as double;
    }
  }

  String _getStockStatus(Map<String, dynamic> item) {
    int quantity = item["quantity"] as int;
    int reorderLevel = item["reorderLevel"] as int;
    int maxLevel = item["maxLevel"] as int;

    if (quantity <= reorderLevel) {
      return "Low Stock";
    } else if (quantity >= maxLevel * 0.8) {
      return "High Stock";
    } else {
      return "Normal";
    }
  }

  Color _getStockStatusColor(Map<String, dynamic> item) {
    String status = _getStockStatus(item);
    switch (status) {
      case "Low Stock":
        return dangerColor;
      case "High Stock":
        return warningColor;
      case "Normal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showValuationSettings() {
    // Show valuation settings dialog
    ss("Valuation settings opened");
  }
}
