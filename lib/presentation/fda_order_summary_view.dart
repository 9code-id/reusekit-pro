import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderSummaryView extends StatefulWidget {
  const FdaOrderSummaryView({super.key});

  @override
  State<FdaOrderSummaryView> createState() => _FdaOrderSummaryViewState();
}

class _FdaOrderSummaryViewState extends State<FdaOrderSummaryView> {
  Map<String, dynamic> orderData = {
    "id": "ORD-2024-001",
    "restaurant": {
      "name": "Burger Palace",
      "image": "https://picsum.photos/100/100?random=1&keyword=restaurant",
      "address": "456 Food Street, Downtown",
      "phone": "+1 (555) 123-4567",
      "rating": 4.5,
      "deliveryTime": "25-35 mins",
    },
    "customer": {
      "name": "John Smith",
      "phone": "+1 (555) 987-6543",
      "email": "john.smith@email.com",
    },
    "delivery": {
      "address": "123 Main St, Apt 4B, Downtown, NY 10001",
      "instructions": "Ring doorbell, leave at door if no answer",
      "estimatedTime": "2024-01-15 15:30",
      "fee": 2.99,
      "type": "Standard Delivery",
    },
    "payment": {
      "method": "Credit Card ****1234",
      "cardType": "Visa",
      "subtotal": 24.98,
      "deliveryFee": 2.99,
      "serviceFee": 1.50,
      "tax": 2.95,
      "tip": 5.00,
      "discount": 3.00,
      "total": 34.42,
      "pointsEarned": 34,
    },
    "items": [
      {
        "id": "item1",
        "name": "Classic Burger",
        "description": "Beef patty with lettuce, tomato, onion, and special sauce",
        "image": "https://picsum.photos/80/80?random=1&keyword=burger",
        "price": 9.99,
        "quantity": 2,
        "customizations": ["No onions", "Extra cheese", "Medium rare"],
        "totalPrice": 19.98,
      },
      {
        "id": "item2",
        "name": "French Fries",
        "description": "Crispy golden french fries with sea salt",
        "image": "https://picsum.photos/80/80?random=2&keyword=fries",
        "price": 4.99,
        "quantity": 1,
        "customizations": ["Large size"],
        "totalPrice": 4.99,
      },
    ],
    "status": "Confirmed",
    "orderTime": "2024-01-15 14:45",
    "estimatedDelivery": "2024-01-15 15:30",
    "promoCode": "SAVE10",
    "loyaltyPoints": {
      "used": 0,
      "earned": 34,
    },
  };

  bool showFullDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Order summary shared!");
            },
          ),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {
              ss("Order summary printed!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Status Header
            _buildOrderStatusHeader(),

            // Restaurant Information
            _buildRestaurantInfo(),

            // Order Items
            _buildOrderItems(),

            // Delivery Information
            _buildDeliveryInfo(),

            // Payment Summary
            _buildPaymentSummary(),

            // Customer Information
            if (showFullDetails) _buildCustomerInfo(),

            // Toggle Details Button
            _buildToggleDetailsButton(),

            // Action Buttons
            _buildActionButtons(),

            // Order Notes
            _buildOrderNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Confirmed!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Order ${orderData["id"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.track_changes,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('OrderTrackingView')
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Estimated delivery: ${orderData["estimatedDelivery"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    Map<String, dynamic> restaurant = orderData["restaurant"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Restaurant Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${restaurant["image"]}",
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
                      "${restaurant["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: warningColor),
                        Text(
                          " ${restaurant["rating"]} • ${restaurant["deliveryTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${restaurant["address"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildOrderItems() {
    List<dynamic> items = orderData["items"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${items.length} items",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          ...items.map((item) => _buildOrderItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${item["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${item["quantity"]}x",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if ((item["customizations"] as List).isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Customizations: ${(item["customizations"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "\$${((item["totalPrice"] as double).toStringAsFixed(2))}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    Map<String, dynamic> delivery = orderData["delivery"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.location_on,
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
                      "Delivery Address",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${delivery["address"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if (delivery["instructions"].isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, size: 14, color: infoColor),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${delivery["instructions"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.delivery_dining, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${delivery["type"]} - \$${((delivery["fee"] as double).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildPaymentSummary() {
    Map<String, dynamic> payment = orderData["payment"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildPaymentRow("Subtotal", payment["subtotal"] as double),
          _buildPaymentRow("Delivery Fee", payment["deliveryFee"] as double),
          _buildPaymentRow("Service Fee", payment["serviceFee"] as double),
          _buildPaymentRow("Tax", payment["tax"] as double),
          _buildPaymentRow("Tip", payment["tip"] as double, color: successColor),
          if ((payment["discount"] as double) > 0)
            _buildPaymentRow("Discount (${orderData["promoCode"]})", 
                -(payment["discount"] as double), color: successColor),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "\$${((payment["total"] as double).toStringAsFixed(2))}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.credit_card, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Paid with ${payment["method"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if ((payment["pointsEarned"] as int) > 0)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.stars, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "You earned ${payment["pointsEarned"]} loyalty points!",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, double amount, {Color? color}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: disabledBoldColor),
          ),
        ),
        Text(
          "${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color ?? disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerInfo() {
    Map<String, dynamic> customer = orderData["customer"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildCustomerRow("Name", customer["name"], Icons.person),
          _buildCustomerRow("Phone", customer["phone"], Icons.phone),
          _buildCustomerRow("Email", customer["email"], Icons.email),
          _buildCustomerRow("Order Time", orderData["orderTime"], Icons.access_time),
        ],
      ),
    );
  }

  Widget _buildCustomerRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          "$label:",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleDetailsButton() {
    return GestureDetector(
      onTap: () {
        showFullDetails = !showFullDetails;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: primaryColor.withAlpha(50),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              showFullDetails ? Icons.expand_less : Icons.expand_more,
              color: primaryColor,
            ),
            SizedBox(width: spXs),
            Text(
              showFullDetails ? "Hide Details" : "Show More Details",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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
                onPressed: () {
                  // navigateTo('OrderTrackingView')
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Reorder",
                size: bs.md,
                onPressed: () {
                  // navigateTo('ReorderView')
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Contact Restaurant",
                size: bs.md,
                onPressed: () {
                  ss("Calling restaurant...");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Get Help",
                size: bs.md,
                onPressed: () {
                  // navigateTo('HelpCenterView')
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderNotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Important Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "• You'll receive SMS updates about your order status",
                  style: TextStyle(fontSize: 12, color: infoColor),
                ),
                Text(
                  "• Driver will contact you when nearby",
                  style: TextStyle(fontSize: 12, color: infoColor),
                ),
                Text(
                  "• Rate your order after delivery to earn bonus points",
                  style: TextStyle(fontSize: 12, color: infoColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
