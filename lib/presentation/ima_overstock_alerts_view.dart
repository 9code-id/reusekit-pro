import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaOverstockAlertsView extends StatefulWidget {
  const ImaOverstockAlertsView({super.key});

  @override
  State<ImaOverstockAlertsView> createState() => _ImaOverstockAlertsViewState();
}

class _ImaOverstockAlertsViewState extends State<ImaOverstockAlertsView> {
  List<Map<String, dynamic>> overstockAlerts = [
    {
      "id": 1,
      "product_name": "iPhone 15 Pro Max",
      "sku": "IP15PM-256-TB",
      "current_stock": 85,
      "optimal_stock": 25,
      "excess_quantity": 60,
      "storage_cost": 1200.00,
      "category": "Electronics",
      "supplier": "Apple Inc",
      "alert_level": "High",
      "days_in_stock": 45,
      "last_sale": "2025-06-10",
      "image": "https://picsum.photos/80/80?random=1&keyword=phone",
    },
    {
      "id": 2,
      "product_name": "Samsung Galaxy S24 Ultra",
      "sku": "SGS24U-512-BL",
      "current_stock": 72,
      "optimal_stock": 20,
      "excess_quantity": 52,
      "storage_cost": 980.00,
      "category": "Electronics",
      "supplier": "Samsung Electronics",
      "alert_level": "High",
      "days_in_stock": 38,
      "last_sale": "2025-06-12",
      "image": "https://picsum.photos/80/80?random=2&keyword=smartphone",
    },
    {
      "id": 3,
      "product_name": "MacBook Pro 16-inch",
      "sku": "MBP16-1TB-SG",
      "current_stock": 45,
      "optimal_stock": 15,
      "excess_quantity": 30,
      "storage_cost": 2400.00,
      "category": "Computers",
      "supplier": "Apple Inc",
      "alert_level": "Medium",
      "days_in_stock": 28,
      "last_sale": "2025-06-15",
      "image": "https://picsum.photos/80/80?random=3&keyword=laptop",
    },
    {
      "id": 4,
      "product_name": "Sony WH-1000XM5",
      "sku": "SW1000XM5-BK",
      "current_stock": 95,
      "optimal_stock": 30,
      "excess_quantity": 65,
      "storage_cost": 650.00,
      "category": "Audio",
      "supplier": "Sony Corporation",
      "alert_level": "High",
      "days_in_stock": 52,
      "last_sale": "2025-06-08",
      "image": "https://picsum.photos/80/80?random=4&keyword=headphones",
    },
    {
      "id": 5,
      "product_name": "Dell XPS 13",
      "sku": "DXPS13-512-SL",
      "current_stock": 38,
      "optimal_stock": 12,
      "excess_quantity": 26,
      "storage_cost": 780.00,
      "category": "Computers",
      "supplier": "Dell Technologies",
      "alert_level": "Medium",
      "days_in_stock": 35,
      "last_sale": "2025-06-14",
      "image": "https://picsum.photos/80/80?random=5&keyword=computer",
    },
  ];

  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLevel = "All";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Computers", "value": "Computers"},
    {"label": "Audio", "value": "Audio"},
  ];

  List<Map<String, dynamic>> levelItems = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return overstockAlerts.where((alert) {
      bool matchesSearch = "${alert["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${alert["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || alert["category"] == selectedCategory;
      bool matchesLevel = selectedLevel == "All" || alert["alert_level"] == selectedLevel;
      
      return matchesSearch && matchesCategory && matchesLevel;
    }).toList();
  }

  Color _getAlertColor(String level) {
    switch (level) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _adjustStock(Map<String, dynamic> alert) {
    // Adjust stock logic would go here
    ss("Stock adjustment initiated for ${alert["product_name"]}");
  }

  void _createSaleOrder(Map<String, dynamic> alert) {
    // Create sale order logic would go here
    ss("Sale order created for ${alert["product_name"]}");
  }

  void _moveToWarehouse(Map<String, dynamic> alert) {
    // Move to warehouse logic would go here
    ss("${alert["product_name"]} scheduled for warehouse transfer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overstock Alerts"),
        actions: [
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
                        Icon(Icons.warning, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "High Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${overstockAlerts.where((a) => a["alert_level"] == "High").length}",
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
                        Icon(Icons.info, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "Medium Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${overstockAlerts.where((a) => a["alert_level"] == "Medium").length}",
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
                          "Total Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${overstockAlerts.fold(0, (sum, alert) => sum + (alert["excess_quantity"] as int))}",
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
                    label: "Search products or SKU",
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
                    label: "Priority Level",
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

            // Alerts List
            ...filteredAlerts.map((alert) {
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
                                  "${alert["category"]} • ${alert["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                        ],
                      ),

                      // Stock Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Current Stock",
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
                                      color: dangerColor,
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
                                    "Optimal Stock",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${alert["optimal_stock"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
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
                                    "Excess",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${alert["excess_quantity"]}",
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
                                    "Storage Cost",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((alert["storage_cost"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Additional Info
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${alert["days_in_stock"]} days in stock",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "Last sale: ${alert["last_sale"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Action Buttons
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Adjust Stock",
                              size: bs.sm,
                              onPressed: () => _adjustStock(alert),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Create Sale",
                              size: bs.sm,
                              onPressed: () => _createSaleOrder(alert),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Transfer",
                              size: bs.sm,
                              onPressed: () => _moveToWarehouse(alert),
                            ),
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
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No overstock alerts found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "All inventory levels are within optimal range",
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
