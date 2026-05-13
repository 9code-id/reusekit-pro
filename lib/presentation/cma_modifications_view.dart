import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaModificationsView extends StatefulWidget {
  const CmaModificationsView({super.key});

  @override
  State<CmaModificationsView> createState() => _CmaModificationsViewState();
}

class _CmaModificationsViewState extends State<CmaModificationsView> {
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Installed", "value": "Installed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Planned", "value": "Planned"},
  ];

  List<Map<String, dynamic>> modifications = [
    {
      "id": "mod_001",
      "name": "Turbo Upgrade Kit",
      "category": "Engine",
      "status": "Installed",
      "installDate": "2024-11-15",
      "installer": "Performance Plus Auto",
      "cost": 2850.00,
      "laborCost": 650.00,
      "description": "Garrett GT2860RS turbocharger with supporting modifications",
      "powerGain": "+85 HP / +110 TQ",
      "warranty": "2 years / 24,000 miles",
      "nextService": "2025-05-15",
      "images": [
        "https://picsum.photos/300/200?random=1&keyword=turbo",
        "https://picsum.photos/300/200?random=2&keyword=engine"
      ],
      "components": [
        "Garrett GT2860RS Turbocharger",
        "Upgraded Intercooler",
        "High-flow Injectors",
        "Performance ECU Tune",
        "Reinforced Engine Internals"
      ],
      "beforeAfter": {
        "beforeHP": 203,
        "afterHP": 288,
        "beforeTorque": 184,
        "afterTorque": 294
      },
      "documentation": [
        {"name": "Installation Certificate", "type": "PDF"},
        {"name": "Dyno Results", "type": "PDF"},
        {"name": "Warranty Information", "type": "PDF"}
      ]
    },
    {
      "id": "mod_002",
      "name": "Coilover Suspension",
      "category": "Suspension",
      "status": "Installed",
      "installDate": "2024-10-20",
      "installer": "Suspension Specialists",
      "cost": 1200.00,
      "laborCost": 400.00,
      "description": "Adjustable coilover suspension system with camber plates",
      "powerGain": null,
      "warranty": "3 years",
      "nextService": "2025-04-20",
      "images": [
        "https://picsum.photos/300/200?random=3&keyword=suspension",
        "https://picsum.photos/300/200?random=4&keyword=coilover"
      ],
      "components": [
        "BC Racing BR Series Coilovers",
        "Front Camber Plates",
        "Adjustable Rear Links",
        "Performance Alignment"
      ],
      "beforeAfter": {
        "beforeHeight": "Stock height",
        "afterHeight": "Lowered 2.5 inches",
        "handling": "Significantly improved"
      },
      "documentation": [
        {"name": "Installation Guide", "type": "PDF"},
        {"name": "Alignment Specs", "type": "PDF"}
      ]
    },
    {
      "id": "mod_003",
      "name": "Big Brake Kit",
      "category": "Brakes",
      "status": "Pending",
      "installDate": null,
      "installer": "Brake Masters Pro",
      "cost": 1800.00,
      "laborCost": 350.00,
      "description": "6-piston front brake kit with slotted rotors",
      "powerGain": null,
      "warranty": "2 years",
      "nextService": null,
      "images": [
        "https://picsum.photos/300/200?random=5&keyword=brakes",
        "https://picsum.photos/300/200?random=6&keyword=rotors"
      ],
      "components": [
        "Brembo 6-piston Calipers",
        "370mm Slotted Rotors",
        "Performance Brake Pads",
        "Stainless Steel Brake Lines"
      ],
      "beforeAfter": null,
      "documentation": [],
      "expectedDelivery": "2025-01-15",
      "orderStatus": "Parts on order"
    },
    {
      "id": "mod_004",
      "name": "Cat-Back Exhaust",
      "category": "Exhaust",
      "status": "Installed",
      "installDate": "2024-09-10",
      "installer": "Exhaust Experts",
      "cost": 680.00,
      "laborCost": 200.00,
      "description": "Stainless steel cat-back exhaust system",
      "powerGain": "+12 HP / +15 TQ",
      "warranty": "Lifetime",
      "nextService": null,
      "images": [
        "https://picsum.photos/300/200?random=7&keyword=exhaust",
        "https://picsum.photos/300/200?random=8&keyword=muffler"
      ],
      "components": [
        "Borla ATAK Cat-Back System",
        "Stainless Steel Construction",
        "Polished Tips"
      ],
      "beforeAfter": {
        "beforeSound": "Stock quiet",
        "afterSound": "Aggressive sporty tone",
        "beforeHP": 203,
        "afterHP": 215
      },
      "documentation": [
        {"name": "Installation Receipt", "type": "PDF"},
        {"name": "Warranty Card", "type": "PDF"}
      ]
    },
    {
      "id": "mod_005",
      "name": "Carbon Fiber Aero Kit",
      "category": "Exterior",
      "status": "Planned",
      "installDate": null,
      "installer": "TBD",
      "cost": 2200.00,
      "laborCost": 500.00,
      "description": "Complete carbon fiber aerodynamic package",
      "powerGain": null,
      "warranty": "1 year",
      "nextService": null,
      "images": [
        "https://picsum.photos/300/200?random=9&keyword=carbon_fiber",
        "https://picsum.photos/300/200?random=10&keyword=aero"
      ],
      "components": [
        "Front Splitter",
        "Side Skirts",
        "Rear Diffuser",
        "Trunk Spoiler"
      ],
      "beforeAfter": null,
      "documentation": [],
      "plannedDate": "2025-03-01",
      "notes": "Waiting for tax refund"
    }
  ];

  List<Map<String, dynamic>> get filteredModifications {
    if (selectedStatus == "All") {
      return modifications;
    }
    return modifications.where((mod) => mod["status"] == selectedStatus).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Installed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Planned":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Engine":
        return dangerColor;
      case "Suspension":
        return warningColor;
      case "Brakes":
        return infoColor;
      case "Exhaust":
        return successColor;
      case "Exterior":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Modifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Opening add modification form...");
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

            // Status Filter
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Modifications Summary
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
                        "Modifications Summary",
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
                              "${modifications.where((m) => m["status"] == "Installed").length}",
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
                              "${modifications.where((m) => m["status"] == "Pending").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Pending",
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
                              "\$${((modifications.where((m) => m["status"] == "Installed").map((m) => (m["cost"] as double) + (m["laborCost"] as double)).fold(0.0, (a, b) => a + b))).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Invested",
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

            // Modifications List
            Text(
              "Modifications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredModifications.map((mod) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(mod["status"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(mod["category"]).withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${mod["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getCategoryColor(mod["category"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(mod["status"]).withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${mod["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(mod["status"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        if (mod["installDate"] != null)
                          Text(
                            "${DateTime.parse(mod["installDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),

                    Text(
                      "${mod["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Text(
                      "${mod["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    // Images
                    if (mod["images"] != null && (mod["images"] as List).isNotEmpty)
                      QHorizontalScroll(
                        children: (mod["images"] as List).map((image) =>
                          Container(
                            width: 120,
                            height: 80,
                            margin: EdgeInsets.only(right: spSm),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "$image",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),

                    // Power Gain
                    if (mod["powerGain"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flash_on, color: successColor, size: 20),
                            SizedBox(width: spSm),
                            Text(
                              "Power Gain: ${mod["powerGain"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Before/After Stats
                    if (mod["beforeAfter"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Before/After Comparison",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(mod["beforeAfter"] as Map<String, dynamic>).entries.map((entry) =>
                              Row(
                                children: [
                                  Text(
                                    "${entry.key.replaceAll(RegExp(r'([A-Z])'), ' \$1').trim()}:",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${entry.value}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ).toList(),
                          ],
                        ),
                      ),

                    // Cost Information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Parts Cost",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(mod["cost"] as double).currency}",
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
                                "Labor Cost",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(mod["laborCost"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
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
                                "Total",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((mod["cost"] as double) + (mod["laborCost"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(mod["status"]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Installer Info
                    if (mod["installer"] != null && mod["installer"] != "TBD")
                      Row(
                        children: [
                          Icon(Icons.build, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "Installed by: ${mod["installer"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                    // Warranty Info
                    if (mod["warranty"] != null)
                      Row(
                        children: [
                          Icon(Icons.verified, size: 14, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Warranty: ${mod["warranty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                    // Next Service
                    if (mod["nextService"] != null)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "Next Service: ${DateTime.parse(mod["nextService"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Pending/Planned Info
                    if (mod["status"] == "Pending" && mod["expectedDelivery"] != null)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.local_shipping, size: 14, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "Expected: ${DateTime.parse(mod["expectedDelivery"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (mod["status"] == "Planned" && mod["plannedDate"] != null)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.event, size: 14, color: infoColor),
                            SizedBox(width: spXs),
                            Text(
                              "Planned: ${DateTime.parse(mod["plannedDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            icon: Icons.info,
                            size: bs.sm,
                            onPressed: () {
                              si("Viewing ${mod["name"]} details...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (mod["status"] == "Installed" && (mod["documentation"] as List).isNotEmpty)
                          Expanded(
                            child: QButton(
                              label: "Documents",
                              icon: Icons.folder,
                              size: bs.sm,
                              onPressed: () {
                                si("Opening documentation...");
                              },
                            ),
                          ),
                        if (mod["status"] == "Planned")
                          Expanded(
                            child: QButton(
                              label: "Schedule",
                              icon: Icons.calendar_today,
                              size: bs.sm,
                              onPressed: () {
                                ss("Opening installation scheduler...");
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add Modification Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Modification",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  ss("Opening modification planner...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
