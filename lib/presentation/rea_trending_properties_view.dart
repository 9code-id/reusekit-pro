import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaTrendingPropertiesView extends StatefulWidget {
  const ReaTrendingPropertiesView({super.key});

  @override
  State<ReaTrendingPropertiesView> createState() => _ReaTrendingPropertiesViewState();
}

class _ReaTrendingPropertiesViewState extends State<ReaTrendingPropertiesView> {
  String selectedCategory = "All";
  String selectedPriceRange = "Any";
  String selectedLocation = "All Areas";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Apartments", "value": "Apartments"},
    {"label": "Houses", "value": "Houses"},
    {"label": "Villas", "value": "Villas"},
    {"label": "Plots", "value": "Plots"},
  ];
  
  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "Under ₹50L", "value": "Under ₹50L"},
    {"label": "₹50L - ₹1Cr", "value": "₹50L - ₹1Cr"},
    {"label": "₹1Cr - ₹2Cr", "value": "₹1Cr - ₹2Cr"},
    {"label": "Above ₹2Cr", "value": "Above ₹2Cr"},
  ];
  
  List<Map<String, dynamic>> locations = [
    {"label": "All Areas", "value": "All Areas"},
    {"label": "Whitefield", "value": "Whitefield"},
    {"label": "Electronic City", "value": "Electronic City"},
    {"label": "Koramangala", "value": "Koramangala"},
    {"label": "Indiranagar", "value": "Indiranagar"},
  ];

  List<Map<String, dynamic>> trendingProperties = [
    {
      "id": 1,
      "title": "Prestige Lakeside Habitat",
      "location": "Whitefield, Bangalore",
      "price": 8500000,
      "type": "3 BHK Apartment",
      "area": 1450,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "views": 2450,
      "likes": 89,
      "trending_rank": 1,
      "price_change": 12.5,
      "amenities": ["Swimming Pool", "Gym", "Security", "Parking"],
      "builder": "Prestige Group",
      "status": "Ready to Move",
      "possession": "Immediate"
    },
    {
      "id": 2,
      "title": "Brigade Cornerstone Utopia",
      "location": "Electronic City, Bangalore",
      "price": 6200000,
      "type": "2 BHK Apartment",
      "area": 1180,
      "image": "https://picsum.photos/300/200?random=2&keyword=building",
      "views": 1980,
      "likes": 76,
      "trending_rank": 2,
      "price_change": 8.3,
      "amenities": ["Clubhouse", "Garden", "Security", "Power Backup"],
      "builder": "Brigade Group",
      "status": "Under Construction",
      "possession": "Dec 2025"
    },
    {
      "id": 3,
      "title": "Sobha Dream Acres",
      "location": "Balagere, Bangalore",
      "price": 12500000,
      "type": "4 BHK Villa",
      "area": 2200,
      "image": "https://picsum.photos/300/200?random=3&keyword=villa",
      "views": 1650,
      "likes": 94,
      "trending_rank": 3,
      "price_change": 15.7,
      "amenities": ["Private Garden", "Swimming Pool", "Security", "Club"],
      "builder": "Sobha Limited",
      "status": "Ready to Move",
      "possession": "Immediate"
    },
    {
      "id": 4,
      "title": "Godrej Aqua",
      "location": "Hosahalli, Bangalore",
      "price": 7800000,
      "type": "3 BHK Apartment",
      "area": 1650,
      "image": "https://picsum.photos/300/200?random=4&keyword=apartment",
      "views": 1420,
      "likes": 67,
      "trending_rank": 4,
      "price_change": 6.8,
      "amenities": ["Swimming Pool", "Gym", "Landscaped Gardens", "Security"],
      "builder": "Godrej Properties",
      "status": "Under Construction",
      "possession": "Mar 2026"
    },
    {
      "id": 5,
      "title": "Embassy Lake Terraces",
      "location": "Hebbal, Bangalore",
      "price": 15200000,
      "type": "4 BHK Apartment",
      "area": 2850,
      "image": "https://picsum.photos/300/200?random=5&keyword=luxury",
      "views": 1280,
      "likes": 102,
      "trending_rank": 5,
      "price_change": 18.2,
      "amenities": ["Lake View", "Swimming Pool", "Concierge", "Valet"],
      "builder": "Embassy Group",
      "status": "Ready to Move",
      "possession": "Immediate"
    },
    {
      "id": 6,
      "title": "Puravankara Zenium",
      "location": "Kanakapura Road, Bangalore",
      "price": 5800000,
      "type": "2 BHK Apartment",
      "area": 1250,
      "image": "https://picsum.photos/300/200?random=6&keyword=residential",
      "views": 1150,
      "likes": 58,
      "trending_rank": 6,
      "price_change": 4.5,
      "amenities": ["Clubhouse", "Swimming Pool", "Gym", "Children's Play Area"],
      "builder": "Puravankara Limited",
      "status": "Under Construction",
      "possession": "Jun 2025"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Properties"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Stats Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Market Trending Now",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Top properties gaining popularity",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "15.2%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Avg Price Rise",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
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
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "2.4K",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
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
            
            SizedBox(height: spLg),
            
            // Filter Section
            Text(
              "Filter Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
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
                    label: "Price Range",
                    items: priceRanges,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Location",
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Properties List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Properties",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${trendingProperties.length} Properties",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Properties List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: trendingProperties.length,
              itemBuilder: (context, index) {
                final property = trendingProperties[index];
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
                      // Property Image with Trending Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${property["image"]}",
                              height: 200,
                              width: double.infinity,
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "#${property["trending_rank"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "+${(property["price_change"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
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
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Property Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${property["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Price and Area
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹${((property["price"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${property["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${property["area"]} sq ft",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${((property["price"] as int) / (property["area"] as int)).toStringAsFixed(0)}/sq ft",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Stats Row
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${property["views"]} views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${property["likes"]} likes",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${property["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Amenities Preview
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (property["amenities"] as List).take(3).map((amenity) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$amenity",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: secondaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo ReaPropertyDetailView
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Call builder
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share property
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
