import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPromotionsView extends StatefulWidget {
  const SmaPromotionsView({super.key});

  @override
  State<SmaPromotionsView> createState() => _SmaPromotionsViewState();
}

class _SmaPromotionsViewState extends State<SmaPromotionsView> {
  String selectedType = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> promotions = [
    {
      "id": 1,
      "title": "Boost Your Business",
      "description": "Reach more customers with our premium promotion tools",
      "type": "Business",
      "price": 29.99,
      "duration": "30 days",
      "features": ["Increased visibility", "Analytics dashboard", "Priority support"],
      "image": "https://picsum.photos/300/200?random=1&keyword=business",
      "status": "Active",
      "engagement": 1250,
      "conversions": 85,
    },
    {
      "id": 2,
      "title": "Creator Spotlight",
      "description": "Get featured in our creator spotlight section",
      "type": "Creator",
      "price": 19.99,
      "duration": "14 days",
      "features": ["Featured placement", "Profile boost", "Increased followers"],
      "image": "https://picsum.photos/300/200?random=2&keyword=creator",
      "status": "Active",
      "engagement": 2100,
      "conversions": 156,
    },
    {
      "id": 3,
      "title": "Event Promotion",
      "description": "Promote your events to a wider audience",
      "type": "Event",
      "price": 39.99,
      "duration": "7 days",
      "features": ["Event highlighting", "Reminder notifications", "RSVP tracking"],
      "image": "https://picsum.photos/300/200?random=3&keyword=event",
      "status": "Pending",
      "engagement": 890,
      "conversions": 62,
    },
    {
      "id": 4,
      "title": "Product Launch",
      "description": "Launch your new product with maximum impact",
      "type": "Product",
      "price": 49.99,
      "duration": "21 days",
      "features": ["Product showcase", "Launch campaign", "Sales tracking"],
      "image": "https://picsum.photos/300/200?random=4&keyword=product",
      "status": "Completed",
      "engagement": 3200,
      "conversions": 245,
    },
  ];

  List<Map<String, dynamic>> get filteredPromotions {
    return promotions.where((promo) {
      final matchesType = selectedType == "All" || promo["type"] == selectedType;
      final matchesSearch = searchQuery.isEmpty ||
          (promo["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (promo["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreatePromotionView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Active Campaigns",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${promotions.where((p) => p["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Engagement",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((promotions.fold(0, (sum, p) => sum + (p["engagement"] as int))) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Conversions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${promotions.fold(0, (sum, p) => sum + (p["conversions"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
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

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search promotions...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Business", "value": "Business"},
                      {"label": "Creator", "value": "Creator"},
                      {"label": "Event", "value": "Event"},
                      {"label": "Product", "value": "Product"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Promotions List
            ...filteredPromotions.map((promotion) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Header
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${promotion["image"]}",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: promotion["status"] == "Active" 
                                    ? successColor 
                                    : promotion["status"] == "Pending"
                                        ? warningColor
                                        : disabledBoldColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${promotion["status"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${promotion["type"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${promotion["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(promotion["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "${promotion["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          // Duration
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Duration: ${promotion["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Features
                          Text(
                            "Features:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(promotion["features"] as List<String>).map((feature) {
                            return Padding(
                              padding: EdgeInsets.only(left: spSm),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          // Stats Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Engagement",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((promotion["engagement"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
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
                                      "Conversions",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${promotion["conversions"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('PromotionDetailView', arguments: promotion)
                                },
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
    );
  }
}
