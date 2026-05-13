import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaStockManagementView extends StatefulWidget {
  const RmaStockManagementView({super.key});

  @override
  State<RmaStockManagementView> createState() => _RmaStockManagementViewState();
}

class _RmaStockManagementViewState extends State<RmaStockManagementView> {
  String selectedAction = "all";
  String selectedCategory = "all";
  String dateFilter = "today";
  String searchQuery = "";
  
  List<Map<String, dynamic>> stockTransactions = [
    {
      "id": "TXN-001",
      "itemName": "Ribeye Steak",
      "category": "meat",
      "action": "restock",
      "quantity": 25,
      "unit": "pieces",
      "unitCost": 18.50,
      "totalCost": 462.50,
      "previousStock": 5,
      "newStock": 30,
      "supplier": "Prime Meats Co.",
      "staffMember": "John Manager",
      "timestamp": "2024-03-15 09:30:00",
      "notes": "Weekly delivery - premium quality",
      "location": "Freezer A",
      "batchNumber": "PM-240315-001",
      "expirationDate": "2024-03-22",
    },
    {
      "id": "TXN-002",
      "itemName": "Fresh Salmon",
      "category": "seafood",
      "action": "usage",
      "quantity": -12,
      "unit": "kg",
      "unitCost": 24.00,
      "totalCost": -288.00,
      "previousStock": 20,
      "newStock": 8,
      "supplier": null,
      "staffMember": "Chef Alice",
      "timestamp": "2024-03-15 14:20:00",
      "notes": "Used for lunch service orders",
      "location": "Cooler B",
      "batchNumber": null,
      "expirationDate": null,
    },
    {
      "id": "TXN-003",
      "itemName": "Olive Oil",
      "category": "pantry",
      "action": "adjustment",
      "quantity": -2,
      "unit": "bottles",
      "unitCost": 12.75,
      "totalCost": -25.50,
      "previousStock": 47,
      "newStock": 45,
      "supplier": null,
      "staffMember": "Sarah Supervisor",
      "timestamp": "2024-03-15 16:45:00",
      "notes": "Inventory count adjustment - breakage",
      "location": "Pantry A",
      "batchNumber": null,
      "expirationDate": null,
    },
    {
      "id": "TXN-004",
      "itemName": "Tomatoes",
      "category": "vegetables",
      "action": "waste",
      "quantity": -15,
      "unit": "kg",
      "unitCost": 3.50,
      "totalCost": -52.50,
      "previousStock": 15,
      "newStock": 0,
      "supplier": null,
      "staffMember": "Mike Kitchen",
      "timestamp": "2024-03-15 20:00:00",
      "notes": "Expired - poor quality from supplier",
      "location": "Cooler A",
      "batchNumber": "FF-240312-002",
      "expirationDate": "2024-03-15",
    },
    {
      "id": "TXN-005",
      "itemName": "Red Wine",
      "category": "beverages",
      "action": "restock",
      "quantity": 24,
      "unit": "bottles",
      "unitCost": 22.00,
      "totalCost": 528.00,
      "previousStock": 11,
      "newStock": 35,
      "supplier": "Fine Wines Ltd",
      "staffMember": "Emma Manager",
      "timestamp": "2024-03-15 11:15:00",
      "notes": "Special order for weekend events",
      "location": "Wine Cellar",
      "batchNumber": "FW-240315-003",
      "expirationDate": "2026-12-31",
    },
  ];

  List<Map<String, dynamic>> actionOptions = [
    {"label": "All Actions", "value": "all"},
    {"label": "Restock", "value": "restock"},
    {"label": "Usage", "value": "usage"},
    {"label": "Adjustment", "value": "adjustment"},
    {"label": "Waste", "value": "waste"},
    {"label": "Transfer", "value": "transfer"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Meat", "value": "meat"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Dairy", "value": "dairy"},
    {"label": "Pantry", "value": "pantry"},
    {"label": "Beverages", "value": "beverages"},
  ];

  List<Map<String, dynamic>> dateOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  Widget _buildStockStats() {
    final totalTransactions = stockTransactions.length;
    final restockCount = stockTransactions.where((t) => t["action"] == "restock").length;
    final wasteCount = stockTransactions.where((t) => t["action"] == "waste").length;
    final totalValue = stockTransactions.map((t) => t["totalCost"] as double).reduce((a, b) => a + b);
    
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
            "Stock Management Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Transactions",
                "$totalTransactions",
                Icons.receipt_long,
                primaryColor,
              ),
              _buildStatCard(
                "Restocks",
                "$restockCount",
                Icons.add_shopping_cart,
                successColor,
              ),
              _buildStatCard(
                "Waste Items",
                "$wasteCount",
                Icons.delete,
                dangerColor,
              ),
              _buildStatCard(
                "Net Value",
                "\$${totalValue.currency}",
                Icons.trending_up,
                totalValue >= 0 ? successColor : dangerColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  label: "Search Transactions",
                  value: searchQuery,
                  hint: "Item name, staff member, or notes",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Action Type",
                  items: actionOptions,
                  value: selectedAction,
                  onChanged: (value, label) {
                    selectedAction = value;
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Date Filter",
                  items: dateOptions,
                  value: dateFilter,
                  onChanged: (value, label) {
                    dateFilter = value;
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

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final actionColor = transaction["action"] == "restock" ? successColor :
                       transaction["action"] == "usage" ? infoColor :
                       transaction["action"] == "adjustment" ? warningColor :
                       transaction["action"] == "waste" ? dangerColor :
                       primaryColor;

    final actionIcon = transaction["action"] == "restock" ? Icons.add_shopping_cart :
                      transaction["action"] == "usage" ? Icons.remove_shopping_cart :
                      transaction["action"] == "adjustment" ? Icons.tune :
                      transaction["action"] == "waste" ? Icons.delete :
                      Icons.swap_horiz;

    final isNegative = (transaction["quantity"] as int) < 0;
    final quantity = (transaction["quantity"] as int).abs();

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: actionColor,
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
                    Row(
                      children: [
                        Text(
                          "${transaction["itemName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: actionColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(actionIcon, color: actionColor, size: 12),
                              SizedBox(width: spXs),
                              Text(
                                "${transaction["action"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: actionColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.category, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${transaction["category"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.location_on, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${transaction["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
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
                  Row(
                    children: [
                      if (isNegative)
                        Icon(Icons.remove, color: dangerColor, size: 16)
                      else
                        Icon(Icons.add, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "$quantity ${transaction["unit"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isNegative ? dangerColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((transaction["totalCost"] as double).abs()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isNegative ? dangerColor : successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stock Change",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${transaction["previousStock"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.arrow_forward, color: disabledBoldColor, size: 16),
                              SizedBox(width: spSm),
                              Text(
                                "${transaction["newStock"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: actionColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "\$${((transaction["unitCost"] as double)).currency}/unit",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${transaction["staffMember"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${transaction["timestamp"]}",
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
              if (transaction["supplier"] != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_shipping, color: successColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${transaction["supplier"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (transaction["batchNumber"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.qr_code, color: primaryColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Batch: ${transaction["batchNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (transaction["expirationDate"] != null) ...[
                          SizedBox(height: spXs),
                          Text(
                            "Expires: ${transaction["expirationDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (transaction["notes"] != null && transaction["notes"] != "") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${transaction["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('TransactionDetails')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditTransaction')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.receipt,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('PrintReceipt')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> filtered = List.from(stockTransactions);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) {
        final itemName = "${transaction["itemName"]}".toLowerCase();
        final staffMember = "${transaction["staffMember"]}".toLowerCase();
        final notes = "${transaction["notes"] ?? ""}".toLowerCase();
        final query = searchQuery.toLowerCase();
        return itemName.contains(query) || staffMember.contains(query) || notes.contains(query);
      }).toList();
    }
    
    // Apply action filter
    if (selectedAction != "all") {
      filtered = filtered.where((transaction) => transaction["action"] == selectedAction).toList();
    }
    
    // Apply category filter
    if (selectedCategory != "all") {
      filtered = filtered.where((transaction) => transaction["category"] == selectedCategory).toList();
    }
    
    // Sort by timestamp (newest first)
    filtered.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('NewStockTransaction')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('StockAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildStockStats(),
            _buildFilters(),
            Container(
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
                      Text(
                        "Stock Transactions (${filteredTransactions.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Transaction",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('NewStockTransaction')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredTransactions.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No transactions found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredTransactions.map((transaction) => _buildTransactionCard(transaction)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
