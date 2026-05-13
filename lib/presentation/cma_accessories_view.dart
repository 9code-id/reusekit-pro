import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAccessoriesView extends StatefulWidget {
  const CmaAccessoriesView({super.key});

  @override
  State<CmaAccessoriesView> createState() => _CmaAccessoriesViewState();
}

class _CmaAccessoriesViewState extends State<CmaAccessoriesView> {
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  String selectedCategory = "All";
  bool showInstalledOnly = false;
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Interior", "value": "Interior"},
    {"label": "Exterior", "value": "Exterior"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Comfort", "value": "Comfort"},
    {"label": "Protection", "value": "Protection"},
  ];

  List<Map<String, dynamic>> accessories = [
    {
      "id": "acc_001",
      "name": "Premium Floor Mats",
      "category": "Interior",
      "description": "All-weather floor mats with custom logo embroidery",
      "price": 120.00,
      "installationPrice": 0.00,
      "difficulty": "Easy",
      "timeRequired": "5 minutes",
      "brand": "WeatherTech",
      "warranty": "3 years",
      "rating": 4.8,
      "reviews": 2340,
      "image": "https://picsum.photos/300/200?random=1&keyword=floor_mats",
      "features": [
        "Custom fit for your vehicle",
        "Easy to clean",
        "Non-slip backing",
        "Logo embroidery available"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true,
      "installDate": "2024-03-15"
    },
    {
      "id": "acc_002",
      "name": "Wireless Phone Charger",
      "category": "Electronics",
      "description": "Qi-compatible wireless charging pad for center console",
      "price": 85.00,
      "installationPrice": 50.00,
      "difficulty": "Moderate",
      "timeRequired": "1 hour",
      "brand": "Nomad",
      "warranty": "2 years",
      "rating": 4.6,
      "reviews": 890,
      "image": "https://picsum.photos/300/200?random=2&keyword=wireless_charger",
      "features": [
        "15W fast charging",
        "LED charging indicator",
        "Non-slip surface",
        "Universal compatibility"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "acc_003",
      "name": "Seat Covers",
      "category": "Interior",
      "description": "Leather seat covers with heating elements",
      "price": 450.00,
      "installationPrice": 200.00,
      "difficulty": "Professional",
      "timeRequired": "3-4 hours",
      "brand": "Katzkin",
      "warranty": "3 years",
      "rating": 4.9,
      "reviews": 450,
      "image": "https://picsum.photos/300/200?random=3&keyword=seat_covers",
      "features": [
        "Genuine leather construction",
        "Built-in heating elements",
        "Custom stitching patterns",
        "Easy maintenance"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true,
      "installDate": "2024-02-20"
    },
    {
      "id": "acc_004",
      "name": "Window Tinting",
      "category": "Exterior",
      "description": "Ceramic window tint for UV protection and privacy",
      "price": 280.00,
      "installationPrice": 120.00,
      "difficulty": "Professional",
      "timeRequired": "2-3 hours",
      "brand": "3M",
      "warranty": "Lifetime",
      "rating": 4.7,
      "reviews": 1200,
      "image": "https://picsum.photos/300/200?random=4&keyword=window_tint",
      "features": [
        "99% UV protection",
        "Heat rejection technology",
        "Non-metallic construction",
        "Lifetime warranty"
      ],
      "compatibility": "Universal",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "acc_005",
      "name": "Dash Camera System",
      "category": "Electronics",
      "description": "Dual-channel 4K dash cam with parking mode",
      "price": 320.00,
      "installationPrice": 150.00,
      "difficulty": "Professional",
      "timeRequired": "2-3 hours",
      "brand": "BlackVue",
      "warranty": "2 years",
      "rating": 4.8,
      "reviews": 780,
      "image": "https://picsum.photos/300/200?random=5&keyword=dash_camera",
      "features": [
        "4K front camera",
        "1080p rear camera",
        "WiFi connectivity",
        "Cloud storage support"
      ],
      "compatibility": "Universal",
      "inStock": false,
      "isInstalled": false
    },
    {
      "id": "acc_006",
      "name": "Cargo Organizer",
      "category": "Interior",
      "description": "Adjustable trunk organizer with compartments",
      "price": 65.00,
      "installationPrice": 0.00,
      "difficulty": "Easy",
      "timeRequired": "2 minutes",
      "brand": "Rubbermaid",
      "warranty": "1 year",
      "rating": 4.5,
      "reviews": 320,
      "image": "https://picsum.photos/300/200?random=6&keyword=cargo_organizer",
      "features": [
        "Adjustable compartments",
        "Non-slip bottom",
        "Collapsible design",
        "Easy to clean"
      ],
      "compatibility": "Universal",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "acc_007",
      "name": "Paint Protection Film",
      "category": "Protection",
      "description": "Clear protective film for high-impact areas",
      "price": 680.00,
      "installationPrice": 400.00,
      "difficulty": "Professional",
      "timeRequired": "4-6 hours",
      "brand": "XPEL",
      "warranty": "10 years",
      "rating": 4.9,
      "reviews": 560,
      "image": "https://picsum.photos/300/200?random=7&keyword=paint_protection",
      "features": [
        "Self-healing technology",
        "UV resistant",
        "Invisible protection",
        "Stain resistant"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true,
      "installDate": "2024-01-10"
    },
    {
      "id": "acc_008",
      "name": "Ambient Lighting Kit",
      "category": "Interior",
      "description": "LED ambient lighting with color customization",
      "price": 150.00,
      "installationPrice": 100.00,
      "difficulty": "Moderate",
      "timeRequired": "2-3 hours",
      "brand": "Philips",
      "warranty": "5 years",
      "rating": 4.6,
      "reviews": 220,
      "image": "https://picsum.photos/300/200?random=8&keyword=ambient_lighting",
      "features": [
        "16 million colors",
        "Smartphone app control",
        "Music sync capability",
        "Easy installation"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "acc_009",
      "name": "Roof Rack System",
      "category": "Exterior",
      "description": "Aerodynamic roof rack for cargo and sports equipment",
      "price": 380.00,
      "installationPrice": 80.00,
      "difficulty": "Easy",
      "timeRequired": "1 hour",
      "brand": "Thule",
      "warranty": "5 years",
      "rating": 4.8,
      "reviews": 1450,
      "image": "https://picsum.photos/300/200?random=9&keyword=roof_rack",
      "features": [
        "Aerodynamic design",
        "Quick release system",
        "Integrated locks",
        "Various attachments available"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    }
  ];

  List<Map<String, dynamic>> get filteredAccessories {
    var filtered = accessories.where((acc) {
      if (selectedCategory != "All" && acc["category"] != selectedCategory) {
        return false;
      }
      if (showInstalledOnly && !acc["isInstalled"]) {
        return false;
      }
      return true;
    }).toList();
    
    return filtered;
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
        title: Text("Vehicle Accessories"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              si("Opening accessories cart...");
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

            // Filters
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
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Installed Only",
                        "value": true,
                        "checked": showInstalledOnly,
                      }
                    ],
                    value: [
                      if (showInstalledOnly)
                        {"label": "Show Installed Only", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      showInstalledOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Accessories Summary
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
                      Icon(Icons.dashboard_customize, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Accessories Overview",
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
                              "${accessories.where((a) => a["isInstalled"]).length}",
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
                              "${accessories.length}",
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
                              "\$${((accessories.where((a) => a["isInstalled"]).map((a) => (a["price"] as double) + (a["installationPrice"] as double)).fold(0.0, (a, b) => a + b))).currency}",
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

            // Accessories Grid
            Text(
              showInstalledOnly ? "Installed Accessories" : "Available Accessories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 300,
              children: filteredAccessories.map((accessory) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: accessory["isInstalled"] ? Border.all(color: successColor, width: 2) : null,
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
                              "${accessory["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (accessory["isInstalled"])
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
                          if (!(accessory["inStock"] as bool))
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
                            // Category and Rating
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${accessory["category"]}",
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
                                      "${accessory["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      " (${accessory["reviews"]})",
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
                              "${accessory["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            Text(
                              "${accessory["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Brand and Difficulty
                            Row(
                              children: [
                                Icon(Icons.business, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${accessory["brand"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(accessory["difficulty"]).withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${accessory["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getDifficultyColor(accessory["difficulty"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Install Date
                            if (accessory["isInstalled"] && accessory["installDate"] != null)
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.event, size: 14, color: successColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Installed: ${DateTime.parse(accessory["installDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
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
                                  ...(accessory["features"] as List).take(2).map((feature) => 
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

                            // Time and Installation
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${accessory["timeRequired"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.verified, size: 12, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${accessory["warranty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            // Price Section
                            if ((accessory["installationPrice"] as double) > 0)
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
                                          "\$${(accessory["price"] as double).currency}",
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
                                          "\$${(accessory["installationPrice"] as double).currency}",
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
                                    (accessory["installationPrice"] as double) > 0 ? "Total:" : "Price:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${((accessory["price"] as double) + (accessory["installationPrice"] as double)).currency}",
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
                              child: accessory["isInstalled"]
                                ? QButton(
                                    label: "View Details",
                                    icon: Icons.info,
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing accessory details...");
                                    },
                                  )
                                : (accessory["inStock"] as bool)
                                  ? QButton(
                                      label: "Add to Cart",
                                      icon: Icons.add_shopping_cart,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Added ${accessory["name"]} to cart");
                                      },
                                    )
                                  : QButton(
                                      label: "Notify When Available",
                                      icon: Icons.notifications,
                                      size: bs.sm,
                                      onPressed: () {
                                        si("You'll be notified when this accessory is available");
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

            // Installation Services
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
                      Icon(Icons.build, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Professional Installation",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Get your accessories professionally installed by certified technicians. We offer mobile service and shop installation options.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule Service",
                          icon: Icons.calendar_today,
                          size: bs.md,
                          onPressed: () {
                            ss("Opening installation scheduler...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Find Installer",
                          icon: Icons.location_on,
                          size: bs.md,
                          onPressed: () {
                            ss("Finding nearby installers...");
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
    );
  }
}
