import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPointsSystemView extends StatefulWidget {
  const RfsPointsSystemView({super.key});

  @override
  State<RfsPointsSystemView> createState() => _RfsPointsSystemViewState();
}

class _RfsPointsSystemViewState extends State<RfsPointsSystemView> {
  int selectedTab = 0;
  String selectedCustomer = "";
  String pointsToAdd = "";
  String pointsToRedeem = "";
  String adjustmentReason = "";
  String manualPointsAdjustment = "";
  bool enablePointsExpiry = false;
  String pointsExpiryDays = "365";

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "Sarah Johnson",
      "loyaltyNumber": "LY001234",
      "currentPoints": 850,
      "tier": "Gold",
      "email": "sarah.j@email.com"
    },
    {
      "id": "CUST002",
      "name": "Michael Chen",
      "loyaltyNumber": "LY002345",
      "currentPoints": 1250,
      "tier": "Platinum",
      "email": "m.chen@email.com"
    },
    {
      "id": "CUST003",
      "name": "Emily Davis",
      "loyaltyNumber": "LY003456",
      "currentPoints": 320,
      "tier": "Silver",
      "email": "emily.davis@email.com"
    }
  ];

  List<Map<String, dynamic>> pointsTransactions = [
    {
      "id": "PT001",
      "customerId": "CUST001",
      "customerName": "Sarah Johnson",
      "type": "Earned",
      "points": 68,
      "description": "Purchase - Order #ORD-1234",
      "timestamp": "2024-06-19 15:45",
      "staff": "John Manager",
      "orderId": "ORD-1234"
    },
    {
      "id": "PT002",
      "customerId": "CUST002",
      "customerName": "Michael Chen",
      "type": "Redeemed",
      "points": -250,
      "description": "Free Appetizer Reward",
      "timestamp": "2024-06-19 14:30",
      "staff": "Lisa Server",
      "orderId": "ORD-1230"
    },
    {
      "id": "PT003",
      "customerId": "CUST003",
      "customerName": "Emily Davis",
      "type": "Adjustment",
      "points": 50,
      "description": "Customer service compensation",
      "timestamp": "2024-06-19 13:15",
      "staff": "Mark Manager",
      "orderId": null
    },
    {
      "id": "PT004",
      "customerId": "CUST001",
      "customerName": "Sarah Johnson",
      "type": "Bonus",
      "points": 100,
      "description": "Birthday bonus points",
      "timestamp": "2024-06-18 10:00",
      "staff": "System Auto",
      "orderId": null
    },
    {
      "id": "PT005",
      "customerId": "CUST002",
      "customerName": "Michael Chen",
      "type": "Expired",
      "points": -50,
      "description": "Points expired after 365 days",
      "timestamp": "2024-06-17 00:00",
      "staff": "System Auto",
      "orderId": null
    }
  ];

  List<Map<String, dynamic>> customerOptions = [];
  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Customer Service Compensation", "value": "Customer Service Compensation"},
    {"label": "System Error Correction", "value": "System Error Correction"},
    {"label": "Promotional Bonus", "value": "Promotional Bonus"},
    {"label": "Referral Bonus", "value": "Referral Bonus"},
    {"label": "Manager Override", "value": "Manager Override"}
  ];

  @override
  void initState() {
    super.initState();
    customerOptions = customers.map((customer) => {
      "label": "${customer["name"]} (${customer["currentPoints"]} pts)",
      "value": customer["id"]
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Points System",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Manage Points", icon: Icon(Icons.stars)),
        Tab(text: "Points History", icon: Icon(Icons.history)),
        Tab(text: "Bulk Operations", icon: Icon(Icons.group)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildManagePointsTab(),
        _buildPointsHistoryTab(),
        _buildBulkOperationsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildManagePointsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Customer",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Customer",
                  items: customerOptions,
                  value: selectedCustomer,
                  onChanged: (value, label) {
                    selectedCustomer = value;
                    setState(() {});
                  },
                ),
                if (selectedCustomer.isNotEmpty)
                  _buildSelectedCustomerInfo(),
              ],
            ),
          ),

          // Add Points
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_circle, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Add Points",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Points to Add",
                  value: pointsToAdd,
                  hint: "Enter number of points",
                  validator: Validator.required,
                  onChanged: (value) {
                    pointsToAdd = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Reason",
                  items: reasonOptions,
                  value: adjustmentReason,
                  onChanged: (value, label) {
                    adjustmentReason = value;
                    setState(() {});
                  },
                ),
                QButton(
                  label: "Add Points",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: selectedCustomer.isNotEmpty && pointsToAdd.isNotEmpty
                      ? () => _addPoints()
                      : null,
                ),
              ],
            ),
          ),

          // Redeem Points
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.remove_circle, color: warningColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Redeem Points",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Points to Redeem",
                  value: pointsToRedeem,
                  hint: "Enter number of points",
                  validator: Validator.required,
                  onChanged: (value) {
                    pointsToRedeem = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Redemption Description",
                  value: adjustmentReason,
                  hint: "e.g., Free appetizer, 10% discount",
                  onChanged: (value) {
                    adjustmentReason = value;
                    setState(() {});
                  },
                ),
                if (selectedCustomer.isNotEmpty && pointsToRedeem.isNotEmpty)
                  _buildRedemptionPreview(),
                QButton(
                  label: "Redeem Points",
                  icon: Icons.remove,
                  size: bs.md,
                  onPressed: selectedCustomer.isNotEmpty && pointsToRedeem.isNotEmpty
                      ? () => _redeemPoints()
                      : null,
                ),
              ],
            ),
          ),

          // Manual Adjustment
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.edit, color: infoColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Manual Adjustment",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Adjustment (+/-)",
                  value: manualPointsAdjustment,
                  hint: "Use negative numbers to deduct points",
                  onChanged: (value) {
                    manualPointsAdjustment = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Adjustment Reason",
                  value: adjustmentReason,
                  hint: "Explain the reason for this adjustment",
                  validator: Validator.required,
                  onChanged: (value) {
                    adjustmentReason = value;
                    setState(() {});
                  },
                ),
                QButton(
                  label: "Apply Adjustment",
                  icon: Icons.check,
                  size: bs.md,
                  onPressed: selectedCustomer.isNotEmpty && 
                             manualPointsAdjustment.isNotEmpty && 
                             adjustmentReason.isNotEmpty
                      ? () => _applyManualAdjustment()
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedCustomerInfo() {
    final customer = customers.firstWhere((c) => c["id"] == selectedCustomer);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getTierColor(customer["tier"] as String).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.person,
                  color: _getTierColor(customer["tier"] as String),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${customer["loyaltyNumber"]} • ${customer["tier"]} Member",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${customer["currentPoints"]} pts",
                style: TextStyle(
                  fontSize: fsH6,
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

  Widget _buildRedemptionPreview() {
    if (selectedCustomer.isEmpty || pointsToRedeem.isEmpty) return SizedBox.shrink();
    
    final customer = customers.firstWhere((c) => c["id"] == selectedCustomer);
    int currentPoints = customer["currentPoints"] as int;
    int redeemPoints = int.tryParse(pointsToRedeem) ?? 0;
    int remainingPoints = currentPoints - redeemPoints;
    bool canRedeem = remainingPoints >= 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: canRedeem ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: canRedeem ? successColor : dangerColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                canRedeem ? Icons.check_circle : Icons.error,
                color: canRedeem ? successColor : dangerColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  canRedeem ? "Redemption Available" : "Insufficient Points",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: canRedeem ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Points:",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Text(
                "$currentPoints pts",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Points to Redeem:",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Text(
                "-$redeemPoints pts",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: warningColor),
              ),
            ],
          ),
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remaining Points:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                "$remainingPoints pts",
                style: TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.w600,
                  color: canRedeem ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Points Earned", "1,234", Icons.add_circle, successColor),
              _buildStatCard("Points Redeemed", "856", Icons.remove_circle, warningColor),
              _buildStatCard("Adjustments", "12", Icons.edit, infoColor),
              _buildStatCard("Expired", "45", Icons.access_time, dangerColor),
            ],
          ),

          // Transaction History
          ...pointsTransactions.map((transaction) {
            Color typeColor = _getTransactionTypeColor(transaction["type"] as String);
            IconData typeIcon = _getTransactionTypeIcon(transaction["type"] as String);
            int points = transaction["points"] as int;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: typeColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(typeIcon, size: 16, color: typeColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction["customerName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${transaction["description"]}",
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
                            "${points >= 0 ? '+' : ''}$points pts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: typeColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${transaction["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: typeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Staff: ${transaction["staff"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (transaction["orderId"] != null) ...[
                        Spacer(),
                        Text(
                          "${transaction["orderId"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    "${transaction["timestamp"]}",
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
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkOperationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bulk Add Points
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.group_add, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Bulk Add Points",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Add points to all customers in a specific tier",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QDropdownField(
                  label: "Target Tier",
                  items: [
                    {"label": "All Customers", "value": "All"},
                    {"label": "Bronze", "value": "Bronze"},
                    {"label": "Silver", "value": "Silver"},
                    {"label": "Gold", "value": "Gold"},
                    {"label": "Platinum", "value": "Platinum"}
                  ],
                  value: "",
                  onChanged: (value, label) {
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Points to Add",
                  value: "",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Reason for Bulk Addition",
                  value: "",
                  hint: "e.g., Holiday bonus, Anniversary celebration",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                QButton(
                  label: "Execute Bulk Addition",
                  size: bs.md,
                  onPressed: () {
                    _executeBulkAddition();
                  },
                ),
              ],
            ),
          ),

          // Points Expiry Management
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Points Expiry Management",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Points Expiring Soon",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "15 customers have points expiring in 30 days",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "View Expiring Points",
                  size: bs.md,
                  onPressed: () {
                    si("Viewing customers with expiring points");
                  },
                ),
                QButton(
                  label: "Send Expiry Notifications",
                  size: bs.md,
                  onPressed: () {
                    _sendExpiryNotifications();
                  },
                ),
              ],
            ),
          ),

          // Data Export
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.download, color: infoColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Export Points Data",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export All Customers",
                        size: bs.md,
                        onPressed: () {
                          _exportData("customers");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Transactions",
                        size: bs.md,
                        onPressed: () {
                          _exportData("transactions");
                        },
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

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Points Configuration
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Points Configuration",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Points per \$1 Spent",
                  value: "1",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Minimum Points for Redemption",
                  value: "100",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Points Expiry Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Points Expiry Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable points expiry",
                      "value": "enable_expiry",
                      "checked": enablePointsExpiry,
                    }
                  ],
                  value: [
                    if (enablePointsExpiry)
                      {"label": "Enable points expiry", "value": "enable_expiry", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    enablePointsExpiry = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (enablePointsExpiry)
                  QNumberField(
                    label: "Points expire after (days)",
                    value: pointsExpiryDays,
                    onChanged: (value) {
                      pointsExpiryDays = value;
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),

          // Notification Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Notify customers when points are earned",
                      "value": "notify_earned",
                      "checked": true,
                    },
                    {
                      "label": "Notify customers when points are redeemed",
                      "value": "notify_redeemed",
                      "checked": true,
                    },
                    {
                      "label": "Send expiry reminders",
                      "value": "expiry_reminders",
                      "checked": true,
                    }
                  ],
                  value: [
                    {"label": "Notify customers when points are earned", "value": "notify_earned", "checked": true},
                    {"label": "Notify customers when points are redeemed", "value": "notify_redeemed", "checked": true},
                    {"label": "Send expiry reminders", "value": "expiry_reminders", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          QButton(
            label: "Save Points Settings",
            size: bs.md,
            onPressed: () {
              ss("Points system settings saved successfully!");
            },
          ),
        ],
      ),
    );
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "Earned":
        return successColor;
      case "Redeemed":
        return warningColor;
      case "Adjustment":
        return infoColor;
      case "Bonus":
        return primaryColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTransactionTypeIcon(String type) {
    switch (type) {
      case "Earned":
        return Icons.add_circle;
      case "Redeemed":
        return Icons.remove_circle;
      case "Adjustment":
        return Icons.edit;
      case "Bonus":
        return Icons.card_giftcard;
      case "Expired":
        return Icons.access_time;
      default:
        return Icons.stars;
    }
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case "Bronze":
        return Colors.brown;
      case "Silver":
        return Colors.grey;
      case "Gold":
        return warningColor;
      case "Platinum":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addPoints() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("${pointsToAdd} points added successfully!");
      pointsToAdd = "";
      adjustmentReason = "";
      setState(() {});
    });
  }

  void _redeemPoints() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("${pointsToRedeem} points redeemed successfully!");
      pointsToRedeem = "";
      adjustmentReason = "";
      setState(() {});
    });
  }

  void _applyManualAdjustment() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Points adjustment applied successfully!");
      manualPointsAdjustment = "";
      adjustmentReason = "";
      setState(() {});
    });
  }

  void _executeBulkAddition() {
    showLoading();
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Bulk points addition completed for 25 customers!");
    });
  }

  void _sendExpiryNotifications() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Expiry notifications sent to 15 customers!");
    });
  }

  void _exportData(String type) {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("${type.toUpperCase()} data exported successfully!");
    });
  }
}
