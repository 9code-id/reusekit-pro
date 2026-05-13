import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderDetailView extends StatefulWidget {
  const FdaOrderDetailView({super.key});

  @override
  State<FdaOrderDetailView> createState() => _FdaOrderDetailViewState();
}

class _FdaOrderDetailViewState extends State<FdaOrderDetailView> {
  bool showInvoice = false;
  double userRating = 4.5;
  String userReview = "";
  bool hasRated = true;

  Map<String, dynamic> orderDetails = {
    "orderId": "#FD12345",
    "orderDate": "March 15, 2024",
    "orderTime": "2:30 PM",
    "deliveryTime": "3:15 PM",
    "status": "Delivered",
    "statusColor": "success",
    "restaurant": {
      "name": "Burger Palace",
      "image": "https://picsum.photos/100/100?random=1&keyword=restaurant",
      "address": "123 Food Street, City Center",
      "phone": "+1 234 567 8901",
      "rating": 4.2,
      "isOpen": true,
    },
    "deliveryPartner": {
      "name": "John Smith",
      "image": "https://picsum.photos/100/100?random=2&keyword=person",
      "phone": "+1 234 567 8900",
      "rating": 4.8,
      "vehicle": "Bike - ABC123",
    },
    "deliveryAddress": {
      "name": "Home",
      "address": "456 Oak Avenue, Apt 3B, Downtown",
      "landmark": "Near Central Park",
      "phone": "+1 234 567 8902",
    },
    "items": [
      {
        "name": "Classic Burger",
        "description": "Beef patty with lettuce, tomato, cheese",
        "quantity": 2,
        "price": 12.99,
        "total": 25.98,
        "image": "https://picsum.photos/80/80?random=3&keyword=burger",
        "customizations": ["Extra cheese", "No onions"],
      },
      {
        "name": "French Fries",
        "description": "Crispy golden fries",
        "quantity": 1,
        "price": 5.99,
        "total": 5.99,
        "image": "https://picsum.photos/80/80?random=4&keyword=fries",
        "customizations": [],
      },
      {
        "name": "Coca Cola",
        "description": "Chilled soft drink",
        "quantity": 2,
        "price": 2.99,
        "total": 5.98,
        "image": "https://picsum.photos/80/80?random=5&keyword=coke",
        "customizations": ["Large size"],
      },
    ],
    "pricing": {
      "subtotal": 37.95,
      "deliveryFee": 3.50,
      "serviceFee": 2.50,
      "tax": 4.40,
      "discount": 5.00,
      "total": 43.35,
    },
    "paymentMethod": "Credit Card ending in 4532",
    "estimatedDelivery": "25-30 mins",
    "actualDelivery": "32 mins",
  };

  List<Map<String, dynamic>> orderTimeline = [
    {
      "title": "Order Placed",
      "time": "2:30 PM",
      "description": "Your order has been confirmed",
      "status": "completed",
      "icon": Icons.receipt,
    },
    {
      "title": "Restaurant Confirmed",
      "time": "2:32 PM",
      "description": "Restaurant is preparing your order",
      "status": "completed",
      "icon": Icons.restaurant,
    },
    {
      "title": "Food Ready",
      "time": "2:55 PM",
      "description": "Your order is ready for pickup",
      "status": "completed",
      "icon": Icons.fastfood,
    },
    {
      "title": "Out for Delivery",
      "time": "3:00 PM",
      "description": "Delivery partner picked up your order",
      "status": "completed",
      "icon": Icons.delivery_dining,
    },
    {
      "title": "Delivered",
      "time": "3:15 PM",
      "description": "Order delivered successfully",
      "status": "completed",
      "icon": Icons.check_circle,
    },
  ];
  bool showFullReceipt = false;
  
  final Map<String, dynamic> orderDetail = {
    "id": "FDA2024001",
    "status": "Delivered",
    "orderDate": "2024-03-15",
    "orderTime": "2:30 PM",
    "deliveredDate": "2024-03-15",
    "deliveredTime": "3:15 PM",
    "restaurant": {
      "name": "Burger Palace",
      "image": "https://picsum.photos/100/100?random=41&keyword=restaurant",
      "address": "123 Food Street, City Center",
      "phone": "+1 234 567 8901",
      "rating": 4.2
    },
    "deliveryPartner": {
      "name": "Alex Johnson",
      "phone": "+1 234 567 8900",
      "image": "https://picsum.photos/80/80?random=42&keyword=delivery",
      "rating": 4.8
    },
    "deliveryAddress": {
      "type": "Home",
      "address": "456 Oak Avenue, Apt 3B",
      "city": "Downtown, NY 10001",
      "instructions": "Ring doorbell twice, leave at door"
    },
    "items": [
      {
        "name": "Classic Burger",
        "description": "Beef patty, lettuce, tomato, onion, pickles",
        "image": "https://picsum.photos/60/60?random=43&keyword=burger",
        "qty": 2,
        "price": 12.99,
        "customizations": ["Extra cheese", "No onions"]
      },
      {
        "name": "French Fries",
        "description": "Crispy golden fries with sea salt",
        "image": "https://picsum.photos/60/60?random=44&keyword=fries",
        "qty": 1,
        "price": 5.99,
        "customizations": []
      },
      {
        "name": "Coca Cola",
        "description": "Chilled soft drink",
        "image": "https://picsum.photos/60/60?random=45&keyword=cola",
        "qty": 2,
        "price": 2.99,
        "customizations": ["Extra ice"]
      }
    ],
    "billBreakdown": {
      "subtotal": 34.96,
      "deliveryFee": 2.99,
      "serviceFee": 1.50,
      "tax": 3.15,
      "discount": -5.00,
      "tip": 5.00,
      "total": 42.60
    },
    "paymentMethod": {
      "type": "Credit Card",
      "details": "Visa ending in 4532",
      "status": "Paid"
    },
    "timeline": [
      {
        "title": "Order Placed",
        "time": "2:30 PM",
        "description": "Your order was confirmed",
        "status": "completed"
      },
      {
        "title": "Restaurant Confirmed",
        "time": "2:32 PM",
        "description": "Burger Palace accepted your order",
        "status": "completed"
      },
      {
        "title": "Preparing Food",
        "time": "2:35 PM",
        "description": "Kitchen started preparing your order",
        "status": "completed"
      },
      {
        "title": "Food Ready",
        "time": "2:55 PM",
        "description": "Order ready for pickup",
        "status": "completed"
      },
      {
        "title": "Out for Delivery",
        "time": "3:00 PM",
        "description": "Alex picked up your order",
        "status": "completed"
      },
      {
        "title": "Delivered",
        "time": "3:15 PM",
        "description": "Order delivered successfully",
        "status": "completed"
      }
    ],
    "customerRating": 4.5,
    "customerReview": "Food was delicious and arrived hot! Alex was very professional.",
    "canCancel": false,
    "canReorder": true,
    "canRate": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              //navigateTo('FdaHelpCenterView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${orderDetails["orderId"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${orderDetails["status"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${orderDetails["orderDate"]} at ${orderDetails["orderTime"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  if (orderDetails["status"] == "Delivered")
                    Text(
                      "Delivered in ${orderDetails["actualDelivery"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                borderRadius: BorderRadius.circular(radiusLg),
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
                          "${orderDetails["restaurant"]["image"]}",
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
                              "${orderDetails["restaurant"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${orderDetails["restaurant"]["address"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${orderDetails["restaurant"]["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: orderDetails["restaurant"]["isOpen"] 
                                        ? successColor.withAlpha(20)
                                        : dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    orderDetails["restaurant"]["isOpen"] ? "Open" : "Closed",
                                    style: TextStyle(
                                      color: orderDetails["restaurant"]["isOpen"] 
                                          ? successColor
                                          : dangerColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.call,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling restaurant");
                        },
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Items (${(orderDetails["items"] as List).length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...List.generate((orderDetails["items"] as List).length, (index) {
                    final item = (orderDetails["items"] as List)[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: index < (orderDetails["items"] as List).length - 1
                            ? Border(bottom: BorderSide(color: disabledColor))
                            : null,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "×${item["quantity"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                if ((item["customizations"] as List).isNotEmpty)
                                  Text(
                                    "Customizations: ${(item["customizations"] as List).join(", ")}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${(item["price"] as double).toStringAsFixed(2)} each",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "\$${(item["total"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
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
                    );
                  }),
                ],
              ),
            ),

            // Bill Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bill Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showInvoice = !showInvoice;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              showInvoice ? Icons.visibility_off : Icons.visibility,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              showInvoice ? "Hide Details" : "View Details",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (showInvoice) ...[
                    _buildBillRow("Subtotal", "\$${(orderDetails["pricing"]["subtotal"] as double).toStringAsFixed(2)}"),
                    _buildBillRow("Delivery Fee", "\$${(orderDetails["pricing"]["deliveryFee"] as double).toStringAsFixed(2)}"),
                    _buildBillRow("Service Fee", "\$${(orderDetails["pricing"]["serviceFee"] as double).toStringAsFixed(2)}"),
                    _buildBillRow("Tax", "\$${(orderDetails["pricing"]["tax"] as double).toStringAsFixed(2)}"),
                    _buildBillRow("Discount", "-\$${(orderDetails["pricing"]["discount"] as double).toStringAsFixed(2)}", isDiscount: true),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: disabledColor,
                      margin: EdgeInsets.symmetric(vertical: spXs),
                    ),
                  ],
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
                        "\$${(orderDetails["pricing"]["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Paid via ${orderDetails["paymentMethod"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
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
                  
                  // Delivery Partner
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${orderDetails["deliveryPartner"]["image"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetails["deliveryPartner"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${orderDetails["deliveryPartner"]["vehicle"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${orderDetails["deliveryPartner"]["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.call,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling delivery partner");
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Delivery Address
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${orderDetails["deliveryAddress"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${orderDetails["deliveryAddress"]["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (orderDetails["deliveryAddress"]["landmark"] != null)
                          Text(
                            "Landmark: ${orderDetails["deliveryAddress"]["landmark"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Order Timeline
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...List.generate(orderTimeline.length, (index) {
                    final step = orderTimeline[index];
                    final isLast = index == orderTimeline.length - 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: step["status"] == "completed" ? successColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                step["icon"] as IconData,
                                color: Colors.white,
                                size: 16,
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
                          child: Container(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${step["title"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${step["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${step["description"]}",
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
                    );
                  }),
                ],
              ),
            ),

            // Customer Rating (if delivered)
            if (orderDetails["status"] == "Delivered") ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Your Review",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hasRated) ...[
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  userRating = (index + 1).toDouble();
                                });
                              },
                              child: Icon(
                                index < userRating.round() ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 24,
                              ),
                            );
                          }),
                          SizedBox(width: spSm),
                          Text(
                            "${userRating}/5",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      if (userReview.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            userReview,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                    ] else ...[
                      Text(
                        "How was your experience?",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      QButton(
                        label: "Rate Order",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('FdaRateOrderView')
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Reorder",
                    size: bs.md,
                    onPressed: () {
                      ss("Items added to cart for reorder");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Get Invoice",
                    size: bs.md,
                    onPressed: () {
                      ss("Invoice downloaded");
                    },
                  ),
                ),
              ],
            ),

            if (orderDetails["status"] != "Delivered") ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Cancel Order",
                  size: bs.md,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                    if (isConfirmed) {
                      ss("Order cancellation requested");
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, String amount, {bool isDiscount = false}) {
    return Row(
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
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDiscount ? successColor : Colors.black,
          ),
        ),
      ],
    );
  }
}
