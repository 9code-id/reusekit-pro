import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaWeightedAverageView extends StatefulWidget {
  const ImaWeightedAverageView({super.key});

  @override
  State<ImaWeightedAverageView> createState() => _ImaWeightedAverageViewState();
}

class _ImaWeightedAverageViewState extends State<ImaWeightedAverageView> {
  String selectedItem = "All Items";
  String selectedPeriod = "Current Month";
  bool showCalculationDetails = true;
  String calculationMethod = "Continuous";

  List<Map<String, dynamic>> weightedAvgItems = [
    {
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "category": "Raw Materials",
      "totalQuantity": 500,
      "totalValue": 6250.00,
      "weightedAvgCost": 12.50,
      "standardCost": 12.25,
      "variance": 0.25,
      "variancePercent": 2.04,
      "transactions": [
        {
          "date": "2024-05-15",
          "type": "Purchase",
          "quantity": 200,
          "unitCost": 12.00,
          "totalCost": 2400.00,
          "runningQty": 200,
          "runningValue": 2400.00,
          "newAvgCost": 12.00,
        },
        {
          "date": "2024-05-20",
          "type": "Sale",
          "quantity": 50,
          "unitCost": 12.00,
          "totalCost": 600.00,
          "runningQty": 150,
          "runningValue": 1800.00,
          "newAvgCost": 12.00,
        },
        {
          "date": "2024-05-28",
          "type": "Purchase",
          "quantity": 300,
          "unitCost": 12.50,
          "totalCost": 3750.00,
          "runningQty": 450,
          "runningValue": 5550.00,
          "newAvgCost": 12.33,
        },
        {
          "date": "2024-06-05",
          "type": "Sale",
          "quantity": 100,
          "unitCost": 12.33,
          "totalCost": 1233.33,
          "runningQty": 350,
          "runningValue": 4316.67,
          "newAvgCost": 12.33,
        },
      ],
    },
    {
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "category": "Components",
      "totalQuantity": 250,
      "totalValue": 11437.50,
      "weightedAvgCost": 45.75,
      "standardCost": 45.00,
      "variance": 0.75,
      "variancePercent": 1.67,
      "transactions": [
        {
          "date": "2024-04-10",
          "type": "Purchase",
          "quantity": 100,
          "unitCost": 44.00,
          "totalCost": 4400.00,
          "runningQty": 100,
          "runningValue": 4400.00,
          "newAvgCost": 44.00,
        },
        {
          "date": "2024-05-20",
          "type": "Purchase",
          "quantity": 150,
          "unitCost": 46.00,
          "totalCost": 6900.00,
          "runningQty": 250,
          "runningValue": 11300.00,
          "newAvgCost": 45.20,
        },
        {
          "date": "2024-05-25",
          "type": "Sale",
          "quantity": 25,
          "unitCost": 45.20,
          "totalCost": 1130.00,
          "runningQty": 225,
          "runningValue": 10170.00,
          "newAvgCost": 45.20,
        },
      ],
    },
    {
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "category": "Packaging",
      "totalQuantity": 1000,
      "totalValue": 2250.00,
      "weightedAvgCost": 2.25,
      "standardCost": 2.20,
      "variance": 0.05,
      "variancePercent": 2.27,
      "transactions": [
        {
          "date": "2024-05-01",
          "type": "Purchase",
          "quantity": 500,
          "unitCost": 2.10,
          "totalCost": 1050.00,
          "runningQty": 500,
          "runningValue": 1050.00,
          "newAvgCost": 2.10,
        },
        {
          "date": "2024-05-15",
          "type": "Sale",
          "quantity": 200,
          "unitCost": 2.10,
          "totalCost": 420.00,
          "runningQty": 300,
          "runningValue": 630.00,
          "newAvgCost": 2.10,
        },
        {
          "date": "2024-05-25",
          "type": "Purchase",
          "quantity": 500,
          "unitCost": 2.30,
          "totalCost": 1150.00,
          "runningQty": 800,
          "runningValue": 1780.00,
          "newAvgCost": 2.225,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> calculationMethods = [
    {
      "method": "Continuous",
      "description": "Recalculates average cost after each transaction",
      "pros": ["Real-time accuracy", "Reflects current market conditions"],
      "cons": ["More complex calculations", "Frequent cost changes"],
      "recommended": "High-volume operations",
    },
    {
      "method": "Periodic",
      "description": "Recalculates average cost at period end",
      "pros": ["Simpler calculations", "Stable cost during period"],
      "cons": ["Less accurate during period", "Delayed cost updates"],
      "recommended": "Low-volume operations",
    },
    {
      "method": "Moving Average",
      "description": "Uses fixed number of recent transactions",
      "pros": ["Responsive to trends", "Eliminates old data impact"],
      "cons": ["May ignore seasonal patterns", "Complex to maintain"],
      "recommended": "Volatile markets",
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

  List<Map<String, dynamic>> methodOptions = [
    {"label": "Continuous", "value": "Continuous"},
    {"label": "Periodic", "value": "Periodic"},
    {"label": "Moving Average", "value": "Moving Average"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weighted Average"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showMethodInfo();
            },
          ),
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              _showWeightedAvgCalculator();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Weighted average report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeightedAvgSummary(),
            SizedBox(height: spLg),
            _buildMethodComparison(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildWeightedAvgTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightedAvgSummary() {
    double totalValue = weightedAvgItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));
    double avgWeightedCost = weightedAvgItems.fold(0.0, (sum, item) => sum + (item["weightedAvgCost"] as double)) / weightedAvgItems.length;
    double totalVariance = weightedAvgItems.fold(0.0, (sum, item) => sum + (item["variance"] as double));
    int totalQuantity = weightedAvgItems.fold(0, (sum, item) => sum + (item["totalQuantity"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total WA Value",
          "\$${(totalValue).currency}",
          Icons.balance,
          primaryColor,
          "Weighted average basis",
        ),
        _buildSummaryCard(
          "Avg WA Cost",
          "\$${(avgWeightedCost).toStringAsFixed(2)}",
          Icons.calculate,
          infoColor,
          "Per unit average",
        ),
        _buildSummaryCard(
          "Cost Variance",
          "${totalVariance >= 0 ? '+' : ''}\$${(totalVariance).toStringAsFixed(2)}",
          Icons.trending_up,
          totalVariance >= 0 ? dangerColor : successColor,
          "vs Standard cost",
        ),
        _buildSummaryCard(
          "Total Quantity",
          "${totalQuantity}",
          Icons.inventory,
          warningColor,
          "Units in stock",
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
          Row(
            children: [
              Icon(
                Icons.compare,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Calculation Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: calculationMethods.map((method) {
              return _buildMethodItem(method);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodItem(Map<String, dynamic> method) {
    bool isSelected = method["method"] == calculationMethod;
    Color methodColor = isSelected ? primaryColor : disabledBoldColor;
    
    return GestureDetector(
      onTap: () {
        calculationMethod = method["method"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${method["method"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: methodColor,
                    ),
                  ),
                ),
                if (isSelected) ...[
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 20,
                  ),
                ],
              ],
            ),
            SizedBox(height: spXs),
            Text(
              "${method["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Pros:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (method["pros"] as List<String>).map((pro) {
                          return Text(
                            "• $pro",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: dangerColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Cons:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (method["cons"] as List<String>).map((con) {
                          return Text(
                            "• $con",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: infoColor,
                    size: 14,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Best for: ${method["recommended"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
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
            "Weighted Average Settings",
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
                  label: "Calculation Method",
                  items: methodOptions,
                  value: calculationMethod,
                  onChanged: (value, label) {
                    calculationMethod = value;
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
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Calculations",
                      "value": true,
                      "checked": showCalculationDetails,
                    }
                  ],
                  value: [
                    if (showCalculationDetails)
                      {
                        "label": "Show Calculations",
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
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Recalculate Weighted Average",
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                _recalculateWeightedAverage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightedAvgTable() {
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
                  Icons.balance,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Text(
                  "Weighted Average Analysis",
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
              return _buildWeightedAvgItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeightedAvgItem(Map<String, dynamic> item) {
    bool isPositiveVariance = (item["variance"] as double) >= 0;
    List<Map<String, dynamic>> transactions = item["transactions"] as List<Map<String, dynamic>>;

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
          Row(
            children: [
              Expanded(
                child: _buildMetric(
                  "Weighted Avg Cost",
                  "\$${(item["weightedAvgCost"] as double).toStringAsFixed(2)}",
                  Icons.calculate,
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildMetric(
                  "Standard Cost",
                  "\$${(item["standardCost"] as double).toStringAsFixed(2)}",
                  Icons.straighten,
                  infoColor,
                ),
              ),
              Expanded(
                child: _buildMetric(
                  "Variance",
                  "${isPositiveVariance ? '+' : ''}\$${(item["variance"] as double).toStringAsFixed(2)}",
                  isPositiveVariance ? Icons.trending_up : Icons.trending_down,
                  isPositiveVariance ? dangerColor : successColor,
                ),
              ),
            ],
          ),
          if (showCalculationDetails) ...[
            SizedBox(height: spMd),
            _buildTransactionHistory(item),
          ],
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
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
        ),
      ],
    );
  }

  Widget _buildTransactionHistory(Map<String, dynamic> item) {
    List<Map<String, dynamic>> transactions = item["transactions"] as List<Map<String, dynamic>>;
    
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
                Icons.history,
                color: infoColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Weighted Average Calculation History",
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
            children: transactions.map((transaction) {
              return _buildTransactionItem(transaction);
            }).toList(),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Text(
                  "Final Weighted Average Cost:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(item["weightedAvgCost"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isPurchase = transaction["type"] == "Purchase";
    Color typeColor = isPurchase ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: typeColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: typeColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${transaction["type"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${transaction["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Qty: ${transaction["quantity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Unit Cost: \$${(transaction["unitCost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Total: \$${(transaction["totalCost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "New Avg: \$${(transaction["newAvgCost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (transaction["runningQty"] as int) / 1000,
            backgroundColor: typeColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(typeColor),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    if (selectedItem == "All Items") {
      return weightedAvgItems;
    }
    return weightedAvgItems.where((item) => item["itemCode"] == selectedItem).toList();
  }

  void _recalculateWeightedAverage() {
    ss("Weighted average recalculated using $calculationMethod method");
  }

  void _showWeightedAvgCalculator() {
    ss("Weighted average calculator opened");
  }

  void _showMethodInfo() {
    ss("Calculation method information displayed");
  }
}
