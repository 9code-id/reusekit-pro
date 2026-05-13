import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryStatusView extends StatefulWidget {
  const FdaDeliveryStatusView({super.key});

  @override
  State<FdaDeliveryStatusView> createState() => _FdaDeliveryStatusViewState();
}

class _FdaDeliveryStatusViewState extends State<FdaDeliveryStatusView> {
  int currentStep = 2;
  
  final Map<String, dynamic> orderInfo = {
    "orderId": "FDA2024001",
    "estimatedTime": "25-30 mins",
    "actualTime": "15 mins",
    "deliveryPartner": {
      "name": "Alex Johnson",
      "phone": "+1 234 567 8900",
      "rating": 4.8,
      "image": "https://picsum.photos/100/100?random=21&keyword=delivery"
    },
    "restaurant": {
      "name": "Burger Palace",
      "phone": "+1 234 567 8901",
      "address": "123 Food Street, City Center"
    },
    "deliveryAddress": "456 Oak Avenue, Apt 3B, Downtown",
    "items": [
      {"name": "Classic Burger", "qty": 2, "price": 15.99},
      {"name": "French Fries", "qty": 1, "price": 5.99},
      {"name": "Coca Cola", "qty": 2, "price": 3.99}
    ],
    "total": 25.97,
    "paymentMethod": "Credit Card ending in 4532"
  };
  
  final List<Map<String, dynamic>> deliverySteps = [
    {
      "title": "Order Confirmed",
      "subtitle": "Restaurant is preparing your order",
      "time": "2:30 PM",
      "status": "completed",
      "icon": Icons.restaurant
    },
    {
      "title": "Food Ready",
      "subtitle": "Your order is ready for pickup",
      "time": "2:45 PM", 
      "status": "completed",
      "icon": Icons.fastfood
    },
    {
      "title": "Out for Delivery",
      "subtitle": "Alex is on the way with your order",
      "time": "3:00 PM",
      "status": "active",
      "icon": Icons.delivery_dining
    },
    {
      "title": "Delivered",
      "subtitle": "Enjoy your meal!",
      "time": "Expected 3:15 PM",
      "status": "pending",
      "icon": Icons.check_circle
    }
  ];

  bool showMap = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Status"),
        actions: [
          GestureDetector(
            onTap: () {
              showMap = !showMap;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Icon(
                showMap ? Icons.list : Icons.map,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: primaryColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Estimated Delivery",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${orderInfo["estimatedTime"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Order #${orderInfo["orderId"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),

            // Map/Delivery Partner Info Section
            if (showMap) ...[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Stack(
                  children: [
                    // Mock Map
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/400/200?random=22&keyword=map"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    // Delivery Partner Info Overlay
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${orderInfo["deliveryPartner"]["image"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${orderInfo["deliveryPartner"]["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${orderInfo["deliveryPartner"]["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Call delivery partner
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Delivery Partner Card (when map is hidden)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Delivery Partner",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${orderInfo["deliveryPartner"]["image"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderInfo["deliveryPartner"]["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${orderInfo["deliveryPartner"]["rating"]} rating",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${orderInfo["deliveryPartner"]["phone"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Call delivery partner
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                // Message delivery partner
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spMd),

            // Delivery Progress
            Text(
              "Delivery Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),

            ...List.generate(deliverySteps.length, (index) {
              final step = deliverySteps[index];
              final isLast = index == deliverySteps.length - 1;
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: step["status"] == "completed" 
                              ? successColor
                              : step["status"] == "active"
                                  ? primaryColor
                                  : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          step["icon"] as IconData,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 60,
                          color: step["status"] == "completed" 
                              ? successColor
                              : disabledColor,
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: step["status"] == "pending" 
                                      ? disabledBoldColor 
                                      : Colors.black,
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
                          SizedBox(height: 4),
                          Text(
                            "${step["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
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
            
            SizedBox(height: spMd),

            // Order Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Restaurant Info
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderInfo["restaurant"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${orderInfo["restaurant"]["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Call restaurant
                        },
                        child: Icon(
                          Icons.call,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(height: spMd * 2),
                  
                  // Delivery Address
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${orderInfo["deliveryAddress"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(height: spMd * 2),
                  
                  // Items
                  Text(
                    "Items (${(orderInfo["items"] as List).length})",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  ...(orderInfo["items"] as List).map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Text(
                            "${item["qty"]}x",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "\$${(item["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  Divider(height: spMd),
                  
                  // Total
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
                        "\$${(orderInfo["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Text(
                    "Paid via ${orderInfo["paymentMethod"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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
                    label: "Need Help?",
                    onPressed: () {
                      // Contact support
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Track Live",
                    onPressed: () {
                      // Open live tracking
                    },
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
