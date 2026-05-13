import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaExpiryAlertsView extends StatefulWidget {
  const ImaExpiryAlertsView({super.key});

  @override
  State<ImaExpiryAlertsView> createState() => _ImaExpiryAlertsViewState();
}

class _ImaExpiryAlertsViewState extends State<ImaExpiryAlertsView> {
  List<Map<String, dynamic>> expiryAlerts = [
    {
      "id": 1,
      "product_name": "Organic Milk 1L",
      "sku": "OM-1L-001",
      "batch_number": "BT240615001",
      "current_stock": 25,
      "expiry_date": "2025-06-25",
      "days_to_expiry": 7,
      "category": "Dairy",
      "supplier": "Fresh Farms Co",
      "alert_level": "Critical",
      "cost_price": 3.50,
      "selling_price": 4.99,
      "location": "Cold Storage A1",
      "image": "https://picsum.photos/80/80?random=1&keyword=milk",
    },
    {
      "id": 2,
      "product_name": "Greek Yogurt 500g",
      "sku": "GY-500G-002",
      "batch_number": "BT240610002",
      "current_stock": 18,
      "expiry_date": "2025-06-28",
      "days_to_expiry": 10,
      "category": "Dairy",
      "supplier": "Healthy Foods Ltd",
      "alert_level": "High",
      "cost_price": 2.75,
      "selling_price": 3.99,
      "location": "Cold Storage A2",
      "image": "https://picsum.photos/80/80?random=2&keyword=yogurt",
    },
    {
      "id": 3,
      "product_name": "Fresh Bread Loaf",
      "sku": "FB-LOAF-003",
      "batch_number": "BT240618003",
      "current_stock": 42,
      "expiry_date": "2025-06-20",
      "days_to_expiry": 2,
      "category": "Bakery",
      "supplier": "Golden Bakery",
      "alert_level": "Critical",
      "cost_price": 1.20,
      "selling_price": 2.49,
      "location": "Bakery Section B1",
      "image": "https://picsum.photos/80/80?random=3&keyword=bread",
    },
    {
      "id": 4,
      "product_name": "Canned Tomatoes 400g",
      "sku": "CT-400G-004",
      "batch_number": "BT240301004",
      "current_stock": 65,
      "expiry_date": "2025-07-15",
      "days_to_expiry": 27,
      "category": "Canned Goods",
      "supplier": "Metro Foods",
      "alert_level": "Medium",
      "cost_price": 0.89,
      "selling_price": 1.49,
      "location": "Dry Storage C3",
      "image": "https://picsum.photos/80/80?random=4&keyword=tomatoes",
    },
    {
      "id": 5,
      "product_name": "Chicken Breast 1kg",
      "sku": "CB-1KG-005",
      "batch_number": "BT240616005",
      "current_stock": 12,
      "expiry_date": "2025-06-22",
      "days_to_expiry": 4,
      "category": "Meat",
      "supplier": "Prime Meats Inc",
      "alert_level": "Critical",
      "cost_price": 8.50,
      "selling_price": 12.99,
      "location": "Meat Freezer D1",
      "image": "https://picsum.photos/80/80?random=5&keyword=chicken",
    },
  ];

  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLevel = "All";
  String selectedTimeframe = "All";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Bakery", "value": "Bakery"},
    {"label": "Canned Goods", "value": "Canned Goods"},
    {"label": "Meat", "value": "Meat"},
  ];

  List<Map<String, dynamic>> levelItems = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "All", "value": "All"},
    {"label": "Expired", "value": "Expired"},
    {"label": "1-3 Days", "value": "1-3 Days"},
    {"label": "4-7 Days", "value": "4-7 Days"},
    {"label": "8-30 Days", "value": "8-30 Days"},
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return expiryAlerts.where((alert) {
      bool matchesSearch = "${alert["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${alert["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${alert["batch_number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || alert["category"] == selectedCategory;
      bool matchesLevel = selectedLevel == "All" || alert["alert_level"] == selectedLevel;
      
      bool matchesTimeframe = true;
      if (selectedTimeframe != "All") {
        int days = alert["days_to_expiry"] as int;
        switch (selectedTimeframe) {
          case "Expired":
            matchesTimeframe = days < 0;
            break;
          case "1-3 Days":
            matchesTimeframe = days >= 1 && days <= 3;
            break;
          case "4-7 Days":
            matchesTimeframe = days >= 4 && days <= 7;
            break;
          case "8-30 Days":
            matchesTimeframe = days >= 8 && days <= 30;
            break;
        }
      }
      
      return matchesSearch && matchesCategory && matchesLevel && matchesTimeframe;
    }).toList();
  }

  Color _getAlertColor(String level) {
    switch (level) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getExpiryColor(int daysToExpiry) {
    if (daysToExpiry < 0) return dangerColor;
    if (daysToExpiry <= 3) return dangerColor;
    if (daysToExpiry <= 7) return warningColor;
    if (daysToExpiry <= 30) return infoColor;
    return successColor;
  }

  String _getExpiryText(int daysToExpiry) {
    if (daysToExpiry < 0) return "Expired ${(-daysToExpiry)} days ago";
    if (daysToExpiry == 0) return "Expires today";
    if (daysToExpiry == 1) return "Expires tomorrow";
    return "Expires in $daysToExpiry days";
  }

  void _markdownPrice(Map<String, dynamic> alert) {
    // Markdown price logic would go here
    ss("Price markdown initiated for ${alert["product_name"]}");
  }

  void _removeFromInventory(Map<String, dynamic> alert) {
    // Remove from inventory logic would go here
    ss("${alert["product_name"]} removed from inventory");
  }

  void _transferProduct(Map<String, dynamic> alert) {
    // Transfer product logic would go here
    ss("${alert["product_name"]} scheduled for transfer");
  }

  void _contactSupplier(Map<String, dynamic> alert) {
    // Contact supplier logic would go here
    ss("Supplier ${alert["supplier"]} contacted about ${alert["product_name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expiry Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ss("Notification settings opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Alerts refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Alert Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(40)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${expiryAlerts.where((a) => a["alert_level"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(40)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "High Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${expiryAlerts.where((a) => a["alert_level"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(40)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.inventory, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${((expiryAlerts.fold(0.0, (sum, alert) => sum + ((alert["cost_price"] as double) * (alert["current_stock"] as int))))).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search products, SKU, or batch",
                    value: searchQuery,
                    hint: "Type to search...",
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
                    label: "Category",
                    items: categoryItems,
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
                    label: "Priority",
                    items: levelItems,
                    value: selectedLevel,
                    onChanged: (value, label) {
                      selectedLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Expiry Timeframe",
              items: timeframeItems,
              value: selectedTimeframe,
              onChanged: (value, label) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),

            // Alerts List
            ...filteredAlerts.map((alert) {
              Color expiryColor = _getExpiryColor(alert["days_to_expiry"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getAlertColor("${alert["alert_level"]}"),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${alert["image"]}",
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
                                  "${alert["product_name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${alert["sku"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Batch: ${alert["batch_number"]}",
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
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getAlertColor("${alert["alert_level"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${alert["alert_level"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getAlertColor("${alert["alert_level"]}"),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: expiryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getExpiryText(alert["days_to_expiry"] as int),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: expiryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Product Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Stock",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${alert["current_stock"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Cost",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((alert["cost_price"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Selling Price",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((alert["selling_price"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${alert["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.business, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${alert["supplier"]}",
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

                      // Expiry Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: expiryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: expiryColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: expiryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Expiry Date: ${alert["expiry_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: expiryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${alert["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Markdown",
                              size: bs.sm,
                              onPressed: () => _markdownPrice(alert),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Remove",
                              size: bs.sm,
                              onPressed: () => _removeFromInventory(alert),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Transfer",
                              size: bs.sm,
                              onPressed: () => _transferProduct(alert),
                            ),
                          ),
                          QButton(
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () => _contactSupplier(alert),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            if (filteredAlerts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: successColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No expiry alerts found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "All products are within safe expiry dates",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
}
