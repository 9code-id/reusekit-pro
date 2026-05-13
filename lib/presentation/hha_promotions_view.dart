import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPromotionsView extends StatefulWidget {
  const HhaPromotionsView({super.key});

  @override
  State<HhaPromotionsView> createState() => _HhaPromotionsViewState();
}

class _HhaPromotionsViewState extends State<HhaPromotionsView> {
  String selectedStatus = "Active";
  String searchQuery = "";

  List<Map<String, dynamic>> promotions = [
    {
      "id": 1,
      "title": "Summer Getaway Package",
      "description": "Enjoy 30% off on all room types with complimentary breakfast",
      "discount": 30,
      "validFrom": "2024-06-01",
      "validTo": "2024-08-31",
      "status": "Active",
      "bookingCount": 145,
      "revenue": 52800.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
      "conditions": ["Minimum 2 nights stay", "Valid for advance booking only"],
    },
    {
      "id": 2,
      "title": "Weekend Special",
      "description": "Book weekend stays and get free spa access",
      "discount": 20,
      "validFrom": "2024-05-15",
      "validTo": "2024-12-31",
      "status": "Active",
      "bookingCount": 89,
      "revenue": 31200.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=spa",
      "conditions": ["Friday-Sunday only", "Subject to availability"],
    },
    {
      "id": 3,
      "title": "Corporate Rates",
      "description": "Special discounted rates for business travelers",
      "discount": 15,
      "validFrom": "2024-01-01",
      "validTo": "2024-12-31",
      "status": "Active",
      "bookingCount": 234,
      "revenue": 78900.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=business",
      "conditions": ["Corporate ID required", "Minimum 5 bookings per month"],
    },
    {
      "id": 4,
      "title": "Early Bird Promotion",
      "description": "Book 60 days in advance and save big",
      "discount": 25,
      "validFrom": "2024-03-01",
      "validTo": "2024-05-31",
      "status": "Expired",
      "bookingCount": 67,
      "revenue": 19800.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=calendar",
      "conditions": ["Book 60 days in advance", "Non-refundable"],
    },
  ];

  List<Map<String, dynamic>> get filteredPromotions {
    return promotions.where((promo) {
      final matchesStatus = selectedStatus == "All" || promo["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty ||
          (promo["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (promo["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions Management"),
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
                          "Active Promotions",
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
                          "Total Bookings",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${promotions.fold(0, (sum, p) => sum + (p["bookingCount"] as int))}",
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
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((promotions.fold(0.0, (sum, p) => sum + (p["revenue"] as double))) / 1000).toStringAsFixed(1)}K",
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
                    label: "Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Active", "value": "Active"},
                      {"label": "Expired", "value": "Expired"},
                      {"label": "Draft", "value": "Draft"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
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
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${promotion["discount"]}% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                          Text(
                            "${promotion["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          Text(
                            "${promotion["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          // Validity Period
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Valid: ${promotion["validFrom"]} - ${promotion["validTo"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Stats Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bookings",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${promotion["bookingCount"]}",
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
                                      "Revenue",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((promotion["revenue"] as double) / 1000).toStringAsFixed(1)}K",
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
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('EditPromotionView', arguments: promotion)
                                },
                              ),
                            ],
                          ),

                          // Conditions
                          if ((promotion["conditions"] as List).isNotEmpty) ...[
                            Text(
                              "Conditions:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            ...(promotion["conditions"] as List<String>).map((condition) {
                              return Padding(
                                padding: EdgeInsets.only(left: spSm),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "• ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        condition,
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
                          ],
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
