import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction8View extends StatefulWidget {
  @override
  State<GrlTransaction8View> createState() => _GrlTransaction8ViewState();
}

class _GrlTransaction8ViewState extends State<GrlTransaction8View> {
  int currentStep = 2;

  List<Map<String, dynamic>> steps = [
    {
      "title": "Order Placed",
      "description": "Your order has been successfully placed",
      "time": "2024-01-15 10:30 AM",
      "status": "completed",
      "icon": Icons.shopping_cart,
    },
    {
      "title": "Payment Confirmed",
      "description": "Payment of \$89.99 has been confirmed",
      "time": "2024-01-15 10:32 AM",
      "status": "completed",
      "icon": Icons.payment,
    },
    {
      "title": "Processing",
      "description": "Your order is being prepared",
      "time": "2024-01-15 11:45 AM",
      "status": "active",
      "icon": Icons.engineering,
    },
    {
      "title": "Shipped",
      "description": "Package has been shipped via FedEx",
      "time": "Estimated: 2024-01-16 2:00 PM",
      "status": "pending",
      "icon": Icons.local_shipping,
    },
    {
      "title": "Delivered",
      "description": "Package delivered to your address",
      "time": "Estimated: 2024-01-18 3:00 PM",
      "status": "pending",
      "icon": Icons.home,
    },
  ];

  Map<String, dynamic> orderDetails = {
    "order_id": "ORD-2024-001567",
    "total_amount": 89.99,
    "shipping_fee": 9.99,
    "tax": 8.10,
    "discount": 15.00,
    "subtotal": 95.00,
    "delivery_address": "123 Main Street, New York, NY 10001",
    "estimated_delivery": "Jan 18, 2024",
    "tracking_number": "FDX123456789012",
  };

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Wireless Bluetooth Headphones",
      "quantity": 1,
      "price": 79.99,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
    },
    {
      "name": "Phone Case Premium",
      "quantity": 1,
      "price": 15.01,
      "image": "https://picsum.photos/80/80?random=2&keyword=phone",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Container(
              width: double.infinity,
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
                        "Order #${orderDetails["order_id"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "In Transit",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Estimated Delivery: ${orderDetails["estimated_delivery"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Tracking: ${orderDetails["tracking_number"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Order Progress
            Text(
              "Order Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Stepper
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: primaryColor),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) => SizedBox.shrink(),
                  steps: steps.map((step) {
                    int index = steps.indexOf(step);
                    bool isCompleted = "${step["status"]}" == "completed";
                    bool isActive = "${step["status"]}" == "active";
                    
                    return Step(
                      title: Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isCompleted || isActive ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${step["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${step["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isCompleted || isActive ? successColor : disabledColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      isActive: isActive,
                      state: isCompleted 
                        ? StepState.complete
                        : isActive 
                          ? StepState.indexed
                          : StepState.disabled,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Order Items
            Text(
              "Order Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: orderItems.map((item) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: orderItems.indexOf(item) < orderItems.length - 1 ? spSm : 0,
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
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(item["price"] as double).toStringAsFixed(2)}",
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
              ),
            ),
            SizedBox(height: spMd),

            // Order Summary
            Text(
              "Order Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["subtotal"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["shipping_fee"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["tax"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
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
                        "-\$${(orderDetails["discount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["total_amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Delivery Address
            Text(
              "Delivery Address",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${orderDetails["delivery_address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Track Package",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: QButton(
                      label: "Contact Support",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
