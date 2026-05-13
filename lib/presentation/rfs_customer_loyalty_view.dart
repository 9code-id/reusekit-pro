import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsCustomerLoyaltyView extends StatefulWidget {
  const RfsCustomerLoyaltyView({super.key});

  @override
  State<RfsCustomerLoyaltyView> createState() => _RfsCustomerLoyaltyViewState();
}

class _RfsCustomerLoyaltyViewState extends State<RfsCustomerLoyaltyView> {
  int selectedTab = 0;
  String selectedCustomerId = "";
  String customerPhone = "";
  String customerEmail = "";
  String customerName = "";
  String loyaltyCardNumber = "";
  bool enableLoyalty = true;

  List<Map<String, dynamic>> loyaltyCustomers = [
    {
      "id": "CUST001",
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 (555) 123-4567",
      "loyaltyNumber": "LY001234",
      "points": 850,
      "tier": "Gold",
      "totalSpent": 2450.00,
      "lastVisit": "2024-06-19",
      "joinDate": "2023-08-15",
      "visits": 24
    },
    {
      "id": "CUST002",
      "name": "Michael Chen",
      "email": "m.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "loyaltyNumber": "LY002345",
      "points": 1250,
      "tier": "Platinum",
      "totalSpent": 4890.00,
      "lastVisit": "2024-06-18",
      "joinDate": "2023-03-22",
      "visits": 41
    },
    {
      "id": "CUST003",
      "name": "Emily Davis",
      "email": "emily.davis@email.com",
      "phone": "+1 (555) 345-6789",
      "loyaltyNumber": "LY003456",
      "points": 320,
      "tier": "Silver",
      "totalSpent": 680.00,
      "lastVisit": "2024-06-17",
      "joinDate": "2024-01-10",
      "visits": 8
    },
    {
      "id": "CUST004",
      "name": "David Wilson",
      "email": "d.wilson@email.com",
      "phone": "+1 (555) 456-7890",
      "loyaltyNumber": "LY004567",
      "points": 95,
      "tier": "Bronze",
      "totalSpent": 190.00,
      "lastVisit": "2024-06-19",
      "joinDate": "2024-05-01",
      "visits": 3
    }
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN001",
      "customerId": "CUST001",
      "customerName": "Sarah Johnson",
      "amount": 67.80,
      "pointsEarned": 68,
      "pointsRedeemed": 0,
      "timestamp": "2024-06-19 15:45",
      "orderNumber": "ORD-1234"
    },
    {
      "id": "TXN002",
      "customerId": "CUST004",
      "customerName": "David Wilson",
      "amount": 32.50,
      "pointsEarned": 33,
      "pointsRedeemed": 0,
      "timestamp": "2024-06-19 14:30",
      "orderNumber": "ORD-1233"
    },
    {
      "id": "TXN003",
      "customerId": "CUST002",
      "customerName": "Michael Chen",
      "amount": 125.00,
      "pointsEarned": 0,
      "pointsRedeemed": 250,
      "timestamp": "2024-06-18 19:20",
      "orderNumber": "ORD-1230"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Loyalty",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Customers", icon: Icon(Icons.people)),
        Tab(text: "Enroll New", icon: Icon(Icons.person_add)),
        Tab(text: "Transactions", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCustomersTab(),
        _buildEnrollNewTab(),
        _buildTransactionsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildCustomersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search customers...",
                    value: "",
                    hint: "Name, phone, or loyalty number",
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.md,
                  onPressed: () {
                    si("Searching customers...");
                  },
                ),
              ],
            ),
          ),

          // Tier Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildTierCard("Bronze", 15, Colors.brown),
              _buildTierCard("Silver", 8, Colors.grey),
              _buildTierCard("Gold", 12, warningColor),
              _buildTierCard("Platinum", 5, primaryColor),
            ],
          ),

          // Customer List
          ...loyaltyCustomers.map((customer) {
            Color tierColor = _getTierColor(customer["tier"] as String);
            
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
                    color: tierColor,
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: tierColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.person, color: tierColor, size: 24),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${customer["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${customer["loyaltyNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: tierColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${customer["tier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tierColor,
                              ),
                            ),
                          ),
                          Text(
                            "${customer["points"]} pts",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${customer["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${customer["email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "\$${(customer["totalSpent"] as double).toStringAsFixed(2)} spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${customer["visits"]} visits",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Last visit: ${customer["lastVisit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showCustomerDetails(customer);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
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
    );
  }

  Widget _buildTierCard(String tier, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(Icons.stars, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            tier,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollNewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Information
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
                  "Customer Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Full Name",
                  value: customerName,
                  validator: Validator.required,
                  onChanged: (value) {
                    customerName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: customerPhone,
                  hint: "+1 (555) 123-4567",
                  validator: Validator.required,
                  onChanged: (value) {
                    customerPhone = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Email Address",
                  value: customerEmail,
                  hint: "customer@example.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    customerEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Loyalty Card Setup
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
                  "Loyalty Card Setup",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Loyalty Card Number",
                  value: loyaltyCardNumber,
                  hint: "LY${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}",
                  onChanged: (value) {
                    loyaltyCardNumber = value;
                    setState(() {});
                  },
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "Loyalty Program Benefits",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "• Earn 1 point for every \$1 spent",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                      Text(
                        "• Bronze tier: 5% discount on orders",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                      Text(
                        "• Silver tier: 10% discount + free appetizer",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                      Text(
                        "• Gold tier: 15% discount + priority seating",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                      Text(
                        "• Platinum tier: 20% discount + exclusive menu access",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                    ],
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable loyalty program for this customer",
                      "value": "enable_loyalty",
                      "checked": enableLoyalty,
                    }
                  ],
                  value: [
                    if (enableLoyalty)
                      {"label": "Enable loyalty program for this customer", "value": "enable_loyalty", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    enableLoyalty = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Starting Bonus
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.card_giftcard, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Bonus!",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "New customers receive 100 bonus points",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "+100 pts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Enroll Customer",
                  size: bs.md,
                  onPressed: () {
                    if (customerName.isNotEmpty && customerPhone.isNotEmpty) {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Customer enrolled successfully! Loyalty card: ${loyaltyCardNumber.isNotEmpty ? loyaltyCardNumber : 'LY${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}'}");
                        // Reset form
                        customerName = "";
                        customerPhone = "";
                        customerEmail = "";
                        loyaltyCardNumber = "";
                        setState(() {});
                      });
                    } else {
                      se("Please fill in required fields");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () {
                  customerName = "";
                  customerPhone = "";
                  customerEmail = "";
                  loyaltyCardNumber = "";
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add_circle, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "101",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Points Earned",
                        textAlign: TextAlign.center,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.remove_circle, color: warningColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "250",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Points Redeemed",
                        textAlign: TextAlign.center,
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
          ),

          // Recent Transactions
          ...recentTransactions.map((transaction) {
            bool isEarned = (transaction["pointsEarned"] as int) > 0;
            Color pointsColor = isEarned ? successColor : warningColor;
            IconData pointsIcon = isEarned ? Icons.add_circle : Icons.remove_circle;
            int points = isEarned ? (transaction["pointsEarned"] as int) : (transaction["pointsRedeemed"] as int);
            
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
                    color: pointsColor,
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
                          color: pointsColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(pointsIcon, size: 16, color: pointsColor),
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
                              "${transaction["orderNumber"]}",
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
                            "${isEarned ? '+' : '-'}$points pts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: pointsColor,
                            ),
                          ),
                          Text(
                            "\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${transaction["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        isEarned ? "Points Earned" : "Points Redeemed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: pointsColor,
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
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overview Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildAnalyticsCard("Total Members", "40", Icons.people, primaryColor),
              _buildAnalyticsCard("Active This Month", "32", Icons.trending_up, successColor),
              _buildAnalyticsCard("Points Issued", "12,450", Icons.stars, warningColor),
              _buildAnalyticsCard("Points Redeemed", "8,230", Icons.redeem, infoColor),
            ],
          ),

          // Member Growth
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
                  "Membership Growth",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_up, size: 48, color: successColor),
                        SizedBox(height: spSm),
                        Text(
                          "+25% Growth This Month",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "8 new members joined",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tier Distribution
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
                  "Tier Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildTierDistributionItem("Bronze", 15, 37.5, Colors.brown),
                _buildTierDistributionItem("Silver", 8, 20.0, Colors.grey),
                _buildTierDistributionItem("Gold", 12, 30.0, warningColor),
                _buildTierDistributionItem("Platinum", 5, 12.5, primaryColor),
              ],
            ),
          ),

          // Top Customers
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
                  "Top Customers by Points",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...loyaltyCustomers.take(3).map((customer) {
                  int index = loyaltyCustomers.indexOf(customer);
                  Color rankColor = index == 0 ? warningColor : index == 1 ? Colors.grey : Colors.brown;
                  String rank = index == 0 ? "🥇" : index == 1 ? "🥈" : "🥉";
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: rankColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: rankColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          rank,
                          style: TextStyle(fontSize: 20),
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
                                "${customer["tier"]} • ${customer["visits"]} visits",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${customer["points"]} pts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierDistributionItem(String tier, int count, double percentage, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  tier,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "$count (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  void _showCustomerDetails(Map<String, dynamic> customer) {
    si("Viewing details for ${customer["name"]}");
  }
}
