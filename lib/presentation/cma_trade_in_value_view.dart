import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTradeInValueView extends StatefulWidget {
  const CmaTradeInValueView({super.key});

  @override
  State<CmaTradeInValueView> createState() => _CmaTradeInValueViewState();
}

class _CmaTradeInValueViewState extends State<CmaTradeInValueView> {
  int currentTab = 0;

  // Vehicle Information
  String selectedMake = "";
  String selectedModel = "";
  String selectedYear = "";
  String selectedTrim = "";
  String vehicleMileage = "";
  String vehicleCondition = "";
  String vehicleColor = "";
  String vin = "";

  // Condition Assessment
  String exteriorCondition = "";
  String interiorCondition = "";
  String mechanicalCondition = "";
  String tireCondition = "";
  String accidentHistory = "";
  String serviceHistory = "";
  String modifications = "";
  String additionalNotes = "";

  // Trade-in Details
  String dealershipName = "";
  String salesPersonName = "";
  DateTime evaluationDate = DateTime.now();
  String offerAmount = "";
  String offerValidUntil = "";
  String negotiationNotes = "";

  List<Map<String, dynamic>> vehicleMakes = [
    {"label": "Toyota", "value": "toyota"},
    {"label": "Honda", "value": "honda"},
    {"label": "Ford", "value": "ford"},
    {"label": "Chevrolet", "value": "chevrolet"},
    {"label": "Nissan", "value": "nissan"},
    {"label": "BMW", "value": "bmw"},
    {"label": "Mercedes-Benz", "value": "mercedes"},
    {"label": "Audi", "value": "audi"},
  ];

  List<Map<String, dynamic>> conditionOptions = [
    {"label": "Excellent", "value": "excellent"},
    {"label": "Very Good", "value": "very_good"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
    {"label": "Poor", "value": "poor"},
  ];

  List<Map<String, dynamic>> mockTradeInOffers = [
    {
      "id": "1",
      "dealership": "Downtown Toyota",
      "location": "Main Street, Downtown",
      "offer_amount": 18500,
      "evaluation_date": "2024-06-15",
      "expires": "2024-06-30",
      "status": "pending",
      "contact_person": "Mike Johnson",
      "phone": "(555) 123-4567",
      "rating": 4.8,
      "reviews": 156,
      "terms": "Final offer after inspection",
      "trade_in_bonus": 500,
    },
    {
      "id": "2",
      "dealership": "Elite Auto Group",
      "location": "Highway 101, West Side",
      "offer_amount": 17800,
      "evaluation_date": "2024-06-14",
      "expires": "2024-06-28",
      "status": "accepted",
      "contact_person": "Sarah Davis",
      "phone": "(555) 234-5678",
      "rating": 4.6,
      "reviews": 89,
      "terms": "Conditional on vehicle inspection",
      "trade_in_bonus": 0,
    },
    {
      "id": "3",
      "dealership": "Premier Motors",
      "location": "Industrial District",
      "offer_amount": 19200,
      "evaluation_date": "2024-06-16",
      "expires": "2024-07-01",
      "status": "negotiating",
      "contact_person": "Tom Wilson",
      "phone": "(555) 345-6789",
      "rating": 4.9,
      "reviews": 234,
      "terms": "Best offer guarantee",
      "trade_in_bonus": 750,
    },
  ];

  List<Map<String, dynamic>> marketComparisons = [
    {
      "source": "KBB Trade-In",
      "value": 17500,
      "range_low": 16800,
      "range_high": 18200,
      "condition": "Good",
      "updated": "2024-06-18",
    },
    {
      "source": "Edmunds Trade-In",
      "value": 17800,
      "range_low": 17200,
      "range_high": 18400,
      "condition": "Good",
      "updated": "2024-06-17",
    },
    {
      "source": "NADA Guides",
      "value": 18100,
      "range_low": 17500,
      "range_high": 18700,
      "condition": "Good",
      "updated": "2024-06-16",
    },
    {
      "source": "AutoTrader",
      "value": 17900,
      "range_low": 17300,
      "range_high": 18500,
      "condition": "Good",
      "updated": "2024-06-18",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Trade-In Value Assessment",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Vehicle Info", icon: Icon(Icons.directions_car)),
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Market Data", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildVehicleInfoTab(),
        _buildOffersTab(),
        _buildMarketDataTab(),
      ],
    );
  }

  Widget _buildVehicleInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Vehicle Basic Information
          Container(
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
                  "Vehicle Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Make",
                        items: vehicleMakes,
                        value: selectedMake,
                        onChanged: (value, label) {
                          selectedMake = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Model",
                        value: selectedModel,
                        onChanged: (value) {
                          selectedModel = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Year",
                        value: selectedYear,
                        onChanged: (value) {
                          selectedYear = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Trim Level",
                        value: selectedTrim,
                        onChanged: (value) {
                          selectedTrim = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "VIN",
                  value: vin,
                  hint: "Enter 17-character VIN",
                  onChanged: (value) {
                    vin = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Mileage",
                        value: vehicleMileage,
                        onChanged: (value) {
                          vehicleMileage = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Color",
                        value: vehicleColor,
                        onChanged: (value) {
                          vehicleColor = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Condition Assessment
          Container(
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
                  "Condition Assessment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Exterior Condition",
                        items: conditionOptions,
                        value: exteriorCondition,
                        onChanged: (value, label) {
                          exteriorCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Interior Condition",
                        items: conditionOptions,
                        value: interiorCondition,
                        onChanged: (value, label) {
                          interiorCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Mechanical Condition",
                        items: conditionOptions,
                        value: mechanicalCondition,
                        onChanged: (value, label) {
                          mechanicalCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Tire Condition",
                        items: conditionOptions,
                        value: tireCondition,
                        onChanged: (value, label) {
                          tireCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Accident History",
                  value: accidentHistory,
                  hint: "Describe any accidents or damage",
                  onChanged: (value) {
                    accidentHistory = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Service History",
                  value: serviceHistory,
                  hint: "Recent maintenance and repairs",
                  onChanged: (value) {
                    serviceHistory = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Modifications",
                  value: modifications,
                  hint: "Any aftermarket modifications",
                  onChanged: (value) {
                    modifications = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Additional Notes",
                  value: additionalNotes,
                  hint: "Any additional information about the vehicle",
                  onChanged: (value) {
                    additionalNotes = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Submit Assessment
          Container(
            width: double.infinity,
            child: QButton(
              label: "Submit for Trade-In Evaluation",
              size: bs.md,
              onPressed: () {
                ss("Trade-in evaluation request submitted successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Best Offer
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor, width: 2),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: successColor, size: 24),
                    SizedBox(width: spXs),
                    Text(
                      "Best Offer",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$19,200",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Premier Motors",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "+\$750 Trade-in Bonus",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Offers List
          ...mockTradeInOffers.map((offer) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: offer["status"] == "accepted" ? successColor : 
                       offer["status"] == "negotiating" ? warningColor : 
                       disabledOutlineBorderColor,
                width: offer["status"] != "pending" ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["dealership"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXxs),
                          Text(
                            "${offer["location"]}",
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
                          "\$${((offer["offer_amount"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if ((offer["trade_in_bonus"] as int) > 0)
                          Text(
                            "+\$${((offer["trade_in_bonus"] as int).toDouble()).currency} bonus",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["contact_person"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${offer["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: offer["status"] == "accepted" ? successColor :
                               offer["status"] == "negotiating" ? warningColor :
                               infoColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${offer["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${offer["terms"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Expires: ${offer["expires"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Row(
                      spacing: spXs,
                      children: [
                        QButton(
                          label: "Contact",
                          size: bs.sm,
                          onPressed: () {
                            si("Contacting ${offer["dealership"]}");
                          },
                        ),
                        if (offer["status"] == "pending")
                          QButton(
                            label: "Accept",
                            size: bs.sm,
                            onPressed: () {
                              ss("Offer accepted from ${offer["dealership"]}");
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),

          // Request More Offers
          Container(
            width: double.infinity,
            child: QButton(
              label: "Request More Offers",
              size: bs.md,
              onPressed: () {
                si("Requesting additional trade-in offers");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketDataTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Market Summary
          Container(
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
                  "Market Value Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Average Trade-In",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$17,850",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Best Offer",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$19,200",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Market Range",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$16,800 - \$18,700",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Premium Above Market",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "+7.6%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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

          // Market Comparisons
          Container(
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
                  "Market Comparison Sources",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...marketComparisons.map((comparison) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${comparison["source"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "\$${((comparison["value"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "Range: \$${((comparison["range_low"] as int).toDouble()).currency} - \$${((comparison["range_high"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Updated: ${comparison["updated"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Market Trends
          Container(
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
                  "Market Trends & Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Trade-in values increasing",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Values for your vehicle model have increased 3.2% over the past 30 days due to high demand and limited inventory.",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Best time to trade-in",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Current market conditions are favorable. Consider trading in within the next 2-3 months before seasonal depreciation.",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.lightbulb, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Maximize your trade-in value",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Consider basic detailing and minor repairs. Address check engine lights and ensure all features work properly.",
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
          ),
        ],
      ),
    );
  }
}
