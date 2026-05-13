import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyDetailView extends StatefulWidget {
  const ReaPropertyDetailView({super.key});

  @override
  State<ReaPropertyDetailView> createState() => _ReaPropertyDetailViewState();
}

class _ReaPropertyDetailViewState extends State<ReaPropertyDetailView> {
  Map<String, dynamic> propertyData = {    "id": 1,
    "title": "Modern Luxury Villa",
    "type": "Villa",
    "status": "For Sale",
    "price": 850000,
    "pricePerSqft": 425,
    "bedrooms": 4,
    "bathrooms": 3,
    "area": 2000,
    "lotSize": 5000,
    "yearBuilt": 2019,
    "parking": 2,
    "address": "123 Sunset Boulevard",
    "city": "Beverly Hills",
    "state": "CA",
    "zipCode": "90210",
    "latitude": 34.0736,
    "longitude": -118.4004,
    "images": [
      "https://picsum.photos/600/400?random=1&keyword=villa",
      "https://picsum.photos/600/400?random=2&keyword=luxury",
      "https://picsum.photos/600/400?random=3&keyword=modern",
      "https://picsum.photos/600/400?random=4&keyword=interior",
      "https://picsum.photos/600/400?random=5&keyword=kitchen",
    ],
    "description": "Stunning modern villa with panoramic city views. Features open floor plan, gourmet kitchen with premium appliances, master suite with walk-in closet, and private backyard with pool. Located in prestigious neighborhood with top-rated schools.",
    "features": [
      "Swimming Pool",
      "Fireplace",
      "Hardwood Floors",
      "Granite Countertops",
      "Walk-in Closet",
      "Garden",
      "Security System",
      "Air Conditioning"
    ],
    "agent": {
      "name": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@realestate.com",
      "photo": "https://picsum.photos/100/100?random=10&keyword=person",
      "rating": 4.9,
      "reviews": 147,
      "experience": "8 years"
    },
    "virtualTour": true,
    "listingDate": "2024-01-15",
    "daysOnMarket": 45,
    "views": 1247,
    "saves": 89,
    "rating": 4.7,
    "reviewCount": 23
  };

  bool isFavorite = false;
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Property shared!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Property Images
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${(propertyData["images"] as List)[currentImageIndex]}",
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${propertyData["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (propertyData["virtualTour"] == true)
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.visibility, color: Colors.white, size: 12),
                            SizedBox(width: spXs),
                            Text(
                              "Virtual Tour",
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
                    bottom: spMd,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      child: QHorizontalScroll(
                        children: List.generate((propertyData["images"] as List).length, (index) {
                          bool isSelected = index == currentImageIndex;
                          return GestureDetector(
                            onTap: () {
                              currentImageIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(left: index == 0 ? spMd : spXs, right: index == (propertyData["images"] as List).length - 1 ? spMd : 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.white.withAlpha(100),
                                  width: isSelected ? 3 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${(propertyData["images"] as List)[index]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Basic Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${propertyData["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((propertyData["price"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${propertyData["address"]}, ${propertyData["city"]}, ${propertyData["state"]} ${propertyData["zipCode"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${propertyData["type"]} • \$${propertyData["pricePerSqft"]}/sqft",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${propertyData["rating"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        " (${propertyData["reviewCount"]} reviews)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${propertyData["daysOnMarket"]} days on market",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Property Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Property Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("Bedrooms", "${propertyData["bedrooms"]}", Icons.bed),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Bathrooms", "${propertyData["bathrooms"]}", Icons.bathtub),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("Area", "${propertyData["area"]} sqft", Icons.square_foot),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Parking", "${propertyData["parking"]} cars", Icons.directions_car),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("Year Built", "${propertyData["yearBuilt"]}", Icons.calendar_today),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Lot Size", "${propertyData["lotSize"]} sqft", Icons.landscape),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Features
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Features & Amenities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: (propertyData["features"] as List).map((feature) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Text(
                          "$feature",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Description
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${propertyData["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Agent Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Listed by",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${(propertyData["agent"] as Map)["photo"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${(propertyData["agent"] as Map)["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${(propertyData["agent"] as Map)["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${(propertyData["agent"] as Map)["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${(propertyData["agent"] as Map)["experience"]} experience",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call",
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling agent...");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Email",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening email...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: Row(
          spacing: spSm,
          children: [
            QButton(
              label: "Schedule Tour",
              icon: Icons.calendar_today,
              size: bs.sm,
              onPressed: () {
                ss("Tour scheduled!");
              },
            ),
            Expanded(
              child: QButton(
                label: "Contact Agent",
                size: bs.md,
                onPressed: () {
                  ss("Contacting agent...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
