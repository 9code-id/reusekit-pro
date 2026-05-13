import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaInAppPurchasesView extends StatefulWidget {
  const GeaInAppPurchasesView({super.key});

  @override
  State<GeaInAppPurchasesView> createState() => _GeaInAppPurchasesViewState();
}

class _GeaInAppPurchasesViewState extends State<GeaInAppPurchasesView> {
  String selectedTab = "Available";

  List<Map<String, dynamic>> purchasePackages = [
    {
      "id": 1,
      "name": "Starter Pack",
      "description": "Perfect for new players to get started",
      "price": 4.99,
      "currency": "USD",
      "items": [
        {"name": "Gold Coins", "quantity": 1000},
        {"name": "Gems", "quantity": 50},
        {"name": "Energy Potions", "quantity": 10},
      ],
      "discount": 0,
      "originalPrice": 4.99,
      "popular": false,
      "category": "Starter",
      "image": "https://picsum.photos/200/150?random=1&keyword=starter",
    },
    {
      "id": 2,
      "name": "Premium Pack",
      "description": "Best value for serious gamers",
      "price": 19.99,
      "currency": "USD",
      "items": [
        {"name": "Gold Coins", "quantity": 5000},
        {"name": "Gems", "quantity": 300},
        {"name": "Premium Chest", "quantity": 5},
        {"name": "XP Boost", "quantity": 3},
      ],
      "discount": 25,
      "originalPrice": 26.65,
      "popular": true,
      "category": "Premium",
      "image": "https://picsum.photos/200/150?random=2&keyword=premium",
    },
    {
      "id": 3,
      "name": "Ultimate Pack",
      "description": "Everything you need to dominate",
      "price": 49.99,
      "currency": "USD",
      "items": [
        {"name": "Gold Coins", "quantity": 15000},
        {"name": "Gems", "quantity": 1000},
        {"name": "Legendary Chest", "quantity": 3},
        {"name": "Exclusive Skin", "quantity": 1},
      ],
      "discount": 30,
      "originalPrice": 71.41,
      "popular": true,
      "category": "Ultimate",
      "image": "https://picsum.photos/200/150?random=3&keyword=ultimate",
    },
    {
      "id": 4,
      "name": "Gold Coins Bundle",
      "description": "Pure gold coins for your adventures",
      "price": 9.99,
      "currency": "USD",
      "items": [
        {"name": "Gold Coins", "quantity": 2500},
      ],
      "discount": 15,
      "originalPrice": 11.75,
      "popular": false,
      "category": "Currency",
      "image": "https://picsum.photos/200/150?random=4&keyword=gold",
    },
  ];

  List<Map<String, dynamic>> purchaseHistory = [
    {
      "id": 1,
      "packageName": "Premium Pack",
      "price": 19.99,
      "currency": "USD",
      "purchaseDate": "2024-06-15",
      "status": "Completed",
      "transactionId": "TXN_001234567890",
    },
    {
      "id": 2,
      "packageName": "Gold Coins Bundle",
      "price": 9.99,
      "currency": "USD",
      "purchaseDate": "2024-06-10",
      "status": "Completed",
      "transactionId": "TXN_001234567891",
    },
    {
      "id": 3,
      "packageName": "Starter Pack",
      "price": 4.99,
      "currency": "USD",
      "purchaseDate": "2024-06-05",
      "status": "Completed",
      "transactionId": "TXN_001234567892",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-App Purchases"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: () {
              //navigateTo('PurchaseReceiptsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Available";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Available" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Available Packages",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Available" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "History";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "History" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Purchase History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "History" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedTab == "Available" ? _buildAvailablePackages() : _buildPurchaseHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailablePackages() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Stats Overview
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
                      Icon(
                        Icons.shopping_bag,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${purchasePackages.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Packages",
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
                      Icon(
                        Icons.local_fire_department,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${purchasePackages.where((p) => p["popular"] == true).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Popular",
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
                      Icon(
                        Icons.percent,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${purchasePackages.where((p) => (p["discount"] as int) > 0).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "On Sale",
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

          // Special Offer Banner
          if (purchasePackages.any((p) => p["popular"] == true)) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Limited Time Offer!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Save up to 30% on popular packages",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Packages Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: purchasePackages.map((package) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: package["popular"] == true
                      ? Border.all(color: warningColor, width: 2)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Header
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${package["image"]}",
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (package["popular"] == true)
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "POPULAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        if ((package["discount"] as int) > 0)
                          Positioned(
                            top: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "-${package["discount"]}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${package["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${package["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),

                          // Items List
                          Text(
                            "Includes:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(package["items"] as List<Map<String, dynamic>>).map((item) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["quantity"]}x ${item["name"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: spSm),

                          // Price
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if ((package["discount"] as int) > 0) ...[
                                    Text(
                                      "\$${(package["originalPrice"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                  ],
                                  Text(
                                    "\$${(package["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${package["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Purchase Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Purchase",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('PurchaseConfirmationView', arguments: package)
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseHistory() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Stats
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
                      Text(
                        "Total Purchases",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${purchaseHistory.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${purchaseHistory.fold(0.0, (sum, p) => sum + (p["price"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Purchase History List
          ...purchaseHistory.map((purchase) {
            return Container(
              padding: EdgeInsets.all(spSm),
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
                          "${purchase["packageName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${purchase["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${purchase["purchaseDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(purchase["price"] as double).toStringAsFixed(2)} ${purchase["currency"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "ID: ${purchase["transactionId"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
