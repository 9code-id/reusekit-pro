import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaLifoView extends StatefulWidget {
  const ImaLifoView({super.key});

  @override
  State<ImaLifoView> createState() => _ImaLifoViewState();
}

class _ImaLifoViewState extends State<ImaLifoView> {
  String selectedItem = "All Items";
  String selectedPeriod = "Current Month";
  bool showCalculationDetails = true;

  List<Map<String, dynamic>> lifoItems = [
    {
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "category": "Raw Materials",
      "totalQuantity": 500,
      "totalValue": 6375.00,
      "avgCost": 12.75,
      "batches": [
        {
          "batchId": "B001",
          "date": "2024-05-15",
          "quantity": 200,
          "unitCost": 12.00,
          "totalCost": 2400.00,
          "remainingQty": 200,
          "soldQty": 0,
          "status": "Available",
        },
        {
          "batchId": "B002",
          "date": "2024-05-28",
          "quantity": 300,
          "unitCost": 12.50,
          "totalCost": 3750.00,
          "remainingQty": 250,
          "soldQty": 50,
          "status": "Partial",
        },
      ],
    },
    {
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "category": "Components",
      "totalQuantity": 250,
      "totalValue": 11625.00,
      "avgCost": 46.50,
      "batches": [
        {
          "batchId": "B003",
          "date": "2024-04-10",
          "quantity": 100,
          "unitCost": 44.00,
          "totalCost": 4400.00,
          "remainingQty": 100,
          "soldQty": 0,
          "status": "Available",
        },
        {
          "batchId": "B004",
          "date": "2024-05-20",
          "quantity": 150,
          "unitCost": 46.00,
          "totalCost": 6900.00,
          "remainingQty": 125,
          "soldQty": 25,
          "status": "Partial",
        },
      ],
    },
    {
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "category": "Packaging",
      "totalQuantity": 1000,
      "totalValue": 2300.00,
      "avgCost": 2.30,
      "batches": [
        {
          "batchId": "B005",
          "date": "2024-05-01",
          "quantity": 500,
          "unitCost": 2.10,
          "totalCost": 1050.00,
          "remainingQty": 500,
          "soldQty": 0,
          "status": "Available",
        },
        {
          "batchId": "B006",
          "date": "2024-05-25",
          "quantity": 500,
          "unitCost": 2.30,
          "totalCost": 1150.00,
          "remainingQty": 400,
          "soldQty": 100,
          "status": "Partial",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> lifoTransactions = [
    {
      "transactionId": "TXN001",
      "date": "2024-06-18",
      "type": "Sale",
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "quantity": 50,
      "batchUsed": "B002",
      "unitCost": 12.50,
      "totalCost": 625.00,
      "sellingPrice": 15.00,
      "totalRevenue": 750.00,
      "profit": 125.00,
    },
    {
      "transactionId": "TXN002",
      "date": "2024-06-17",
      "type": "Sale",
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "quantity": 25,
      "batchUsed": "B004",
      "unitCost": 46.00,
      "totalCost": 1150.00,
      "sellingPrice": 58.00,
      "totalRevenue": 1450.00,
      "profit": 300.00,
    },
    {
      "transactionId": "TXN003",
      "date": "2024-06-16",
      "type": "Sale",
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "quantity": 100,
      "batchUsed": "B006",
      "unitCost": 2.30,
      "totalCost": 230.00,
      "sellingPrice": 3.50,
      "totalRevenue": 350.00,
      "profit": 120.00,
    },
    {
      "transactionId": "TXN004",
      "date": "2024-06-15",
      "type": "Purchase",
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "quantity": 300,
      "batchUsed": "B002",
      "unitCost": 12.50,
      "totalCost": 3750.00,
      "sellingPrice": 0.00,
      "totalRevenue": 0.00,
      "profit": 0.00,
    },
  ];

  List<Map<String, dynamic>> lifoBenefits = [
    {
      "benefit": "Tax Advantages",
      "description": "LIFO can reduce taxable income during inflationary periods",
      "impact": "High",
      "applicableWhen": "Rising prices",
      "icon": Icons.trending_down,
      "color": "success",
    },
    {
      "benefit": "Cash Flow Improvement",
      "description": "Lower taxes mean better cash flow for operations",
      "impact": "Medium",
      "applicableWhen": "Consistent price increases",
      "icon": Icons.account_balance_wallet,
      "color": "info",
    },
    {
      "benefit": "Inventory Management",
      "description": "Matches current costs with current revenues",
      "impact": "Medium",
      "applicableWhen": "Volatile pricing",
      "icon": Icons.inventory,
      "color": "warning",
    },
    {
      "benefit": "Profit Margin Control",
      "description": "More conservative profit reporting in inflationary times",
      "impact": "Low",
      "applicableWhen": "Price volatility",
      "icon": Icons.control_point,
      "color": "primary",
    },
  ];

  List<Map<String, dynamic>> itemFilterOptions = [
    {"label": "All Items", "value": "All Items"},
    {"label": "RAW001 - Steel Rod 10mm", "value": "RAW001"},
    {"label": "COM002 - Electronic Circuit", "value": "COM002"},
    {"label": "PKG003 - Cardboard Box Large", "value": "PKG003"},
  ];

  List<Map<String, dynamic>> periodOptions = [
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
        title: Text("LIFO Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              _showLifoCalculator();
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showLifoBenefits();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("LIFO report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLifoSummary(),
            SizedBox(height: spLg),
            _buildLifoComparison(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildLifoInventoryTable(),
            SizedBox(height: spLg),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildLifoSummary() {
    double totalValue = lifoItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));
    int totalItems = lifoItems.length;
    double totalProfit = lifoTransactions
        .where((txn) => txn["type"] == "Sale")
        .fold(0.0, (sum, txn) => sum + (txn["profit"] as double));
    double avgCost = totalValue / lifoItems.fold(0, (sum, item) => sum + (item["totalQuantity"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total LIFO Value",
          "\$${(totalValue).currency}",
          Icons.inventory,
          primaryColor,
          "Latest cost basis",
        ),
        _buildSummaryCard(
          "LIFO Profit",
          "\$${(totalProfit).currency}",
          Icons.trending_up,
          successColor,
          "Based on latest cost",
        ),
        _buildSummaryCard(
          "Average Cost",
          "\$${(avgCost).toStringAsFixed(2)}",
          Icons.calculate,
          infoColor,
          "Per unit LIFO",
        ),
        _buildSummaryCard(
          "Active Items",
          "${totalItems}",
          Icons.category,
          warningColor,
          "Items with stock",
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

  Widget _buildLifoComparison() {
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
                Icons.compare_arrows,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "LIFO vs FIFO Impact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildComparisonMetric(
            "Inventory Valuation",
            "LIFO: \$19,300",
            "FIFO: \$19,575",
            "Difference: -\$275",
            dangerColor,
            Icons.inventory,
          ),
          _buildComparisonMetric(
            "Cost of Goods Sold",
            "LIFO: \$12,750",
            "FIFO: \$12,475",
            "Difference: +\$275",
            successColor,
            Icons.attach_money,
          ),
          _buildComparisonMetric(
            "Gross Profit",
            "LIFO: \$8,250",
            "FIFO: \$8,525",
            "Difference: -\$275",
            warningColor,
            Icons.trending_up,
          ),
          _buildComparisonMetric(
            "Tax Impact",
            "LIFO Savings: \$68.75",
            "Tax Rate: 25%",
            "Annual Savings: \$825",
            infoColor,
            Icons.account_balance,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonMetric(String title, String value1, String value2, String difference, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      value1,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      value2,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            difference,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
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
            "LIFO Analysis Filters",
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
                  label: "Select Item",
                  items: itemFilterOptions,
                  value: selectedItem,
                  onChanged: (value, label) {
                    selectedItem = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
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
                      "label": "Show Calculation Details",
                      "value": true,
                      "checked": showCalculationDetails,
                    }
                  ],
                  value: [
                    if (showCalculationDetails)
                      {
                        "label": "Show Calculation Details",
                        "value": true,
                        "checked": true,
                      }
                  ],
                  onChanged: (values, ids) {
                    showCalculationDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Apply LIFO",
                icon: Icons.calculate,
                size: bs.sm,
                onPressed: () {
                  _applyLifoCalculation();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLifoInventoryTable() {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();
    
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
                Icon(
                  Icons.inventory,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Text(
                  "LIFO Inventory Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredItems.length} items",
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
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return _buildLifoItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLifoItem(Map<String, dynamic> item) {
    List<Map<String, dynamic>> batches = item["batches"] as List<Map<String, dynamic>>;
    batches.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));

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
                    "\$${(item["totalValue"] as double).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${item["totalQuantity"]} units",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Batch Sequence (LIFO Order - Latest First)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: batches.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> batch = entry.value;
              return _buildBatchItem(batch, index + 1);
            }).toList(),
          ),
          if (showCalculationDetails) ...[
            SizedBox(height: spMd),
            _buildLifoCalculation(item),
          ],
        ],
      ),
    );
  }

  Widget _buildBatchItem(Map<String, dynamic> batch, int order) {
    Color statusColor = _getBatchStatusColor(batch["status"]);
    bool isLatest = order == 1;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isLatest ? primaryColor : statusColor.withAlpha(100),
          width: isLatest ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isLatest ? primaryColor : statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${order}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                    Text(
                      "Batch ${batch["batchId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${batch["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isLatest) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "LATEST",
                          style: TextStyle(
                            fontSize: 8,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Date: ${batch["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Cost: \$${(batch["unitCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                "${batch["remainingQty"]}/${batch["quantity"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${(batch["totalCost"] as double).currency}",
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

  Widget _buildLifoCalculation(Map<String, dynamic> item) {
    List<Map<String, dynamic>> batches = item["batches"] as List<Map<String, dynamic>>;
    batches.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
    double totalValue = batches.fold(0.0, (sum, batch) => 
        sum + ((batch["remainingQty"] as int) * (batch["unitCost"] as double)));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: infoColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "LIFO Calculation Details (Latest First)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: batches.map((batch) {
              double batchValue = (batch["remainingQty"] as int) * (batch["unitCost"] as double);
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Text(
                      "${batch["batchId"]} (${batch["date"]}):",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${batch["remainingQty"]} × \$${(batch["unitCost"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${(batchValue).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Text(
                "Total LIFO Value:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(totalValue).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Note: LIFO uses the most recent (latest) costs first",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    List<Map<String, dynamic>> recentTxns = lifoTransactions.take(5).toList();
    
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  color: successColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Text(
                  "Recent LIFO Transactions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${recentTxns.length} transactions",
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
            itemCount: recentTxns.length,
            itemBuilder: (context, index) {
              final transaction = recentTxns[index];
              return _buildTransactionItem(transaction);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isSale = transaction["type"] == "Sale";
    Color typeColor = isSale ? successColor : infoColor;
    
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${transaction["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${transaction["itemName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${transaction["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
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
                      "Latest Batch: ${transaction["batchUsed"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Qty: ${transaction["quantity"]} @ \$${(transaction["unitCost"] as double).toStringAsFixed(2)}",
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
                    "\$${(transaction["totalCost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if (isSale) ...[
                    SizedBox(height: 2),
                    Text(
                      "Profit: \$${(transaction["profit"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    if (selectedItem == "All Items") {
      return lifoItems;
    }
    return lifoItems.where((item) => item["itemCode"] == selectedItem).toList();
  }

  Color _getBatchStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Partial":
        return warningColor;
      case "Sold":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getBenefitColor(String color) {
    switch (color) {
      case "success":
        return successColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "primary":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _applyLifoCalculation() {
    ss("LIFO calculation applied successfully");
  }

  void _showLifoCalculator() {
    ss("LIFO calculator opened");
  }

  void _showLifoBenefits() {
    ss("LIFO benefits information displayed");
  }
}
