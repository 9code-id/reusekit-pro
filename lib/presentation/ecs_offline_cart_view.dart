import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOfflineCartView extends StatefulWidget {
  const EcsOfflineCartView({super.key});

  @override
  State<EcsOfflineCartView> createState() => _EcsOfflineCartViewState();
}

class _EcsOfflineCartViewState extends State<EcsOfflineCartView> {
  bool isOnline = false;
  bool autoSync = true;
  bool showOfflineIndicator = true;

  List<Map<String, dynamic>> offlineItems = [
    {
      "id": "1",
      "name": "Wireless Headphones",
      "price": 299.99,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
      "availability": "In Stock",
      "lastUpdated": "2 hours ago",
      "syncStatus": "pending",
    },
    {
      "id": "2",
      "name": "Smart Watch",
      "price": 199.99,
      "quantity": 2,
      "image": "https://picsum.photos/100/100?random=2&keyword=watch",
      "availability": "Limited Stock",
      "lastUpdated": "1 hour ago",
      "syncStatus": "synced",
    },
    {
      "id": "3",
      "name": "Bluetooth Speaker",
      "price": 79.99,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=3&keyword=speaker",
      "availability": "Out of Stock",
      "lastUpdated": "30 min ago",
      "syncStatus": "conflict",
    },
    {
      "id": "4",
      "name": "Phone Case",
      "price": 24.99,
      "quantity": 3,
      "image": "https://picsum.photos/100/100?random=4&keyword=phone",
      "availability": "In Stock",
      "lastUpdated": "5 min ago",
      "syncStatus": "pending",
    },
  ];

  double get subtotal {
    return offlineItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Cart"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: isOnline ? successColor : dangerColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isOnline ? Icons.cloud_done : Icons.cloud_off,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  isOnline ? "Online" : "Offline",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.sync,
            size: bs.sm,
            onPressed: () {
              _syncCart();
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
            // Offline Status Banner
            if (!isOnline)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cloud_off, color: warningColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You're currently offline",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Your cart items are saved locally and will sync when you're back online",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Sync Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Sync Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.sync, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto Sync",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically sync when online",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoSync,
                        onChanged: (value) {
                          setState(() {
                            autoSync = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.visibility, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Show Offline Indicator",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Display connection status",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: showOfflineIndicator,
                        onChanged: (value) {
                          setState(() {
                            showOfflineIndicator = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Cart Items
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "Cart Items (${offlineItems.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Clear All",
                        size: bs.sm,
                        color: dangerColor,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Clear all offline cart items?");
                          if (isConfirmed) {
                            setState(() {
                              offlineItems.clear();
                            });
                            ss("Cart cleared");
                          }
                        },
                      ),
                    ],
                  ),
                  ...offlineItems.map((item) {
                    Color statusColor = item["syncStatus"] == "synced" ? successColor :
                                       item["syncStatus"] == "conflict" ? dangerColor : warningColor;
                    IconData statusIcon = item["syncStatus"] == "synced" ? Icons.check_circle :
                                         item["syncStatus"] == "conflict" ? Icons.error : Icons.pending;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(top: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "\$${((item["price"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Qty: ${item["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(
                                    statusIcon,
                                    color: statusColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: spXs),
                                  QButton(
                                    icon: Icons.close,
                                    size: bs.sm,
                                    color: dangerColor,
                                    onPressed: () {
                                      setState(() {
                                        offlineItems.removeWhere((element) => element["id"] == item["id"]);
                                      });
                                      ss("Item removed from cart");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item["availability"] == "In Stock" ? successColor :
                                         item["availability"] == "Limited Stock" ? warningColor : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["availability"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Last updated: ${item["lastUpdated"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          if (item["syncStatus"] == "conflict") ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: dangerColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sync Conflict",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "This item has been modified in your online cart. Choose which version to keep.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Keep Local",
                                          size: bs.sm,
                                          onPressed: () {
                                            setState(() {
                                              item["syncStatus"] = "synced";
                                            });
                                            ss("Local version kept");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Use Online",
                                          size: bs.sm,
                                          color: dangerColor,
                                          onPressed: () {
                                            setState(() {
                                              item["syncStatus"] = "synced";
                                            });
                                            ss("Online version used");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Cart Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Cart Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Subtotal (${offlineItems.length} items)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "\$${subtotal.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (!isOnline)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Prices and availability will be verified when you go online",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QButton(
                    label: isOnline ? "Proceed to Checkout" : "Sync and Checkout",
                    size: bs.md,
                    icon: isOnline ? Icons.shopping_cart_checkout : Icons.sync,
                    onPressed: () {
                      if (!isOnline) {
                        _syncCart();
                      } else {
                        // Navigate to checkout
                      }
                    },
                  ),
                  QButton(
                    label: "Save for Later",
                    size: bs.md,
                    icon: Icons.bookmark_add,
                    onPressed: () {
                      ss("Cart saved for later");
                    },
                  ),
                  QButton(
                    label: "Export Cart",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: () {
                      ss("Cart exported successfully");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _syncCart() {
    // Simulate sync process
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      setState(() {
        isOnline = true;
        for (var item in offlineItems) {
          if (item["syncStatus"] != "conflict") {
            item["syncStatus"] = "synced";
          }
        }
      });
      ss("Cart synced successfully");
    });
  }
}
