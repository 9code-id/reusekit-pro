import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout4View extends StatefulWidget {
  const GrlCheckout4View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout4View> createState() => _GrlCheckout4ViewState();
}

class _GrlCheckout4ViewState extends State<GrlCheckout4View> {
  String orderStatus = "confirmed";
  String trackingNumber = "TRK123456789";
  String estimatedDelivery = "March 15, 2024";
  
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Premium Gaming Headset",
      "image": "https://picsum.photos/80/80?random=1&keyword=headset",
      "price": 199.99,
      "quantity": 1,
      "status": "Processing",
    },
    {
      "id": 2,
      "name": "Mechanical Keyboard",
      "image": "https://picsum.photos/80/80?random=2&keyword=keyboard",
      "price": 149.99,
      "quantity": 1,
      "status": "Processing",
    },
    {
      "id": 3,
      "name": "Gaming Mouse Pad",
      "image": "https://picsum.photos/80/80?random=3&keyword=mousepad",
      "price": 29.99,
      "quantity": 2,
      "status": "Processing",
    },
  ];

  List<Map<String, dynamic>> orderTimeline = [
    {
      "status": "Order Placed",
      "description": "Your order has been received and is being processed",
      "timestamp": "2024-03-10 14:30",
      "completed": true,
      "icon": Icons.shopping_cart,
    },
    {
      "status": "Payment Confirmed",
      "description": "Payment has been successfully processed",
      "timestamp": "2024-03-10 14:35",
      "completed": true,
      "icon": Icons.payment,
    },
    {
      "status": "Processing",
      "description": "Your items are being prepared for shipment",
      "timestamp": "2024-03-11 09:15",
      "completed": true,
      "icon": Icons.inventory,
    },
    {
      "status": "Shipped",
      "description": "Your order has been shipped",
      "timestamp": "",
      "completed": false,
      "icon": Icons.local_shipping,
    },
    {
      "status": "Delivered",
      "description": "Order delivered to your address",
      "timestamp": "",
      "completed": false,
      "icon": Icons.check_circle,
    },
  ];

  Map<String, dynamic> orderDetails = {
    "orderNumber": "ORD-2024-001578",
    "orderDate": "March 10, 2024",
    "totalAmount": 409.96,
    "shippingAddress": {
      "name": "John Doe",
      "address": "123 Main Street, Apt 4B",
      "city": "New York, NY 10001",
      "phone": "+1 (555) 123-4567",
    },
    "paymentMethod": {
      "type": "Credit Card",
      "last4": "4242",
      "brand": "Visa",
    },
  };

  double get subtotal => orderItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get shipping => 12.99;
  double get tax => subtotal * 0.085;
  double get total => subtotal + shipping + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareOrder,
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            _buildSuccessHeader(),
            _buildOrderStatus(),
            _buildOrderTimeline(),
            _buildOrderItems(),
            _buildShippingDetails(),
            _buildPaymentDetails(),
            _buildOrderSummary(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, Colors.green.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: successColor,
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Order Confirmed!",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Text(
            "Thank you for your purchase. Your order has been successfully placed and will be processed shortly.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.confirmation_number,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Order #${orderDetails["orderNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inventory,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Processing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Your order is being prepared for shipment",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "In Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Estimated Delivery: $estimatedDelivery",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTimeline() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: orderTimeline.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> step = entry.value;
              bool isLast = index == orderTimeline.length - 1;
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step["completed"] ? successColor : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          step["icon"] as IconData,
                          color: step["completed"] ? Colors.white : disabledBoldColor,
                          size: 16,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: step["completed"] ? successColor : Colors.grey.shade300,
                        ),
                    ],
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${step["status"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: step["completed"] ? Colors.black : disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${step["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (step["timestamp"].toString().isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Text(
                              "${step["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${orderItems.length} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: orderItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${(item["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total: \$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingDetails() {
    Map<String, dynamic> address = orderDetails["shippingAddress"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${address["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${address["address"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${address["city"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${address["phone"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    Map<String, dynamic> payment = orderDetails["paymentMethod"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${payment["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "**** **** **** ${payment["last4"]} (${payment["brand"]})",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "Paid",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("Shipping", shipping),
          _buildPriceRow("Tax", tax),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Paid",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
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
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Track Your Order",
            size: bs.md,
            icon: Icons.track_changes,
            onPressed: _trackOrder,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Download Receipt",
                size: bs.md,
                color: secondaryColor,
                icon: Icons.receipt,
                onPressed: _downloadReceipt,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Contact Support",
                size: bs.md,
                color: infoColor,
                icon: Icons.support_agent,
                onPressed: _contactSupport,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue Shopping",
            size: bs.md,
            color: Colors.grey.shade600,
            icon: Icons.shopping_bag,
            onPressed: _continueShopping,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _shareOrder() {
    ss("Order details shared successfully!");
  }

  void _trackOrder() {
    si("Redirecting to tracking page...");
    // Navigate to tracking page
  }

  void _downloadReceipt() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Receipt downloaded successfully!");
    });
  }

  void _contactSupport() {
    si("Opening support chat...");
    // Navigate to support page
  }

  void _continueShopping() {
    si("Returning to shopping...");
    // Navigate back to shop
  }
}
