import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPendingOrdersView extends StatefulWidget {
  const RmaPendingOrdersView({super.key});

  @override
  State<RmaPendingOrdersView> createState() => _RmaPendingOrdersViewState();
}

class _RmaPendingOrdersViewState extends State<RmaPendingOrdersView> {
  List<Map<String, dynamic>> pendingOrders = [
    {
      "id": "ORD-2024-0156",
      "customerName": "John Doe",
      "customerEmail": "john.doe@email.com",
      "customerPhone": "+1 555-0123",
      "items": [
        {"name": "iPhone 15 Pro Max", "qty": 1, "price": 1199.99, "sku": "IPH15PM-256"},
        {"name": "MagSafe Charger", "qty": 1, "price": 39.99, "sku": "MAGSAFE-CHG"}
      ],
      "total": 1239.98,
      "orderDate": "2024-06-19 10:30",
      "priority": "high",
      "paymentMethod": "Credit Card",
      "paymentStatus": "paid",
      "shippingAddress": "123 Main St, Apt 4B, New York, NY 10001",
      "notes": "Customer requested expedited processing",
      "estimatedCompletion": "2024-06-20 16:00"
    },
    {
      "id": "ORD-2024-0155",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "customerPhone": "+1 555-0456",
      "items": [
        {"name": "MacBook Air M2", "qty": 1, "price": 1199.99, "sku": "MBA-M2-256"},
        {"name": "USB-C Hub", "qty": 1, "price": 79.99, "sku": "USBC-HUB-7IN1"}
      ],
      "total": 1279.98,
      "orderDate": "2024-06-19 09:15",
      "priority": "medium",
      "paymentMethod": "PayPal",
      "paymentStatus": "paid",
      "shippingAddress": "456 Oak Avenue, Suite 201, Los Angeles, CA 90210",
      "notes": "",
      "estimatedCompletion": "2024-06-21 14:00"
    },
    {
      "id": "ORD-2024-0154",
      "customerName": "Michael Chen",
      "customerEmail": "m.chen@email.com",
      "customerPhone": "+1 555-0789",
      "items": [
        {"name": "Samsung Galaxy S24", "qty": 2, "price": 799.99, "sku": "SGS24-256"},
        {"name": "Wireless Earbuds", "qty": 2, "price": 199.99, "sku": "WBUDS-PRO"}
      ],
      "total": 1999.96,
      "orderDate": "2024-06-19 08:45",
      "priority": "high",
      "paymentMethod": "Credit Card",
      "paymentStatus": "pending",
      "shippingAddress": "789 Pine Street, Building C, Chicago, IL 60601",
      "notes": "Bulk order for corporate account",
      "estimatedCompletion": "2024-06-20 12:00"
    },
    {
      "id": "ORD-2024-0153",
      "customerName": "Emma Davis",
      "customerEmail": "emma.davis@email.com",
      "customerPhone": "+1 555-0321",
      "items": [
        {"name": "iPad Pro 12.9", "qty": 1, "price": 1099.99, "sku": "IPADPRO-129-512"},
        {"name": "Apple Pencil", "qty": 1, "price": 129.99, "sku": "PENCIL-2ND"},
        {"name": "Magic Keyboard", "qty": 1, "price": 349.99, "sku": "MAGKEY-129"}
      ],
      "total": 1579.97,
      "orderDate": "2024-06-18 16:20",
      "priority": "low",
      "paymentMethod": "Bank Transfer",
      "paymentStatus": "paid",
      "shippingAddress": "321 Elm Street, House 15, Miami, FL 33101",
      "notes": "Customer is an artist, handle with care",
      "estimatedCompletion": "2024-06-22 10:00"
    },
    {
      "id": "ORD-2024-0152",
      "customerName": "David Rodriguez",
      "customerEmail": "d.rodriguez@email.com",
      "customerPhone": "+1 555-0654",
      "items": [
        {"name": "Gaming Laptop", "qty": 1, "price": 1899.99, "sku": "GLAP-RTX4070"},
        {"name": "Gaming Mouse", "qty": 1, "price": 79.99, "sku": "GMOUSE-RGB"},
        {"name": "Mechanical Keyboard", "qty": 1, "price": 149.99, "sku": "MKEY-RGB-BLUE"}
      ],
      "total": 2129.97,
      "orderDate": "2024-06-18 14:10",
      "priority": "medium",
      "paymentMethod": "Credit Card",
      "paymentStatus": "paid",
      "shippingAddress": "654 Maple Drive, Unit 8, Seattle, WA 98101",
      "notes": "Gaming setup for streaming",
      "estimatedCompletion": "2024-06-21 15:30"
    }
  ];

  String searchQuery = "";
  String selectedPriority = "all";
  String selectedPaymentStatus = "all";
  String sortBy = "orderDate";

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = pendingOrders;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) =>
        order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["customerEmail"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((order) => order["priority"] == selectedPriority).toList();
    }

    if (selectedPaymentStatus != "all") {
      filtered = filtered.where((order) => order["paymentStatus"] == selectedPaymentStatus).toList();
    }

    // Sort orders
    switch (sortBy) {
      case "orderDate":
        filtered.sort((a, b) => b["orderDate"].compareTo(a["orderDate"]));
        break;
      case "total":
        filtered.sort((a, b) => (b["total"] as num).compareTo(a["total"] as num));
        break;
      case "priority":
        filtered.sort((a, b) {
          Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
          return (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
        });
        break;
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Orders"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredOrders.length}",
              style: TextStyle(
                color: warningColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search orders, customers...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: [
                      {"label": "All Priorities", "value": "all"},
                      {"label": "High Priority", "value": "high"},
                      {"label": "Medium Priority", "value": "medium"},
                      {"label": "Low Priority", "value": "low"},
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
                    label: "Payment Status",
                    items: [
                      {"label": "All Payments", "value": "all"},
                      {"label": "Paid", "value": "paid"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Failed", "value": "failed"},
                    ],
                    value: selectedPaymentStatus,
                    onChanged: (value, label) {
                      selectedPaymentStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: [
                      {"label": "Order Date", "value": "orderDate"},
                      {"label": "Total Amount", "value": "total"},
                      {"label": "Priority", "value": "priority"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${filteredOrders.length} pending orders • Total value: \$${(filteredOrders.fold(0.0, (sum, order) => sum + (order["total"] as num))).currency}",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Orders List
            ...filteredOrders.map((order) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(order["priority"]),
                    ),
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(order["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["priority"]}".toUpperCase(),
                            style: TextStyle(
                              color: _getPriorityColor(order["priority"]),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPaymentStatusColor(order["paymentStatus"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["paymentStatus"]}".toUpperCase(),
                            style: TextStyle(
                              color: _getPaymentStatusColor(order["paymentStatus"]),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${order["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${order["customerName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${order["customerEmail"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${order["customerPhone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((order["total"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Items (${(order["items"] as List).length}):",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          ...((order["items"] as List).map((item) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${item["name"]} (${item["sku"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${item["qty"]}x \$${((item["price"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          })).toList(),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Ordered: ${order["orderDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "ETA: ${order["estimatedCompletion"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    if (order["notes"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note, size: 14, color: infoColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Note: ${order["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Process Order",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to order processing
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {
                            // View order details
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            // Call customer
                          },
                        ),
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
              );
            }).toList(),

            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inbox,
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
                    SizedBox(height: spXs),
                    Text(
                      "All orders are either completed or there are no orders matching your filters.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new order
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
