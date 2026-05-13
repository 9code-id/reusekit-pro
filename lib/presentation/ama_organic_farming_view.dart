import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaOrganicFarmingView extends StatefulWidget {
  const AmaOrganicFarmingView({super.key});

  @override
  State<AmaOrganicFarmingView> createState() => _AmaOrganicFarmingViewState();
}

class _AmaOrganicFarmingViewState extends State<AmaOrganicFarmingView> {
  int selectedTab = 0;
  
  List<Map<String, dynamic>> organicPrinciples = [
    {
      "title": "Soil Health",
      "description": "Build and maintain healthy soil through natural composting and crop rotation",
      "icon": Icons.agriculture,
      "color": primaryColor,
      "progress": 85,
      "practices": [
        "Composting program",
        "Cover crop rotation",
        "No synthetic fertilizers",
        "Beneficial microorganisms"
      ],
    },
    {
      "title": "Biodiversity",
      "description": "Encourage diverse ecosystems to support natural pest control and pollination",
      "icon": Icons.pets,
      "color": successColor,
      "progress": 92,
      "practices": [
        "Native plant strips",
        "Pollinator habitats",
        "Beneficial insect refuges",
        "Diverse crop varieties"
      ],
    },
    {
      "title": "Natural Pest Control",
      "description": "Use biological and mechanical methods instead of synthetic pesticides",
      "icon": Icons.bug_report_outlined,
      "color": warningColor,
      "progress": 78,
      "practices": [
        "Integrated pest management",
        "Beneficial insects",
        "Companion planting",
        "Physical barriers"
      ],
    },
    {
      "title": "Water Conservation",
      "description": "Protect water resources through efficient and sustainable water management",
      "icon": Icons.water_drop,
      "color": infoColor,
      "progress": 87,
      "practices": [
        "Drip irrigation systems",
        "Rainwater harvesting",
        "Mulching for retention",
        "Native drought-resistant crops"
      ],
    },
  ];
  
  List<Map<String, dynamic>> organicCrops = [
    {
      "name": "Organic Tomatoes",
      "variety": "Heritage Cherokee Purple",
      "planted": "2024-03-15",
      "expectedHarvest": "2024-07-20",
      "status": "Growing",
      "health": 95,
      "yield": "2.5 tons/acre",
      "image": "https://picsum.photos/150/120?random=1&keyword=tomatoes",
      "certificationStatus": "Certified",
      "price": 8.50,
    },
    {
      "name": "Organic Lettuce",
      "variety": "Buttercrunch",
      "planted": "2024-04-01",
      "expectedHarvest": "2024-06-15",
      "status": "Ready to Harvest",
      "health": 98,
      "yield": "1.8 tons/acre",
      "image": "https://picsum.photos/150/120?random=2&keyword=lettuce",
      "certificationStatus": "Certified",
      "price": 12.00,
    },
    {
      "name": "Organic Carrots",
      "variety": "Nantes",
      "planted": "2024-02-20",
      "expectedHarvest": "2024-06-25",
      "status": "Harvesting",
      "health": 93,
      "yield": "3.2 tons/acre",
      "image": "https://picsum.photos/150/120?random=3&keyword=carrots",
      "certificationStatus": "In Progress",
      "price": 6.75,
    },
    {
      "name": "Organic Herbs",
      "variety": "Mixed Culinary",
      "planted": "2024-03-01",
      "expectedHarvest": "2024-06-01",
      "status": "Continuous Harvest",
      "health": 89,
      "yield": "0.8 tons/acre",
      "image": "https://picsum.photos/150/120?random=4&keyword=herbs",
      "certificationStatus": "Certified",
      "price": 25.00,
    },
  ];
  
  List<Map<String, dynamic>> certificationSteps = [
    {
      "step": 1,
      "title": "Application Submission",
      "description": "Submit initial application with farm details and intended practices",
      "status": "Completed",
      "completedDate": "2023-01-15",
    },
    {
      "step": 2,
      "title": "Transition Period",
      "description": "36-month transition period without synthetic chemicals",
      "status": "Completed",
      "completedDate": "2024-01-15",
    },
    {
      "step": 3,
      "title": "Documentation Review",
      "description": "Detailed review of farming practices and record keeping",
      "status": "Completed",
      "completedDate": "2024-02-20",
    },
    {
      "step": 4,
      "title": "On-Site Inspection",
      "description": "Comprehensive farm inspection by certified inspector",
      "status": "Completed",
      "completedDate": "2024-03-10",
    },
    {
      "step": 5,
      "title": "Certification Approval",
      "description": "Final approval and certificate issuance",
      "status": "Completed",
      "completedDate": "2024-04-01",
    },
    {
      "step": 6,
      "title": "Annual Renewal",
      "description": "Yearly renewal and continued compliance monitoring",
      "status": "Active",
      "completedDate": "Ongoing",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready to Harvest":
        return successColor;
      case "Growing":
        return primaryColor;
      case "Harvesting":
        return warningColor;
      case "Continuous Harvest":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCertificationColor(String status) {
    switch (status) {
      case "Certified":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organic Farming"),
        actions: [
          QButton(
            icon: Icons.verified,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Organic Farming Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Certified Organic Farm",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Growing healthy food while protecting the environment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "100%",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Organic Certified",
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
                              "3",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Years Certified",
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
                              "245",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Acres Organic",
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
            
            // Organic Principles
            Text(
              "Organic Farming Principles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: organicPrinciples.map((principle) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (principle["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              principle["icon"] as IconData,
                              size: 24,
                              color: principle["color"] as Color,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${principle["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${principle["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      
                      Text(
                        "Implementation: ${principle["progress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: principle["color"] as Color,
                        ),
                      ),
                      
                      LinearProgressIndicator(
                        value: (principle["progress"] as int) / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(principle["color"] as Color),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (principle["practices"] as List<String>).map((practice) {
                          return Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    practice,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Current Organic Crops
            Row(
              children: [
                Text(
                  "Current Organic Crops",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Crop",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            ...List.generate(organicCrops.length, (index) {
              final crop = organicCrops[index];
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${crop["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${crop["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getCertificationColor(crop["certificationStatus"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${crop["certificationStatus"]}",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: _getCertificationColor(crop["certificationStatus"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${crop["variety"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(crop["status"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${crop["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(crop["status"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${((crop["price"] as double)).toStringAsFixed(2)}/lb",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${crop["yield"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Planted: ${crop["planted"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Expected Harvest: ${crop["expectedHarvest"]}",
                                style: TextStyle(
                                  fontSize: 11,
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
                              "Health: ${crop["health"]}%",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: (crop["health"] as int) >= 90 ? successColor : 
                                       (crop["health"] as int) >= 70 ? warningColor : dangerColor,
                              ),
                            ),
                            Container(
                              width: 60,
                              child: LinearProgressIndicator(
                                value: (crop["health"] as int) / 100,
                                backgroundColor: disabledOutlineBorderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  (crop["health"] as int) >= 90 ? successColor : 
                                  (crop["health"] as int) >= 70 ? warningColor : dangerColor
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // Certification Process
            Text(
              "Organic Certification Process",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: certificationSteps.map((step) {
                  bool isCompleted = step["status"] == "Completed";
                  bool isActive = step["status"] == "Active";
                  
                  return Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor : 
                                 isActive ? primaryColor : disabledOutlineBorderColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted 
                            ? Icon(Icons.check, size: 16, color: Colors.white)
                            : isActive
                              ? Icon(Icons.play_arrow, size: 16, color: Colors.white)
                              : Text(
                                  "${step["step"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${step["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${step["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (step["completedDate"] != "Ongoing")
                              Text(
                                "Completed: ${step["completedDate"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor.withAlpha(20) : 
                                 isActive ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${step["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isCompleted ? successColor : 
                                   isActive ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            
            // Benefits Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.eco,
                        size: 24,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Organic Farming Benefits",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Environmental Impact:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "• 45% reduction in carbon footprint\n• 60% less water pollution\n• 80% increase in soil biodiversity\n• 100% elimination of synthetic chemicals",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    "Economic Benefits:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "• 35% premium pricing for organic produce\n• Reduced input costs over time\n• Access to specialty markets\n• Government incentives and subsidies",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
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
}
