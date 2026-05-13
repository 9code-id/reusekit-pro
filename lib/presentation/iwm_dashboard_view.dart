import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmDashboardView extends StatefulWidget {
  const IwmDashboardView({super.key});

  @override
  State<IwmDashboardView> createState() => _IwmDashboardViewState();
}

class _IwmDashboardViewState extends State<IwmDashboardView> {
  int currentBottomIndex = 0;

  // Dashboard Data
  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Total Products",
      "value": "1,247",
      "change": "+12%",
      "isPositive": true,
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Low Stock Items",
      "value": "23",
      "change": "-8%",
      "isPositive": true,
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Total Value",
      "value": "\$2.4M",
      "change": "+15%",
      "isPositive": true,
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Locations",
      "value": "8",
      "change": "+1",
      "isPositive": true,
      "icon": Icons.location_on,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "action": "Stock Replenishment",
      "item": "Office Chairs",
      "quantity": "+50 units",
      "user": "John Smith",
      "time": "2 hours ago",
      "type": "in",
    },
    {
      "action": "Item Shipped",
      "item": "Laptops",
      "quantity": "-15 units",
      "user": "System",
      "time": "4 hours ago",
      "type": "out",
    },
    {
      "action": "Low Stock Alert",
      "item": "Printer Paper",
      "quantity": "5 units left",
      "user": "System",
      "time": "6 hours ago",
      "type": "alert",
    },
    {
      "action": "New Item Added",
      "item": "Standing Desks",
      "quantity": "+25 units",
      "user": "Sarah Wilson",
      "time": "1 day ago",
      "type": "new",
    },
  ];

  List<Map<String, dynamic>> lowStockItems = [
    {
      "name": "Printer Paper A4",
      "sku": "PPR-A4-001",
      "current": 5,
      "minimum": 20,
      "location": "Office - Floor 1",
      "urgency": "High",
    },
    {
      "name": "Blue Ink Pens",
      "sku": "PEN-BLU-012",
      "current": 12,
      "minimum": 50,
      "location": "Supply Room",
      "urgency": "Medium",
    },
    {
      "name": "USB Cables",
      "sku": "CBL-USB-005",
      "current": 8,
      "minimum": 25,
      "location": "IT Storage",
      "urgency": "Medium",
    },
  ];

  List<Map<String, dynamic>> topPerformingItems = [
    {
      "name": "Wireless Mouse",
      "sku": "MSE-WL-001",
      "movement": 125,
      "value": "\$2,450",
      "trend": "up",
    },
    {
      "name": "Monitor 24\"",
      "sku": "MON-24-003",
      "movement": 89,
      "value": "\$15,680",
      "trend": "up",
    },
    {
      "name": "Desk Lamp",
      "sku": "LMP-DSK-007",
      "movement": 67,
      "value": "\$1,340",
      "trend": "down",
    },
  ];

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "in":
        return successColor;
      case "out":
        return infoColor;
      case "alert":
        return warningColor;
      case "new":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "in":
        return Icons.arrow_upward;
      case "out":
        return Icons.arrow_downward;
      case "alert":
        return Icons.warning;
      case "new":
        return Icons.add;
      default:
        return Icons.info;
    }
  }

  Widget _buildKpiCard(Map<String, dynamic> kpi) {
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kpi["color"].withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  kpi["icon"],
                  color: kpi["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: kpi["isPositive"] 
                      ? successColor.withAlpha(20) 
                      : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${kpi["change"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kpi["isPositive"] ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${kpi["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${kpi["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
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
                child: QButton(
                  label: "Add Item",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Scan Barcode",
                  icon: Icons.qr_code_scanner,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.assessment,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Stock Transfer",
                  icon: Icons.swap_horiz,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Welcome Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning, John!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Here's what's happening in your warehouse today",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // KPI Metrics Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: kpiMetrics.map((kpi) => _buildKpiCard(kpi)).toList(),
          ),

          // Quick Actions
          _buildQuickActions(),

          // Recent Activities
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
                    Expanded(
                      child: Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...recentActivities.map((activity) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getActivityColor(activity["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getActivityIcon(activity["type"]),
                            color: _getActivityColor(activity["type"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["action"]} - ${activity["item"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${activity["quantity"]} • ${activity["user"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Alert Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${lowStockItems.where((item) => item["urgency"] == "High").length}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Critical Alerts",
                        style: TextStyle(
                          fontSize: 14,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${lowStockItems.where((item) => item["urgency"] == "Medium").length}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Warning Alerts",
                        style: TextStyle(
                          fontSize: 14,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Low Stock Items
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
                Text(
                  "Low Stock Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...lowStockItems.map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _getUrgencyColor(item["urgency"]).withAlpha(100),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      color: _getUrgencyColor(item["urgency"]).withAlpha(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getUrgencyColor(item["urgency"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["urgency"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getUrgencyColor(item["urgency"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "SKU: ${item["sku"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Current: ${item["current"]} | Min: ${item["minimum"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _getUrgencyColor(item["urgency"]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Location: ${item["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Reorder",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Update Stock",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Top Performing Items
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
                Text(
                  "Top Performing Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...topPerformingItems.map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
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
                                "SKU: ${item["sku"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item["trend"] == "up" 
                                      ? Icons.trending_up 
                                      : Icons.trending_down,
                                  color: item["trend"] == "up" 
                                      ? successColor 
                                      : dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["movement"]} moves",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["value"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Analytics Actions
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
                Text(
                  "Analytics Reports",
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
                      child: QButton(
                        label: "Inventory Report",
                        icon: Icons.inventory,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Movement Report",
                        icon: Icons.timeline,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Value Report",
                        icon: Icons.monetization_on,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Forecast Report",
                        icon: Icons.trending_up,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Inventory Dashboard",
      selectedIndex: currentBottomIndex,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.warning),
          label: "Alerts",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: "Analytics",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildDashboardTab(),
        _buildAlertsTab(),
        _buildAnalyticsTab(),
        Container(
          padding: EdgeInsets.all(spMd),
          child: Center(
            child: Text(
              "Profile Tab",
              style: TextStyle(
                fontSize: fsH4,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
      onTap: (index) {
        currentBottomIndex = index;
        setState(() {});
      },
    );
  }
}
