import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOrderDetailView extends StatefulWidget {
  const RmaOrderDetailView({super.key});

  @override
  State<RmaOrderDetailView> createState() => _RmaOrderDetailViewState();
}

class _RmaOrderDetailViewState extends State<RmaOrderDetailView> {
  String selectedTab = "details";
  bool isEditingMode = false;
  String orderStatus = "preparing";
  String paymentStatus = "paid";
  String deliveryStatus = "pending";

  Map<String, dynamic> orderDetails = {
    "orderId": "ORD-2024-001287",
    "customerName": "Sarah Johnson",
    "customerEmail": "sarah.johnson@email.com",
    "customerPhone": "+1-555-0123",
    "orderDate": "2024-06-17 14:30:00",
    "estimatedTime": "25 minutes",
    "actualTime": "0 minutes",
    "orderType": "Dine In",
    "tableNumber": "Table 12",
    "paymentMethod": "Credit Card",
    "subtotal": 48.75,
    "tax": 4.38,
    "tip": 9.75,
    "discount": 0.00,
    "total": 62.88,
    "specialInstructions": "Extra crispy fries, no onions on burger",
    "priority": "normal",
    "server": "Mike Thompson",
    "kitchen": "Station 2",
    "preparationNotes": "Customer has nut allergy - use separate utensils"
  };

  List<Map<String, dynamic>> orderItems = [
    {
      "itemId": "ITEM001",
      "name": "Classic Cheeseburger",
      "category": "Main Course",
      "quantity": 1,
      "unitPrice": 16.50,
      "totalPrice": 16.50,
      "status": "preparing",
      "cookingTime": "12 minutes",
      "modifiers": ["Extra Cheese", "No Onions"],
      "allergens": ["Dairy", "Gluten"],
      "instructions": "Medium rare, extra pickles"
    },
    {
      "itemId": "ITEM002", 
      "name": "Truffle Fries",
      "category": "Side",
      "quantity": 2,
      "unitPrice": 8.50,
      "totalPrice": 17.00,
      "status": "preparing",
      "cookingTime": "8 minutes",
      "modifiers": ["Extra Crispy", "Truffle Oil"],
      "allergens": [],
      "instructions": "Well done"
    },
    {
      "itemId": "ITEM003",
      "name": "Caesar Salad",
      "category": "Salad",
      "quantity": 1,
      "unitPrice": 12.25,
      "totalPrice": 12.25,
      "status": "ready",
      "cookingTime": "5 minutes",
      "modifiers": ["Extra Dressing", "No Croutons"],
      "allergens": ["Dairy"],
      "instructions": "Light on dressing"
    },
    {
      "itemId": "ITEM004",
      "name": "Iced Coffee",
      "category": "Beverage",
      "quantity": 1,
      "unitPrice": 3.00,
      "totalPrice": 3.00,
      "status": "completed",
      "cookingTime": "2 minutes",
      "modifiers": ["Extra Ice", "Vanilla Syrup"],
      "allergens": [],
      "instructions": "Large size"
    }
  ];

  List<Map<String, dynamic>> orderHistory = [
    {
      "timestamp": "2024-06-17 14:30:00",
      "action": "Order Placed",
      "user": "System",
      "details": "Order received from customer"
    },
    {
      "timestamp": "2024-06-17 14:32:00", 
      "action": "Payment Confirmed",
      "user": "Payment System",
      "details": "Credit card payment processed successfully"
    },
    {
      "timestamp": "2024-06-17 14:33:00",
      "action": "Order Accepted",
      "user": "Mike Thompson",
      "details": "Order confirmed and sent to kitchen"
    },
    {
      "timestamp": "2024-06-17 14:35:00",
      "action": "Preparation Started",
      "user": "Kitchen Staff",
      "details": "Order started preparation at Station 2"
    },
    {
      "timestamp": "2024-06-17 14:40:00",
      "action": "Item Ready",
      "user": "Kitchen Staff", 
      "details": "Iced Coffee completed"
    },
    {
      "timestamp": "2024-06-17 14:45:00",
      "action": "Item Ready",
      "user": "Kitchen Staff",
      "details": "Caesar Salad completed"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'ready':
      case 'delivered':
        return successColor;
      case 'preparing':
      case 'cooking':
      case 'pending':
        return warningColor;
      case 'cancelled':
      case 'rejected':
        return dangerColor;
      case 'paid':
        return successColor;
      case 'refunded':
        return infoColor;
      default:
        return disabledBoldColor;
    }
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orderDetails["orderId"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${orderDetails["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${orderDetails["orderType"]} • ${orderDetails["tableNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(orderStatus).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      orderStatus.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(orderStatus),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((orderDetails["total"] as num).toDouble()).currency}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              _buildInfoChip("Time", "${orderDetails["estimatedTime"]}", Icons.schedule),
              SizedBox(width: spSm),
              _buildInfoChip("Server", "${orderDetails["server"]}", Icons.person),
              SizedBox(width: spSm),
              _buildInfoChip("Kitchen", "${orderDetails["kitchen"]}", Icons.restaurant),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 16,
            ),
            SizedBox(width: spXs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
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

  Widget _buildTabSelector() {
    final tabs = [
      {"id": "details", "label": "Details", "icon": Icons.receipt_long},
      {"id": "items", "label": "Items", "icon": Icons.restaurant_menu},
      {"id": "payment", "label": "Payment", "icon": Icons.payment},
      {"id": "history", "label": "History", "icon": Icons.history},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab["id"];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = tab["id"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      tab["icon"] as IconData,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      tab["label"] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOrderDetailsTab() {
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
            "Order Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildDetailRow("Order ID", "${orderDetails["orderId"]}"),
          _buildDetailRow("Order Date", "${DateTime.parse(orderDetails["orderDate"]).dMMMy}"),
          _buildDetailRow("Order Time", "${DateTime.parse(orderDetails["orderDate"]).kkmm}"),
          _buildDetailRow("Order Type", "${orderDetails["orderType"]}"),
          _buildDetailRow("Table", "${orderDetails["tableNumber"]}"),
          _buildDetailRow("Estimated Time", "${orderDetails["estimatedTime"]}"),
          SizedBox(height: spMd),
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildDetailRow("Name", "${orderDetails["customerName"]}"),
          _buildDetailRow("Email", "${orderDetails["customerEmail"]}"),
          _buildDetailRow("Phone", "${orderDetails["customerPhone"]}"),
          if (orderDetails["specialInstructions"] != null && (orderDetails["specialInstructions"] as String).isNotEmpty) ...[
            SizedBox(height: spMd),
            Text(
              "Special Instructions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Text(
                "${orderDetails["specialInstructions"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          ],
          if (orderDetails["preparationNotes"] != null && (orderDetails["preparationNotes"] as String).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${orderDetails["preparationNotes"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            ":",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsTab() {
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
            children: [
              Text(
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (isEditingMode) ...[
                QButton(
                  label: "Save Changes",
                  size: bs.sm,
                  onPressed: () {
                    isEditingMode = false;
                    setState(() {});
                    ss("Order items updated successfully");
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: isEditingMode ? "Cancel" : "Edit Items",
                size: bs.sm,
                color: isEditingMode ? dangerColor : infoColor,
                onPressed: () {
                  isEditingMode = !isEditingMode;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...orderItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: _getStatusColor(item["status"] as String).withAlpha(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["category"]} • Qty: ${item["quantity"]}",
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(item["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            (item["status"] as String).toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(item["status"] as String),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((item["totalPrice"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if ((item["modifiers"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (item["modifiers"] as List).map((modifier) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "$modifier",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
                if ((item["allergens"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Allergens: ${(item["allergens"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
                if (item["instructions"] != null && (item["instructions"] as String).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Instructions: ${item["instructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Cook Time: ${item["cookingTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (isEditingMode) ...[
                      QButton(
                        label: "Update Status",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('UpdateItemStatusView')
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPaymentTab() {
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
            "Payment Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildPaymentRow("Subtotal", "${((orderDetails["subtotal"] as num).toDouble()).currency}"),
                _buildPaymentRow("Tax", "${((orderDetails["tax"] as num).toDouble()).currency}"),
                _buildPaymentRow("Tip", "${((orderDetails["tip"] as num).toDouble()).currency}"),
                if ((orderDetails["discount"] as num) > 0)
                  _buildPaymentRow("Discount", "-${((orderDetails["discount"] as num).toDouble()).currency}", isDiscount: true),
                Divider(),
                _buildPaymentRow("Total", "${((orderDetails["total"] as num).toDouble()).currency}", isTotal: true),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.payment,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Payment Method: ${orderDetails["paymentMethod"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(paymentStatus).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  paymentStatus.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(paymentStatus),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Process Refund",
                  color: warningColor,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('ProcessRefundView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Send Receipt",
                  size: bs.sm,
                  onPressed: () {
                    ss("Receipt sent to customer email");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isTotal = false, bool isDiscount = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "\$${amount}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isDiscount ? dangerColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
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
            "Order History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...orderHistory.map((history) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${history["action"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${DateTime.parse(history["timestamp"]).kkmm}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${history["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "by ${history["user"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Update Status",
              size: bs.sm,
              onPressed: () {
                //navigateTo('UpdateOrderStatusView')
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Print Order",
              color: infoColor,
              size: bs.sm,
              onPressed: () {
                ss("Order sent to printer");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Cancel Order",
              color: dangerColor,
              size: bs.sm,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                if (isConfirmed) {
                  //navigateTo('CancelOrderView')
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "items":
        return _buildOrderItemsTab();
      case "payment":
        return _buildPaymentTab();
      case "history":
        return _buildHistoryTab();
      default:
        return _buildOrderDetailsTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Order details shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              ss("Order sent to printer");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOrderHeader(),
            _buildTabSelector(),
            _buildTabContent(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
