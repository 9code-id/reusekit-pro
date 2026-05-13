import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCostCalculatorView extends StatefulWidget {
  const TtaCostCalculatorView({super.key});

  @override
  State<TtaCostCalculatorView> createState() => _TtaCostCalculatorViewState();
}

class _TtaCostCalculatorViewState extends State<TtaCostCalculatorView> {
  String destination = "Paris, France";
  String duration = "7";
  String travelers = "2";
  String budgetType = "mid-range";
  String accommodationType = "hotel";
  String transportationType = "flight";

  List<Map<String, dynamic>> budgetTypes = [
    {"label": "Budget", "value": "budget"},
    {"label": "Mid-Range", "value": "mid-range"},
    {"label": "Luxury", "value": "luxury"},
  ];

  List<Map<String, dynamic>> accommodationTypes = [
    {"label": "Hotel", "value": "hotel"},
    {"label": "Hostel", "value": "hostel"},
    {"label": "Airbnb", "value": "airbnb"},
    {"label": "Resort", "value": "resort"},
  ];

  List<Map<String, dynamic>> transportationTypes = [
    {"label": "Flight", "value": "flight"},
    {"label": "Train", "value": "train"},
    {"label": "Bus", "value": "bus"},
    {"label": "Car Rental", "value": "car"},
  ];

  Map<String, dynamic> calculatedCosts = {
    "accommodation": {
      "daily": 120.0,
      "total": 840.0,
      "description": "Hotel room per night for 2 people",
    },
    "transportation": {
      "total": 800.0,
      "description": "Round-trip flights for 2 people",
    },
    "food": {
      "daily": 80.0,
      "total": 560.0,
      "description": "Meals for 2 people per day",
    },
    "activities": {
      "daily": 60.0,
      "total": 420.0,
      "description": "Tours and attractions per day",
    },
    "miscellaneous": {
      "daily": 30.0,
      "total": 210.0,
      "description": "Shopping, tips, and other expenses",
    },
  };

  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Accommodation",
      "icon": Icons.hotel,
      "color": primaryColor,
      "daily": 120.0,
      "total": 840.0,
      "percentage": 30,
      "description": "Hotel stays for the entire trip",
    },
    {
      "category": "Transportation",
      "icon": Icons.flight,
      "color": infoColor,
      "daily": 0.0,
      "total": 800.0,
      "percentage": 29,
      "description": "Flights and local transportation",
    },
    {
      "category": "Food & Dining",
      "icon": Icons.restaurant,
      "color": warningColor,
      "daily": 80.0,
      "total": 560.0,
      "percentage": 20,
      "description": "Restaurants, cafes, and local cuisine",
    },
    {
      "category": "Activities",
      "icon": Icons.attractions,
      "color": successColor,
      "daily": 60.0,
      "total": 420.0,
      "percentage": 15,
      "description": "Tours, museums, and entertainment",
    },
    {
      "category": "Miscellaneous",
      "icon": Icons.more_horiz,
      "color": dangerColor,
      "daily": 30.0,
      "total": 210.0,
      "percentage": 6,
      "description": "Shopping, tips, and other expenses",
    },
  ];

  double get totalCost {
    return costBreakdown.fold(0.0, (sum, item) => sum + (item["total"] as double));
  }

  double get costPerPerson {
    return totalCost / (double.tryParse(travelers) ?? 1);
  }

  double get costPerDay {
    return totalCost / (double.tryParse(duration) ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Recalculate costs
              ss("Costs recalculated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Trip Details Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calculate,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trip Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Destination",
                    value: destination,
                    onChanged: (value) {
                      destination = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Duration (Days)",
                          value: duration,
                          onChanged: (value) {
                            duration = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Number of Travelers",
                          value: travelers,
                          onChanged: (value) {
                            travelers = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Budget Type",
                    items: budgetTypes,
                    value: budgetType,
                    onChanged: (value, label) {
                      budgetType = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Accommodation",
                          items: accommodationTypes,
                          value: accommodationType,
                          onChanged: (value, label) {
                            accommodationType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Transportation",
                          items: transportationTypes,
                          value: transportationType,
                          onChanged: (value, label) {
                            transportationType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Total Cost Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Text(
                    "Estimated Total Cost",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${totalCost.currency}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "\$${costPerPerson.currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Per Person",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(100),
                      ),
                      Column(
                        children: [
                          Text(
                            "\$${costPerDay.currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Per Day",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Cost Breakdown
            Text(
              "Cost Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...costBreakdown.map((item) {
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (item["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            item["icon"],
                            color: item["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["category"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["percentage"]}% of total cost",
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
                            Text(
                              "\$${((item["total"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: item["color"] as Color,
                              ),
                            ),
                            if ((item["daily"] as double) > 0) ...[
                              SizedBox(height: spXs),
                              Text(
                                "\$${((item["daily"] as double)).currency}/day",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (item["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Estimate",
                    size: bs.md,
                    onPressed: () {
                      ss("Cost estimate saved successfully");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Results",
                    color: infoColor,
                    size: bs.md,
                    onPressed: () {
                      ss("Cost estimate shared");
                    },
                  ),
                ),
              ],
            ),

            // Tips Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Money Saving Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Book flights and accommodation 2-3 months in advance\n• Consider traveling during off-peak seasons\n• Use public transportation instead of taxis\n• Look for free walking tours and attractions\n• Choose accommodation with kitchen facilities",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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
}
