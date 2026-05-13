import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaFifoView extends StatefulWidget {
  const ImaFifoView({super.key});

  @override
  State<ImaFifoView> createState() => _ImaFifoViewState();
}

class _ImaFifoViewState extends State<ImaFifoView> {
  String selectedItem = "All Items";
  String selectedPeriod = "Current Month";
  bool showCalculationDetails = true;

  List<Map<String, dynamic>> fifoItems = [
    {
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "category": "Raw Materials",
      "totalQuantity": 500,
      "totalValue": 6125.00,
      "avgCost": 12.25,
      "batches": [
        {
          "batchId": "B001",
          "date": "2024-05-15",
          "quantity": 200,
          "unitCost": 12.00,
          "totalCost": 2400.00,
          "remainingQty": 150,
          "soldQty": 50,
          "status": "Partial",
        },
        {
          "batchId": "B002",
          "date": "2024-05-28",
          "quantity": 300,
          "unitCost": 12.50,
          "totalCost": 3750.00,
          "remainingQty": 300,
          "soldQty": 0,
          "status": "Available",
        },
      ],
    },
    {
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "category": "Components",
      "totalQuantity": 250,
      "totalValue": 11250.00,
      "avgCost": 45.00,
      "batches": [
        {
          "batchId": "B003",
          "date": "2024-04-10",
          "quantity": 100,
          "unitCost": 44.00,
          "totalCost": 4400.00,
          "remainingQty": 50,
          "soldQty": 50,
          "status": "Partial",
        },
        {
          "batchId": "B004",
          "date": "2024-05-20",
          "quantity": 150,
          "unitCost": 46.00,
          "totalCost": 6900.00,
          "remainingQty": 150,
          "soldQty": 0,
          "status": "Available",
        },
      ],
    },
    {
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "category": "Packaging",
      "totalQuantity": 1000,
      "totalValue": 2200.00,
      "avgCost": 2.20,
      "batches": [
        {
          "batchId": "B005",
          "date": "2024-05-01",
          "quantity": 500,
          "unitCost": 2.10,
          "totalCost": 1050.00,
          "remainingQty": 300,
          "soldQty": 200,
          "status": "Partial",
        },
        {
          "batchId": "B006",
          "date": "2024-05-25",
          "quantity": 500,
          "unitCost": 2.30,
          "totalCost": 1150.00,
          "remainingQty": 500,
          "soldQty": 0,
          "status": "Available",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> fifoTransactions = [
    {
      "transactionId": "TXN001",
      "date": "2024-06-18",
      "type": "Sale",
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "quantity": 50,
      "batchUsed": "B001",
      "unitCost": 12.00,
      "totalCost": 600.00,
      "sellingPrice": 15.00,
      "totalRevenue": 750.00,
      "profit": 150.00,
    },
    {
      "transactionId": "TXN002",
      "date": "2024-06-17",
      "type": "Sale",
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "quantity": 25,
      "batchUsed": "B003",
      "unitCost": 44.00,
      "totalCost": 1100.00,
      "sellingPrice": 58.00,
      "totalRevenue": 1450.00,
      "profit": 350.00,
    },
    {
      "transactionId": "TXN003",
      "date": "2024-06-16",
      "type": "Sale",
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "quantity": 100,
      "batchUsed": "B005",
      "unitCost": 2.10,
      "totalCost": 210.00,
      "sellingPrice": 3.50,
      "totalRevenue": 350.00,
      "profit": 140.00,
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
        title: Text("FIFO Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              _showFifoCalculator();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("FIFO report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFifoSummary(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildFifoInventoryTable(),
            SizedBox(height: spLg),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildFifoSummary() {
    double totalValue = fifoItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));
    int totalItems = fifoItems.length;
    double totalProfit = fifoTransactions
        .where((txn) => txn["type"] == "Sale")
        .fold(0.0, (sum, txn) => sum + (txn["profit"] as double));
    int availableBatches = fifoItems.fold(0, (sum, item) {
      List<Map<String, dynamic>> batches = item["batches"] as List<Map<String, dynamic>>;
      return sum + batches.where((batch) => batch["status"] == "Available").length;
    });

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total FIFO Value",
          "\$${(totalValue).currency}",
          Icons.inventory,
          primaryColor,
          "Current inventory",
        ),
        _buildSummaryCard(
          "FIFO Profit",
          "\$${(totalProfit).currency}",
          Icons.trending_up,
          successColor,
          "Based on oldest cost",
        ),
        _buildSummaryCard(
          "Active Items",
          "${totalItems}",
          Icons.category,
          infoColor,
          "Items with stock",
        ),
        _buildSummaryCard(
          "Available Batches",
          "${availableBatches}",
          Icons.layers,
          warningColor,
          "Ready for sale",
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
            "FIFO Analysis Filters",
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
                label: "Apply FIFO",
                icon: Icons.calculate,
                size: bs.sm,
                onPressed: () {
                  _applyFifoCalculation();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFifoInventoryTable() {
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
                  "FIFO Inventory Analysis",
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
              return _buildFifoItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFifoItem(Map<String, dynamic> item) {
    List<Map<String, dynamic>> batches = item["batches"] as List<Map<String, dynamic>>;
    batches.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));

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
            "Batch Sequence (FIFO Order)",
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
            _buildFifoCalculation(item),
          ],
        ],
      ),
    );
  }

  Widget _buildBatchItem(Map<String, dynamic> batch, int order) {
    Color statusColor = _getBatchStatusColor(batch["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: statusColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: statusColor,
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

  Widget _buildFifoCalculation(Map<String, dynamic> item) {
    List<Map<String, dynamic>> batches = item["batches"] as List<Map<String, dynamic>>;
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
                "FIFO Calculation Details",
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
                      "${batch["batchId"]}:",
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
                "Total FIFO Value:",
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
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    List<Map<String, dynamic>> recentTxns = fifoTransactions.take(5).toList();
    
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
                  "Recent FIFO Transactions",
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
                      "Batch: ${transaction["batchUsed"]}",
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
      return fifoItems;
    }
    return fifoItems.where((item) => item["itemCode"] == selectedItem).toList();
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

  void _applyFifoCalculation() {
    ss("FIFO calculation applied successfully");
  }

  void _showFifoCalculator() {
    ss("FIFO calculator opened");
  }
}
