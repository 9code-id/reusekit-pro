import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation1View extends StatefulWidget {
  @override
  State<GrlConfirmation1View> createState() => _GrlConfirmation1ViewState();
}

class _GrlConfirmation1ViewState extends State<GrlConfirmation1View> {
  final formKey = GlobalKey<FormState>();
  String orderNumber = "ORD-2024-001234";
  String customerName = "John Smith";
  String customerEmail = "john.smith@email.com";
  String customerPhone = "+1 (555) 123-4567";
  String deliveryAddress = "123 Main Street, Apt 4B\nNew York, NY 10001";
  String paymentMethod = "Credit Card ending in 1234";
  double subtotal = 124.50;
  double tax = 12.45;
  double shipping = 9.99;
  double discount = 15.00;
  String estimatedDelivery = "2024-02-20";
  
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "sku": "WBH-001",
      "quantity": 1,
      "price": 79.99,
      "image": "https://picsum.photos/100/100?random=1&keyword=headphones"
    },
    {
      "id": 2,
      "name": "USB-C Cable (3ft)",
      "sku": "USBC-3FT",
      "quantity": 2,
      "price": 14.99,
      "image": "https://picsum.photos/100/100?random=2&keyword=cable"
    },
    {
      "id": 3,
      "name": "Phone Case - Clear",
      "sku": "PC-CLEAR",
      "quantity": 1,
      "price": 19.99,
      "image": "https://picsum.photos/100/100?random=3&keyword=phonecase"
    },
  ];

  double get total => subtotal + tax + shipping - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () => _shareOrder(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSuccessHeader(),
            _buildOrderSummary(),
            _buildOrderItems(),
            _buildCustomerInfo(),
            _buildPaymentInfo(),
            _buildDeliveryInfo(),
            _buildOrderTracking(),
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
          colors: [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 48,
              color: successColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Order Confirmed!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Thank you for your purchase",
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 16,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Order #$orderNumber",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fsH6,
              ),
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
        spacing: spSm,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal:", style: TextStyle(fontWeight: FontWeight.w600)),
              Text("\$${subtotal.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax:", style: TextStyle(color: disabledBoldColor)),
              Text("\$${tax.toStringAsFixed(2)}", style: TextStyle(color: disabledBoldColor)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping:", style: TextStyle(color: disabledBoldColor)),
              Text("\$${shipping.toStringAsFixed(2)}", style: TextStyle(color: disabledBoldColor)),
            ],
          ),
          if (discount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount:", style: TextStyle(color: successColor)),
                Text("-\$${discount.toStringAsFixed(2)}", style: TextStyle(color: successColor)),
              ],
            ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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

  Widget _buildOrderItems() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Items Ordered",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...orderItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
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
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "SKU: ${item["sku"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Qty: ${item["quantity"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
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

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow(Icons.person, "Name", customerName),
          _buildInfoRow(Icons.email, "Email", customerEmail),
          _buildInfoRow(Icons.phone, "Phone", customerPhone),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow(Icons.payment, "Payment Method", paymentMethod),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Payment processed successfully",
                    style: TextStyle(
                      color: successColor,
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

  Widget _buildDeliveryInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow(Icons.local_shipping, "Delivery Address", deliveryAddress),
          _buildInfoRow(Icons.schedule, "Estimated Delivery", 
            "${DateTime.parse(estimatedDelivery).dMMMy}"),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "You will receive tracking information once your order ships.",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
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

  Widget _buildOrderTracking() {
    List<Map<String, dynamic>> trackingSteps = [
      {
        "title": "Order Confirmed",
        "description": "Your order has been confirmed and is being processed",
        "status": "completed",
        "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      },
      {
        "title": "Payment Processed",
        "description": "Payment has been successfully processed",
        "status": "completed",
        "timestamp": DateTime.now().subtract(Duration(minutes: 3)),
      },
      {
        "title": "Preparing for Shipment",
        "description": "Items are being picked and packed",
        "status": "current",
        "timestamp": null,
      },
      {
        "title": "Shipped",
        "description": "Your order is on its way",
        "status": "pending",
        "timestamp": null,
      },
      {
        "title": "Delivered",
        "description": "Order delivered to your address",
        "status": "pending",
        "timestamp": null,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...trackingSteps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == trackingSteps.length - 1;
            
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _getStepColor(step["status"]),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getStepIcon(step["status"]),
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: step["status"] == "completed" ? successColor : disabledColor,
                      ),
                  ],
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: step["status"] == "current" ? primaryColor : Colors.black,
                        ),
                      ),
                      Text(
                        "${step["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      if (step["timestamp"] != null)
                        Text(
                          "${(step["timestamp"] as DateTime).dMMMy} at ${(step["timestamp"] as DateTime).hour.toString().padLeft(2, '0')}:${(step["timestamp"] as DateTime).minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                          ),
                        ),
                      if (!isLast) SizedBox(height: spSm),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Track Order",
                size: bs.md,
                onPressed: () => _trackOrder(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Download Invoice",
                size: bs.md,
                onPressed: () => _downloadInvoice(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Continue Shopping",
                size: bs.sm,
                onPressed: () => _continueShopping(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Contact Support",
                size: bs.sm,
                onPressed: () => _contactSupport(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStepColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "current":
        return primaryColor;
      case "pending":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStepIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check;
      case "current":
        return Icons.radio_button_checked;
      case "pending":
        return Icons.radio_button_unchecked;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  void _shareOrder() {
    ss("Order details shared successfully!");
  }

  void _trackOrder() {
    ss("Redirecting to order tracking...");
  }

  void _downloadInvoice() {
    ss("Invoice downloaded successfully!");
  }

  void _continueShopping() {
    ss("Returning to shop...");
  }

  void _contactSupport() {
    ss("Opening support chat...");
  }
}
