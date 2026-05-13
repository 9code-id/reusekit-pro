import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaSpecialOffersView extends StatefulWidget {
  const TtaSpecialOffersView({super.key});

  @override
  State<TtaSpecialOffersView> createState() => _TtaSpecialOffersViewState();
}

class _TtaSpecialOffersViewState extends State<TtaSpecialOffersView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Flight", "value": "Flight"},
    {"label": "Hotel", "value": "Hotel"},
    {"label": "Package", "value": "Package"},
    {"label": "Activity", "value": "Activity"},
  ];

  List<Map<String, dynamic>> specialOffers = [
    {
      "id": 1,
      "title": "Flash Sale: 50% Off Bali Hotels",
      "description": "Limited time offer on premium hotels in Bali",
      "discount": 50,
      "originalPrice": 200.0,
      "discountedPrice": 100.0,
      "category": "Hotel",
      "validUntil": "2025-06-30",
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
      "location": "Bali, Indonesia",
      "rating": 4.8,
      "reviews": 245,
      "isPopular": true,
      "features": ["Free WiFi", "Pool", "Spa", "Beach Access"]
    },
    {
      "id": 2,
      "title": "Early Bird: Tokyo Flight Deals",
      "description": "Book 30 days in advance and save big on Tokyo flights",
      "discount": 35,
      "originalPrice": 800.0,
      "discountedPrice": 520.0,
      "category": "Flight",
      "validUntil": "2025-07-15",
      "image": "https://picsum.photos/300/200?random=2&keyword=flight",
      "location": "Tokyo, Japan",
      "rating": 4.6,
      "reviews": 189,
      "isPopular": false,
      "features": ["Direct Flight", "Meals Included", "Entertainment"]
    },
    {
      "id": 3,
      "title": "Weekend Getaway: Singapore Package",
      "description": "3D2N all-inclusive package to Singapore",
      "discount": 25,
      "originalPrice": 600.0,
      "discountedPrice": 450.0,
      "category": "Package",
      "validUntil": "2025-06-25",
      "image": "https://picsum.photos/300/200?random=3&keyword=singapore",
      "location": "Singapore",
      "rating": 4.7,
      "reviews": 156,
      "isPopular": true,
      "features": ["Hotel", "Airport Transfer", "City Tour", "Meals"]
    },
    {
      "id": 4,
      "title": "Adventure Package: Mount Bromo",
      "description": "Sunrise trekking and photography tour",
      "discount": 40,
      "originalPrice": 150.0,
      "discountedPrice": 90.0,
      "category": "Activity",
      "validUntil": "2025-07-01",
      "image": "https://picsum.photos/300/200?random=4&keyword=mountain",
      "location": "East Java, Indonesia",
      "rating": 4.9,
      "reviews": 98,
      "isPopular": false,
      "features": ["Guide", "Transportation", "Equipment", "Breakfast"]
    },
    {
      "id": 5,
      "title": "Last Minute: Bangkok Hotel",
      "description": "Book today for this weekend in Bangkok",
      "discount": 60,
      "originalPrice": 120.0,
      "discountedPrice": 48.0,
      "category": "Hotel",
      "validUntil": "2025-06-20",
      "image": "https://picsum.photos/300/200?random=5&keyword=bangkok",
      "location": "Bangkok, Thailand",
      "rating": 4.5,
      "reviews": 203,
      "isPopular": true,
      "features": ["Free Breakfast", "Airport Shuttle", "Pool", "Gym"]
    },
    {
      "id": 6,
      "title": "Group Discount: Europe Flight",
      "description": "Special rates for groups of 4 or more",
      "discount": 30,
      "originalPrice": 1000.0,
      "discountedPrice": 700.0,
      "category": "Flight",
      "validUntil": "2025-08-01",
      "image": "https://picsum.photos/300/200?random=6&keyword=europe",
      "location": "Europe",
      "rating": 4.4,
      "reviews": 167,
      "isPopular": false,
      "features": ["Group Booking", "Flexible Dates", "Premium Economy"]
    }
  ];

  List<Map<String, dynamic>> get filteredOffers {
    return specialOffers.where((offer) {
      bool matchesCategory = selectedCategory == "All" || offer["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (offer["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (offer["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Offers"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showFilterDialog();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search offers...",
                    value: searchQuery,
                    hint: "Search by title or location",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Offers",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredOffers.length} offers available",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Limited Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Offers List
            ...filteredOffers.map((offer) => _buildOfferCard(offer)),

            // Empty State
            if (filteredOffers.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No offers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
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

  Widget _buildOfferCard(Map<String, dynamic> offer) {
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
          // Image and Badge
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  child: Image.network(
                    "${offer["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
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
              if (offer["isPopular"] as bool)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "POPULAR",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${offer["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
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
                  ],
                ),

                // Description
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                // Location and Rating
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${offer["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["rating"]} (${offer["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Features
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (offer["features"] as List).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Price and Valid Until
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${((offer["originalPrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${((offer["discountedPrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Valid until ${offer["validUntil"]}",
                            style: TextStyle(
                              fontSize: 10,
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
                        _bookOffer(offer);
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
  }

  void _showFilterDialog() {
    // Filter dialog implementation
    ss("Filter options will be implemented here");
  }

  void _bookOffer(Map<String, dynamic> offer) {
    // Book offer implementation
    ss("Booking ${offer["title"]}...");
  }
}
