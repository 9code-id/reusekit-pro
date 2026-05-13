import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder5View extends StatefulWidget {
  @override
  State<GrlOrder5View> createState() => _GrlOrder5ViewState();
}

class _GrlOrder5ViewState extends State<GrlOrder5View> {
  int currentTab = 0;

  List<Map<String, dynamic>> pendingOrders = [
    {
      "id": "ORD-2024-001",
      "customerName": "John Smith",
      "customerEmail": "john.smith@email.com",
      "date": "2024-01-20",
      "items": 2,
      "total": 159.98,
      "priority": "high",
      "products": [
        {
          "name": "Wireless Headphones",
          "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
          "price": 79.99,
          "qty": 1,
          "sku": "WH-001"
        },
        {
          "name": "Phone Case Premium",
          "image": "https://picsum.photos/60/60?random=2&keyword=phone",
          "price": 79.99,
          "qty": 1,
          "sku": "PC-002"
        }
      ]
    },
    {
      "id": "ORD-2024-002",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.johnson@email.com",
      "date": "2024-01-19",
      "items": 1,
      "total": 299.99,
      "priority": "medium",
      "products": [
        {
          "name": "Smart Watch Pro",
          "image": "https://picsum.photos/60/60?random=3&keyword=watch",
          "price": 299.99,
          "qty": 1,
          "sku": "SW-003"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> processingOrders = [
    {
      "id": "ORD-2024-003",
      "customerName": "Mike Davis",
      "customerEmail": "mike.davis@email.com",
      "date": "2024-01-18",
      "items": 3,
      "total": 189.97,
      "estimatedCompletion": "2024-01-22",
      "assignedTo": "Team A",
      "products": [
        {
          "name": "Bluetooth Speaker",
          "image": "https://picsum.photos/60/60?random=4&keyword=speaker",
          "price": 89.99,
          "qty": 1,
          "sku": "BS-004"
        },
        {
          "name": "USB Cable Set",
          "image": "https://picsum.photos/60/60?random=5&keyword=cable",
          "price": 49.99,
          "qty": 2,
          "sku": "UC-005"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> shippedOrders = [
    {
      "id": "ORD-2024-004",
      "customerName": "Emily Wilson",
      "customerEmail": "emily.wilson@email.com",
      "date": "2024-01-15",
      "items": 2,
      "total": 249.98,
      "trackingNumber": "TRK001234567",
      "shippedDate": "2024-01-17",
      "carrier": "FedEx",
      "estimatedDelivery": "2024-01-20",
      "products": [
        {
          "name": "Laptop Stand",
          "image": "https://picsum.photos/60/60?random=6&keyword=laptop",
          "price": 149.99,
          "qty": 1,
          "sku": "LS-006"
        },
        {
          "name": "Wireless Mouse",
          "image": "https://picsum.photos/60/60?random=7&keyword=mouse",
          "price": 99.99,
          "qty": 1,
          "sku": "WM-007"
        }
      ]
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getPriorityText(String priority) {
    switch (priority) {
      case "high":
        return "High Priority";
      case "medium":
        return "Medium Priority";
      case "low":
        return "Low Priority";
      default:
        return "Normal";
    }
  }

  Widget _buildOrderCard(Map<String, dynamic> order, String status) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: status == "pending" && order.containsKey("priority")
            ? Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor(order["priority"]),
                ),
              )
            : null,
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
                      "${order["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${order["customerEmail"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (status == "pending" && order.containsKey("priority"))
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(order["priority"]).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _getPriorityText(order["priority"]),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getPriorityColor(order["priority"]),
                    ),
                  ),
                ),
            ],
          ),

          // Order Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${order["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Items: ${order["items"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (status == "processing" && order.containsKey("assignedTo"))
                      Text(
                        "Assigned to: ${order["assignedTo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (status == "shipped" && order.containsKey("carrier"))
                      Text(
                        "Carrier: ${order["carrier"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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

          // Additional Status Info
          if (status == "processing" && order.containsKey("estimatedCompletion"))
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Est. completion: ${order["estimatedCompletion"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          if (status == "shipped") ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Tracking: ${order["trackingNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Copy tracking number
                          ss("Tracking number copied");
                        },
                        child: Icon(
                          Icons.copy,
                          size: 16,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  if (order.containsKey("estimatedDelivery"))
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Est. delivery: ${order["estimatedDelivery"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],

          // Product Preview
          QHorizontalScroll(
            children: (order["products"] as List).map((product) {
              return Container(
                width: 100,
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
                    Text(
                      "Qty: ${product["qty"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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
              if (status == "pending")
                Expanded(
                  child: QButton(
                    label: "Start Processing",
                    size: bs.sm,
                    onPressed: () {
                      ss("Order moved to processing");
                    },
                  ),
                ),
              if (status == "processing")
                Expanded(
                  child: QButton(
                    label: "Mark as Shipped",
                    size: bs.sm,
                    onPressed: () {
                      ss("Order marked as shipped");
                    },
                  ),
                ),
              if (status == "shipped")
                Expanded(
                  child: QButton(
                    label: "Track Package",
                    size: bs.sm,
                    onPressed: () {
                      // Track package
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return Column(
          children: [
            if (pendingOrders.isEmpty)
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
                      Icons.inbox_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Pending Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "All orders are being processed",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...pendingOrders.map((order) => _buildOrderCard(order, "pending")).toList(),
          ],
        );
      case 1:
        return Column(
          children: [
            if (processingOrders.isEmpty)
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
                      Icons.settings_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Processing Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "No orders are currently being processed",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...processingOrders.map((order) => _buildOrderCard(order, "processing")).toList(),
          ],
        );
      case 2:
        return Column(
          children: [
            if (shippedOrders.isEmpty)
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
                      Icons.local_shipping_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Shipped Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "No orders have been shipped yet",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...shippedOrders.map((order) => _buildOrderCard(order, "shipped")).toList(),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.inbox)),
        Tab(text: "Processing", icon: Icon(Icons.settings)),
        Tab(text: "Shipped", icon: Icon(Icons.local_shipping)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTabContent(0),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTabContent(1),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTabContent(2),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
