import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaReorderAlertsView extends StatefulWidget {
  const HhaReorderAlertsView({super.key});

  @override
  State<HhaReorderAlertsView> createState() => _HhaReorderAlertsViewState();
}

class _HhaReorderAlertsViewState extends State<HhaReorderAlertsView> {
  String selectedPriority = "All";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showFilters = false;

  List<Map<String, dynamic>> reorderAlerts = [
    {
      "id": "ALT001",
      "itemName": "Surgical Gloves",
      "itemId": "STK001",
      "category": "Medical Supplies",
      "currentStock": 45,
      "minStock": 200,
      "maxStock": 1000,
      "supplier": "MedSupply Pro",
      "unitPrice": 12.50,
      "suggestedOrder": 500,
      "estimatedCost": 6250.00,
      "priority": "High",
      "status": "Pending",
      "alertDate": "2024-01-15",
      "expectedDays": 3,
      "location": "Medical Storage",
      "lastOrdered": "2023-12-28",
      "avgDailyUsage": 45,
      "leadTime": 5,
      "stockoutRisk": 85,
      "costCenter": "SURGERY",
      "approver": "Dr. Sarah Johnson",
      "notes": "Critical shortage - immediate order required"
    },
    {
      "id": "ALT002",
      "itemName": "Hand Sanitizer",
      "itemId": "STK002",
      "category": "Cleaning Supplies",
      "currentStock": 25,
      "minStock": 50,
      "maxStock": 200,
      "supplier": "CleanTech Solutions",
      "unitPrice": 8.75,
      "suggestedOrder": 175,
      "estimatedCost": 1531.25,
      "priority": "Medium",
      "status": "Approved",
      "alertDate": "2024-01-14",
      "expectedDays": 2,
      "location": "Housekeeping",
      "lastOrdered": "2024-01-08",
      "avgDailyUsage": 12,
      "leadTime": 3,
      "stockoutRisk": 65,
      "costCenter": "HOUSEKEEPING",
      "approver": "Mike Rodriguez",
      "notes": "Regular restock cycle"
    },
    {
      "id": "ALT003",
      "itemName": "Antibiotics - Amoxicillin",
      "itemId": "STK003",
      "category": "Pharmaceuticals",
      "currentStock": 0,
      "minStock": 100,
      "maxStock": 500,
      "supplier": "Pharma Direct",
      "unitPrice": 25.00,
      "suggestedOrder": 400,
      "estimatedCost": 10000.00,
      "priority": "Critical",
      "status": "Ordered",
      "alertDate": "2024-01-13",
      "expectedDays": 1,
      "location": "Pharmacy",
      "lastOrdered": "2023-12-15",
      "avgDailyUsage": 8,
      "leadTime": 2,
      "stockoutRisk": 100,
      "costCenter": "PHARMACY",
      "approver": "Dr. Emily Chen",
      "notes": "OUT OF STOCK - Emergency order placed"
    },
    {
      "id": "ALT004",
      "itemName": "Fresh Vegetables",
      "itemId": "STK004",
      "category": "Food Items",
      "currentStock": 35,
      "minStock": 50,
      "maxStock": 150,
      "supplier": "FoodService Express",
      "unitPrice": 3.20,
      "suggestedOrder": 115,
      "estimatedCost": 368.00,
      "priority": "Low",
      "status": "Dismissed",
      "alertDate": "2024-01-12",
      "expectedDays": 4,
      "location": "Kitchen Storage",
      "lastOrdered": "2024-01-10",
      "avgDailyUsage": 35,
      "leadTime": 1,
      "stockoutRisk": 45,
      "costCenter": "KITCHEN",
      "approver": "Chef Maria Garcia",
      "notes": "Fresh delivery scheduled for tomorrow"
    },
    {
      "id": "ALT005",
      "itemName": "Pain Relief Medication",
      "itemId": "STK008",
      "category": "Pharmaceuticals",
      "currentStock": 65,
      "minStock": 80,
      "maxStock": 300,
      "supplier": "Pharma Direct",
      "unitPrice": 32.00,
      "suggestedOrder": 235,
      "estimatedCost": 7520.00,
      "priority": "Medium",
      "status": "Reviewed",
      "alertDate": "2024-01-14",
      "expectedDays": 5,
      "location": "Pharmacy",
      "lastOrdered": "2024-01-05",
      "avgDailyUsage": 15,
      "leadTime": 2,
      "stockoutRisk": 55,
      "costCenter": "PHARMACY",
      "approver": "Dr. Robert Brown",
      "notes": "Monitor usage trend before ordering"
    },
    {
      "id": "ALT006",
      "itemName": "Disinfectant Spray",
      "itemId": "STK009",
      "category": "Cleaning Supplies",
      "currentStock": 15,
      "minStock": 30,
      "maxStock": 100,
      "supplier": "CleanTech Solutions",
      "unitPrice": 35.00,
      "suggestedOrder": 85,
      "estimatedCost": 2975.00,
      "priority": "High",
      "status": "Pending",
      "alertDate": "2024-01-16",
      "expectedDays": 2,
      "location": "General Storage",
      "lastOrdered": "2024-01-02",
      "avgDailyUsage": 8,
      "leadTime": 3,
      "stockoutRisk": 75,
      "costCenter": "HOUSEKEEPING",
      "approver": "Linda Thompson",
      "notes": "High usage due to flu season"
    },
    {
      "id": "ALT007",
      "itemName": "IV Bags",
      "itemId": "STK010",
      "category": "Medical Supplies",
      "currentStock": 120,
      "minStock": 150,
      "maxStock": 500,
      "supplier": "MedSupply Pro",
      "unitPrice": 18.50,
      "suggestedOrder": 380,
      "estimatedCost": 7030.00,
      "priority": "Medium",
      "status": "Pending",
      "alertDate": "2024-01-15",
      "expectedDays": 8,
      "location": "Medical Storage",
      "lastOrdered": "2024-01-01",
      "avgDailyUsage": 20,
      "leadTime": 5,
      "stockoutRisk": 40,
      "costCenter": "GENERAL",
      "approver": "Nurse Manager",
      "notes": "Stock sufficient for one more week"
    },
    {
      "id": "ALT008",
      "itemName": "Bed Linens",
      "itemId": "STK011",
      "category": "Textiles",
      "currentStock": 85,
      "minStock": 100,
      "maxStock": 300,
      "supplier": "Linen & More",
      "unitPrice": 22.00,
      "suggestedOrder": 215,
      "estimatedCost": 4730.00,
      "priority": "Low",
      "status": "Scheduled",
      "alertDate": "2024-01-13",
      "expectedDays": 12,
      "location": "Linen Storage",
      "lastOrdered": "2023-12-30",
      "avgDailyUsage": 18,
      "leadTime": 7,
      "stockoutRisk": 25,
      "costCenter": "HOUSEKEEPING",
      "approver": "Susan Clark",
      "notes": "Scheduled for next week's bulk order"
    }
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return reorderAlerts.where((alert) {
      if (selectedPriority != "All" && (alert["priority"] as String) != selectedPriority) return false;
      if (selectedCategory != "All" && (alert["category"] as String) != selectedCategory) return false;
      if (selectedStatus != "All" && (alert["status"] as String) != selectedStatus) return false;
      if (searchQuery.isNotEmpty) {
        String query = searchQuery.toLowerCase();
        String itemName = (alert["itemName"] as String).toLowerCase();
        String itemId = (alert["itemId"] as String).toLowerCase();
        if (!itemName.contains(query) && !itemId.contains(query)) return false;
      }
      return true;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return primaryColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Approved":
        return successColor;
      case "Ordered":
        return infoColor;
      case "Reviewed":
        return primaryColor;
      case "Scheduled":
        return secondaryColor;
      case "Dismissed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(alert["priority"] as String),
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
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
                            "${alert["itemName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${alert["itemId"]} • ${alert["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(alert["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["status"]}",
                        style: TextStyle(
                          color: _getStatusColor(alert["status"] as String),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(alert["priority"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["priority"]} Priority",
                        style: TextStyle(
                          color: _getPriorityColor(alert["priority"] as String),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Alert: ${alert["alertDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                // Stock status
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stock Level Alert",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Current: ${alert["currentStock"]} units | Minimum: ${alert["minStock"]} units",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["stockoutRisk"]}% Risk",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Suggested order details
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Suggested Order",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${alert["suggestedOrder"]} units",
                            style: TextStyle(
                              fontSize: fsH6,
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
                            "Estimated Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((alert["estimatedCost"] as double)).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Supply info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
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
                                  "Supplier",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${alert["supplier"]}",
                                  style: TextStyle(
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
                                  "Lead Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${alert["leadTime"]} days",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Daily Usage",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${alert["avgDailyUsage"]} units/day",
                                  style: TextStyle(
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
                                  "Expected Shortage",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${alert["expectedDays"]} days",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Location and approver
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
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${alert["approver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                if ((alert["notes"] as String).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notes:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spSm),

                // Action buttons
                Row(
                  children: [
                    if ((alert["status"] as String) == "Pending") ...[
                      Expanded(
                        child: QButton(
                          label: "Approve Order",
                          size: bs.sm,
                          onPressed: () {
                            ss("Order approved");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          // Edit order details
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.close,
                        size: bs.sm,
                        onPressed: () {
                          ss("Alert dismissed");
                        },
                      ),
                    ] else ...[
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to detailed view
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.history,
                        size: bs.sm,
                        onPressed: () {
                          // Show order history
                        },
                      ),
                    ],
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
                      },
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

  Widget _buildStatsCard() {
    int totalAlerts = reorderAlerts.length;
    int criticalAlerts = reorderAlerts.where((a) => a["priority"] == "Critical").length;
    int pendingAlerts = reorderAlerts.where((a) => a["status"] == "Pending").length;
    double totalCost = reorderAlerts.fold(0.0, (sum, a) => sum + (a["estimatedCost"] as double));

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reorder Alerts Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatItem("Total Alerts", "$totalAlerts", Icons.notifications, primaryColor),
              _buildStatItem("Critical", "$criticalAlerts", Icons.error, dangerColor),
              _buildStatItem("Pending", "$pendingAlerts", Icons.pending_actions, warningColor),
              _buildStatItem("Est. Cost", "\$${(totalCost / 1000).toStringAsFixed(0)}K", Icons.attach_money, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    if (!showFilters) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Critical", "value": "Critical"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
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
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Pending", "value": "Pending"},
                    {"label": "Approved", "value": "Approved"},
                    {"label": "Ordered", "value": "Ordered"},
                    {"label": "Reviewed", "value": "Reviewed"},
                    {"label": "Scheduled", "value": "Scheduled"},
                    {"label": "Dismissed", "value": "Dismissed"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorder Alerts"),
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
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search alerts...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    showFilters = !showFilters;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Filters
            _buildFilters(),

            // Stats overview
            _buildStatsCard(),

            // Category filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "All",
                  "Medical Supplies",
                  "Cleaning Supplies",
                  "Pharmaceuticals",
                  "Food Items",
                  "Textiles",
                  "IT Equipment"
                ].map((category) {
                  bool isSelected = selectedCategory == category;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Results count
            Row(
              children: [
                Text(
                  "${filteredAlerts.length} alerts found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    // Show sort options
                  },
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Alerts list
            ...filteredAlerts.map((alert) => _buildAlertCard(alert)).toList(),

            if (filteredAlerts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No reorder alerts found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
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
