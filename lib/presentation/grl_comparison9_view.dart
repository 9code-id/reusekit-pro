import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComparison9View extends StatefulWidget {
  @override
  State<GrlComparison9View> createState() => _GrlComparison9ViewState();
}

class _GrlComparison9ViewState extends State<GrlComparison9View> {
  List<Map<String, dynamic>> hotels = [
    {
      "id": 1,
      "name": "Grand Palace Hotel",
      "image": "https://picsum.photos/400/250?random=1&keyword=luxury",
      "images": [
        "https://picsum.photos/400/250?random=11&keyword=hotel",
        "https://picsum.photos/400/250?random=12&keyword=room",
        "https://picsum.photos/400/250?random=13&keyword=restaurant"
      ],
      "location": "Downtown Manhattan, NY",
      "category": "Luxury",
      "rating": 4.8,
      "reviews": 2847,
      "price": 450,
      "originalPrice": 550,
      "discount": 18,
      "features": ["Free WiFi", "Pool", "Spa", "Restaurant", "Gym", "Room Service"],
      "amenities": ["24/7 Concierge", "Valet Parking", "Business Center", "Laundry"],
      "roomTypes": ["Deluxe Room", "Suite", "Presidential Suite"],
      "checkIn": "3:00 PM",
      "checkOut": "11:00 AM",
      "distance": 0.5,
      "transportation": "5 min walk to subway",
      "cancellation": "Free cancellation until 6 PM",
      "highlight": "City View",
      "saved": false,
      "color": primaryColor,
      "availability": "Last 2 rooms",
      "popularWith": "Business travelers"
    },
    {
      "id": 2,
      "name": "Boutique Garden Inn",
      "image": "https://picsum.photos/400/250?random=2&keyword=boutique",
      "images": [
        "https://picsum.photos/400/250?random=21&keyword=garden",
        "https://picsum.photos/400/250?random=22&keyword=boutique",
        "https://picsum.photos/400/250?random=23&keyword=cozy"
      ],
      "location": "Brooklyn Heights, NY",
      "category": "Boutique",
      "rating": 4.6,
      "reviews": 1245,
      "price": 280,
      "originalPrice": 320,
      "discount": 12,
      "features": ["Free WiFi", "Garden", "Restaurant", "Pet Friendly", "Bike Rental"],
      "amenities": ["Continental Breakfast", "Library", "Garden Terrace", "Local Tours"],
      "roomTypes": ["Standard Room", "Garden View", "Loft Suite"],
      "checkIn": "2:00 PM",
      "checkOut": "12:00 PM",
      "distance": 2.1,
      "transportation": "10 min to subway",
      "cancellation": "Free cancellation until 48 hours",
      "highlight": "Garden Terrace",
      "saved": true,
      "color": successColor,
      "availability": "Good availability",
      "popularWith": "Couples"
    },
    {
      "id": 3,
      "name": "Metropolitan Business Hotel",
      "image": "https://picsum.photos/400/250?random=3&keyword=business",
      "images": [
        "https://picsum.photos/400/250?random=31&keyword=conference",
        "https://picsum.photos/400/250?random=32&keyword=office",
        "https://picsum.photos/400/250?random=33&keyword=modern"
      ],
      "location": "Financial District, NY",
      "category": "Business",
      "rating": 4.4,
      "reviews": 3456,
      "price": 320,
      "originalPrice": 380,
      "discount": 16,
      "features": ["Free WiFi", "Business Center", "Conference Rooms", "Gym", "Airport Shuttle"],
      "amenities": ["Meeting Facilities", "Printing Services", "Executive Lounge", "Car Rental"],
      "roomTypes": ["Business Room", "Executive Room", "Conference Suite"],
      "checkIn": "3:00 PM",
      "checkOut": "12:00 PM",
      "distance": 1.2,
      "transportation": "Direct subway access",
      "cancellation": "Flexible cancellation policy",
      "highlight": "Conference Center",
      "saved": false,
      "color": infoColor,
      "availability": "Limited rooms",
      "popularWith": "Business travelers"
    },
    {
      "id": 4,
      "name": "Cozy Corner B&B",
      "image": "https://picsum.photos/400/250?random=4&keyword=cozy",
      "images": [
        "https://picsum.photos/400/250?random=41&keyword=breakfast",
        "https://picsum.photos/400/250?random=42&keyword=homey",
        "https://picsum.photos/400/250?random=43&keyword=comfortable"
      ],
      "location": "Greenwich Village, NY",
      "category": "B&B",
      "rating": 4.7,
      "reviews": 876,
      "price": 180,
      "originalPrice": 200,
      "discount": 10,
      "features": ["Free WiFi", "Breakfast Included", "Shared Kitchen", "Local Guide"],
      "amenities": ["Homemade Breakfast", "Local Recommendations", "Shared Lounge", "Library"],
      "roomTypes": ["Single Room", "Double Room", "Family Room"],
      "checkIn": "2:00 PM",
      "checkOut": "11:00 AM",
      "distance": 1.8,
      "transportation": "15 min walk to subway",
      "cancellation": "Free cancellation until 24 hours",
      "highlight": "Homemade Breakfast",
      "saved": false,
      "color": warningColor,
      "availability": "Good availability",
      "popularWith": "Solo travelers"
    }
  ];

  String sortBy = "price";
  String filterCategory = "all";
  double maxPrice = 500;
  bool showOnlyAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Comparison"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showFilters(),
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search Header
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.hotel, color: Colors.white, size: 32),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Find Your Perfect Stay",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Compare hotels and book with confidence",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Quick Search Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 20),
                              SizedBox(height: spXs),
                              Text(
                                "New York",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withAlpha(100),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white, size: 20),
                              SizedBox(height: spXs),
                              Text(
                                "Dec 15-17",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withAlpha(100),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.people, color: Colors.white, size: 20),
                              SizedBox(height: spXs),
                              Text(
                                "2 Guests",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
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
            ),
            SizedBox(height: spMd),

            // Sort and Filter Controls
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: [
                            {"label": "Price (Low to High)", "value": "price"},
                            {"label": "Rating (High to Low)", "value": "rating"},
                            {"label": "Distance", "value": "distance"},
                            {"label": "Popularity", "value": "reviews"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "all"},
                            {"label": "Luxury", "value": "Luxury"},
                            {"label": "Boutique", "value": "Boutique"},
                            {"label": "Business", "value": "Business"},
                            {"label": "B&B", "value": "B&B"},
                          ],
                          value: filterCategory,
                          onChanged: (value, label) {
                            filterCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only available",
                        "value": true,
                        "checked": showOnlyAvailable,
                      }
                    ],
                    value: showOnlyAvailable ? [{"label": "Show only available", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      showOnlyAvailable = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Price Comparison Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bar_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Price Comparison",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildPriceChart(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Hotel Cards
            ...hotels.map((hotel) => _buildHotelCard(hotel)),

            SizedBox(height: spMd),

            // Feature Comparison Table
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.compare, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Feature Comparison",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildFeatureComparison(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    Color cardColor = hotel["color"] as Color;
    bool isSaved = hotel["saved"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          // Hotel Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
                child: Image.network(
                  "${hotel["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Overlay Badges
              Positioned(
                top: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${hotel["category"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              if ((hotel["discount"] as int) > 0)
                Positioned(
                  top: spMd,
                  right: spMd,
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
                      "-${hotel["discount"]}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Save Button
              Positioned(
                bottom: spMd,
                right: spMd,
                child: GestureDetector(
                  onTap: () {
                    hotel["saved"] = !isSaved;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Hotel Images Indicator
              Positioned(
                bottom: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(hotel["images"] as List).length + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Hotel Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Name and Rating
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${hotel["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${hotel["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${hotel["rating"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "${hotel["reviews"]} reviews",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Highlight and Distance
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.highlight,
                            size: 16,
                            color: cardColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${hotel["highlight"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: cardColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${hotel["distance"]} km from center",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Transportation
                Row(
                  children: [
                    Icon(
                      Icons.directions_transit,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${hotel["transportation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Key Features
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (hotel["features"] as List).take(4).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: cardColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),

                // Availability Status
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: hotel["availability"] == "Last 2 rooms"
                              ? dangerColor.withAlpha(40)
                              : successColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${hotel["availability"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: hotel["availability"] == "Last 2 rooms"
                                ? dangerColor
                                : successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Popular with ${hotel["popularWith"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Cancellation Policy
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${hotel["cancellation"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Price and Booking
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((hotel["discount"] as int) > 0) ...[
                            Text(
                              "\$${hotel["originalPrice"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(height: spXs),
                          ],
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${hotel["price"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                " /night",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Total: \$${(hotel["price"] as int) * 2}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 120,
                          child: QButton(
                            label: "Book Now",
                            size: bs.sm,
                            onPressed: () {
                              ss("Booking initiated for ${hotel["name"]}");
                            },
                          ),
                        ),
                        SizedBox(height: spXs),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildPriceChart() {
    return Column(
      children: hotels.map((hotel) {
        double normalizedPrice = (hotel["price"] as int) / 500; // Normalize to max 500
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${hotel["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${hotel["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: normalizedPrice,
                    child: Container(
                      decoration: BoxDecoration(
                        color: hotel["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${hotel["price"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureComparison() {
    List<String> features = ["WiFi", "Pool", "Gym", "Restaurant", "Spa", "Pet Friendly"];
    
    return Column(
      children: [
        // Header Row
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Feature",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...hotels.take(3).map((hotel) {
                return Expanded(
                  child: Text(
                    "${hotel["name"]}".split(" ")[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Feature Rows
        ...features.map((feature) {
          return Container(
            padding: EdgeInsets.all(spSm),
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
                Expanded(
                  flex: 2,
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                ...hotels.take(3).map((hotel) {
                  bool hasFeature = (hotel["features"] as List).contains(feature) ||
                                   (hotel["features"] as List).any((f) => f.toString().contains(feature));
                  return Expanded(
                    child: Icon(
                      hasFeature ? Icons.check_circle : Icons.cancel,
                      color: hasFeature ? successColor : disabledBoldColor,
                      size: 16,
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _showFilters() {
    // Implementation for filter bottom sheet would go here
  }
}
