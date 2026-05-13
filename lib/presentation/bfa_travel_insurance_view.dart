import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTravelInsuranceView extends StatefulWidget {
  const BfaTravelInsuranceView({super.key});

  @override
  State<BfaTravelInsuranceView> createState() => _BfaTravelInsuranceViewState();
}

class _BfaTravelInsuranceViewState extends State<BfaTravelInsuranceView> {
  int currentTab = 0;
  String selectedPlan = "comprehensive";
  String tripType = "international";
  int travelers = 1;
  int tripDuration = 7;
  String destination = "Europe";
  DateTime departureDate = DateTime.now().add(Duration(days: 30));
  DateTime returnDate = DateTime.now().add(Duration(days: 37));
  bool hasPreExisting = false;
  String ageGroup = "adult";

  List<Map<String, dynamic>> travelPlans = [
    {
      "id": "basic",
      "name": "Basic Protection",
      "description": "Essential coverage for budget travelers",
      "premium": 45.0,
      "icon": Icons.shield_outlined,
      "color": Colors.blue,
      "maxCoverage": 50000,
      "features": [
        "Emergency medical coverage",
        "Trip cancellation (50%)",
        "Baggage protection",
        "24/7 assistance"
      ],
      "medicalCoverage": 50000,
      "tripCancellation": 25000,
      "baggageCoverage": 1000
    },
    {
      "id": "standard",
      "name": "Standard Coverage",
      "description": "Balanced protection for most travelers",
      "premium": 75.0,
      "icon": Icons.security,
      "color": Colors.green,
      "maxCoverage": 100000,
      "features": [
        "Enhanced medical coverage",
        "Full trip cancellation",
        "Baggage delay compensation",
        "Travel delay coverage",
        "Emergency evacuation"
      ],
      "medicalCoverage": 100000,
      "tripCancellation": 50000,
      "baggageCoverage": 2500
    },
    {
      "id": "comprehensive",
      "name": "Comprehensive Plus",
      "description": "Maximum protection for worry-free travel",
      "premium": 120.0,
      "icon": Icons.star,
      "color": Colors.purple,
      "maxCoverage": 250000,
      "features": [
        "Premium medical coverage",
        "Cancel for any reason",
        "Adventure sports coverage",
        "Rental car protection",
        "Pre-existing conditions",
        "Business equipment coverage"
      ],
      "medicalCoverage": 250000,
      "tripCancellation": 100000,
      "baggageCoverage": 5000
    },
  ];

  List<Map<String, dynamic>> destinations = [
    {"name": "Europe", "riskLevel": "Low", "color": Colors.green},
    {"name": "Asia", "riskLevel": "Medium", "color": Colors.orange},
    {"name": "North America", "riskLevel": "Low", "color": Colors.green},
    {"name": "South America", "riskLevel": "Medium", "color": Colors.orange},
    {"name": "Africa", "riskLevel": "High", "color": Colors.red},
    {"name": "Oceania", "riskLevel": "Low", "color": Colors.green},
  ];

  List<Map<String, dynamic>> coverageDetails = [
    {
      "title": "Medical Emergency",
      "icon": Icons.local_hospital,
      "description": "Coverage for unexpected medical expenses abroad",
      "scenarios": [
        "Emergency room visits",
        "Hospital stays",
        "Prescription medications",
        "Emergency dental care"
      ]
    },
    {
      "title": "Trip Cancellation",
      "icon": Icons.cancel,
      "description": "Reimbursement for non-refundable trip costs",
      "scenarios": [
        "Illness or injury",
        "Family emergency",
        "Natural disasters",
        "Flight cancellations"
      ]
    },
    {
      "title": "Baggage Protection",
      "icon": Icons.luggage,
      "description": "Coverage for lost, stolen, or damaged luggage",
      "scenarios": [
        "Lost baggage",
        "Delayed baggage",
        "Stolen personal items",
        "Damaged electronics"
      ]
    },
    {
      "title": "Travel Delays",
      "icon": Icons.schedule,
      "description": "Compensation for unexpected travel delays",
      "scenarios": [
        "Flight delays over 6 hours",
        "Missed connections",
        "Weather-related delays",
        "Mechanical issues"
      ]
    },
  ];

  Map<String, dynamic> get selectedPlanData {
    return travelPlans.firstWhere((plan) => plan["id"] == selectedPlan);
  }

  double calculatePremium() {
    double basePremium = selectedPlanData["premium"] as double;
    
    // Trip duration factor
    basePremium *= (tripDuration / 7);
    
    // Number of travelers
    basePremium *= travelers;
    
    // Destination risk factor
    switch (destination) {
      case "Africa":
        basePremium *= 1.8;
        break;
      case "Asia":
      case "South America":
        basePremium *= 1.3;
        break;
      case "Europe":
      case "North America":
      case "Oceania":
        basePremium *= 1.0;
        break;
    }
    
    // Trip type factor
    if (tripType == "international") {
      basePremium *= 1.2;
    }
    
    // Age factor
    if (ageGroup == "senior") {
      basePremium *= 1.4;
    } else if (ageGroup == "child") {
      basePremium *= 0.8;
    }
    
    // Pre-existing conditions
    if (hasPreExisting) {
      basePremium *= 1.3;
    }
    
    return basePremium;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Travel Insurance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Plans", icon: Icon(Icons.card_travel)),
        Tab(text: "Coverage", icon: Icon(Icons.shield)),
        Tab(text: "Destinations", icon: Icon(Icons.public)),
      ],
      tabChildren: [
        // Plans Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Travel with",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Peace of Mind",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Comprehensive travel insurance for adventures near and far",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.flight_takeoff,
                      size: 60,
                      color: Colors.white.withAlpha(180),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Trip Details Form
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trip Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Trip Type
                    Text(
                      "Trip Type",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              tripType = "domestic";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: tripType == "domestic" ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: tripType == "domestic" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                "Domestic",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tripType == "domestic" ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              tripType = "international";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: tripType == "international" ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: tripType == "international" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                "International",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tripType == "international" ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Destination & Duration
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Destination",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: disabledOutlineBorderColor),
                                ),
                                child: Text(
                                  destination,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Duration: $tripDuration days",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Slider(
                                value: tripDuration.toDouble(),
                                min: 1,
                                max: 365,
                                divisions: 50,
                                label: "$tripDuration days",
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  tripDuration = value.toInt();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Travelers Count
                    Text(
                      "Number of Travelers: $travelers",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Slider(
                      value: travelers.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: "$travelers",
                      activeColor: primaryColor,
                      onChanged: (value) {
                        travelers = value.toInt();
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Pre-existing Conditions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pre-existing medical conditions?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: hasPreExisting,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            hasPreExisting = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Travel Plans
              Text(
                "Choose Your Protection Level",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...travelPlans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedPlan = plan["id"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (plan["color"] as Color).withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? plan["color"] as Color : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: plan["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  plan["icon"] as IconData,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${plan["description"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Up to \$${((plan["maxCoverage"] as int).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: plan["color"] as Color,
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: plan["color"] as Color,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),

                          // Coverage Breakdown
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Medical",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["medicalCoverage"] as int).toDouble()).currency}",
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
                                  children: [
                                    Text(
                                      "Trip Cancel",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["tripCancellation"] as int).toDouble()).currency}",
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
                                  children: [
                                    Text(
                                      "Baggage",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["baggageCoverage"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Features
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (plan["features"] as List).map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (plan["color"] as Color).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: (plan["color"] as Color).withAlpha(100),
                                  ),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: plan["color"] as Color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Premium Result
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Premium for Your Trip",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((calculatePremium()).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "For $travelers traveler(s) • $tripDuration days • ${selectedPlanData["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Purchase Coverage",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Coverage Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coverage Details",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Understanding what's covered in your travel insurance",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Coverage Categories
              ...coverageDetails.map((coverage) {
                return Container(
                  margin: EdgeInsets.only(bottom: spLg),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              coverage["icon"] as IconData,
                              color: primaryColor,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${coverage["title"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${coverage["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "What's Covered:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      
                      ...(coverage["scenarios"] as List).map((scenario) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "$scenario",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),

              // Emergency Contacts
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Emergency Assistance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "24/7 Emergency Hotline: +1-800-EMERGENCY",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Available worldwide for medical emergencies, travel assistance, and claims support",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Destinations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Destination Guide",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Travel risk levels and coverage recommendations",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Current Selection
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Destination",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                          Text(
                            destination,
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${destinations.firstWhere((d) => d["name"] == destination)["riskLevel"]} Risk",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Destination List
              Text(
                "All Destinations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...destinations.map((dest) {
                final isSelected = destination == dest["name"];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: GestureDetector(
                    onTap: () {
                      destination = dest["name"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (dest["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.public,
                              color: dest["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${dest["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Travel risk level: ${dest["riskLevel"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: (dest["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: (dest["color"] as Color).withAlpha(100),
                              ),
                            ),
                            child: Text(
                              "${dest["riskLevel"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dest["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isSelected) ...[
                            SizedBox(width: spSm),
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Risk Level Guide
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Risk Level Guide",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...[
                      {"level": "Low Risk", "color": Colors.green, "description": "Stable political environment, good healthcare system"},
                      {"level": "Medium Risk", "color": Colors.orange, "description": "Some political instability or healthcare limitations"},
                      {"level": "High Risk", "color": Colors.red, "description": "Political unrest, limited healthcare, travel advisories"}
                    ].map((risk) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: risk["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${risk["level"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${risk["description"]}",
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
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
