import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShipping1View extends StatefulWidget {
  @override
  State<GrlShipping1View> createState() => _GrlShipping1ViewState();
}

class _GrlShipping1ViewState extends State<GrlShipping1View> {
  String selectedOption = "standard";
  
  List<Map<String, dynamic>> shippingOptions = [
    {
      "id": "economy",
      "name": "Economy Shipping",
      "description": "Delivery in 7-10 business days",
      "price": 4.99,
      "estimatedDays": "7-10",
      "icon": Icons.local_shipping,
      "features": [
        "No tracking available",
        "Standard packaging",
        "Business days only",
      ],
      "isRecommended": false,
      "discount": 0,
    },
    {
      "id": "standard",
      "name": "Standard Shipping",
      "description": "Delivery in 3-5 business days",
      "price": 7.99,
      "estimatedDays": "3-5",
      "icon": Icons.fire_truck,
      "features": [
        "Package tracking included",
        "Secure packaging",
        "Business days only",
        "Insurance coverage up to \$100",
      ],
      "isRecommended": true,
      "discount": 0,
    },
    {
      "id": "express",
      "name": "Express Shipping",
      "description": "Delivery in 1-2 business days",
      "price": 12.99,
      "estimatedDays": "1-2",
      "icon": Icons.flash_on,
      "features": [
        "Real-time tracking",
        "Priority handling",
        "Business days only",
        "Insurance coverage up to \$500",
        "Signature required",
      ],
      "isRecommended": false,
      "discount": 0,
    },
    {
      "id": "overnight",
      "name": "Overnight Shipping",
      "description": "Next business day delivery",
      "price": 24.99,
      "estimatedDays": "1",
      "icon": Icons.rocket_launch,
      "features": [
        "Live tracking updates",
        "Premium packaging",
        "Next business day",
        "Full insurance coverage",
        "Signature required",
        "SMS/Email notifications",
      ],
      "isRecommended": false,
      "discount": 0,
    },
    {
      "id": "same_day",
      "name": "Same Day Delivery",
      "description": "Delivery within 3-6 hours",
      "price": 19.99,
      "estimatedDays": "Today",
      "icon": Icons.speed,
      "features": [
        "Available in select areas",
        "Live GPS tracking",
        "Direct courier delivery",
        "Contact driver directly",
        "Photo confirmation",
      ],
      "isRecommended": false,
      "discount": 25,
    },
  ];

  Map<String, dynamic> orderDetails = {
    "subtotal": 89.97,
    "tax": 7.20,
    "discount": 0.0,
    "weight": "2.1 lbs",
    "dimensions": "12x8x6 inches",
    "destination": "New York, NY",
  };

  @override
  Widget build(BuildContext context) {
    final selectedShipping = shippingOptions.firstWhere(
      (option) => option["id"] == selectedOption,
    );

    double total = (orderDetails["subtotal"] as double) + 
                   (orderDetails["tax"] as double) + 
                   (selectedShipping["price"] as double) - 
                   (orderDetails["discount"] as double);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Options"),
      ),
      body: Column(
        children: [
          // Order Summary Card
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
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
                            "Package Weight",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${orderDetails["weight"]}",
                            style: TextStyle(
                              color: Colors.white,
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
                            "Dimensions",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${orderDetails["dimensions"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white70,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Shipping to: ${orderDetails["destination"]}",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Shipping Options List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: shippingOptions.length,
              itemBuilder: (context, index) {
                final option = shippingOptions[index];
                final isSelected = selectedOption == option["id"];
                final hasDiscount = (option["discount"] as int) > 0;
                final discountedPrice = hasDiscount 
                    ? (option["price"] as double) * (1 - (option["discount"] as int) / 100)
                    : option["price"] as double;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: isSelected ? Border.all(
                      color: primaryColor,
                      width: 2,
                    ) : null,
                  ),
                  child: Column(
                    children: [
                      // Option Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : (option["isRecommended"] as bool ? successColor.withAlpha(20) : Colors.grey[50]),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? primaryColor 
                                    : (option["isRecommended"] as bool ? successColor : disabledBoldColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                option["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${option["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      if (option["isRecommended"] as bool)
                                        Container(
                                          margin: EdgeInsets.only(left: spSm),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "RECOMMENDED",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${option["description"]}",
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
                                if (hasDiscount)
                                  Text(
                                    "\$${(option["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    if (hasDiscount)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "-${option["discount"]}%",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    if (hasDiscount)
                                      SizedBox(width: spXs),
                                    Text(
                                      "\$${discountedPrice.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: hasDiscount ? dangerColor : (isSelected ? primaryColor : Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${option["estimatedDays"]} days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            GestureDetector(
                              onTap: () {
                                selectedOption = option["id"];
                                setState(() {});
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Features List
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Features Included:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(option["features"] as List<String>).map((feature) => Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cost Breakdown
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Subtotal:",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "\$${(orderDetails["subtotal"] as double).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Shipping:",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "\$${((selectedShipping["discount"] as int) > 0 ? (selectedShipping["price"] as double) * (1 - (selectedShipping["discount"] as int) / 100) : selectedShipping["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tax:",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "\$${(orderDetails["tax"] as double).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
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
              ),
              
              SizedBox(height: spMd),
              
              QButton(
                label: "Continue to Payment",
                size: bs.md,
                icon: Icons.payment,
                onPressed: () {
                  ss("Selected ${selectedShipping["name"]} - \$${((selectedShipping["discount"] as int) > 0 ? (selectedShipping["price"] as double) * (1 - (selectedShipping["discount"] as int) / 100) : selectedShipping["price"] as double).toStringAsFixed(2)}");
                  // navigateTo(PaymentView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
