import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderDetailsView extends StatefulWidget {
  const RfsOrderDetailsView({super.key});

  @override
  State<RfsOrderDetailsView> createState() => _RfsOrderDetailsViewState();
}

class _RfsOrderDetailsViewState extends State<RfsOrderDetailsView> {
  int currentTab = 0;
  String orderStatus = "Preparing";
  bool showPaymentDialog = false;
  String selectedPaymentMethod = "Cash";
  String specialInstructions = "";
  String orderNotes = "";
  bool isEditingOrder = false;
  int selectedOrderId = 12456;
  
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Grilled Salmon",
      "category": "Main Course",
      "price": 28.99,
      "quantity": 2,
      "total": 57.98,
      "status": "Preparing",
      "image": "https://picsum.photos/100/100?random=1&keyword=salmon",
      "customizations": ["No sauce", "Extra vegetables"],
      "cookingTime": 15,
      "allergens": ["Fish"],
      "spiceLevel": "Medium"
    },
    {
      "id": 2,
      "name": "Caesar Salad",
      "category": "Appetizer",
      "price": 12.50,
      "quantity": 1,
      "total": 12.50,
      "status": "Ready",
      "image": "https://picsum.photos/100/100?random=2&keyword=salad",
      "customizations": ["Extra croutons", "Dressing on side"],
      "cookingTime": 5,
      "allergens": ["Dairy", "Gluten"],
      "spiceLevel": "None"
    },
    {
      "id": 3,
      "name": "Chocolate Lava Cake",
      "category": "Dessert",
      "price": 9.99,
      "quantity": 1,
      "total": 9.99,
      "status": "Pending",
      "image": "https://picsum.photos/100/100?random=3&keyword=cake",
      "customizations": ["Vanilla ice cream"],
      "cookingTime": 12,
      "allergens": ["Dairy", "Eggs", "Gluten"],
      "spiceLevel": "None"
    },
    {
      "id": 4,
      "name": "House Wine",
      "category": "Beverages",
      "price": 8.50,
      "quantity": 2,
      "total": 17.00,
      "status": "Served",
      "image": "https://picsum.photos/100/100?random=4&keyword=wine",
      "customizations": [],
      "cookingTime": 0,
      "allergens": ["Sulfites"],
      "spiceLevel": "None"
    }
  ];

  Map<String, dynamic> orderInfo = {
    "orderId": 12456,
    "tableNumber": "A-12",
    "serverName": "Sarah Johnson",
    "customerName": "Michael Chen",
    "customerPhone": "+1 (555) 123-4567",
    "orderTime": "2024-01-15 19:30:00",
    "estimatedTime": "2024-01-15 20:15:00",
    "specialRequests": "Birthday celebration - please bring candles",
    "paymentStatus": "Pending",
    "orderType": "Dine-in",
    "guestCount": 4,
    "subtotal": 97.47,
    "tax": 9.75,
    "tip": 14.62,
    "discount": 5.00,
    "total": 116.84
  };

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Cash", "value": "Cash"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "Mobile Payment", "value": "Mobile Payment"},
    {"label": "Gift Card", "value": "Gift Card"},
  ];

  List<Map<String, dynamic>> orderStatusOptions = [
    {"label": "Pending", "value": "Pending", "color": warningColor},
    {"label": "Confirmed", "value": "Confirmed", "color": infoColor},
    {"label": "Preparing", "value": "Preparing", "color": primaryColor},
    {"label": "Ready", "value": "Ready", "color": successColor},
    {"label": "Served", "value": "Served", "color": disabledBoldColor},
    {"label": "Completed", "value": "Completed", "color": successColor},
    {"label": "Cancelled", "value": "Cancelled", "color": dangerColor}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "Confirmed": return infoColor;
      case "Preparing": return primaryColor;
      case "Ready": return successColor;
      case "Served": return disabledBoldColor;
      case "Completed": return successColor;
      case "Cancelled": return dangerColor;
      default: return disabledColor;
    }
  }

  void _updateOrderStatus(String newStatus) {
    setState(() {
      orderStatus = newStatus;
    });
    ss("Order status updated to $newStatus");
  }

  void _updateItemStatus(int itemId, String newStatus) {
    setState(() {
      int index = orderItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        orderItems[index]["status"] = newStatus;
      }
    });
    ss("Item status updated to $newStatus");
  }

  void _processPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Process Payment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Payment Method",
              items: paymentMethods,
              value: selectedPaymentMethod,
              onChanged: (value, label) {
                selectedPaymentMethod = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Text(
              "Total Amount: \$${(orderInfo["total"] as double).currency}",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Process Payment",
            size: bs.sm,
            onPressed: () {
              back();
              setState(() {
                orderInfo["paymentStatus"] = "Paid";
                orderStatus = "Completed";
              });
              ss("Payment processed successfully");
            },
          ),
        ],
      ),
    );
  }

  void _printReceipt() {
    ss("Receipt printed successfully");
  }

  void _addSpecialInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Special Instructions"),
        content: QMemoField(
          label: "Instructions",
          value: specialInstructions,
          hint: "Enter special instructions for the kitchen...",
          onChanged: (value) {
            specialInstructions = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Instructions",
            size: bs.sm,
            onPressed: () {
              back();
              setState(() {
                orderInfo["specialRequests"] = specialInstructions;
              });
              ss("Special instructions added");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #${orderInfo["orderId"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Table ${orderInfo["tableNumber"]} • ${orderInfo["guestCount"]} Guests",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(orderStatus).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(orderStatus),
                    width: 1,
                  ),
                ),
                child: Text(
                  orderStatus,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(orderStatus),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${orderInfo["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${orderInfo["customerPhone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                      "Server",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${orderInfo["serverName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateTime.parse("${orderInfo["orderTime"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Estimated Ready",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateTime.parse("${orderInfo["estimatedTime"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (isEditingOrder)
                  QButton(
                    label: "Save Changes",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        isEditingOrder = false;
                      });
                      ss("Order changes saved");
                    },
                  )
                else
                  QButton(
                    label: "Edit Order",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        isEditingOrder = true;
                      });
                    },
                  ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: orderItems.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final item = orderItems[index];
              return Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if ((item["customizations"] as List).isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Customizations: ${(item["customizations"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${(item["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Total: \$${(item["total"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(item["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: _getStatusColor(item["status"]),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(item["status"]),
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              if ((item["cookingTime"] as int) > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["cookingTime"]}min",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isEditingOrder)
                      Column(
                        children: [
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              sw("Edit item functionality");
                            },
                          ),
                          SizedBox(height: spXs),
                          QButton(
                            icon: Icons.delete,
                            size: bs.sm,
                            onPressed: () async {
                              bool isConfirmed = await confirm("Remove this item from order?");
                              if (isConfirmed) {
                                setState(() {
                                  orderItems.removeAt(index);
                                });
                                ss("Item removed from order");
                              }
                            },
                          ),
                        ],
                      )
                    else
                      PopupMenuButton<String>(
                        onSelected: (status) => _updateItemStatus(item["id"], status),
                        itemBuilder: (context) => orderStatusOptions.map((status) {
                          return PopupMenuItem<String>(
                            value: status["value"],
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: status["color"],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text("${status["label"]}"),
                              ],
                            ),
                          );
                        }).toList(),
                        child: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "\$${(orderInfo["subtotal"] as double).currency}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "\$${(orderInfo["tax"] as double).currency}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tip",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "\$${(orderInfo["tip"] as double).currency}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          if ((orderInfo["discount"] as double) > 0) ...[
            SizedBox(height: spXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
                Text(
                  "-\$${(orderInfo["discount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ],
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${(orderInfo["total"] as double).currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Status:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: orderInfo["paymentStatus"] == "Paid" 
                      ? successColor.withAlpha(20) 
                      : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: orderInfo["paymentStatus"] == "Paid" ? successColor : warningColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  "${orderInfo["paymentStatus"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: orderInfo["paymentStatus"] == "Paid" ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QButton(
                label: "Update Status",
                icon: Icons.update,
                size: bs.md,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Update Order Status"),
                      content: QDropdownField(
                        label: "New Status",
                        items: orderStatusOptions,
                        value: orderStatus,
                        onChanged: (value, label) {
                          orderStatus = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => back(),
                          child: Text("Cancel"),
                        ),
                        QButton(
                          label: "Update",
                          size: bs.sm,
                          onPressed: () {
                            back();
                            _updateOrderStatus(orderStatus);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (orderInfo["paymentStatus"] == "Pending")
                QButton(
                  label: "Process Payment",
                  icon: Icons.payment,
                  size: bs.md,
                  onPressed: _processPayment,
                ),
              QButton(
                label: "Print Receipt",
                icon: Icons.print,
                size: bs.md,
                onPressed: _printReceipt,
              ),
              QButton(
                label: "Add Instructions",
                icon: Icons.note_add,
                size: bs.md,
                onPressed: _addSpecialInstructions,
              ),
              QButton(
                label: "Send to Kitchen",
                icon: Icons.restaurant,
                size: bs.md,
                onPressed: () {
                  ss("Order sent to kitchen");
                },
              ),
              QButton(
                label: "Contact Customer",
                icon: Icons.phone,
                size: bs.md,
                onPressed: () {
                  ss("Calling customer...");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Special Requests & Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if ("${orderInfo["specialRequests"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Requests:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${orderInfo["specialRequests"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],
          QMemoField(
            label: "Add Order Notes",
            value: orderNotes,
            hint: "Add internal notes about this order...",
            onChanged: (value) {
              orderNotes = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Save Notes",
            size: bs.sm,
            onPressed: () {
              ss("Order notes saved");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTimeline() {
    List<Map<String, dynamic>> timeline = [
      {
        "time": "19:30",
        "title": "Order Placed",
        "description": "Order received from table A-12",
        "status": "completed",
        "icon": Icons.receipt_long
      },
      {
        "time": "19:32",
        "title": "Order Confirmed",
        "description": "Kitchen confirmed order receipt",
        "status": "completed",
        "icon": Icons.check_circle
      },
      {
        "time": "19:35",
        "title": "Preparation Started",
        "description": "Kitchen started preparing items",
        "status": "completed",
        "icon": Icons.restaurant
      },
      {
        "time": "19:45",
        "title": "Caesar Salad Ready",
        "description": "First course completed",
        "status": "completed",
        "icon": Icons.done
      },
      {
        "time": "20:05",
        "title": "Main Course Ready",
        "description": "Grilled Salmon completed",
        "status": "current",
        "icon": Icons.timer
      },
      {
        "time": "20:15",
        "title": "Dessert Preparation",
        "description": "Starting chocolate lava cake",
        "status": "pending",
        "icon": Icons.cake
      },
      {
        "time": "20:25",
        "title": "Order Complete",
        "description": "All items ready for service",
        "status": "pending",
        "icon": Icons.restaurant_menu
      }
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: timeline.length,
            itemBuilder: (context, index) {
              final event = timeline[index];
              final isLast = index == timeline.length - 1;
              
              Color eventColor;
              switch (event["status"]) {
                case "completed":
                  eventColor = successColor;
                  break;
                case "current":
                  eventColor = primaryColor;
                  break;
                default:
                  eventColor = disabledColor;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: eventColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          event["icon"],
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: eventColor.withAlpha(30),
                        ),
                    ],
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: eventColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (!isLast) SizedBox(height: spSm),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.receipt_long)),
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
        Tab(text: "Actions", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildOrderHeader(),
              _buildOrderItems(),
              _buildOrderSummary(),
              _buildSpecialRequests(),
            ],
          ),
        ),
        // Timeline Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildOrderTimeline(),
            ],
          ),
        ),
        // Actions Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildOrderActions(),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Access to TabController if needed
      },
    );
  }
}
