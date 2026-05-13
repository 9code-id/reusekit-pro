import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaPerformanceUpgradesView extends StatefulWidget {
  const CmaPerformanceUpgradesView({super.key});

  @override
  State<CmaPerformanceUpgradesView> createState() => _CmaPerformanceUpgradesViewState();
}

class _CmaPerformanceUpgradesViewState extends State<CmaPerformanceUpgradesView> {
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Engine", "value": "Engine"},
    {"label": "Turbo/Supercharger", "value": "Turbo/Supercharger"},
    {"label": "Exhaust", "value": "Exhaust"},
    {"label": "Intake", "value": "Intake"},
    {"label": "Tuning", "value": "Tuning"},
  ];

  Map<String, dynamic> currentPerformance = {
    "horsepower": 203,
    "torque": 184,
    "zeroToSixty": 8.4,
    "quarterMile": 16.1,
    "topSpeed": 125,
    "dynoDate": "2024-01-15",
    "dynoShop": "Performance Dyno Center"
  };

  List<Map<String, dynamic>> performanceUpgrades = [
    {
      "id": "perf_001",
      "name": "Stage 1 ECU Tune",
      "category": "Tuning",
      "description": "Professional ECU remapping for optimal performance and efficiency",
      "price": 450.00,
      "installationPrice": 150.00,
      "difficulty": "Professional",
      "timeRequired": "2-3 hours",
      "powerGains": {
        "hp": 25,
        "torque": 35,
        "efficiency": 8
      },
      "requirements": ["Stock internals", "Premium fuel recommended"],
      "brand": "Cobb Tuning",
      "warranty": "1 year",
      "rating": 4.9,
      "reviews": 1250,
      "image": "https://picsum.photos/300/200?random=1&keyword=ecu_tune",
      "features": [
        "Increased power and torque",
        "Improved throttle response",
        "Better fuel economy",
        "Removes factory limitations"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "perf_002",
      "name": "Turbocharger Kit",
      "category": "Turbo/Supercharger",
      "description": "Complete turbocharger system with all supporting modifications",
      "price": 3500.00,
      "installationPrice": 1200.00,
      "difficulty": "Professional",
      "timeRequired": "12-16 hours",
      "powerGains": {
        "hp": 120,
        "torque": 150,
        "efficiency": -5
      },
      "requirements": ["Forged internals recommended", "High octane fuel required"],
      "brand": "Garrett Motion",
      "warranty": "2 years",
      "rating": 4.8,
      "reviews": 340,
      "image": "https://picsum.photos/300/200?random=2&keyword=turbocharger",
      "features": [
        "Garrett GT2860RS turbocharger",
        "Front-mount intercooler",
        "High-flow injectors",
        "Boost controller included"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "perf_003",
      "name": "Cold Air Intake System",
      "category": "Intake",
      "description": "High-flow cold air intake with performance filter",
      "price": 320.00,
      "installationPrice": 100.00,
      "difficulty": "Easy",
      "timeRequired": "1-2 hours",
      "powerGains": {
        "hp": 15,
        "torque": 12,
        "efficiency": 3
      },
      "requirements": ["No modifications required"],
      "brand": "K&N Engineering",
      "warranty": "10 years / 1 million miles",
      "rating": 4.7,
      "reviews": 890,
      "image": "https://picsum.photos/300/200?random=3&keyword=cold_air_intake",
      "features": [
        "Washable cotton filter",
        "Increased airflow",
        "Enhanced engine sound",
        "Direct bolt-on installation"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": true
    },
    {
      "id": "perf_004",
      "name": "Cat-Back Exhaust System",
      "category": "Exhaust",
      "description": "Performance exhaust system with aggressive sound",
      "price": 680.00,
      "installationPrice": 200.00,
      "difficulty": "Moderate",
      "timeRequired": "2-4 hours",
      "powerGains": {
        "hp": 18,
        "torque": 22,
        "efficiency": 2
      },
      "requirements": ["Stock catalytic converter"],
      "brand": "Borla Performance",
      "warranty": "Lifetime",
      "rating": 4.8,
      "reviews": 520,
      "image": "https://picsum.photos/300/200?random=4&keyword=exhaust_system",
      "features": [
        "Stainless steel construction",
        "Aggressive exhaust note",
        "Polished tips",
        "Direct bolt-on"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": false,
      "isInstalled": false
    },
    {
      "id": "perf_005",
      "name": "High-Flow Downpipe",
      "category": "Exhaust",
      "description": "High-flow downpipe with sports catalyst",
      "price": 480.00,
      "installationPrice": 300.00,
      "difficulty": "Professional",
      "timeRequired": "3-5 hours",
      "powerGains": {
        "hp": 22,
        "torque": 28,
        "efficiency": 1
      },
      "requirements": ["ECU tune recommended"],
      "brand": "Injen Technology",
      "warranty": "2 years",
      "rating": 4.6,
      "reviews": 180,
      "image": "https://picsum.photos/300/200?random=5&keyword=downpipe",
      "features": [
        "200-cell sports catalyst",
        "Stainless steel construction",
        "Improved exhaust flow",
        "Enhanced turbo spool"
      ],
      "compatibility": "2018-2024 Toyota Camry Turbo",
      "inStock": true,
      "isInstalled": false
    },
    {
      "id": "perf_006",
      "name": "Performance Chip Module",
      "category": "Tuning",
      "description": "Plug-and-play performance module for instant power gains",
      "price": 280.00,
      "installationPrice": 50.00,
      "difficulty": "Easy",
      "timeRequired": "30 minutes",
      "powerGains": {
        "hp": 12,
        "torque": 18,
        "efficiency": 5
      },
      "requirements": ["OBD-II port access"],
      "brand": "Pedal Commander",
      "warranty": "2 years",
      "rating": 4.5,
      "reviews": 750,
      "image": "https://picsum.photos/300/200?random=6&keyword=performance_chip",
      "features": [
        "Plug-and-play installation",
        "Multiple performance modes",
        "Reversible modification",
        "Smartphone app control"
      ],
      "compatibility": "2018-2024 Toyota Camry",
      "inStock": true,
      "isInstalled": false
    }
  ];

  List<Map<String, dynamic>> get filteredUpgrades {
    if (selectedCategory == "All") {
      return performanceUpgrades;
    }
    return performanceUpgrades.where((upgrade) => upgrade["category"] == selectedCategory).toList();
  }

  Map<String, dynamic> get projectedPerformance {
    var installedUpgrades = performanceUpgrades.where((u) => u["isInstalled"]).toList();
    var totalHpGain = installedUpgrades.fold(0, (sum, u) => sum + (u["powerGains"]["hp"] as int));
    var totalTorqueGain = installedUpgrades.fold(0, (sum, u) => sum + (u["powerGains"]["torque"] as int));
    
    return {
      "horsepower": currentPerformance["horsepower"] + totalHpGain,
      "torque": currentPerformance["torque"] + totalTorqueGain,
      "zeroToSixty": currentPerformance["zeroToSixty"] - (totalHpGain * 0.02),
      "quarterMile": currentPerformance["quarterMile"] - (totalHpGain * 0.015),
    };
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
        title: Text("Performance Upgrades"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              si("Opening performance timeline...");
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

            // Current Performance Stats
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
                      Icon(Icons.speed, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Current Performance",
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
                              "${currentPerformance["horsepower"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "HP",
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
                              "${currentPerformance["torque"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "lb-ft",
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
                              "${currentPerformance["zeroToSixty"]}s",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "0-60 mph",
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
                  Text(
                    "Last dyno: ${DateTime.parse(currentPerformance["dynoDate"]).dMMMy} at ${currentPerformance["dynoShop"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Projected Performance
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: successColor.withAlpha(60)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Projected Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                              "${projectedPerformance["horsepower"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "HP (+${projectedPerformance["horsepower"] - currentPerformance["horsepower"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${projectedPerformance["torque"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "lb-ft (+${projectedPerformance["torque"] - currentPerformance["torque"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${projectedPerformance["zeroToSixty"].toStringAsFixed(1)}s",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "0-60 mph",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
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

            // Category Filter
            QCategoryPicker(
              label: "Upgrade Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Performance Upgrades
            Text(
              "Available Upgrades",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 300,
              children: filteredUpgrades.map((upgrade) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: upgrade["isInstalled"] ? Border.all(color: successColor, width: 2) : null,
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
                              "${upgrade["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (upgrade["isInstalled"])
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
                          if (!(upgrade["inStock"] as bool))
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
                                    "${upgrade["category"]}",
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
                                      "${upgrade["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      " (${upgrade["reviews"]})",
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
                              "${upgrade["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            Text(
                              "${upgrade["description"]}",
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
                                  "${upgrade["brand"]}",
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
                                    color: _getDifficultyColor(upgrade["difficulty"]).withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${upgrade["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getDifficultyColor(upgrade["difficulty"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Power Gains
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Performance Gains:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "+${upgrade["powerGains"]["hp"]} HP",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "+${upgrade["powerGains"]["torque"]} TQ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${upgrade["powerGains"]["efficiency"] >= 0 ? '+' : ''}${upgrade["powerGains"]["efficiency"]}% MPG",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: upgrade["powerGains"]["efficiency"] >= 0 ? successColor : warningColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Requirements
                            if ((upgrade["requirements"] as List).isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Requirements:",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    ...(upgrade["requirements"] as List).map((req) => 
                                      Text(
                                        "• $req",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ).toList(),
                                  ],
                                ),
                              ),

                            // Price Information
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
                                        "\$${(upgrade["price"] as double).currency}",
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
                                        "\$${(upgrade["installationPrice"] as double).currency}",
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

                            // Total Cost
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
                                    "Total Cost:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${((upgrade["price"] as double) + (upgrade["installationPrice"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Warranty
                            Row(
                              children: [
                                Icon(Icons.verified, size: 14, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Warranty: ${upgrade["warranty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: upgrade["isInstalled"]
                                ? QButton(
                                    label: "View Details",
                                    icon: Icons.info,
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing upgrade details...");
                                    },
                                  )
                                : (upgrade["inStock"] as bool)
                                  ? QButton(
                                      label: "Add to Cart",
                                      icon: Icons.add_shopping_cart,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Added ${upgrade["name"]} to cart");
                                      },
                                    )
                                  : QButton(
                                      label: "Notify When Available",
                                      icon: Icons.notifications,
                                      size: bs.sm,
                                      onPressed: () {
                                        si("You'll be notified when this upgrade is available");
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

            // Performance Calculator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
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
                      Icon(Icons.calculate, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Performance Calculator",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Plan your performance upgrades and see projected gains before you buy. Our calculator considers compatibility and synergy between modifications.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  QButton(
                    label: "Open Calculator",
                    icon: Icons.launch,
                    size: bs.md,
                    onPressed: () {
                      ss("Opening performance calculator...");
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
