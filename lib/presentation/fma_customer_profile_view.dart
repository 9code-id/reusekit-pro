import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCustomerProfileView extends StatefulWidget {
  const FmaCustomerProfileView({super.key});

  @override
  State<FmaCustomerProfileView> createState() => _FmaCustomerProfileViewState();
}

class _FmaCustomerProfileViewState extends State<FmaCustomerProfileView> {
  String selectedTab = "Overview";
  
  // Customer data
  Map<String, dynamic> customer = {
    "id": "CUST001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 234 567 8900",
    "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
    "status": "Active",
    "joinDate": "2024-01-15",
    "lastVisit": "2024-03-15",
    "totalOrders": 47,
    "totalSpent": 1250.50,
    "averageOrder": 26.60,
    "loyaltyPoints": 245,
    "loyaltyTier": "Gold",
    "preferredCuisine": "Italian",
    "dietaryRestrictions": ["Vegetarian", "No Nuts"],
    "address": {
      "street": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "isDefault": true
    },
    "paymentMethods": [
      {
        "type": "Credit Card",
        "last4": "4532",
        "brand": "Visa",
        "isDefault": true
      }
    ]
  };

  List<Map<String, dynamic>> orderHistory = [
    {
      "orderId": "ORD-2024-003",
      "date": "2024-03-15",
      "items": ["Margherita Pizza", "Caesar Salad", "Tiramisu"],
      "total": 34.50,
      "status": "Delivered",
      "rating": 5
    },
    {
      "orderId": "ORD-2024-002",
      "date": "2024-03-10",
      "items": ["Pasta Carbonara", "Garlic Bread"],
      "total": 24.99,
      "status": "Delivered",
      "rating": 4
    },
    {
      "orderId": "ORD-2024-001",
      "date": "2024-03-05",
      "items": ["Vegetarian Pizza", "Italian Soda"],
      "total": 28.75,
      "status": "Delivered",
      "rating": 5
    }
  ];

  List<Map<String, dynamic>> loyaltyActivity = [
    {
      "type": "earned",
      "points": 25,
      "description": "Order #ORD-2024-003",
      "date": "2024-03-15"
    },
    {
      "type": "redeemed",
      "points": -50,
      "description": "Free Appetizer Coupon",
      "date": "2024-03-10"
    },
    {
      "type": "earned",
      "points": 20,
      "description": "Order #ORD-2024-002",
      "date": "2024-03-08"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // navigateTo("EditCustomerView")
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCustomerHeader(),
            _buildQuickStats(),
            _buildTabNavigation(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${customer["avatar"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${customer["status"]}",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${customer["email"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${customer["phone"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${customer["loyaltyTier"]} Member",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  // navigateTo("ChatView")
                },
              ),
              SizedBox(height: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  // Call customer
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
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
              spacing: spXs,
              children: [
                Text(
                  "${customer["totalOrders"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Orders",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
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
              spacing: spXs,
              children: [
                Text(
                  "\$${(customer["totalSpent"] as double).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total Spent",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
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
              spacing: spXs,
              children: [
                Text(
                  "${customer["loyaltyPoints"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Points",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabNavigation() {
    List<String> tabs = ["Overview", "Orders", "Loyalty", "Preferences"];
    
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = tab;
                setState(() {});
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Overview":
        return _buildOverviewTab();
      case "Orders":
        return _buildOrdersTab();
      case "Loyalty":
        return _buildLoyaltyTab();
      case "Preferences":
        return _buildPreferencesTab();
      default:
        return Container();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      children: [
        _buildInfoSection(),
        _buildRecentActivity(),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildInfoRow("Customer ID", "${customer["id"]}"),
          _buildInfoRow("Join Date", "${DateTime.parse(customer["joinDate"]).dMMMy}"),
          _buildInfoRow("Last Visit", "${DateTime.parse(customer["lastVisit"]).dMMMy}"),
          _buildInfoRow("Average Order", "\$${(customer["averageOrder"] as double).currency}"),
          _buildInfoRow("Preferred Cuisine", "${customer["preferredCuisine"]}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...orderHistory.take(3).map((order) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.receipt,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${order["orderId"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(order["date"]).dMMMy}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${(order["total"] as double).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 14,
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

  Widget _buildOrdersTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Order History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...orderHistory.map((order) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${order["orderId"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${order["status"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Date: ${DateTime.parse(order["date"]).dMMMy}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Items: ${(order["items"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (order["rating"] as int) 
                                ? Icons.star 
                                : Icons.star_border,
                            color: warningColor,
                            size: 16,
                          );
                        }),
                      ),
                      Text(
                        "\$${(order["total"] as double).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primaryColor,
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

  Widget _buildLoyaltyTab() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Loyalty Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Current Points",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${customer["loyaltyPoints"]} pts",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Tier Status",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${customer["loyaltyTier"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Redeem Points",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo("RedeemPointsView")
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Points Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...loyaltyActivity.map((activity) {
                bool isEarned = activity["type"] == "earned";
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: (isEarned ? successColor : dangerColor).withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (isEarned ? successColor : dangerColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isEarned ? Icons.add : Icons.remove,
                          color: isEarned ? successColor : dangerColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${activity["description"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(activity["date"]).dMMMy}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${isEarned ? '+' : ''}${activity["points"]} pts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isEarned ? successColor : dangerColor,
                          fontSize: 14,
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
    );
  }

  Widget _buildPreferencesTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Customer Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildPreferenceSection("Preferred Cuisine", "${customer["preferredCuisine"]}"),
          _buildPreferenceSection(
            "Dietary Restrictions", 
            (customer["dietaryRestrictions"] as List).join(", ")
          ),
          _buildPreferenceSection(
            "Default Address", 
            "${customer["address"]["street"]}, ${customer["address"]["city"]}, ${customer["address"]["state"]} ${customer["address"]["zipCode"]}"
          ),
          _buildPreferenceSection(
            "Payment Method", 
            "${(customer["paymentMethods"] as List)[0]["brand"]} **** ${(customer["paymentMethods"] as List)[0]["last4"]}"
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Edit Preferences",
              size: bs.md,
              onPressed: () {
                // navigateTo("EditPreferencesView")
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(5),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              ListTile(
                leading: Icon(Icons.block, color: dangerColor),
                title: Text("Block Customer"),
                onTap: () {
                  Navigator.pop(context);
                  _blockCustomer();
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: primaryColor),
                title: Text("View Full History"),
                onTap: () {
                  Navigator.pop(context);
                  // navigateTo("CustomerHistoryView")
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: primaryColor),
                title: Text("Share Profile"),
                onTap: () {
                  Navigator.pop(context);
                  // Share customer profile
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _blockCustomer() async {
    bool isConfirmed = await confirm("Are you sure you want to block this customer?");
    if (isConfirmed) {
      ss("Customer blocked successfully");
    }
  }
}
