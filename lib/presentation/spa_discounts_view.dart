import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDiscountsView extends StatefulWidget {
  const SpaDiscountsView({Key? key}) : super(key: key);

  @override
  State<SpaDiscountsView> createState() => _SpaDiscountsViewState();
}

class _SpaDiscountsViewState extends State<SpaDiscountsView> {
  String selectedCategory = "all";
  String selectedDiscount = "all";
  String sortBy = "ending_soon";

  List<Map<String, dynamic>> discounts = [
    {
      "id": 1,
      "title": "Luxury Facial Package",
      "originalPrice": 299.0,
      "discountedPrice": 199.0,
      "discountPercentage": 33,
      "image": "https://picsum.photos/300/200?random=1&keyword=facial",
      "spa": "Elite Beauty Spa",
      "rating": 4.8,
      "reviews": 124,
      "category": "facial",
      "endsAt": "2024-06-20T23:59:59",
      "description": "Complete luxury facial treatment with organic products and LED therapy",
      "features": ["90-minute session", "Organic products", "LED therapy", "Free consultation"],
      "location": "Downtown Center",
      "distance": 2.3,
      "isFavorite": false,
    },
    {
      "id": 2,
      "title": "Relaxation Massage Combo",
      "originalPrice": 450.0,
      "discountedPrice": 270.0,
      "discountPercentage": 40,
      "image": "https://picsum.photos/300/200?random=2&keyword=massage",
      "spa": "Serenity Wellness Center",
      "rating": 4.9,
      "reviews": 89,
      "category": "massage",
      "endsAt": "2024-06-18T18:00:00",
      "description": "Deep tissue and Swedish massage combination for ultimate relaxation",
      "features": ["120-minute session", "Hot stones", "Aromatherapy", "Sauna access"],
      "location": "Wellness District",
      "distance": 1.8,
      "isFavorite": true,
    },
    {
      "id": 3,
      "title": "Anti-Aging Treatment",
      "originalPrice": 380.0,
      "discountedPrice": 266.0,
      "discountPercentage": 30,
      "image": "https://picsum.photos/300/200?random=3&keyword=skincare",
      "spa": "Youth Renewal Clinic",
      "rating": 4.7,
      "reviews": 156,
      "category": "facial",
      "endsAt": "2024-06-25T20:00:00",
      "description": "Advanced anti-aging facial with peptide infusion and microcurrent therapy",
      "features": ["Peptide treatment", "Microcurrent", "Collagen mask", "Home care kit"],
      "location": "Medical Center",
      "distance": 3.1,
      "isFavorite": false,
    },
    {
      "id": 4,
      "title": "Couples Spa Package",
      "originalPrice": 680.0,
      "discountedPrice": 408.0,
      "discountPercentage": 40,
      "image": "https://picsum.photos/300/200?random=4&keyword=couple",
      "spa": "Romance Spa Retreat",
      "rating": 4.6,
      "reviews": 78,
      "category": "package",
      "endsAt": "2024-06-22T16:00:00",
      "description": "Romantic couples spa experience with massage and champagne",
      "features": ["2 massages", "Private suite", "Champagne", "Rose petals"],
      "location": "Resort Area",
      "distance": 5.2,
      "isFavorite": true,
    },
    {
      "id": 5,
      "title": "Full Body Detox",
      "originalPrice": 320.0,
      "discountedPrice": 224.0,
      "discountPercentage": 30,
      "image": "https://picsum.photos/300/200?random=5&keyword=detox",
      "spa": "Pure Wellness Studio",
      "rating": 4.5,
      "reviews": 92,
      "category": "body",
      "endsAt": "2024-06-28T21:00:00",
      "description": "Complete body detox with lymphatic drainage and herbal wraps",
      "features": ["Lymphatic massage", "Herbal wraps", "Infrared sauna", "Detox tea"],
      "location": "Health Center",
      "distance": 2.7,
      "isFavorite": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Facial Treatments", "value": "facial"},
    {"label": "Massage Therapy", "value": "massage"},
    {"label": "Body Treatments", "value": "body"},
    {"label": "Spa Packages", "value": "package"},
  ];

  List<Map<String, dynamic>> discountFilters = [
    {"label": "All Discounts", "value": "all"},
    {"label": "20% or more", "value": "20"},
    {"label": "30% or more", "value": "30"},
    {"label": "40% or more", "value": "40"},
    {"label": "50% or more", "value": "50"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Ending Soon", "value": "ending_soon"},
    {"label": "Highest Discount", "value": "discount_high"},
    {"label": "Lowest Price", "value": "price_low"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Nearest", "value": "distance"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Discounts"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Discount Summary Banner
          _buildDiscountBanner(),

          // Filter Controls
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Discounts List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getFilteredDiscounts().length,
              itemBuilder: (context, index) {
                final discount = _getFilteredDiscounts()[index];
                return _buildDiscountCard(discount);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountBanner() {
    int totalDiscounts = discounts.length;
    double maxDiscount = discounts.map((d) => d["discountPercentage"] as int).reduce((a, b) => a > b ? a : b).toDouble();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Limited Time Offers",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalDiscounts exclusive spa deals",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "Up to ${maxDiscount.toInt()}% OFF",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountCard(Map<String, dynamic> discount) {
    DateTime endTime = DateTime.parse(discount["endsAt"]);
    Duration timeLeft = endTime.difference(DateTime.now());
    String timeLeftText = _formatTimeLeft(timeLeft);

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
          // Image and Discount Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${discount["image"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
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
                    "${discount["discountPercentage"]}% OFF",
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
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(discount["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      discount["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                      color: discount["isFavorite"] ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Spa
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${discount["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${discount["spa"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Price and Rating
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${((discount["discountedPrice"] as double)).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((discount["originalPrice"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Save \$${(((discount["originalPrice"] as double) - (discount["discountedPrice"] as double))).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${discount["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " (${discount["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${discount["distance"]} km away",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Description
                Text(
                  "${discount["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),

                // Features
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (discount["features"] as List<String>).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Time Left and Action
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: warningColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Ends in $timeLeftText",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Book Now",
                        size: bs.sm,
                        onPressed: () {
                          _bookDiscount(discount);
                        },
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

  List<Map<String, dynamic>> _getFilteredDiscounts() {
    List<Map<String, dynamic>> filtered = List.from(discounts);

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((discount) => discount["category"] == selectedCategory).toList();
    }

    // Filter by discount percentage
    if (selectedDiscount != "all") {
      int minDiscount = int.tryParse(selectedDiscount) ?? 0;
      filtered = filtered.where((discount) => (discount["discountPercentage"] as int) >= minDiscount).toList();
    }

    // Sort
    switch (sortBy) {
      case "discount_high":
        filtered.sort((a, b) => (b["discountPercentage"] as int).compareTo(a["discountPercentage"] as int));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["discountedPrice"] as double).compareTo(b["discountedPrice"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      default: // ending_soon
        filtered.sort((a, b) {
          DateTime aEnd = DateTime.parse(a["endsAt"]);
          DateTime bEnd = DateTime.parse(b["endsAt"]);
          return aEnd.compareTo(bEnd);
        });
    }

    return filtered;
  }

  String _formatTimeLeft(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays}d ${duration.inHours % 24}h";
    } else if (duration.inHours > 0) {
      return "${duration.inHours}h ${duration.inMinutes % 60}m";
    } else {
      return "${duration.inMinutes}m";
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Discounts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Minimum Discount",
                items: discountFilters,
                value: selectedDiscount,
                onChanged: (value, label) {
                  selectedDiscount = value;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset",
                      color: secondaryColor,
                      onPressed: () {
                        selectedCategory = "all";
                        selectedDiscount = "all";
                        sortBy = "ending_soon";
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Apply",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavorite(int discountId) {
    setState(() {
      final index = discounts.indexWhere((d) => d["id"] == discountId);
      if (index != -1) {
        discounts[index]["isFavorite"] = !(discounts[index]["isFavorite"] as bool);
      }
    });
    
    bool isFavorite = discounts.firstWhere((d) => d["id"] == discountId)["isFavorite"];
    if (isFavorite) {
      ss("Added to favorites");
    } else {
      si("Removed from favorites");
    }
  }

  void _bookDiscount(Map<String, dynamic> discount) {
    ss("Booking ${discount["title"]}...");
    //navigateTo ( SpaBookingView )
  }
}
