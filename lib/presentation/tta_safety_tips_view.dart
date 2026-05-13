import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaSafetyTipsView extends StatefulWidget {
  const TtaSafetyTipsView({super.key});

  @override
  State<TtaSafetyTipsView> createState() => _TtaSafetyTipsViewState();
}

class _TtaSafetyTipsViewState extends State<TtaSafetyTipsView> {
  String selectedCategory = "general";
  String selectedCountry = "";

  final List<Map<String, dynamic>> categories = [
    {"label": "General Safety", "value": "general", "icon": Icons.security},
    {"label": "Health & Medical", "value": "health", "icon": Icons.health_and_safety},
    {"label": "Transportation", "value": "transport", "icon": Icons.directions_car},
    {"label": "Money & Valuables", "value": "money", "icon": Icons.account_balance_wallet},
    {"label": "Natural Disasters", "value": "disasters", "icon": Icons.warning},
    {"label": "Crime Prevention", "value": "crime", "icon": Icons.shield},
    {"label": "Emergency Contacts", "value": "emergency", "icon": Icons.emergency},
    {"label": "Communication", "value": "communication", "icon": Icons.phone},
  ];

  final List<Map<String, dynamic>> countries = [
    {"label": "All Countries", "value": ""},
    {"label": "United States", "value": "us"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "France", "value": "france"},
    {"label": "Germany", "value": "germany"},
    {"label": "Japan", "value": "japan"},
    {"label": "Thailand", "value": "thailand"},
    {"label": "India", "value": "india"},
    {"label": "Brazil", "value": "brazil"},
  ];

  final Map<String, List<Map<String, dynamic>>> safetyTips = {
    "general": [
      {
        "title": "Research Your Destination",
        "description": "Learn about local laws, customs, and current events before traveling",
        "importance": "high",
        "icon": Icons.search,
        "details": [
          "Check government travel advisories",
          "Research local laws and regulations",
          "Learn about cultural norms and customs",
          "Stay updated on current events and political situation"
        ]
      },
      {
        "title": "Keep Important Documents Safe",
        "description": "Store copies of important documents in multiple locations",
        "importance": "high",
        "icon": Icons.description,
        "details": [
          "Make digital and physical copies of passport, visa, and ID",
          "Store copies separately from originals",
          "Leave copies with trusted contacts at home",
          "Use secure cloud storage for digital copies"
        ]
      },
      {
        "title": "Share Your Itinerary",
        "description": "Keep someone informed about your travel plans and check-in regularly",
        "importance": "medium",
        "icon": Icons.share,
        "details": [
          "Share detailed itinerary with family/friends",
          "Provide accommodation details and contact information",
          "Set regular check-in schedules",
          "Update contacts if plans change"
        ]
      },
      {
        "title": "Trust Your Instincts",
        "description": "If something feels wrong, remove yourself from the situation",
        "importance": "high",
        "icon": Icons.psychology,
        "details": [
          "Listen to your gut feelings about people and situations",
          "Avoid areas that seem unsafe or unwelcoming",
          "Don't ignore warning signs",
          "Have an exit strategy for uncomfortable situations"
        ]
      },
    ],
    "health": [
      {
        "title": "Get Necessary Vaccinations",
        "description": "Consult with a travel health clinic 4-6 weeks before departure",
        "importance": "high",
        "icon": Icons.vaccines,
        "details": [
          "Check CDC recommendations for your destination",
          "Schedule appointments well in advance",
          "Carry vaccination certificates",
          "Consider malaria prophylaxis if needed"
        ]
      },
      {
        "title": "Pack a Medical Kit",
        "description": "Bring essential medications and first aid supplies",
        "importance": "medium",
        "icon": Icons.medical_services,
        "details": [
          "Include prescription medications with extra supply",
          "Pack basic first aid items",
          "Bring any necessary medical devices",
          "Include emergency contact and medical information"
        ]
      },
      {
        "title": "Stay Hydrated and Eat Safely",
        "description": "Be cautious about food and water sources to avoid illness",
        "importance": "medium",
        "icon": Icons.restaurant,
        "details": [
          "Drink bottled or purified water",
          "Avoid ice in drinks unless from safe sources",
          "Choose well-cooked foods from reputable establishments",
          "Avoid raw or undercooked foods in high-risk areas"
        ]
      },
    ],
    "transport": [
      {
        "title": "Use Reputable Transportation",
        "description": "Choose licensed and well-reviewed transportation options",
        "importance": "high",
        "icon": Icons.directions_bus,
        "details": [
          "Use official taxis or ride-sharing apps",
          "Research public transportation safety",
          "Avoid unlicensed or informal transport",
          "Keep transportation receipts and details"
        ]
      },
      {
        "title": "Wear Seatbelts and Helmets",
        "description": "Always use safety equipment even if not required locally",
        "importance": "high",
        "icon": Icons.safety_check,
        "details": [
          "Wear seatbelts in all vehicles",
          "Use helmets when riding motorcycles or bicycles",
          "Choose vehicles with working safety equipment",
          "Don't compromise on safety for convenience"
        ]
      },
    ],
    "money": [
      {
        "title": "Use Multiple Payment Methods",
        "description": "Diversify your payment options and notify banks of travel",
        "importance": "high",
        "icon": Icons.payment,
        "details": [
          "Bring cash, cards, and backup payment methods",
          "Notify banks of travel plans to avoid card blocks",
          "Use ATMs at banks rather than standalone machines",
          "Keep emergency cash in different locations"
        ]
      },
      {
        "title": "Avoid Displaying Wealth",
        "description": "Don't make yourself a target by showing expensive items",
        "importance": "medium",
        "icon": Icons.visibility_off,
        "details": [
          "Keep expensive jewelry and electronics out of sight",
          "Use modest bags and clothing",
          "Don't flash large amounts of cash",
          "Be discreet when using expensive devices"
        ]
      },
    ],
    "disasters": [
      {
        "title": "Know Natural Disaster Risks",
        "description": "Research potential natural disasters for your destination",
        "importance": "high",
        "icon": Icons.nature,
        "details": [
          "Learn about earthquake, hurricane, or flood risks",
          "Know evacuation routes and procedures",
          "Understand local warning systems",
          "Have emergency supplies and plans ready"
        ]
      },
    ],
    "crime": [
      {
        "title": "Be Aware of Common Scams",
        "description": "Learn about tourist-targeted scams in your destination",
        "importance": "medium",
        "icon": Icons.report_problem,
        "details": [
          "Research common tourist scams",
          "Be cautious of overly friendly strangers",
          "Don't accept food or drinks from strangers",
          "Verify any urgent requests or emergencies"
        ]
      },
      {
        "title": "Stay in Well-Lit, Populated Areas",
        "description": "Avoid isolated or poorly lit areas, especially at night",
        "importance": "high",
        "icon": Icons.lightbulb,
        "details": [
          "Plan routes through safe, well-traveled areas",
          "Avoid shortcuts through unfamiliar areas",
          "Stay with groups when possible",
          "Return to accommodation before late hours"
        ]
      },
    ],
    "emergency": [
      {
        "title": "Know Emergency Numbers",
        "description": "Save local emergency contact numbers in your phone",
        "importance": "high",
        "icon": Icons.emergency,
        "details": [
          "Learn local emergency service numbers",
          "Save embassy or consulate contact information",
          "Know how to contact local police, medical, and fire services",
          "Keep emergency contacts easily accessible"
        ]
      },
    ],
    "communication": [
      {
        "title": "Ensure Communication Access",
        "description": "Have multiple ways to communicate and access the internet",
        "importance": "medium",
        "icon": Icons.signal_cellular_alt,
        "details": [
          "Check international roaming plans",
          "Consider local SIM cards or international plans",
          "Download offline maps and translation apps",
          "Know how to access WiFi safely"
        ]
      },
    ],
  };

  List<Map<String, dynamic>> get filteredTips {
    return safetyTips[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Safety Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Save/bookmark tips
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stay Safe While Traveling",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Essential safety tips and guidelines for travelers",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Country Filter
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Country/Region",
                    items: countries,
                    value: selectedCountry,
                    onChanged: (value, label) {
                      selectedCountry = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.location_on,
                  size: bs.sm,
                  onPressed: () {
                    // Auto-detect location
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Categories
            Text(
              "Safety Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"] as String;
                    setState(() {});
                  },
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected ? Colors.white : primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Safety Tips List
            Text(
              "${categories.firstWhere((c) => c["value"] == selectedCategory)["label"]} Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: filteredTips.map((tip) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: _buildTipCard(tip),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Emergency Contacts Quick Access
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Contacts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Keep these numbers easily accessible at all times:",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Local Emergency",
                          size: bs.sm,
                          onPressed: () {
                            // Call local emergency
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Embassy",
                          size: bs.sm,
                          onPressed: () {
                            // Call embassy
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

  Widget _buildTipCard(Map<String, dynamic> tip) {
    final importance = tip["importance"] as String;
    Color importanceColor = importance == "high" 
        ? dangerColor 
        : importance == "medium" 
        ? warningColor 
        : infoColor;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: importanceColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            tip["icon"] as IconData,
            color: importanceColor,
            size: 24,
          ),
        ),
        title: Text(
          "${tip["title"]}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        subtitle: Text(
          "${tip["description"]}",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: importanceColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                importance.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: spSm),
            Icon(Icons.expand_more),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detailed Guidelines:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...((tip["details"] as List).map((detail) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$detail",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      icon: Icons.bookmark,
                      size: bs.sm,
                      onPressed: () {
                        // Save tip
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        // Share tip
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
  }
}
