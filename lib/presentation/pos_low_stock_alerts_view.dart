import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosLowStockAlertsView extends StatefulWidget {
  const PosLowStockAlertsView({super.key});

  @override
  State<PosLowStockAlertsView> createState() => _PosLowStockAlertsViewState();
}

class _PosLowStockAlertsViewState extends State<PosLowStockAlertsView> {
  int selectedTab = 0;
  String selectedPriority = "all";
  String selectedCategory = "all";
  String searchQuery = "";
  bool loading = false;

  // Alert Settings
  bool enableLowStockAlerts = true;
  bool enableOutOfStockAlerts = true;
  bool enableEmailNotifications = false;
  bool enablePushNotifications = true;
  String alertFrequency = "daily";
  String defaultLeadTime = "7";

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Books", "value": "books"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> alertFrequencyOptions = [
    {"label": "Real-time", "value": "realtime"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
  ];

  List<Map<String, dynamic>> lowStockAlerts = [
    {
      "id": "alert_001",
      "product_name": "Bluetooth Speaker",
      "product_sku": "BS-002",
      "category": "electronics",
      "current_stock": 8,
      "min_stock": 15,
      "reorder_point": 20,
      "shortage": 12,
      "priority": "critical",
      "warehouse": "Main Warehouse",
      "supplier": "AudioMax",
      "lead_time_days": 5,
      "last_order_date": "2024-05-20",
      "estimated_stockout": "2024-06-25",
      "daily_sales_avg": 2.5,
      "price": 129.99,
      "cost": 65.00,
      "image": "https://picsum.photos/80/80?random=1&keyword=speaker",
      "status": "active"
    },
    {
      "id": "alert_002",
      "product_name": "Cotton T-Shirt",
      "product_sku": "CT-003",
      "category": "clothing",
      "current_stock": 3,
      "min_stock": 20,
      "reorder_point": 30,
      "shortage": 27,
      "priority": "critical",
      "warehouse": "Store B",
      "supplier": "FashionHub",
      "lead_time_days": 10,
      "last_order_date": "2024-04-15",
      "estimated_stockout": "2024-06-20",
      "daily_sales_avg": 4.2,
      "price": 24.99,
      "cost": 8.50,
      "image": "https://picsum.photos/80/80?random=2&keyword=shirt",
      "status": "active"
    },
    {
      "id": "alert_003",
      "product_name": "Programming Book",
      "product_sku": "PB-005",
      "category": "books",
      "current_stock": 5,
      "min_stock": 8,
      "reorder_point": 12,
      "shortage": 7,
      "priority": "high",
      "warehouse": "Online Warehouse",
      "supplier": "BookWorld",
      "lead_time_days": 14,
      "last_order_date": "2024-05-01",
      "estimated_stockout": "2024-07-10",
      "daily_sales_avg": 0.8,
      "price": 49.99,
      "cost": 15.00,
      "image": "https://picsum.photos/80/80?random=3&keyword=book",
      "status": "active"
    },
    {
      "id": "alert_004",
      "product_name": "Coffee Beans 1kg",
      "product_sku": "CB-004",
      "category": "food",
      "current_stock": 25,
      "min_stock": 30,
      "reorder_point": 40,
      "shortage": 15,
      "priority": "medium",
      "warehouse": "Store A",
      "supplier": "CoffeeMart",
      "lead_time_days": 3,
      "last_order_date": "2024-06-10",
      "estimated_stockout": "2024-07-05",
      "daily_sales_avg": 3.5,
      "price": 32.99,
      "cost": 12.00,
      "image": "https://picsum.photos/80/80?random=4&keyword=coffee",
      "status": "active"
    },
    {
      "id": "alert_005",
      "product_name": "Garden Tools Set",
      "product_sku": "GT-006",
      "category": "home",
      "current_stock": 6,
      "min_stock": 8,
      "reorder_point": 12,
      "shortage": 6,
      "priority": "low",
      "warehouse": "Main Warehouse",
      "supplier": "GardenPro",
      "lead_time_days": 7,
      "last_order_date": "2024-05-25",
      "estimated_stockout": "2024-08-15",
      "daily_sales_avg": 0.5,
      "price": 79.99,
      "cost": 25.00,
      "image": "https://picsum.photos/80/80?random=5&keyword=garden",
      "status": "snoozed"
    },
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return lowStockAlerts.where((alert) {
      final matchesPriority = selectedPriority == "all" || alert["priority"] == selectedPriority;
      final matchesCategory = selectedCategory == "all" || alert["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
        alert["product_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        alert["product_sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final isActive = alert["status"] == "active";
      
      return matchesPriority && matchesCategory && matchesSearch && isActive;
    }).toList()..sort((a, b) {
      // Sort by priority: critical > high > medium > low
      const priorityOrder = {"critical": 0, "high": 1, "medium": 2, "low": 3};
      return priorityOrder[a["priority"]]!.compareTo(priorityOrder[b["priority"]]!);
    });
  }

  void _acknowledgeAlert(String alertId) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final alertIndex = lowStockAlerts.indexWhere((alert) => alert["id"] == alertId);
    if (alertIndex != -1) {
      lowStockAlerts[alertIndex]["status"] = "acknowledged";
    }

    loading = false;
    setState(() {});
    si("Alert acknowledged");
  }

  void _snoozeAlert(String alertId) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final alertIndex = lowStockAlerts.indexWhere((alert) => alert["id"] == alertId);
    if (alertIndex != -1) {
      lowStockAlerts[alertIndex]["status"] = "snoozed";
    }

    loading = false;
    setState(() {});
    si("Alert snoozed for 24 hours");
  }

  void _reorderProduct(Map<String, dynamic> alert) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));

    loading = false;
    setState(() {});
    ss("Reorder initiated for ${alert["product_name"]}");
  }

  void _updateAlertSettings() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 800));

    loading = false;
    setState(() {});
    ss("Alert settings updated successfully");
  }

  Widget _buildAlertStats() {
    final criticalAlerts = lowStockAlerts.where((a) => a["priority"] == "critical" && a["status"] == "active").length;
    final highAlerts = lowStockAlerts.where((a) => a["priority"] == "high" && a["status"] == "active").length;
    final totalActiveAlerts = lowStockAlerts.where((a) => a["status"] == "active").length;
    final estimatedStockouts = lowStockAlerts.where((a) => 
      a["status"] == "active" && 
      DateTime.parse("${a["estimated_stockout"]} 00:00:00").isBefore(DateTime.now().add(Duration(days: 7)))
    ).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$criticalAlerts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Critical Alerts",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.priority_high,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$highAlerts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "High Priority",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.notifications_active,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalActiveAlerts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Active",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.schedule,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$estimatedStockouts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Stockouts (7d)",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertsTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
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
                      label: "Search Products",
                      value: searchQuery,
                      hint: "Enter product name or SKU",
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
                      label: "Priority",
                      items: priorityOptions,
                      value: selectedPriority,
                      onChanged: (value, label) {
                        selectedPriority = value;
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
          ),
        ),
        if (filteredAlerts.isEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "No active low stock alerts",
                    style: TextStyle(
                      fontSize: 16,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredAlerts.map((alert) => _buildAlertCard(alert)),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final priority = alert["priority"] as String;
    final currentStock = alert["current_stock"] as int;
    final minStock = alert["min_stock"] as int;
    final shortage = alert["shortage"] as int;
    final leadTimeDays = alert["lead_time_days"] as int;
    final dailySalesAvg = alert["daily_sales_avg"] as double;
    final estimatedStockout = alert["estimated_stockout"] as String;

    Color priorityColor = successColor;
    if (priority == "critical") priorityColor = dangerColor;
    else if (priority == "high") priorityColor = warningColor;
    else if (priority == "medium") priorityColor = infoColor;

    final stockoutDate = DateTime.parse("$estimatedStockout 00:00:00");
    final daysUntilStockout = stockoutDate.difference(DateTime.now()).inDays;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: priorityColor.withAlpha(50)),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  priority == "critical" ? Icons.error : 
                  priority == "high" ? Icons.warning : 
                  priority == "medium" ? Icons.info : Icons.notifications,
                  color: priorityColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${alert["image"]}",
                  width: 50,
                  height: 50,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${alert["product_sku"]} | ${alert["warehouse"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            priority.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: priorityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "SHORT $shortage UNITS",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  QButton(
                    icon: Icons.shopping_cart,
                    size: bs.sm,
                    onPressed: () => _reorderProduct(alert),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.snooze,
                    size: bs.sm,
                    onPressed: () => _snoozeAlert(alert["id"]),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$currentStock",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
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
                      "Min Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$minStock",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                      "Daily Sales",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${dailySalesAvg.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                      "Lead Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${leadTimeDays}d",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: daysUntilStockout <= 7 ? dangerColor.withAlpha(10) : warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: daysUntilStockout <= 7 ? dangerColor : warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    daysUntilStockout <= 0 
                      ? "STOCKOUT IMMINENT"
                      : "Estimated stockout in $daysUntilStockout days ($estimatedStockout)",
                    style: TextStyle(
                      fontSize: 12,
                      color: daysUntilStockout <= 7 ? dangerColor : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _acknowledgeAlert(alert["id"]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alert Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Alert Types",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable low stock alerts",
                "value": "low_stock",
                "checked": enableLowStockAlerts,
              }
            ],
            value: [if (enableLowStockAlerts) {"label": "Enable low stock alerts", "value": "low_stock", "checked": true}],
            onChanged: (values, ids) {
              enableLowStockAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable out of stock alerts",
                "value": "out_of_stock",
                "checked": enableOutOfStockAlerts,
              }
            ],
            value: [if (enableOutOfStockAlerts) {"label": "Enable out of stock alerts", "value": "out_of_stock", "checked": true}],
            onChanged: (values, ids) {
              enableOutOfStockAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          Text(
            "Notification Settings",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Email notifications",
                "value": "email",
                "checked": enableEmailNotifications,
              }
            ],
            value: [if (enableEmailNotifications) {"label": "Email notifications", "value": "email", "checked": true}],
            onChanged: (values, ids) {
              enableEmailNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Push notifications",
                "value": "push",
                "checked": enablePushNotifications,
              }
            ],
            value: [if (enablePushNotifications) {"label": "Push notifications", "value": "push", "checked": true}],
            onChanged: (values, ids) {
              enablePushNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Alert Frequency",
            items: alertFrequencyOptions,
            value: alertFrequency,
            onChanged: (value, label) {
              alertFrequency = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Default Lead Time (days)",
            value: defaultLeadTime,
            hint: "Default lead time for all products",
            onChanged: (value) {
              defaultLeadTime = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: loading ? "Updating..." : "Update Settings",
              onPressed: loading ? null : _updateAlertSettings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Low Stock Alerts",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active Alerts", icon: Icon(Icons.warning)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildAlertStats(),
              _buildAlertsTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSettingsTab(),
        ),
      ],
    );
  }
}
