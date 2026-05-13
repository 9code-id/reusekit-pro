import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsSeasonalOffersView extends StatefulWidget {
  const BrsSeasonalOffersView({super.key});

  @override
  State<BrsSeasonalOffersView> createState() => _BrsSeasonalOffersViewState();
}

class _BrsSeasonalOffersViewState extends State<BrsSeasonalOffersView> {
  List<Map<String, dynamic>> seasonalOffers = [
    {
      "id": 1,
      "title": "Summer Fresh Cut",
      "description": "Get the perfect summer look with our special styling package",
      "originalPrice": 45.0,
      "discountPrice": 35.0,
      "discount": 22,
      "validUntil": "2024-08-31",
      "image": "https://picsum.photos/300/200?random=1&keyword=barber",
      "services": ["Haircut", "Beard Trim", "Hair Wash"],
      "isPopular": true,
      "season": "Summer"
    },
    {
      "id": 2,
      "title": "Winter Warm Up",
      "description": "Keep your style warm and trendy this winter season",
      "originalPrice": 55.0,
      "discountPrice": 42.0,
      "discount": 24,
      "validUntil": "2024-12-31",
      "image": "https://picsum.photos/300/200?random=2&keyword=haircut",
      "services": ["Premium Cut", "Hot Towel", "Beard Oil Treatment"],
      "isPopular": false,
      "season": "Winter"
    },
    {
      "id": 3,
      "title": "Spring Refresh",
      "description": "Start the new season with a fresh new look",
      "originalPrice": 40.0,
      "discountPrice": 28.0,
      "discount": 30,
      "validUntil": "2024-05-31",
      "image": "https://picsum.photos/300/200?random=3&keyword=salon",
      "services": ["Haircut", "Styling", "Hair Treatment"],
      "isPopular": true,
      "season": "Spring"
    },
    {
      "id": 4,
      "title": "Autumn Classic",
      "description": "Classic cuts for the sophisticated gentleman",
      "originalPrice": 50.0,
      "discountPrice": 38.0,
      "discount": 24,
      "validUntil": "2024-11-30",
      "image": "https://picsum.photos/300/200?random=4&keyword=barbershop",
      "services": ["Classic Cut", "Beard Styling", "Face Massage"],
      "isPopular": false,
      "season": "Autumn"
    },
    {
      "id": 5,
      "title": "Holiday Special",
      "description": "Look your best for the holiday celebrations",
      "originalPrice": 65.0,
      "discountPrice": 48.0,
      "discount": 26,
      "validUntil": "2024-12-25",
      "image": "https://picsum.photos/300/200?random=5&keyword=grooming",
      "services": ["Premium Cut", "Beard Trim", "Hair Styling", "Face Care"],
      "isPopular": true,
      "season": "Holiday"
    },
    {
      "id": 6,
      "title": "Back to School",
      "description": "Student-friendly packages for a smart new look",
      "originalPrice": 35.0,
      "discountPrice": 25.0,
      "discount": 29,
      "validUntil": "2024-09-30",
      "image": "https://picsum.photos/300/200?random=6&keyword=student",
      "services": ["Basic Cut", "Hair Wash"],
      "isPopular": false,
      "season": "Back to School"
    }
  ];

  String selectedSeason = "All";
  List<String> seasons = ["All", "Summer", "Winter", "Spring", "Autumn", "Holiday", "Back to School"];

  List<Map<String, dynamic>> get filteredOffers {
    if (selectedSeason == "All") {
      return seasonalOffers;
    }
    return seasonalOffers.where((offer) => offer["season"] == selectedSeason).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Offers"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Limited Time Seasonal Offers",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Save up to 30% on premium grooming services",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),

            // Season Filter
            Text(
              "Filter by Season",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: seasons.map((season) {
                bool isSelected = selectedSeason == season;
                return GestureDetector(
                  onTap: () {
                    selectedSeason = season;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    child: Text(
                      season,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Offers Count
            Text(
              "${filteredOffers.length} Offers Available",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Offers List
            ...filteredOffers.map((offer) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offer Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          child: Image.network(
                            "${offer["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (offer["isPopular"] as bool)
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "POPULAR",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${offer["discount"]}% OFF",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Offer Details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Season
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${offer["title"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${offer["season"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Description
                          Text(
                            "${offer["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),

                          // Services Included
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (offer["services"] as List).map((service) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$service",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Price and Validity
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "\$${((offer["originalPrice"] as double).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "\$${((offer["discountPrice"] as double).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Valid until ${offer["validUntil"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Book Now",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Offer selected successfully!");
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
            }).toList(),
          ],
        ),
      ),
    );
  }
}
