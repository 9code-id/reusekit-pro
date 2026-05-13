import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyGalleryView extends StatefulWidget {
  const ReaPropertyGalleryView({super.key});

  @override
  State<ReaPropertyGalleryView> createState() => _ReaPropertyGalleryViewState();
}

class _ReaPropertyGalleryViewState extends State<ReaPropertyGalleryView> {
  int selectedImageIndex = 0;
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "title": "Modern Luxury Villa",
      "price": 2500000,
      "location": "Beverly Hills, CA",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 4500,
      "type": "Villa",
      "images": [
        "https://picsum.photos/800/600?random=1&keyword=luxury+villa",
        "https://picsum.photos/800/600?random=2&keyword=villa+interior",
        "https://picsum.photos/800/600?random=3&keyword=villa+bedroom",
        "https://picsum.photos/800/600?random=4&keyword=villa+kitchen",
        "https://picsum.photos/800/600?random=5&keyword=villa+pool",
      ],
      "featured": true,
      "amenities": ["Pool", "Garden", "Garage", "Security"],
    },
    {
      "id": 2,
      "title": "Downtown Penthouse",
      "price": 1800000,
      "location": "Manhattan, NY",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2800,
      "type": "Apartment",
      "images": [
        "https://picsum.photos/800/600?random=6&keyword=penthouse",
        "https://picsum.photos/800/600?random=7&keyword=penthouse+view",
        "https://picsum.photos/800/600?random=8&keyword=modern+living",
      ],
      "featured": false,
      "amenities": ["City View", "Concierge", "Gym", "Rooftop"],
    },
    {
      "id": 3,
      "title": "Seaside Beach House",
      "price": 3200000,
      "location": "Malibu, CA",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 3500,
      "type": "House",
      "images": [
        "https://picsum.photos/800/600?random=9&keyword=beach+house",
        "https://picsum.photos/800/600?random=10&keyword=ocean+view",
        "https://picsum.photos/800/600?random=11&keyword=beach+interior",
      ],
      "featured": true,
      "amenities": ["Beach Access", "Deck", "Fireplace", "Wine Cellar"],
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    if (selectedFilter == "All") return properties;
    return properties.where((property) => property["type"] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Gallery"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filter Categories
            QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Villa", "value": "Villa"},
                {"label": "Apartment", "value": "Apartment"},
                {"label": "House", "value": "House"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Featured Properties Header
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Featured Properties",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),

            // Property Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredProperties.map((property) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image Gallery
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${(property["images"] as List)[0]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          // Featured Badge
                          if (property["featured"] as bool)
                            Positioned(
                              top: spSm,
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
                                  "FEATURED",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                          // Image Counter
                          Positioned(
                            top: spSm,
                            right: spSm,
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
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(property["images"] as List).length}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Heart Icon
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [shadowSm],
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: dangerColor,
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
                          spacing: spXs,
                          children: [
                            // Price
                            Text(
                              "\$${((property["price"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            // Title
                            Text(
                              "${property["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Location
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
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Property Specs
                            Row(
                              children: [
                                _buildSpecItem(
                                  Icons.bed,
                                  "${property["bedrooms"]} bed",
                                ),
                                SizedBox(width: spSm),
                                _buildSpecItem(
                                  Icons.bathtub,
                                  "${property["bathrooms"]} bath",
                                ),
                                SizedBox(width: spSm),
                                _buildSpecItem(
                                  Icons.straighten,
                                  "${property["area"]} sqft",
                                ),
                              ],
                            ),

                            // Amenities
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (property["amenities"] as List).take(3).map((amenity) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$amenity",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.message,
                                  size: bs.sm,
                                  onPressed: () {},
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
            ),

            // Gallery Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(25), secondaryColor.withAlpha(25)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "Properties",
                      "${filteredProperties.length}",
                      Icons.home,
                    ),
                  ),
                  Expanded(
                    child: _buildStatCard(
                      "Avg Price",
                      "\$${((filteredProperties.map((p) => p["price"] as int).reduce((a, b) => a + b) / filteredProperties.length).toDouble()).currency}",
                      Icons.attach_money,
                    ),
                  ),
                  Expanded(
                    child: _buildStatCard(
                      "Featured",
                      "${filteredProperties.where((p) => p["featured"] as bool).length}",
                      Icons.star,
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

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
