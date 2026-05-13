import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaReorderView extends StatefulWidget {
  const FdaReorderView({super.key});

  @override
  State<FdaReorderView> createState() => _FdaReorderViewState();
}

class _FdaReorderViewState extends State<FdaReorderView> {
  List<Map<String, dynamic>> previousOrders = [
    {
      "id": "ORDER#12345",
      "date": "2024-06-10",
      "restaurant": {
        "name": "Tony's Pizzeria",
        "image": "https://picsum.photos/80/80?random=100&keyword=restaurant",
        "rating": 4.5,
        "deliveryTime": "30-45 mins",
        "isOpen": true
      },
      "total": 43.05,
      "items": [
        {
          "name": "Margherita Pizza",
          "size": "Large",
          "price": 12.99,
          "quantity": 2,
          "image": "https://picsum.photos/60/60?random=1&keyword=pizza",
          "available": true,
          "newPrice": 12.99
        },
        {
          "name": "Chicken Caesar Salad",
          "size": "Regular",
          "price": 8.99,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=2&keyword=salad",
          "available": true,
          "newPrice": 9.99
        },
        {
          "name": "Chocolate Brownie",
          "size": "Regular",
          "price": 4.99,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=3&keyword=brownie",
          "available": false,
          "newPrice": 0.0
        }
      ],
      "status": "Delivered"
    },
    {
      "id": "ORDER#12346",
      "date": "2024-06-08",
      "restaurant": {
        "name": "Burger Palace",
        "image": "https://picsum.photos/80/80?random=101&keyword=burger",
        "rating": 4.2,
        "deliveryTime": "25-35 mins",
        "isOpen": true
      },
      "total": 28.50,
      "items": [
        {
          "name": "Classic Cheeseburger",
          "size": "Regular",
          "price": 15.99,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=4&keyword=burger",
          "available": true,
          "newPrice": 16.99
        },
        {
          "name": "French Fries",
          "size": "Large",
          "price": 5.99,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=5&keyword=fries",
          "available": true,
          "newPrice": 5.99
        },
        {
          "name": "Coca Cola",
          "size": "Medium",
          "price": 2.99,
          "quantity": 2,
          "image": "https://picsum.photos/60/60?random=6&keyword=cola",
          "available": true,
          "newPrice": 3.49
        }
      ],
      "status": "Delivered"
    }
  ];

  List<String> selectedItems = [];
  Map<String, int> itemQuantities = {};
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Initialize quantities for all available items
    for (var order in previousOrders) {
      for (var item in order["items"]) {
        if (item["available"]) {
          String itemKey = "${order["id"]}_${item["name"]}";
          itemQuantities[itemKey] = item["quantity"];
        }
      }
    }
  }

  List<Map<String, dynamic>> get filteredOrders {
    if (searchQuery.isEmpty) return previousOrders;
    return previousOrders.where((order) {
      return order["restaurant"]["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
             (order["items"] as List).any((item) => 
                 item["name"].toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();
  }

  double get totalAmount {
    double total = 0.0;
    for (var order in previousOrders) {
      for (var item in order["items"]) {
        String itemKey = "${order["id"]}_${item["name"]}";
        if (selectedItems.contains(itemKey) && item["available"]) {
          total += (item["newPrice"] as double) * (itemQuantities[itemKey] ?? 0);
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorder"),
        actions: [
          if (selectedItems.isNotEmpty) ...[
            QButton(
              label: "Clear All",
              size: bs.sm,
              color: dangerColor,
              onPressed: () {
                _clearAllSelections();
              },
            ),
            SizedBox(width: spSm),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search previous orders",
                    value: searchQuery,
                    hint: "Restaurant name or food item...",
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
                  onPressed: () {
                    // Search functionality already works with onChanged
                  },
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Info Banner
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
                        Icon(Icons.info_outline, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select items to reorder",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Choose items from your previous orders. Some items may have price changes or be unavailable.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Previous Orders
                  ...filteredOrders.map((order) {
                    return _buildOrderCard(order);
                  }).toList(),

                  if (filteredOrders.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No orders found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try searching with different keywords",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: selectedItems.isNotEmpty ? Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedItems.length} items selected",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Total: \$${totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QButton(
                  label: "Add to Cart",
                  onPressed: () {
                    _addSelectedItemsToCart();
                  },
                ),
              ],
            ),
          ],
        ),
      ) : null,
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${order["restaurant"]["image"]}",
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
                      "${order["restaurant"]["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${order["restaurant"]["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.access_time, color: primaryColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${order["restaurant"]["deliveryTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${order["id"]} • ${order["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: order["restaurant"]["isOpen"] ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            order["restaurant"]["isOpen"] ? "Open" : "Closed",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Order Items
          Column(
            children: (order["items"] as List).map<Widget>((item) {
              String itemKey = "${order["id"]}_${item["name"]}";
              bool isSelected = selectedItems.contains(itemKey);
              bool isAvailable = item["available"];
              bool priceChanged = item["price"] != item["newPrice"];

              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isAvailable 
                      ? (isSelected ? primaryColor.withAlpha(20) : Colors.grey[50])
                      : dangerColor.withAlpha(20),
                  border: Border.all(
                    color: isAvailable 
                        ? (isSelected ? primaryColor : disabledOutlineBorderColor)
                        : dangerColor,
                  ),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    if (isAvailable) ...[
                      GestureDetector(
                        onTap: () {
                          _toggleItemSelection(itemKey);
                        },
                        child: Icon(
                          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ] else ...[
                      Icon(
                        Icons.block,
                        color: dangerColor,
                        size: 20,
                      ),
                    ],
                    SizedBox(width: spSm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${item["image"]}",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]} (${item["size"]})",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isAvailable ? Colors.black : disabledBoldColor,
                            ),
                          ),
                          if (!isAvailable) ...[
                            Text(
                              "Currently unavailable",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ] else ...[
                            Row(
                              children: [
                                if (priceChanged) ...[
                                  Text(
                                    "\$${(item["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                Text(
                                  "\$${(item["newPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: priceChanged ? dangerColor : primaryColor,
                                  ),
                                ),
                                if (priceChanged) ...[
                                  SizedBox(width: spXs),
                                  Text(
                                    "Price changed",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isAvailable && isSelected) ...[
                      SizedBox(width: spSm),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _decreaseQuantity(itemKey);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${itemQuantities[itemKey] ?? 0}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              _increaseQuantity(itemKey);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          if (order["restaurant"]["isOpen"]) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reorder All Available",
                    size: bs.sm,
                    onPressed: () {
                      _reorderAllAvailable(order);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "View Menu",
                  size: bs.sm,
                  color: secondaryColor,
                  onPressed: () {
                    // Navigate to restaurant menu
                    // ss('Next page'));
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _toggleItemSelection(String itemKey) {
    if (selectedItems.contains(itemKey)) {
      selectedItems.remove(itemKey);
    } else {
      selectedItems.add(itemKey);
    }
    setState(() {});
  }

  void _increaseQuantity(String itemKey) {
    itemQuantities[itemKey] = (itemQuantities[itemKey] ?? 0) + 1;
    setState(() {});
  }

  void _decreaseQuantity(String itemKey) {
    int currentQty = itemQuantities[itemKey] ?? 0;
    if (currentQty > 1) {
      itemQuantities[itemKey] = currentQty - 1;
    } else {
      // Remove from selection if quantity becomes 0
      selectedItems.remove(itemKey);
    }
    setState(() {});
  }

  void _reorderAllAvailable(Map<String, dynamic> order) {
    for (var item in order["items"]) {
      if (item["available"]) {
        String itemKey = "${order["id"]}_${item["name"]}";
        if (!selectedItems.contains(itemKey)) {
          selectedItems.add(itemKey);
        }
      }
    }
    setState(() {});
    ss("All available items added to selection");
  }

  void _clearAllSelections() {
    selectedItems.clear();
    setState(() {});
    si("All selections cleared");
  }

  void _addSelectedItemsToCart() async {
    if (selectedItems.isEmpty) {
      se("Please select items to reorder");
      return;
    }

    showLoading();

    // Simulate adding to cart
    await Future.delayed(Duration(seconds: 2));

    hideLoading();

    ss("${selectedItems.length} items added to cart!");

    // Navigate to cart
    // ss('Next page'));
  }
}
