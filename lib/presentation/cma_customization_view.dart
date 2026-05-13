import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomizationView extends StatefulWidget {
  const CmaCustomizationView({super.key});

  @override
  State<CmaCustomizationView> createState() => _CmaCustomizationViewState();
}

class _CmaCustomizationViewState extends State<CmaCustomizationView> {
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Exterior", "value": "Exterior"},
    {"label": "Interior", "value": "Interior"},
    {"label": "Performance", "value": "Performance"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Lighting", "value": "Lighting"},
  ];

  List<Map<String, dynamic>> customizations = [
    {
      "id": "custom_001",
      "name": "Carbon Fiber Hood",
      "category": "Exterior",
      "description": "Lightweight carbon fiber hood replacement for improved performance and style",
      "price": 1250.00,
      "installationPrice": 350.00,
      "difficulty": "Professional",
      "timeRequired": "4-6 hours",
      "warranty": "2 years",
      "brand": "Seibon",
      "rating": 4.8,
      "reviews": 142,
      "image": "https://picsum.photos/300/200?random=1&keyword=car_hood",
      "features": ["Weight reduction: 50%", "OEM fitment", "UV resistant clear coat"],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "custom_002",
      "name": "LED Headlight Conversion",
      "category": "Lighting",
      "description": "Complete LED headlight conversion kit with adaptive lighting",
      "price": 850.00,
      "installationPrice": 200.00,
      "difficulty": "Moderate",
      "timeRequired": "2-3 hours",
      "warranty": "3 years",
      "brand": "Morimoto",
      "rating": 4.9,
      "reviews": 89,
      "image": "https://picsum.photos/300/200?random=2&keyword=car_lights",
      "features": ["6000K color temperature", "Plug & play installation", "DOT approved"],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true
    },
    {
      "id": "custom_003",
      "name": "Sport Exhaust System",
      "category": "Performance",
      "description": "Cat-back sport exhaust system for enhanced sound and performance",
      "price": 680.00,
      "installationPrice": 275.00,
      "difficulty": "Professional",
      "timeRequired": "3-4 hours",
      "warranty": "Lifetime",
      "brand": "Borla",
      "rating": 4.7,
      "reviews": 203,
      "image": "https://picsum.photos/300/200?random=3&keyword=exhaust",
      "features": ["Stainless steel construction", "+15 HP gain", "Deep aggressive tone"],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": false,
      "isInstalled": false
    },
    {
      "id": "custom_004",
      "name": "Leather Seat Covers",
      "category": "Interior",
      "description": "Premium leather seat covers with custom stitching",
      "price": 450.00,
      "installationPrice": 150.00,
      "difficulty": "Easy",
      "timeRequired": "1-2 hours",
      "warranty": "1 year",
      "brand": "Coverking",
      "rating": 4.6,
      "reviews": 67,
      "image": "https://picsum.photos/300/200?random=4&keyword=car_seats",
      "features": ["Genuine leather", "Custom fit", "Easy maintenance"],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "custom_005",
      "name": "Cold Air Intake",
      "category": "Performance",
      "description": "High-flow cold air intake system for increased horsepower",
      "price": 320.00,
      "installationPrice": 125.00,
      "difficulty": "Moderate",
      "timeRequired": "1-2 hours",
      "warranty": "2 years",
      "brand": "K&N",
      "rating": 4.8,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=5&keyword=air_filter",
      "features": ["+12 HP gain", "Washable filter", "Million mile warranty"],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true
    },
    {
      "id": "custom_006",
      "name": "Dash Cam System",
      "category": "Electronics",
      "description": "4K dual-channel dash cam with parking mode",
      "price": 280.00,
      "installationPrice": 100.00,
      "difficulty": "Moderate",
      "timeRequired": "2-3 hours",
      "warranty": "2 years",
      "brand": "BlackVue",
      "rating": 4.9,
      "reviews": 234,
      "image": "https://picsum.photos/300/200?random=6&keyword=dashcam",
      "features": ["4K recording", "WiFi connectivity", "Cloud storage"],
      "compatibility": "Universal",
      "inStock": true,
      "isInstalled": false
    }
  ];

  List<Map<String, dynamic>> get filteredCustomizations {
    if (selectedCategory == "All") {
      return customizations;
    }
    return customizations.where((item) => item["category"] == selectedCategory).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Professional":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Customization"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              si("Opening customization cart...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Selection
            QDropdownField(
              label: "Select Vehicle",
              items: vehicleOptions,
              value: selectedVehicle,
              onChanged: (value, label) {
                selectedVehicle = value;
                setState(() {});
              },
            ),

            // Category Filter
            QCategoryPicker(
              label: "Customization Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Stats Card
            Container(
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.build, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Customization Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${customizations.where((c) => c["isInstalled"]).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Installed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${customizations.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((customizations.where((c) => c["isInstalled"]).map((c) => c["price"] as double).fold(0.0, (a, b) => a + b))).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Investment",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customization Items
            Text(
              "Available Customizations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 300,
              children: filteredCustomizations.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: item["isInstalled"] ? Border.all(color: successColor, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image and Status
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${item["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (item["isInstalled"])
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check, color: Colors.white, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "INSTALLED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (!(item["inStock"] as bool))
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
                                  "OUT OF STOCK",
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

                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name and Category
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 14),
                                    SizedBox(width: 2),
                                    Text(
                                      "${item["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      " (${item["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Brand
                            Row(
                              children: [
                                Icon(Icons.business, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["brand"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            // Difficulty and Time
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(item["difficulty"]).withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getDifficultyColor(item["difficulty"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["timeRequired"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            // Features
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Key Features:",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  ...(item["features"] as List).take(2).map((feature) => 
                                    Text(
                                      "• $feature",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ).toList(),
                                ],
                              ),
                            ),

                            // Price Section
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Part Price",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["price"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                        "Installation",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["installationPrice"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Total Price
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${((item["price"] as double) + (item["installationPrice"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: item["isInstalled"]
                                ? QButton(
                                    label: "View Details",
                                    icon: Icons.info,
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing installation details...");
                                    },
                                  )
                                : (item["inStock"] as bool)
                                  ? QButton(
                                      label: "Add to Cart",
                                      icon: Icons.add_shopping_cart,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Added ${item["name"]} to cart");
                                      },
                                    )
                                  : QButton(
                                      label: "Notify When Available",
                                      icon: Icons.notifications,
                                      size: bs.sm,
                                      onPressed: () {
                                        si("You'll be notified when this item is back in stock");
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

            // Consultation Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.support_agent, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help Choosing?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Get a free consultation with our customization experts to find the perfect upgrades for your vehicle.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  QButton(
                    label: "Schedule Consultation",
                    icon: Icons.calendar_today,
                    size: bs.md,
                    onPressed: () {
                      ss("Opening consultation scheduler...");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
