import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder4View extends StatefulWidget {
  @override
  State<GrlOrder4View> createState() => _GrlOrder4ViewState();
}

class _GrlOrder4ViewState extends State<GrlOrder4View> {
  List<Map<String, dynamic>> orderHistory = [
    {
      "id": "ORD-2024-001",
      "date": "2024-01-20",
      "status": "delivered",
      "total": 156.99,
      "items": 3,
      "trackingNumber": "TRK001234567",
      "deliveryDate": "2024-01-22",
      "products": [
        {
          "name": "Wireless Headphones Pro",
          "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
          "price": 89.99,
          "qty": 1
        },
        {
          "name": "Phone Case Premium",
          "image": "https://picsum.photos/60/60?random=2&keyword=phone",
          "price": 34.99,
          "qty": 2
        }
      ]
    },
    {
      "id": "ORD-2024-002", 
      "date": "2024-01-15",
      "status": "shipped",
      "total": 245.50,
      "items": 2,
      "trackingNumber": "TRK001234568",
      "estimatedDelivery": "2024-01-25",
      "products": [
        {
          "name": "Smart Watch Series 5",
          "image": "https://picsum.photos/60/60?random=3&keyword=watch",
          "price": 199.99,
          "qty": 1
        },
        {
          "name": "Charging Dock",
          "image": "https://picsum.photos/60/60?random=4&keyword=charger",
          "price": 45.51,
          "qty": 1
        }
      ]
    },
    {
      "id": "ORD-2024-003",
      "date": "2024-01-10",
      "status": "processing",
      "total": 89.99,
      "items": 1,
      "trackingNumber": "",
      "estimatedDelivery": "2024-01-28",
      "products": [
        {
          "name": "Bluetooth Speaker Mini",
          "image": "https://picsum.photos/60/60?random=5&keyword=speaker",
          "price": 89.99,
          "qty": 1
        }
      ]
    },
    {
      "id": "ORD-2024-004",
      "date": "2024-01-05",
      "status": "cancelled",
      "total": 67.50,
      "items": 2,
      "trackingNumber": "",
      "cancelledDate": "2024-01-06",
      "products": [
        {
          "name": "USB-C Hub",
          "image": "https://picsum.photos/60/60?random=6&keyword=hub",
          "price": 39.99,
          "qty": 1
        },
        {
          "name": "Screen Protector",
          "image": "https://picsum.photos/60/60?random=7&keyword=screen",
          "price": 27.51,
          "qty": 1
        }
      ]
    },
    {
      "id": "ORD-2023-156",
      "date": "2023-12-20",
      "status": "delivered",
      "total": 349.99,
      "items": 1,
      "trackingNumber": "TRK001234569",
      "deliveryDate": "2023-12-22",
      "products": [
        {
          "name": "Wireless Earbuds Pro",
          "image": "https://picsum.photos/60/60?random=8&keyword=earbuds",
          "price": 349.99,
          "qty": 1
        }
      ]
    },
  ];

  String selectedStatus = "all";
  String selectedPeriod = "all";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Orders", "value": "all"},
    {"label": "Processing", "value": "processing"},
    {"label": "Shipped", "value": "shipped"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> periodFilters = [
    {"label": "All Time", "value": "all"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last Year", "value": "1year"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "processing":
        return infoColor;
      case "shipped":
        return primaryColor;
      case "delivered":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "processing":
        return "Processing";
      case "shipped":
        return "Shipped";
      case "delivered":
        return "Delivered";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = orderHistory;

    if (selectedStatus != "all") {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }

    return filtered;
  }

  double get totalSpent {
    return orderHistory
        .where((order) => order["status"] == "delivered")
        .fold(0.0, (sum, order) => sum + (order["total"] as double));
  }

  int get totalOrders {
    return orderHistory.length;
  }

  int get deliveredOrders {
    return orderHistory.where((order) => order["status"] == "delivered").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Download order history
              ss("Order history downloaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$totalOrders",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Orders",
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$deliveredOrders",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Delivered",
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalSpent.currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Spent",
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

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: statusFilters,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periodFilters,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Orders List
            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Orders Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "No orders match your current filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredOrders.map((order) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor(order["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Order Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${order["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Ordered on ${order["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order["status"]).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getStatusText(order["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(order["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Product Images
                      QHorizontalScroll(
                        children: (order["products"] as List).map((product) {
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: spSm),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${product["image"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${product["name"]}",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      // Order Summary
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${order["items"]} item${(order["items"] as int) > 1 ? 's' : ''}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (order["trackingNumber"] != null && order["trackingNumber"] != "")
                                  Text(
                                    "Tracking: ${order["trackingNumber"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                if (order["status"] == "delivered" && order["deliveryDate"] != null)
                                  Text(
                                    "Delivered on ${order["deliveryDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                if (order["status"] == "cancelled" && order["cancelledDate"] != null)
                                  Text(
                                    "Cancelled on ${order["cancelledDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                    ),
                                  ),
                                if (order["estimatedDelivery"] != null && order["status"] != "delivered" && order["status"] != "cancelled")
                                  Text(
                                    "Est. delivery: ${order["estimatedDelivery"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(order["total"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to order details
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (order["status"] == "delivered")
                            Expanded(
                              child: QButton(
                                label: "Reorder",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Items added to cart");
                                },
                              ),
                            ),
                          if (order["status"] == "processing")
                            Expanded(
                              child: QButton(
                                label: "Cancel",
                                size: bs.sm,
                                onPressed: () async {
                                  bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                                  if (isConfirmed) {
                                    // Cancel order logic
                                    ss("Order cancelled successfully");
                                  }
                                },
                              ),
                            ),
                          if (order["status"] == "shipped" && order["trackingNumber"] != "")
                            Expanded(
                              child: QButton(
                                label: "Track Order",
                                size: bs.sm,
                                onPressed: () {
                                  // Track order
                                },
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
    );
  }
}
