import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsNewOrderView extends StatefulWidget {
  const RfsNewOrderView({super.key});

  @override
  State<RfsNewOrderView> createState() => _RfsNewOrderViewState();
}

class _RfsNewOrderViewState extends State<RfsNewOrderView> {
  String selectedTable = "";
  String selectedServer = "";
  String guestName = "";
  String guestPhone = "";
  int guestCount = 2;
  String specialRequests = "";
  String orderType = "Dine In";
  DateTime orderDate = DateTime.now();
  TimeOfDay orderTime = TimeOfDay.now();

  List<Map<String, dynamic>> tableOptions = [
    {"label": "Select Table", "value": ""},
    {"label": "Table 1 (2 seats)", "value": "T001"},
    {"label": "Table 2 (4 seats)", "value": "T002"},
    {"label": "Table 3 (6 seats)", "value": "T003"},
    {"label": "Table 4 (4 seats)", "value": "T004"},
    {"label": "Table 5 (8 seats)", "value": "T005"},
    {"label": "VIP Room 1 (12 seats)", "value": "VIP001"},
    {"label": "VIP Room 2 (8 seats)", "value": "VIP002"},
    {"label": "Bar Counter (6 seats)", "value": "BAR001"},
    {"label": "Outdoor Table 1 (4 seats)", "value": "OUT001"},
    {"label": "Outdoor Table 2 (6 seats)", "value": "OUT002"},
  ];

  List<Map<String, dynamic>> serverOptions = [
    {"label": "Select Server", "value": ""},
    {"label": "Sarah Johnson", "value": "sarah"},
    {"label": "Mike Davis", "value": "mike"},
    {"label": "Emma Wilson", "value": "emma"},
    {"label": "James Brown", "value": "james"},
    {"label": "Lisa Anderson", "value": "lisa"},
    {"label": "Tom Martinez", "value": "tom"},
  ];

  List<Map<String, dynamic>> guestCountOptions = [
    {"label": "1 Guest", "value": 1},
    {"label": "2 Guests", "value": 2},
    {"label": "3 Guests", "value": 3},
    {"label": "4 Guests", "value": 4},
    {"label": "5 Guests", "value": 5},
    {"label": "6 Guests", "value": 6},
    {"label": "7 Guests", "value": 7},
    {"label": "8 Guests", "value": 8},
    {"label": "9 Guests", "value": 9},
    {"label": "10+ Guests", "value": 10},
  ];

  List<Map<String, dynamic>> orderTypeOptions = [
    {"label": "Dine In", "value": "Dine In"},
    {"label": "Takeout", "value": "Takeout"},
    {"label": "Delivery", "value": "Delivery"},
    {"label": "Reservation", "value": "Reservation"},
  ];

  List<Map<String, dynamic>> orderItems = [];

  List<Map<String, dynamic>> menuCategories = [
    {"name": "Appetizers", "icon": Icons.local_dining, "color": Color(0xFF4CAF50)},
    {"name": "Main Course", "icon": Icons.dinner_dining, "color": Color(0xFF2196F3)},
    {"name": "Desserts", "icon": Icons.cake, "color": Color(0xFFFF9800)},
    {"name": "Beverages", "icon": Icons.local_cafe, "color": Color(0xFF9C27B0)},
    {"name": "Specials", "icon": Icons.star, "color": Color(0xFFF44336)},
    {"name": "Salads", "icon": Icons.eco, "color": Color(0xFF4CAF50)},
  ];

  List<Map<String, dynamic>> quickItems = [
    {
      "name": "Caesar Salad",
      "category": "Appetizers",
      "price": 14.99,
      "popular": true,
    },
    {
      "name": "Grilled Salmon",
      "category": "Main Course",
      "price": 28.99,
      "popular": true,
    },
    {
      "name": "Ribeye Steak",
      "category": "Main Course",
      "price": 42.99,
      "popular": true,
    },
    {
      "name": "Pasta Alfredo",
      "category": "Main Course",
      "price": 18.99,
      "popular": false,
    },
    {
      "name": "Chocolate Cake",
      "category": "Desserts",
      "price": 8.99,
      "popular": true,
    },
    {
      "name": "House Wine",
      "category": "Beverages",
      "price": 8.99,
      "popular": false,
    },
    {
      "name": "Soft Drinks",
      "category": "Beverages",
      "price": 3.99,
      "popular": true,
    },
    {
      "name": "Chef's Special",
      "category": "Specials",
      "price": 35.99,
      "popular": true,
    },
  ];

  double get orderTotal {
    return orderItems.fold(0.0, (total, item) => total + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get taxAmount {
    return orderTotal * 0.08; // 8% tax
  }

  double get finalTotal {
    return orderTotal + taxAmount;
  }

  void _addToOrder(Map<String, dynamic> item) {
    setState(() {
      int existingIndex = orderItems.indexWhere((orderItem) => orderItem["name"] == item["name"]);
      if (existingIndex >= 0) {
        orderItems[existingIndex]["quantity"]++;
      } else {
        orderItems.add({
          ...item,
          "quantity": 1,
          "notes": "",
        });
      }
    });
    ss("${item["name"]} added to order");
  }

  void _removeFromOrder(Map<String, dynamic> item) {
    setState(() {
      if (item["quantity"] > 1) {
        item["quantity"]--;
      } else {
        orderItems.remove(item);
      }
    });
  }

  void _updateItemQuantity(Map<String, dynamic> item, int quantity) {
    setState(() {
      if (quantity <= 0) {
        orderItems.remove(item);
      } else {
        item["quantity"] = quantity;
      }
    });
  }

  void _updateItemNotes(Map<String, dynamic> item, String notes) {
    setState(() {
      item["notes"] = notes;
    });
  }

  void _clearOrder() async {
    bool isConfirmed = await confirm("Clear all items from the order?");
    if (isConfirmed) {
      setState(() {
        orderItems.clear();
      });
      ss("Order cleared");
    }
  }

  void _saveOrder() async {
    if (selectedTable.isEmpty && orderType == "Dine In") {
      se("Please select a table for dine-in orders");
      return;
    }
    
    if (selectedServer.isEmpty) {
      se("Please select a server");
      return;
    }

    if (orderItems.isEmpty) {
      se("Please add items to the order");
      return;
    }

    bool isConfirmed = await confirm("Create new order? Total: \$${finalTotal.currency}");
    if (isConfirmed) {
      // Reset form
      setState(() {
        selectedTable = "";
        selectedServer = "";
        guestName = "";
        guestPhone = "";
        guestCount = 2;
        specialRequests = "";
        orderType = "Dine In";
        orderItems.clear();
        orderDate = DateTime.now();
        orderTime = TimeOfDay.now();
      });

      ss("Order created successfully!");
    }
  }

  void _browseCatalog() {
    si("Opening full menu catalog");
  }

  Color _getCategoryColor(String category) {
    return menuCategories.firstWhere(
      (cat) => cat["name"] == category, 
      orElse: () => {"color": primaryColor}
    )["color"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Order"),
        actions: [
          if (orderItems.isNotEmpty)
            QButton(
              icon: Icons.clear_all,
              size: bs.sm,
              onPressed: _clearOrder,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Order Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Order Type and Server
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Order Type*",
                          items: orderTypeOptions,
                          value: orderType,
                          onChanged: (value, label) {
                            orderType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Server*",
                          items: serverOptions,
                          value: selectedServer,
                          onChanged: (value, label) {
                            selectedServer = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Table and Guest Count
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: orderType == "Dine In" ? "Table*" : "Table (Optional)",
                          items: tableOptions,
                          value: selectedTable,
                          onChanged: (value, label) {
                            selectedTable = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Guest Count",
                          items: guestCountOptions,
                          value: guestCount,
                          onChanged: (value, label) {
                            guestCount = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Guest Details
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Guest Name",
                          value: guestName,
                          hint: "Enter guest name",
                          onChanged: (value) {
                            guestName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Phone Number",
                          value: guestPhone,
                          hint: "+1 234-567-8900",
                          onChanged: (value) {
                            guestPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Date and Time
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Order Date",
                          value: orderDate,
                          onChanged: (value) {
                            orderDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Order Time",
                          value: orderTime,
                          onChanged: (value) {
                            if (value != null) {
                              orderTime = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  // Special Requests
                  QMemoField(
                    label: "Special Requests",
                    value: specialRequests,
                    hint: "Any special instructions, allergies, preferences...",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Add Menu Categories
            Text(
              "Quick Add - Menu Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: menuCategories.map((category) {
                return GestureDetector(
                  onTap: _browseCatalog,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(color: category["color"], width: 2),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category["icon"],
                          color: category["color"],
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: category["color"],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Popular Items
            Text(
              "Popular Items - Quick Add",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickItems.where((item) => item["popular"] == true).map((item) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(item["category"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["category"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.star, color: warningColor, size: 16),
                        ],
                      ),

                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "\$${(item["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.add,
                            size: bs.sm,
                            onPressed: () => _addToOrder(item),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Current Order
            if (orderItems.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor, width: 2),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.receipt_long, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Current Order",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${orderItems.length} items",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      spacing: spSm,
                      children: orderItems.map((item) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(item["category"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${item["quantity"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${item["category"]} • \$${(item["price"] as double).currency} each",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$${((item["price"] as double) * (item["quantity"] as int)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.remove,
                                    size: bs.sm,
                                    onPressed: () => _removeFromOrder(item),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QTextField(
                                      label: "Special Notes",
                                      value: item["notes"],
                                      hint: "Any special instructions...",
                                      onChanged: (value) => _updateItemNotes(item, value),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.add,
                                    size: bs.sm,
                                    onPressed: () => _addToOrder(item),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    // Order Summary
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Subtotal:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${orderTotal.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Tax (8%):",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${taxAmount.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: primaryColor),
                          Row(
                            children: [
                              Text(
                                "Total:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${finalTotal.currency}",
                                style: TextStyle(
                                  fontSize: 18,
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
                            label: "Browse Full Menu",
                            size: bs.sm,
                            onPressed: _browseCatalog,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Create Order",
                            onPressed: _saveOrder,
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
      ),
    );
  }
}
