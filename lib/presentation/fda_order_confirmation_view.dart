import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderConfirmationView extends StatefulWidget {
  const FdaOrderConfirmationView({super.key});

  @override
  State<FdaOrderConfirmationView> createState() => _FdaOrderConfirmationViewState();
}

class _FdaOrderConfirmationViewState extends State<FdaOrderConfirmationView> {
  Map<String, dynamic> orderDetails = {
    "orderId": "#FD2025001234",
    "orderDate": DateTime.now(),
    "estimatedDelivery": DateTime.now().add(Duration(minutes: 45)),
    "status": "confirmed",
    "total": 67.48,
    "paymentMethod": "Visa ending in 4567",
    "deliveryAddress": {
      "name": "John Doe",
      "address": "123 Main Street, Apt 4B",
      "city": "New York, NY 10001",
      "phone": "+1 (555) 123-4567",
    },
    "restaurant": {
      "name": "Tony's Italian Kitchen",
      "address": "456 Restaurant Ave, New York",
      "phone": "+1 (555) 888-9999",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
    },
    "deliveryPartner": {
      "name": "Mike Rodriguez",
      "phone": "+1 (555) 777-6666",
      "image": "https://picsum.photos/100/100?random=2&keyword=person",
      "rating": 4.8,
      "vehicle": "Honda Civic - ABC 123",
    },
    "items": [
      {
        "name": "Margherita Pizza",
        "quantity": 2,
        "price": 24.99,
        "size": "Medium",
        "addons": ["Extra Cheese"],
      },
      {
        "name": "Caesar Salad",
        "quantity": 1,
        "price": 12.99,
        "size": "Regular",
        "addons": ["Grilled Chicken"],
      },
    ],
    "billing": {
      "subtotal": 49.98,
      "deliveryFee": 3.99,
      "serviceFee": 2.50,
      "taxes": 4.00,
      "tip": 7.01,
      "total": 67.48,
    },
  };

  bool isOrderTracked = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        automaticallyImplyLeading: false,
        actions: [
          QButton(
            icon: Icons.close,
            size: bs.sm,
            onPressed: () {
              // Navigate to home
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Success Animation/Icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Order Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your order has been placed successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),

            // Order Info
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
                    "Order Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildInfoRow("Order ID", "${orderDetails["orderId"]}"),
                  _buildInfoRow("Order Date", "${(orderDetails["orderDate"] as DateTime).dMMMy}"),
                  _buildInfoRow("Estimated Delivery", "${(orderDetails["estimatedDelivery"] as DateTime).dMMMykkss}"),
                  _buildInfoRow("Payment Method", "${orderDetails["paymentMethod"]}"),
                  _buildInfoRow("Total Amount", "\$${((orderDetails["total"] as double)).currency}"),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Your food will be ready in 35-45 minutes",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Restaurant Info
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
                    "Restaurant",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${(orderDetails["restaurant"] as Map)["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(orderDetails["restaurant"] as Map)["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(orderDetails["restaurant"] as Map)["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(orderDetails["restaurant"] as Map)["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling restaurant...");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delivery Address
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
                    "Delivery Address",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 24),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(orderDetails["deliveryAddress"] as Map)["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(orderDetails["deliveryAddress"] as Map)["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(orderDetails["deliveryAddress"] as Map)["city"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(orderDetails["deliveryAddress"] as Map)["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Items
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
                    "Order Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...(orderDetails["items"] as List).map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(100)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${item["quantity"]}x",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
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
                                Text(
                                  "Size: ${item["size"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((item["addons"] as List).isNotEmpty)
                                  Text(
                                    "Add-ons: ${(item["addons"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(((item["price"] as double) * (item["quantity"] as int))).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Bill Summary
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
                    "Bill Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildBillRow("Subtotal", (orderDetails["billing"] as Map)["subtotal"] as double),
                  _buildBillRow("Delivery Fee", (orderDetails["billing"] as Map)["deliveryFee"] as double),
                  _buildBillRow("Service Fee", (orderDetails["billing"] as Map)["serviceFee"] as double),
                  _buildBillRow("Taxes & Fees", (orderDetails["billing"] as Map)["taxes"] as double),
                  _buildBillRow("Tip", (orderDetails["billing"] as Map)["tip"] as double),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Paid",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((orderDetails["billing"] as Map)["total"] as double).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    label: "Track Your Order",
                    size: bs.md,
                    icon: Icons.location_on,
                    onPressed: () {
                      // Navigate to order tracking
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Restaurant",
                          size: bs.md,
                          icon: Icons.phone,
                          onPressed: () {
                            ss("Calling restaurant...");
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Share Order",
                          size: bs.md,
                          icon: Icons.share,
                          onPressed: () {
                            ss("Order shared successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                  QButton(
                    label: "Download Receipt",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: () {
                      ss("Receipt downloaded");
                    },
                  ),
                ],
              ),
            ),

            // Notifications Settings
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
                    "Order Updates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications, color: primaryColor, size: 20),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Push Notifications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Get notified about order status updates",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 16),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "You'll receive updates via SMS and app notifications",
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

            // Support
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Chat Support",
                          size: bs.md,
                          icon: Icons.chat,
                          onPressed: () {
                            // Open chat support
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Call Support",
                          size: bs.md,
                          icon: Icons.support_agent,
                          onPressed: () {
                            ss("Calling support...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Continue Shopping",
          size: bs.md,
          icon: Icons.shopping_bag,
          onPressed: () {
            // Navigate to home/restaurants
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillRow(String label, double amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
