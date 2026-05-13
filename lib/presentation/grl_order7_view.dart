import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder7View extends StatefulWidget {
  @override
  State<GrlOrder7View> createState() => _GrlOrder7ViewState();
}

class _GrlOrder7ViewState extends State<GrlOrder7View> {
  List<Map<String, dynamic>> bulkOrders = [
    {
      "id": "BULK-2024-001",
      "companyName": "TechCorp Solutions",
      "contactPerson": "Robert Johnson",
      "contactEmail": "robert@techcorp.com",
      "contactPhone": "+1 (555) 123-4567",
      "orderDate": "2024-01-20",
      "requestedDelivery": "2024-02-15",
      "status": "pending_quote",
      "priority": "high",
      "totalItems": 150,
      "estimatedValue": 15750.00,
      "discount": 15.0,
      "finalValue": 13387.50,
      "items": [
        {
          "productName": "Wireless Headphones Pro",
          "sku": "WHP-001",
          "unitPrice": 89.99,
          "quantity": 50,
          "totalPrice": 4499.50,
          "image": "https://picsum.photos/60/60?random=1&keyword=headphones"
        },
        {
          "productName": "Smartphone Cases Premium",
          "sku": "SCP-002",
          "unitPrice": 24.99,
          "quantity": 100,
          "totalPrice": 2499.00,
          "image": "https://picsum.photos/60/60?random=2&keyword=phone"
        }
      ],
      "shippingAddress": "123 Business Ave, Suite 100\nTech City, TC 12345\nUnited States",
      "notes": "Urgent order for corporate gifts. Please expedite processing."
    },
    {
      "id": "BULK-2024-002",
      "companyName": "Global Retail Inc",
      "contactPerson": "Sarah Miller",
      "contactEmail": "sarah@globalretail.com",
      "contactPhone": "+1 (555) 987-6543",
      "orderDate": "2024-01-18",
      "requestedDelivery": "2024-02-01",
      "status": "quote_sent",
      "priority": "medium",
      "totalItems": 200,
      "estimatedValue": 24980.00,
      "discount": 20.0,
      "finalValue": 19984.00,
      "quoteSentDate": "2024-01-19",
      "quoteExpiryDate": "2024-01-26",
      "items": [
        {
          "productName": "Bluetooth Speakers Mini",
          "sku": "BSM-003",
          "unitPrice": 59.99,
          "quantity": 80,
          "totalPrice": 4799.20,
          "image": "https://picsum.photos/60/60?random=3&keyword=speaker"
        },
        {
          "productName": "Wireless Charging Pads",
          "sku": "WCP-004",
          "unitPrice": 39.99,
          "quantity": 120,
          "totalPrice": 4798.80,
          "image": "https://picsum.photos/60/60?random=4&keyword=charger"
        }
      ],
      "shippingAddress": "456 Commerce Blvd\nRetail City, RC 67890\nUnited States",
      "notes": "Bulk order for retail distribution. Net 30 payment terms requested."
    },
    {
      "id": "BULK-2024-003",
      "companyName": "Education First Academy",
      "contactPerson": "Dr. Michael Chen",
      "contactEmail": "m.chen@edufirst.edu",
      "contactPhone": "+1 (555) 555-0123",
      "orderDate": "2024-01-15",
      "requestedDelivery": "2024-02-28",
      "status": "approved",
      "priority": "low",
      "totalItems": 300,
      "estimatedValue": 18000.00,
      "discount": 25.0,
      "finalValue": 13500.00,
      "approvedDate": "2024-01-17",
      "items": [
        {
          "productName": "Educational Tablets",
          "sku": "EDT-005",
          "unitPrice": 299.99,
          "quantity": 50,
          "totalPrice": 14999.50,
          "image": "https://picsum.photos/60/60?random=5&keyword=tablet"
        },
        {
          "productName": "Stylus Pens",
          "sku": "SP-006",
          "unitPrice": 12.99,
          "quantity": 250,
          "totalPrice": 3247.50,
          "image": "https://picsum.photos/60/60?random=6&keyword=pen"
        }
      ],
      "shippingAddress": "789 Education Drive\nLearning City, LC 54321\nUnited States",
      "notes": "Educational discount applied. Invoice required for school district."
    },
    {
      "id": "BULK-2024-004",
      "companyName": "Healthcare Solutions LLC",
      "contactPerson": "Dr. Lisa Anderson",
      "contactEmail": "l.anderson@healthsolutions.com",
      "contactPhone": "+1 (555) 444-7890",
      "orderDate": "2024-01-12",
      "requestedDelivery": "2024-01-30",
      "status": "in_production",
      "priority": "high",
      "totalItems": 75,
      "estimatedValue": 22500.00,
      "discount": 10.0,
      "finalValue": 20250.00,
      "productionStartDate": "2024-01-14",
      "estimatedCompletion": "2024-01-28",
      "items": [
        {
          "productName": "Medical Grade Tablets",
          "sku": "MGT-007",
          "unitPrice": 399.99,
          "quantity": 50,
          "totalPrice": 19999.50,
          "image": "https://picsum.photos/60/60?random=7&keyword=medical"
        },
        {
          "productName": "Sanitizing Wipes",
          "sku": "SW-008",
          "unitPrice": 15.99,
          "quantity": 25,
          "totalPrice": 399.75,
          "image": "https://picsum.photos/60/60?random=8&keyword=wipes"
        }
      ],
      "shippingAddress": "321 Medical Center Blvd\nHealth City, HC 98765\nUnited States",
      "notes": "Medical grade certification required. Rush order for hospital deployment."
    },
  ];

  String selectedStatus = "all";
  String selectedPriority = "all";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Orders", "value": "all"},
    {"label": "Pending Quote", "value": "pending_quote"},
    {"label": "Quote Sent", "value": "quote_sent"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Production", "value": "in_production"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending_quote":
        return warningColor;
      case "quote_sent":
        return infoColor;
      case "approved":
        return successColor;
      case "in_production":
        return primaryColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending_quote":
        return "Pending Quote";
      case "quote_sent":
        return "Quote Sent";
      case "approved":
        return "Approved";
      case "in_production":
        return "In Production";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

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

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = bulkOrders;

    if (selectedStatus != "all") {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((order) => order["priority"] == selectedPriority).toList();
    }

    return filtered;
  }

  double get totalValue {
    return bulkOrders.fold(0.0, (sum, order) => sum + (order["finalValue"] as double));
  }

  int get totalOrders {
    return bulkOrders.length;
  }

  int get pendingOrders {
    return bulkOrders.where((order) => order["status"] == "pending_quote").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bulk Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new bulk order
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
                          "$pendingOrders",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending Quote",
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
                          "\$${(totalValue / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Value",
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
                    label: "Filter by Priority",
                    items: priorityFilters,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Bulk Orders List
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
                      Icons.business_center_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Bulk Orders Found",
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
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getPriorityColor(order["priority"]),
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
                                  "${order["companyName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${order["contactPerson"]} • ${order["contactEmail"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                              SizedBox(height: spXs),
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
                        ],
                      ),

                      // Order Summary
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Date: ${order["orderDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Requested Delivery: ${order["requestedDelivery"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Total Items: ${order["totalItems"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (order["discount"] != null && (order["discount"] as double) > 0)
                                  Text(
                                    "Discount: ${(order["discount"] as double).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if ((order["discount"] as double) > 0)
                                Text(
                                  "\$${(order["estimatedValue"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                "\$${(order["finalValue"] as double).currency}",
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

                      // Product Preview
                      QHorizontalScroll(
                        children: (order["items"] as List).map((item) {
                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: spSm),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${item["image"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${item["productName"]}",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Qty: ${item["quantity"]} • \$${(item["unitPrice"] as double).currency}",
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

                      // Status-specific Information
                      if (order["status"] == "quote_sent" && order.containsKey("quoteExpiryDate"))
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
                                "Quote expires: ${order["quoteExpiryDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (order["status"] == "in_production")
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.build,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Production started: ${order["productionStartDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (order.containsKey("estimatedCompletion"))
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Est. completion: ${order["estimatedCompletion"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),

                      // Notes
                      if (order["notes"] != null && order["notes"] != "")
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.note,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${order["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to bulk order details
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (order["status"] == "pending_quote")
                            Expanded(
                              child: QButton(
                                label: "Create Quote",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Quote created and sent");
                                },
                              ),
                            ),
                          if (order["status"] == "quote_sent")
                            Expanded(
                              child: QButton(
                                label: "Follow Up",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Follow-up email sent");
                                },
                              ),
                            ),
                          if (order["status"] == "approved")
                            Expanded(
                              child: QButton(
                                label: "Start Production",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Production started");
                                },
                              ),
                            ),
                          if (order["status"] == "in_production")
                            Expanded(
                              child: QButton(
                                label: "Update Progress",
                                size: bs.sm,
                                onPressed: () {
                                  // Update production progress
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new bulk order
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
