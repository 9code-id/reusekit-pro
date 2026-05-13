import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSpecialOffersView extends StatefulWidget {
  const HhaSpecialOffersView({super.key});

  @override
  State<HhaSpecialOffersView> createState() => _HhaSpecialOffersViewState();
}

class _HhaSpecialOffersViewState extends State<HhaSpecialOffersView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> offers = [
    {
      "id": 1,
      "title": "Honeymoon Package",
      "category": "Romance",
      "description": "Perfect romantic getaway with champagne, roses, and couple's spa",
      "originalPrice": 899.0,
      "discountedPrice": 649.0,
      "discount": 28,
      "validUntil": "2024-07-31",
      "inclusions": ["Champagne on arrival", "Rose petals decoration", "Couple's spa session", "Candlelight dinner"],
      "image": "https://picsum.photos/400/250?random=1&keyword=honeymoon",
      "availability": "Limited",
      "bookingCount": 34,
      "rating": 4.9,
    },
    {
      "id": 2,
      "title": "Family Fun Package",
      "category": "Family",
      "description": "Complete family experience with kids activities and entertainment",
      "originalPrice": 1299.0,
      "discountedPrice": 999.0,
      "discount": 23,
      "validUntil": "2024-08-15",
      "inclusions": ["Kids club access", "Family game room", "Pool activities", "Welcome gifts for kids"],
      "image": "https://picsum.photos/400/250?random=2&keyword=family",
      "availability": "Available",
      "bookingCount": 67,
      "rating": 4.7,
    },
    {
      "id": 3,
      "title": "Wellness Retreat",
      "category": "Wellness",
      "description": "Rejuvenate your body and mind with our comprehensive wellness program",
      "originalPrice": 1599.0,
      "discountedPrice": 1199.0,
      "discount": 25,
      "validUntil": "2024-06-30",
      "inclusions": ["Daily yoga sessions", "Spa treatments", "Healthy cuisine", "Meditation classes"],
      "image": "https://picsum.photos/400/250?random=3&keyword=spa",
      "availability": "Available",
      "bookingCount": 23,
      "rating": 4.8,
    },
    {
      "id": 4,
      "title": "Business Executive Package",
      "category": "Business",
      "description": "Enhanced business amenities for the modern executive traveler",
      "originalPrice": 799.0,
      "discountedPrice": 599.0,
      "discount": 25,
      "validUntil": "2024-12-31",
      "inclusions": ["Executive lounge access", "Business center", "Airport transfer", "Late checkout"],
      "image": "https://picsum.photos/400/250?random=4&keyword=business",
      "availability": "Available",
      "bookingCount": 89,
      "rating": 4.6,
    },
    {
      "id": 5,
      "title": "Adventure Seeker Package",
      "category": "Adventure",
      "description": "Thrilling outdoor activities and adventure sports included",
      "originalPrice": 1099.0,
      "discountedPrice": 799.0,
      "discount": 27,
      "validUntil": "2024-09-30",
      "inclusions": ["Rock climbing", "Kayaking", "Hiking tours", "Adventure gear rental"],
      "image": "https://picsum.photos/400/250?random=5&keyword=adventure",
      "availability": "Limited",
      "bookingCount": 12,
      "rating": 4.5,
    },
  ];

  List<Map<String, dynamic>> get filteredOffers {
    return offers.where((offer) {
      final matchesCategory = selectedCategory == "All" || offer["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (offer["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (offer["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              //navigateTo('FavoriteOffersView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Exclusive Special Offers",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Limited time deals crafted just for you",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Save up to 30% on selected packages",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search offers...",
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
                    label: "Category",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Romance", "value": "Romance"},
                      {"label": "Family", "value": "Family"},
                      {"label": "Wellness", "value": "Wellness"},
                      {"label": "Business", "value": "Business"},
                      {"label": "Adventure", "value": "Adventure"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Offers Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredOffers.map((offer) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with discount badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${offer["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${offer["discount"]}% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          if (offer["availability"] == "Limited")
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Limited Availability",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            // Category and Rating
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${offer["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${offer["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              "${offer["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            Text(
                              "${offer["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Price
                            Row(
                              children: [
                                Text(
                                  "\$${(offer["originalPrice"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${(offer["discountedPrice"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),

                            // Valid until
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 12,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Valid until ${offer["validUntil"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            // Bookings count
                            Text(
                              "${offer["bookingCount"]} bookings made",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('OfferDetailView', arguments: offer)
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
