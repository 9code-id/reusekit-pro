import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaNearbyAttractionsView extends StatefulWidget {
  const TtaNearbyAttractionsView({super.key});

  @override
  State<TtaNearbyAttractionsView> createState() => _TtaNearbyAttractionsViewState();
}

class _TtaNearbyAttractionsViewState extends State<TtaNearbyAttractionsView> {
  String selectedRadius = "5 km";
  String selectedCategory = "All";
  String currentLocation = "Jakarta, Indonesia";
  
  final List<String> radiusOptions = [
    "1 km",
    "5 km",
    "10 km",
    "25 km",
    "50 km"
  ];

  final List<String> categories = [
    "All",
    "Museums",
    "Parks",
    "Restaurants",
    "Shopping",
    "Entertainment",
    "Historical"
  ];

  final List<Map<String, dynamic>> nearbyAttractions = [
    {
      "id": 1,
      "name": "National Monument (Monas)",
      "category": "Historical",
      "image": "https://picsum.photos/400/300?random=31&keyword=monument",
      "distance": 0.8,
      "rating": 4.5,
      "reviews": 12340,
      "openingHours": "08:00 - 16:00",
      "entryFee": 15000,
      "estimatedTime": "2-3 hours",
      "isOpen": true,
      "isFavorite": false,
      "latitude": -6.1753871,
      "longitude": 106.8271443,
      "description": "Iconic golden tower symbolizing Indonesia's independence",
      "facilities": ["Parking", "Restroom", "Souvenir Shop", "Guide"],
    },
    {
      "id": 2,
      "name": "Grand Indonesia Mall",
      "category": "Shopping",
      "image": "https://picsum.photos/400/300?random=32&keyword=mall",
      "distance": 1.2,
      "rating": 4.3,
      "reviews": 8970,
      "openingHours": "10:00 - 22:00",
      "entryFee": 0,
      "estimatedTime": "2-4 hours",
      "isOpen": true,
      "isFavorite": true,
      "latitude": -6.1944174,
      "longitude": 106.8208073,
      "description": "Premium shopping mall with international brands",
      "facilities": ["Parking", "Food Court", "Cinema", "ATM"],
    },
    {
      "id": 3,
      "name": "Taman Mini Indonesia Indah",
      "category": "Parks",
      "image": "https://picsum.photos/400/300?random=33&keyword=park",
      "distance": 15.3,
      "rating": 4.2,
      "reviews": 15600,
      "openingHours": "07:00 - 17:00",
      "entryFee": 25000,
      "estimatedTime": "4-6 hours",
      "isOpen": true,
      "isFavorite": false,
      "latitude": -6.3025,
      "longitude": 106.8955,
      "description": "Cultural park showcasing Indonesia's diversity",
      "facilities": ["Parking", "Restaurant", "Cable Car", "Museum"],
    },
    {
      "id": 4,
      "name": "Café Batavia",
      "category": "Restaurants",
      "image": "https://picsum.photos/400/300?random=34&keyword=restaurant",
      "distance": 2.1,
      "rating": 4.6,
      "reviews": 3450,
      "openingHours": "11:00 - 23:00",
      "entryFee": 0,
      "estimatedTime": "1-2 hours",
      "isOpen": true,
      "isFavorite": true,
      "latitude": -6.1354,
      "longitude": 106.8133,
      "description": "Historic Dutch colonial restaurant in Old Town",
      "facilities": ["Wi-Fi", "Air Conditioning", "Live Music", "Terrace"],
    },
    {
      "id": 5,
      "name": "National Museum",
      "category": "Museums",
      "image": "https://picsum.photos/400/300?random=35&keyword=museum",
      "distance": 1.5,
      "rating": 4.4,
      "reviews": 6780,
      "openingHours": "09:00 - 16:00",
      "entryFee": 10000,
      "estimatedTime": "2-3 hours",
      "isOpen": false,
      "isFavorite": false,
      "latitude": -6.1769,
      "longitude": 106.8190,
      "description": "Indonesia's premier museum of history and culture",
      "facilities": ["Audio Guide", "Gift Shop", "Cafeteria", "Library"],
    },
    {
      "id": 6,
      "name": "Ancol Dreamland",
      "category": "Entertainment",
      "image": "https://picsum.photos/400/300?random=36&keyword=amusement",
      "distance": 8.7,
      "rating": 4.1,
      "reviews": 22100,
      "openingHours": "06:00 - 21:00",
      "entryFee": 30000,
      "estimatedTime": "Full day",
      "isOpen": true,
      "isFavorite": true,
      "latitude": -6.1229,
      "longitude": 106.8495,
      "description": "Beach resort with theme park and water activities",
      "facilities": ["Beach", "Water Park", "Rides", "Hotels"],
    },
  ];

  List<Map<String, dynamic>> get filteredAttractions {
    var filtered = nearbyAttractions;
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((attraction) => 
        attraction["category"] == selectedCategory).toList();
    }
    
    // Filter by radius
    double radiusKm = double.parse(selectedRadius.split(' ')[0]);
    filtered = filtered.where((attraction) => 
      (attraction["distance"] as double) <= radiusKm).toList();
    
    // Sort by distance
    filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    
    return filtered;
  }

  void toggleFavorite(int attractionId) {
    setState(() {
      final index = nearbyAttractions.indexWhere((attraction) => 
        attraction["id"] == attractionId);
      if (index != -1) {
        nearbyAttractions[index]["isFavorite"] = 
          !nearbyAttractions[index]["isFavorite"];
      }
    });
  }

  String _formatCurrency(int amount) {
    if (amount == 0) return "Free";
    return "Rp ${(amount.toDouble()).currency}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Attractions"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.map),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.my_location,
                  color: primaryColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Location",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        currentLocation,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Change",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Filters Row
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                // Radius Filter
                Expanded(
                  child: QDropdownField(
                    label: "Radius",
                    items: radiusOptions.map((radius) => {
                      "label": radius,
                      "value": radius,
                    }).toList(),
                    value: selectedRadius,
                    onChanged: (value, label) {
                      selectedRadius = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                // Category Filter
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "${filteredAttractions.length} attractions found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sort by distance",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.sort,
                  color: primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Attractions List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredAttractions.length,
              itemBuilder: (context, index) {
                final attraction = filteredAttractions[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Image Header
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: Image.network(
                                "${attraction["image"]}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),

                          // Distance Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${attraction["distance"]} km",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Status Badge
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: attraction["isOpen"] ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                attraction["isOpen"] ? "OPEN" : "CLOSED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Favorite Button
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => toggleFavorite(attraction["id"] as int),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  attraction["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                  color: attraction["isFavorite"] ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Category
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${attraction["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${attraction["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Description
                            Text(
                              "${attraction["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Rating and Reviews
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${attraction["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "(${attraction["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${attraction["estimatedTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Details Grid
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Opening Hours",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${attraction["openingHours"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Entry Fee",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        _formatCurrency(attraction["entryFee"] as int),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: attraction["entryFee"] == 0 ? successColor : primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Facilities
                            Text(
                              "Facilities:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Wrap(
                              spacing: spSm,
                              runSpacing: 4,
                              children: (attraction["facilities"] as List<String>).map((facility) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    facility,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: spMd),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Get Directions",
                                    icon: Icons.directions,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
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
          ),
        ],
      ),
    );
  }
}
