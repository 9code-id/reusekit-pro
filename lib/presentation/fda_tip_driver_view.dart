import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaTipDriverView extends StatefulWidget {
  const FdaTipDriverView({super.key});

  @override
  State<FdaTipDriverView> createState() => _FdaTipDriverViewState();
}

class _FdaTipDriverViewState extends State<FdaTipDriverView> {
  double selectedTipAmount = 5.70;
  String customTipAmount = "";
  bool isCustomTip = false;
  String selectedTipType = "percentage";

  Map<String, dynamic> orderDetails = {
    "order_id": "#FD2024001",
    "restaurant": "Pizza Palace",
    "driver_name": "John Smith",
    "driver_photo": "https://picsum.photos/100/100?random=1&keyword=person",
    "delivery_time": "25 mins",
    "distance": "3.2 km",
    "rating": 4.8,
    "total_deliveries": 1247,
    "order_total": 28.50,
  };
  List<Map<String, dynamic>> tipOptions = [
    {
      "label": "No tip",
      "amount": 0.0,
      "percentage": 0,
      "recommended": false,
    },
    {
      "label": "15%",
      "amount": 4.25,
      "percentage": 15,
      "recommended": false,
    },
    {
      "label": "18%",
      "amount": 5.15,
      "percentage": 18,
      "recommended": false,
    },
    {
      "label": "20%",
      "amount": 5.70,
      "percentage": 20,
      "recommended": true,
    },
    {
      "label": "22%",
      "amount": 6.27,
      "percentage": 22,
      "recommended": false,
    },
    {
      "label": "25%",
      "amount": 7.15,
      "percentage": 25,
      "recommended": false,
    },
  ];

  List<Map<String, dynamic>> quickTipAmounts = [
    {"amount": 2.00, "label": "\$2"},
    {"amount": 3.00, "label": "\$3"},
    {"amount": 5.00, "label": "\$5"},
    {"amount": 10.00, "label": "\$10"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tip Your Driver"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Driver Profile
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Driver Info
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${orderDetails["driver_photo"]}",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetails["driver_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${orderDetails["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " (${orderDetails["total_deliveries"]} deliveries)",
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
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Delivery Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${orderDetails["delivery_time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Delivery Time",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${orderDetails["distance"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Distance",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Summary
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Order Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${orderDetails["order_id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " - ${orderDetails["restaurant"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Order Total:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(orderDetails["order_total"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),            // Tip Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Choose Tip Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Tip Type Selector
                  QCategoryPicker(
                    items: [
                      {"label": "Percentage", "value": "percentage"},
                      {"label": "Fixed Amount", "value": "fixed"},
                    ],
                    value: selectedTipType,
                    onChanged: (index, label, value, item) {
                      selectedTipType = value;
                      selectedTipAmount = 0.0;
                      isCustomTip = false;
                      setState(() {});
                    },
                  ),

                  // Predefined Tip Options
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: tipOptions.map((tip) {
                      bool isSelected = !isCustomTip && selectedTipAmount == tip["amount"];
                      return GestureDetector(
                        onTap: () {
                          selectedTipAmount = tip["amount"];
                          isCustomTip = false;
                          customTipAmount = "";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${tip["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                              if (tip["amount"] > 0)
                                Text(
                                  "\$${(tip["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white.withAlpha(204) : disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Custom Tip Option
                  GestureDetector(
                    onTap: () {
                      isCustomTip = true;
                      selectedTipAmount = 0.0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isCustomTip ? primaryColor.withAlpha(30) : Colors.grey.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCustomTip ? primaryColor : Colors.grey.withAlpha(60),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: isCustomTip ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Custom Amount",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isCustomTip ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Custom Amount Input
                  if (isCustomTip)
                    QNumberField(
                      label: "Enter custom tip amount (\$)",
                      value: customTipAmount,
                      onChanged: (value) {
                        customTipAmount = value;
                        selectedTipAmount = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Tip Summary
            if (selectedTipAmount > 0 || isCustomTip)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(60)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Tip Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Total:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(orderDetails["order_total"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tip Amount:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${selectedTipAmount.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((orderDetails["order_total"] as double) + selectedTipAmount).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Appreciation Message
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "Your tip helps support our delivery partners and shows appreciation for their hard work!",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: selectedTipAmount > 0 
                ? "Add Tip \$${selectedTipAmount.currency}"
                : "Skip Tip",
              onPressed: () {
                if (selectedTipAmount > 0) {
                  ss("Tip of \$${selectedTipAmount.currency} added successfully!");
                } else {
                  si("No tip added to this order");
                }
                back();
              },
            ),
            if (selectedTipAmount == 0)
              Text(
                "You can always tip later from your order history",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
