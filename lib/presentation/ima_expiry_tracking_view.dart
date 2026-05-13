import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaExpiryTrackingView extends StatefulWidget {
  const ImaExpiryTrackingView({super.key});

  @override
  State<ImaExpiryTrackingView> createState() => _ImaExpiryTrackingViewState();
}

class _ImaExpiryTrackingViewState extends State<ImaExpiryTrackingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedPeriod = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> expiringItems = [
    {
      "id": "EXP001",
      "name": "Antibiotics Pack",
      "category": "Medicine",
      "sku": "MED-ANT-001",
      "batch": "BT2024001",
      "quantity": 50,
      "unitPrice": 25.0,
      "expiryDate": "2024-07-15",
      "daysToExpiry": 26,
      "status": "Critical",
      "supplier": "PharmaCorp",
      "location": "A-01-15",
      "image": "https://picsum.photos/60/60?random=1&keyword=medicine",
    },
    {
      "id": "EXP002",
      "name": "Organic Milk",
      "category": "Dairy",
      "sku": "DAIRY-MLK-002",
      "batch": "BT2024002",
      "quantity": 24,
      "unitPrice": 4.50,
      "expiryDate": "2024-06-25",
      "daysToExpiry": 6,
      "status": "Expired Soon",
      "supplier": "Fresh Farms",
      "location": "B-02-08",
      "image": "https://picsum.photos/60/60?random=2&keyword=milk",
    },
    {
      "id": "EXP003",
      "name": "Canned Tomatoes",
      "category": "Food",
      "sku": "FOOD-TOM-003",
      "batch": "BT2024003",
      "quantity": 100,
      "unitPrice": 2.25,
      "expiryDate": "2024-08-30",
      "daysToExpiry": 72,
      "status": "Warning",
      "supplier": "Food Industries",
      "location": "C-03-22",
      "image": "https://picsum.photos/60/60?random=3&keyword=tomato",
    },
    {
      "id": "EXP004",
      "name": "Vitamin Supplements",
      "category": "Health",
      "sku": "HLTH-VIT-004",
      "batch": "BT2024004",
      "quantity": 75,
      "unitPrice": 15.75,
      "expiryDate": "2024-06-20",
      "daysToExpiry": 1,
      "status": "Expired",
      "supplier": "HealthCorp",
      "location": "D-01-05",
      "image": "https://picsum.photos/60/60?random=4&keyword=vitamins",
    },
    {
      "id": "EXP005",
      "name": "Fresh Bread",
      "category": "Bakery",
      "sku": "BAK-BRD-005",
      "batch": "BT2024005",
      "quantity": 30,
      "unitPrice": 3.00,
      "expiryDate": "2024-06-22",
      "daysToExpiry": 3,
      "status": "Critical",
      "supplier": "Local Bakery",
      "location": "E-01-12",
      "image": "https://picsum.photos/60/60?random=5&keyword=bread",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "All", "value": "All"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Next 7 Days", "value": "7days"},
    {"label": "Next 30 Days", "value": "30days"},
    {"label": "Next 90 Days", "value": "90days"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medicine", "value": "Medicine"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Food", "value": "Food"},
    {"label": "Health", "value": "Health"},
    {"label": "Bakery", "value": "Bakery"},
  ];

  List<Map<String, dynamic>> get filteredItems {
    var items = expiringItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["batch"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      
      bool matchesPeriod = true;
      if (selectedPeriod != "All") {
        int daysToExpiry = item["daysToExpiry"] as int;
        switch (selectedPeriod) {
          case "Expired":
            matchesPeriod = daysToExpiry < 0;
            break;
          case "7days":
            matchesPeriod = daysToExpiry >= 0 && daysToExpiry <= 7;
            break;
          case "30days":
            matchesPeriod = daysToExpiry >= 0 && daysToExpiry <= 30;
            break;
          case "90days":
            matchesPeriod = daysToExpiry >= 0 && daysToExpiry <= 90;
            break;
        }
      }
      
      return matchesSearch && matchesCategory && matchesPeriod;
    }).toList();

    // Sort by days to expiry (most urgent first)
    items.sort((a, b) => (a["daysToExpiry"] as int).compareTo(b["daysToExpiry"] as int));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Expired":
        return dangerColor;
      case "Critical":
        return Colors.red.shade700;
      case "Expired Soon":
        return Colors.orange.shade600;
      case "Warning":
        return warningColor;
      default:
        return successColor;
    }
  }

  int get expiredCount {
    return expiringItems.where((item) => (item["daysToExpiry"] as int) < 0).length;
  }

  int get criticalCount {
    return expiringItems.where((item) => (item["daysToExpiry"] as int) >= 0 && (item["daysToExpiry"] as int) <= 7).length;
  }

  double get totalValueAtRisk {
    return filteredItems.fold(0.0, (sum, item) => sum + ((item["quantity"] as int) * (item["unitPrice"] as double)));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expiry Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to expiry alerts
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to tracking settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlertSummary(),
            _buildFilters(),
            _buildExpiryList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new batch with expiry date
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAlertSummary() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAlertCard(
                "Expired",
                "$expiredCount",
                Icons.dangerous,
                dangerColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAlertCard(
                "Critical (≤7 days)",
                "$criticalCount",
                Icons.warning,
                Colors.red.shade700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildAlertCard(
                "Total Items",
                "${filteredItems.length}",
                Icons.inventory,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAlertCard(
                "Value at Risk",
                "\$${totalValueAtRisk.currency}",
                Icons.attach_money,
                warningColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAlertCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search items...",
                value: searchQuery,
                hint: "Search by name, SKU, or batch",
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
              child: QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpiryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiring Items (${filteredItems.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return _buildExpiryItem(item);
          },
        ),
      ],
    );
  }

  Widget _buildExpiryItem(Map<String, dynamic> item) {
    int daysToExpiry = item["daysToExpiry"] as int;
    double totalValue = (item["quantity"] as int) * (item["unitPrice"] as double);
    
    String expiryText;
    if (daysToExpiry < 0) {
      expiryText = "Expired ${(-daysToExpiry)} days ago";
    } else if (daysToExpiry == 0) {
      expiryText = "Expires today";
    } else {
      expiryText = "Expires in $daysToExpiry days";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${item["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "SKU: ${item["sku"]} | Batch: ${item["batch"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${item["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${item["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          expiryText,
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor("${item["status"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["quantity"]} units",
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
                      "Unit Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["unitPrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                      "\$${totalValue.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expiry Date: ${item["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Location: ${item["location"]} | Supplier: ${item["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showItemActions(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showItemActions(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Item Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.visibility, color: primaryColor),
              title: Text("View Details"),
              onTap: () {
                back();
                // Navigate to item details
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: infoColor),
              title: Text("Update Expiry Date"),
              onTap: () {
                back();
                _updateExpiryDate(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.sell, color: successColor),
              title: Text("Mark for Clearance"),
              onTap: () {
                back();
                _markForClearance(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove Expired"),
              onTap: () {
                back();
                _removeExpiredItem(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateExpiryDate(Map<String, dynamic> item) {
    // Update expiry date logic
    ss("Expiry date updated successfully");
  }

  void _markForClearance(Map<String, dynamic> item) {
    // Mark for clearance logic
    ss("Item marked for clearance sale");
  }

  void _removeExpiredItem(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove this expired item from inventory?");
    if (isConfirmed) {
      // Remove expired item logic
      ss("Expired item removed from inventory");
    }
  }
}
