import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPackingSuggestionsView extends StatefulWidget {
  const WcaPackingSuggestionsView({super.key});

  @override
  State<WcaPackingSuggestionsView> createState() => _WcaPackingSuggestionsViewState();
}

class _WcaPackingSuggestionsViewState extends State<WcaPackingSuggestionsView> {
  String destination = "Paris, France";
  String travelDuration = "7 days";
  String travelSeason = "Spring";
  String tripType = "Leisure";

  List<Map<String, dynamic>> tripTypeItems = [
    {"label": "Leisure", "value": "Leisure"},
    {"label": "Business", "value": "Business"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "Beach", "value": "Beach"},
    {"label": "City Tour", "value": "City Tour"},
    {"label": "Mountain", "value": "Mountain"},
  ];

  List<Map<String, dynamic>> durationItems = [
    {"label": "1-3 days", "value": "1-3 days"},
    {"label": "4-7 days", "value": "4-7 days"},
    {"label": "1-2 weeks", "value": "1-2 weeks"},
    {"label": "2+ weeks", "value": "2+ weeks"},
  ];

  List<Map<String, dynamic>> packingCategories = [
    {
      "category": "Clothing",
      "icon": Icons.checkroom,
      "color": "primary",
      "items": [
        {"name": "Light jacket", "essential": true, "weather": "Cool evenings expected"},
        {"name": "Comfortable walking shoes", "essential": true, "weather": "For city exploration"},
        {"name": "Casual shirts (3-4)", "essential": true, "weather": "Daily wear"},
        {"name": "Jeans/pants (2-3)", "essential": true, "weather": "Versatile bottoms"},
        {"name": "Underwear (7 pairs)", "essential": true, "weather": "Daily essentials"},
        {"name": "Light sweater", "essential": false, "weather": "If temperature drops"},
        {"name": "Dress/formal outfit", "essential": false, "weather": "For dining out"},
      ],
    },
    {
      "category": "Weather Protection",
      "icon": Icons.umbrella,
      "color": "info",
      "items": [
        {"name": "Compact umbrella", "essential": true, "weather": "20% chance of rain"},
        {"name": "Light raincoat", "essential": false, "weather": "Extended rain protection"},
        {"name": "Sunglasses", "essential": true, "weather": "UV protection needed"},
        {"name": "Sun hat", "essential": false, "weather": "Outdoor activities"},
        {"name": "Sunscreen SPF 30+", "essential": true, "weather": "UV index 6-8"},
      ],
    },
    {
      "category": "Accessories",
      "icon": Icons.shopping_bag,
      "color": "success",
      "items": [
        {"name": "Day backpack", "essential": true, "weather": "For daily excursions"},
        {"name": "Power bank", "essential": true, "weather": "Keep devices charged"},
        {"name": "Universal adapter", "essential": true, "weather": "European plug type"},
        {"name": "Travel documents folder", "essential": true, "weather": "Keep organized"},
        {"name": "Reusable water bottle", "essential": true, "weather": "Stay hydrated"},
        {"name": "Camera", "essential": false, "weather": "Capture memories"},
      ],
    },
    {
      "category": "Health & Comfort",
      "icon": Icons.medical_services,
      "color": "warning",
      "items": [
        {"name": "First aid kit", "essential": true, "weather": "Basic medical supplies"},
        {"name": "Medications", "essential": true, "weather": "Personal prescriptions"},
        {"name": "Hand sanitizer", "essential": true, "weather": "Hygiene essential"},
        {"name": "Moisturizer", "essential": false, "weather": "For dry weather"},
        {"name": "Lip balm", "essential": false, "weather": "Wind protection"},
        {"name": "Travel pillow", "essential": false, "weather": "Flight comfort"},
      ],
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "Temperature",
      "alert": "Cooler evenings expected",
      "suggestion": "Pack a light jacket or sweater",
      "icon": Icons.thermostat,
      "color": "info",
    },
    {
      "type": "Precipitation",
      "alert": "20% chance of rain",
      "suggestion": "Bring a compact umbrella",
      "icon": Icons.umbrella,
      "color": "warning",
    },
    {
      "type": "UV Index",
      "alert": "High UV levels (6-8)",
      "suggestion": "Pack sunscreen and sunglasses",
      "icon": Icons.wb_sunny,
      "color": "danger",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Packing Suggestions"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              si("Download packing checklist");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Share packing suggestions");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), successColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.luggage,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart Packing Assistant",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Weather-based packing recommendations for your trip",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Trip Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QTextField(
              label: "Destination",
              value: destination,
              hint: "Enter destination city",
              onChanged: (value) {
                destination = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Trip Duration",
                    items: durationItems,
                    value: travelDuration,
                    onChanged: (value, label) {
                      travelDuration = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Trip Type",
                    items: tripTypeItems,
                    value: tripType,
                    onChanged: (value, label) {
                      tripType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Weather Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...weatherAlerts.map((alert) {
              Color alertColor = primaryColor;
              if (alert["color"] == "info") alertColor = infoColor;
              if (alert["color"] == "warning") alertColor = warningColor;
              if (alert["color"] == "danger") alertColor = dangerColor;

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: alertColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: alertColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      alert["icon"] as IconData,
                      color: alertColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alert["type"]}: ${alert["alert"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: alertColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${alert["suggestion"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            Text(
              "Packing Checklist",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...packingCategories.map((category) {
              Color categoryColor = primaryColor;
              if (category["color"] == "info") categoryColor = infoColor;
              if (category["color"] == "success") categoryColor = successColor;
              if (category["color"] == "warning") categoryColor = warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category["icon"] as IconData,
                            color: categoryColor,
                            size: 24,
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${category["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(category["items"] as List).length} items",
                              style: TextStyle(
                                color: categoryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: (category["items"] as List<Map<String, dynamic>>).map((item) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: disabledColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item["essential"] ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: item["essential"] ? successColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spMd),
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
                                        "${item["weather"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (item["essential"])
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Essential",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Packing Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Pack versatile items that can be mixed and matched",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Check airline baggage restrictions before packing",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Leave space for souvenirs and purchases",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Pack essential medications in carry-on",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Checklist",
                    size: bs.md,
                    onPressed: () {
                      ss("Packing checklist saved");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Update Weather",
                    size: bs.md,
                    onPressed: () {
                      si("Updating weather-based suggestions");
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
