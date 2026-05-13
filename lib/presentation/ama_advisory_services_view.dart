import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaAdvisoryServicesView extends StatefulWidget {
  const AmaAdvisoryServicesView({super.key});

  @override
  State<AmaAdvisoryServicesView> createState() => _AmaAdvisoryServicesViewState();
}

class _AmaAdvisoryServicesViewState extends State<AmaAdvisoryServicesView> {
  List advisoryServices = [
    {
      "id": 1,
      "title": "Crop Planning & Selection",
      "category": "Planning",
      "description": "Expert guidance on crop selection based on soil, climate, and market conditions",
      "provider": "Agricultural Extension Office",
      "duration": "2-3 hours consultation",
      "price": 150.0,
      "rating": 4.8,
      "reviews": 45,
      "availability": "Available",
      "next_slot": "2024-02-10 10:00 AM",
      "expertise": ["Soil Analysis", "Market Research", "Crop Rotation"],
      "color": successColor,
      "icon": Icons.grass,
    },
    {
      "id": 2,
      "title": "Integrated Pest Management",
      "category": "Pest Control",
      "description": "Sustainable pest control strategies to minimize chemical usage",
      "provider": "IPM Specialists Inc.",
      "duration": "Half-day field visit",
      "price": 300.0,
      "rating": 4.9,
      "reviews": 67,
      "availability": "Busy",
      "next_slot": "2024-02-18 08:00 AM",
      "expertise": ["Biological Control", "Pesticide Alternatives", "Monitoring"],
      "color": warningColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 3,
      "title": "Soil Health Assessment",
      "category": "Soil Management",
      "description": "Comprehensive soil testing and fertility management recommendations",
      "provider": "Soil Science Consultants",
      "duration": "Full day assessment",
      "price": 450.0,
      "rating": 4.7,
      "reviews": 32,
      "availability": "Available",
      "next_slot": "2024-02-12 09:00 AM",
      "expertise": ["Soil Testing", "Nutrient Management", "pH Correction"],
      "color": primaryColor,
      "icon": Icons.landscape,
    },
    {
      "id": 4,
      "title": "Water Management Optimization",
      "category": "Irrigation",
      "description": "Efficient irrigation systems design and water conservation strategies",
      "provider": "Irrigation Solutions Ltd.",
      "duration": "2-day consultation",
      "price": 600.0,
      "rating": 4.6,
      "reviews": 28,
      "availability": "Limited",
      "next_slot": "2024-02-20 07:00 AM",
      "expertise": ["Drip Systems", "Water Conservation", "Automation"],
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 5,
      "title": "Organic Certification Support",
      "category": "Certification",
      "description": "Complete guidance through organic certification process",
      "provider": "Organic Advisory Group",
      "duration": "Multi-session program",
      "price": 800.0,
      "rating": 4.9,
      "reviews": 51,
      "availability": "Available",
      "next_slot": "2024-02-15 10:00 AM",
      "expertise": ["USDA Organic", "Documentation", "Compliance"],
      "color": secondaryColor,
      "icon": Icons.eco,
    },
    {
      "id": 6,
      "title": "Financial Planning & Analysis",
      "category": "Finance",
      "description": "Farm profitability analysis and financial planning services",
      "provider": "Agri-Finance Advisors",
      "duration": "3-hour consultation",
      "price": 250.0,
      "rating": 4.5,
      "reviews": 23,
      "availability": "Available",
      "next_slot": "2024-02-14 02:00 PM",
      "expertise": ["Cost Analysis", "ROI Calculation", "Budgeting"],
      "color": warningColor,
      "icon": Icons.account_balance,
    },
  ];

  String selectedCategory = "All";
  String selectedAvailability = "All";
  List<String> categories = ["All", "Planning", "Pest Control", "Soil Management", "Irrigation", "Certification", "Finance"];
  List<String> availabilities = ["All", "Available", "Busy", "Limited"];

  @override
  Widget build(BuildContext context) {
    List filteredServices = advisoryServices.where((service) {
      bool categoryMatch = selectedCategory == "All" || service["category"] == selectedCategory;
      bool availabilityMatch = selectedAvailability == "All" || service["availability"] == selectedAvailability;
      return categoryMatch && availabilityMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Advisory Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              // View scheduled consultations
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Services Overview
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expert Agricultural Advisory",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${advisoryServices.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Services Available",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                              "${advisoryServices.where((s) => s["availability"] == "Available").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Available Now",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Book Consultation",
                    icon: Icons.calendar_today,
                    size: bs.sm,
                    onPressed: () {
                      // Book consultation
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Emergency Support",
                    icon: Icons.emergency,
                    size: bs.sm,
                    onPressed: () {
                      // Emergency agricultural support
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((cat) => {
                      "label": cat,
                      "value": cat,
                    }).toList(),
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
                    label: "Availability",
                    items: availabilities.map((avail) => {
                      "label": avail,
                      "value": avail,
                    }).toList(),
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Advisory Services List
            Text(
              "Available Services (${filteredServices.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: service["color"] as Color,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (service["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                service["icon"] as IconData,
                                color: service["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${service["provider"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getAvailabilityColor(service["availability"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${service["availability"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getAvailabilityColor(service["availability"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Description
                        Text(
                          "${service["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Service Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${service["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "\$${(service["price"] as double).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${service["rating"]} (${service["reviews"]} reviews)",
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
                        
                        SizedBox(height: spSm),
                        
                        // Next Available Slot
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Next Available: ${service["next_slot"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Expertise Tags
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expertise Areas:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (service["expertise"] as List).map((skill) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (service["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$skill",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: service["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Book Now",
                                size: bs.sm,
                                onPressed: () {
                                  // Book consultation
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Details",
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () {
                                // View service details
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.message,
                              size: bs.sm,
                              onPressed: () {
                                // Contact advisor
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Limited":
        return warningColor;
      case "Busy":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
