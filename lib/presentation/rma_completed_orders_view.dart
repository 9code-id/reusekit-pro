import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCompletedOrdersView extends StatefulWidget {
  const RmaCompletedOrdersView({super.key});

  @override
  State<RmaCompletedOrdersView> createState() => _RmaCompletedOrdersViewState();
}

class _RmaCompletedOrdersViewState extends State<RmaCompletedOrdersView> {
  List<Map<String, dynamic>> completedOrders = [
    {
      "id": "ORD-2024-0151",
      "customerName": "Alice Wilson",
      "customerEmail": "alice.wilson@email.com",
      "customerPhone": "+1 555-0987",
      "items": [
        {"name": "iPhone 14 Pro", "qty": 1, "price": 999.99, "sku": "IPH14P-128"},
        {"name": "AirPods Pro", "qty": 1, "price": 249.99, "sku": "AIRPODS-PRO-2"}
      ],
      "total": 1249.98,
      "orderDate": "2024-06-17 14:20",
      "completedDate": "2024-06-18 16:45",
      "processingTime": "1 day 2 hours",
      "paymentMethod": "Credit Card",
      "deliveryMethod": "Standard Shipping",
      "trackingNumber": "1Z999AA1234567890",
      "rating": 5,
      "review": "Excellent service and fast delivery!",
      "completedBy": "Staff: John Smith"
    },
    {
      "id": "ORD-2024-0150",
      "customerName": "Robert Taylor",
      "customerEmail": "r.taylor@email.com",
      "customerPhone": "+1 555-0654",
      "items": [
        {"name": "MacBook Pro 16", "qty": 1, "price": 2399.99, "sku": "MBP16-M2-512"},
        {"name": "Thunderbolt Cable", "qty": 2, "price": 49.99, "sku": "TB4-CABLE-2M"}
      ],
      "total": 2499.97,
      "orderDate": "2024-06-16 09:30",
      "completedDate": "2024-06-18 14:20",
      "processingTime": "2 days 4 hours",
      "paymentMethod": "PayPal",
      "deliveryMethod": "Express Shipping",
      "trackingNumber": "1Z999AA1234567891",
      "rating": 4,
      "review": "Good experience, delivery was on time.",
      "completedBy": "Staff: Sarah Johnson"
    },
    {
      "id": "ORD-2024-0149",
      "customerName": "Jennifer Lee",
      "customerEmail": "j.lee@email.com",
      "customerPhone": "+1 555-0321",
      "items": [
        {"name": "iPad Air", "qty": 1, "price": 599.99, "sku": "IPADAIR-256"},
        {"name": "Apple Pencil", "qty": 1, "price": 129.99, "sku": "PENCIL-2ND"},
        {"name": "iPad Case", "qty": 1, "price": 79.99, "sku": "IPADCASE-AIR"}
      ],
      "total": 809.97,
      "orderDate": "2024-06-15 16:45",
      "completedDate": "2024-06-17 10:30",
      "processingTime": "1 day 17 hours",
      "paymentMethod": "Credit Card",
      "deliveryMethod": "Standard Shipping",
      "trackingNumber": "1Z999AA1234567892",
      "rating": 5,
      "review": "Perfect packaging and quick processing!",
      "completedBy": "Staff: Mike Wilson"
    },
    {
      "id": "ORD-2024-0148",
      "customerName": "Steven Brown",
      "customerEmail": "s.brown@email.com",
      "customerPhone": "+1 555-0789",
      "items": [
        {"name": "Gaming Desktop PC", "qty": 1, "price": 2799.99, "sku": "GDT-RTX4080"},
        {"name": "Gaming Monitor", "qty": 2, "price": 449.99, "sku": "GMON-27-4K"},
        {"name": "Mechanical Keyboard", "qty": 1, "price": 199.99, "sku": "MKEY-CHERRY-RGB"}
      ],
      "total": 3349.96,
      "orderDate": "2024-06-14 11:15",
      "completedDate": "2024-06-17 09:45",
      "processingTime": "2 days 22 hours",
      "paymentMethod": "Bank Transfer",
      "deliveryMethod": "White Glove Delivery",
      "trackingNumber": "1Z999AA1234567893",
      "rating": 5,
      "review": "Amazing setup service and professional delivery team!",
      "completedBy": "Staff: David Chen"
    },
    {
      "id": "ORD-2024-0147",
      "customerName": "Maria Garcia",
      "customerEmail": "m.garcia@email.com",
      "customerPhone": "+1 555-0456",
      "items": [
        {"name": "Surface Laptop", "qty": 1, "price": 1299.99, "sku": "SL5-I7-512"},
        {"name": "Surface Mouse", "qty": 1, "price": 99.99, "sku": "SMOUSE-PLATINUM"}
      ],
      "total": 1399.98,
      "orderDate": "2024-06-13 13:20",
      "completedDate": "2024-06-16 15:30",
      "processingTime": "3 days 2 hours",
      "paymentMethod": "Credit Card",
      "deliveryMethod": "Standard Shipping",
      "trackingNumber": "1Z999AA1234567894",
      "rating": 4,
      "review": "Good product quality, delivery took a bit longer than expected.",
      "completedBy": "Staff: Lisa Anderson"
    },
    {
      "id": "ORD-2024-0146",
      "customerName": "Christopher Moore",
      "customerEmail": "c.moore@email.com",
      "customerPhone": "+1 555-0123",
      "items": [
        {"name": "Samsung Galaxy Tab S9", "qty": 2, "price": 849.99, "sku": "TABS9-256"},
        {"name": "S Pen", "qty": 2, "price": 59.99, "sku": "SPEN-TABS9"}
      ],
      "total": 1819.96,
      "orderDate": "2024-06-12 10:45",
      "completedDate": "2024-06-15 14:15",
      "processingTime": "3 days 3 hours",
      "paymentMethod": "PayPal",
      "deliveryMethod": "Express Shipping",
      "trackingNumber": "1Z999AA1234567895",
      "rating": 5,
      "review": "Excellent customer service throughout the process!",
      "completedBy": "Staff: Rachel Kim"
    }
  ];

  String searchQuery = "";
  String selectedDateRange = "all";
  String selectedRating = "all";
  String sortBy = "completedDate";

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = completedOrders;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) =>
        order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    if (selectedDateRange != "all") {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedDateRange) {
        case "today":
          filterDate = DateTime(now.year, now.month, now.day);
          break;
        case "week":
          filterDate = now.subtract(Duration(days: 7));
          break;
        case "month":
          filterDate = DateTime(now.year, now.month - 1, now.day);
          break;
        default:
          filterDate = DateTime(2000);
      }
      
      filtered = filtered.where((order) =>
        DateTime.parse(order["completedDate"]).isAfter(filterDate)
      ).toList();
    }

    if (selectedRating != "all") {
      int rating = int.parse(selectedRating);
      filtered = filtered.where((order) => order["rating"] >= rating).toList();
    }

    // Sort orders
    switch (sortBy) {
      case "completedDate":
        filtered.sort((a, b) => b["completedDate"].compareTo(a["completedDate"]));
        break;
      case "total":
        filtered.sort((a, b) => (b["total"] as num).compareTo(a["total"] as num));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as int).compareTo(a["rating"] as int));
        break;
    }

    return filtered;
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? warningColor : disabledColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Orders"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredOrders.length}",
              style: TextStyle(
                color: successColor,
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
              label: "Search orders, customers, tracking...",
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
                    label: "Date Range",
                    items: [
                      {"label": "All Time", "value": "all"},
                      {"label": "Today", "value": "today"},
                      {"label": "Last Week", "value": "week"},
                      {"label": "Last Month", "value": "month"},
                    ],
                    value: selectedDateRange,
                    onChanged: (value, label) {
                      selectedDateRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Min Rating",
                    items: [
                      {"label": "All Ratings", "value": "all"},
                      {"label": "5 Stars", "value": "5"},
                      {"label": "4+ Stars", "value": "4"},
                      {"label": "3+ Stars", "value": "3"},
                    ],
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
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
                      {"label": "Completion Date", "value": "completedDate"},
                      {"label": "Order Total", "value": "total"},
                      {"label": "Customer Rating", "value": "rating"},
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
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Completed Orders Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                              "Total Orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${filteredOrders.length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Total Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "\$${(filteredOrders.fold(0.0, (sum, order) => sum + (order["total"] as num))).currency}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Avg Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${(filteredOrders.fold(0, (sum, order) => sum + (order["rating"] as int)) / filteredOrders.length).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(Icons.star, color: warningColor, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      color: successColor,
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, size: 10, color: successColor),
                              SizedBox(width: 2),
                              Text(
                                "COMPLETED",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${((order["total"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            _buildStarRating(order["rating"]),
                          ],
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
                            return Text(
                              "• ${item["name"]} (${item["qty"]}x) - \$${((item["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            );
                          })).toList(),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Processing Time: ${order["processingTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.check_circle, size: 14, color: successColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Completed: ${order["completedDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 14, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${order["completedBy"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.local_shipping, color: infoColor, size: 16),
                              SizedBox(height: spXs),
                              Text(
                                "${order["trackingNumber"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (order["review"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: warningColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.reviews, size: 14, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Customer Review:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\"${order["review"]}\"",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

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
                        QButton(
                          icon: Icons.receipt,
                          size: bs.sm,
                          onPressed: () {
                            // Generate invoice
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.local_shipping,
                          size: bs.sm,
                          onPressed: () {
                            // Track shipment
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
                      Icons.check_circle_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Completed Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "No orders match your current filters or there are no completed orders yet.",
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
    );
  }
}
