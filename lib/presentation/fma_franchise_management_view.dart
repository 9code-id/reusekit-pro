import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaFranchiseManagementView extends StatefulWidget {
  const FmaFranchiseManagementView({super.key});

  @override
  State<FmaFranchiseManagementView> createState() => _FmaFranchiseManagementViewState();
}

class _FmaFranchiseManagementViewState extends State<FmaFranchiseManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedRegion = "all";
  String selectedPerformance = "all";

  List<Map<String, dynamic>> franchiseLocations = [
    {
      "id": "FR-001",
      "franchiseName": "FMA Downtown Plaza",
      "franchisee": "Sarah Johnson",
      "location": "Downtown Business District",
      "city": "New York",
      "state": "NY",
      "openingDate": "2023-03-15",
      "status": "active",
      "performance": "excellent",
      "monthlyRevenue": 85000.0,
      "yearlyRevenue": 950000.0,
      "employeeCount": 25,
      "customerRating": 4.8,
      "franchiseFee": 50000.0,
      "royaltyRate": 6.5,
      "contactEmail": "sarah.j@fmadowntown.com",
      "contactPhone": "+1-555-0301",
      "manager": "David Chen",
      "complianceScore": 95,
      "lastInspection": "2024-03-20",
      "nextReview": "2024-06-20"
    },
    {
      "id": "FR-002",
      "franchiseName": "FMA Westside Kitchen",
      "franchisee": "Michael Rodriguez",
      "location": "Westside Shopping Center",
      "city": "Los Angeles",
      "state": "CA",
      "openingDate": "2022-11-08",
      "status": "active",
      "performance": "good",
      "monthlyRevenue": 72000.0,
      "yearlyRevenue": 820000.0,
      "employeeCount": 20,
      "customerRating": 4.5,
      "franchiseFee": 45000.0,
      "royaltyRate": 6.0,
      "contactEmail": "m.rodriguez@fmawestside.com",
      "contactPhone": "+1-555-0302",
      "manager": "Lisa Wang",
      "complianceScore": 88,
      "lastInspection": "2024-02-15",
      "nextReview": "2024-05-15"
    },
    {
      "id": "FR-003",
      "franchiseName": "FMA Central Station",
      "franchisee": "Jennifer Park",
      "location": "Central Train Station",
      "city": "Chicago",
      "state": "IL",
      "openingDate": "2024-01-20",
      "status": "active",
      "performance": "average",
      "monthlyRevenue": 55000.0,
      "yearlyRevenue": 220000.0,
      "employeeCount": 15,
      "customerRating": 4.2,
      "franchiseFee": 40000.0,
      "royaltyRate": 5.5,
      "contactEmail": "j.park@fmacentral.com",
      "contactPhone": "+1-555-0303",
      "manager": "Tom Anderson",
      "complianceScore": 82,
      "lastInspection": "2024-04-10",
      "nextReview": "2024-07-10"
    },
    {
      "id": "FR-004",
      "franchiseName": "FMA Harbor View",
      "franchisee": "Dr. Amanda Wilson",
      "location": "Harbor District",
      "city": "Seattle",
      "state": "WA",
      "openingDate": "2023-08-12",
      "status": "under_review",
      "performance": "needs_improvement",
      "monthlyRevenue": 38000.0,
      "yearlyRevenue": 340000.0,
      "employeeCount": 12,
      "customerRating": 3.8,
      "franchiseFee": 35000.0,
      "royaltyRate": 5.0,
      "contactEmail": "a.wilson@fmaharbor.com",
      "contactPhone": "+1-555-0304",
      "manager": "Emma Thompson",
      "complianceScore": 74,
      "lastInspection": "2024-04-05",
      "nextReview": "2024-05-05"
    }
  ];

  List<Map<String, dynamic>> franchiseSupport = [
    {
      "category": "Training & Development",
      "services": [
        {
          "name": "Initial Franchise Training",
          "description": "Comprehensive 4-week training program covering all aspects of restaurant operations",
          "duration": "4 weeks",
          "location": "Corporate Training Center",
          "included": true
        },
        {
          "name": "Ongoing Skills Development",
          "description": "Monthly training sessions and workshops for franchisees and staff",
          "duration": "Monthly",
          "location": "Virtual & On-site",
          "included": true
        },
        {
          "name": "Leadership Development Program",
          "description": "Advanced management training for franchise owners and managers",
          "duration": "2 weeks",
          "location": "Corporate HQ",
          "included": false
        }
      ]
    },
    {
      "category": "Marketing & Advertising",
      "services": [
        {
          "name": "National Advertising Fund",
          "description": "Participation in national marketing campaigns and brand promotion",
          "duration": "Ongoing",
          "location": "National",
          "included": true
        },
        {
          "name": "Local Marketing Support",
          "description": "Customized local marketing materials and campaign assistance",
          "duration": "As needed",
          "location": "Local market",
          "included": true
        },
        {
          "name": "Digital Marketing Platform",
          "description": "Access to corporate digital marketing tools and social media management",
          "duration": "Ongoing",
          "location": "Online",
          "included": true
        }
      ]
    },
    {
      "category": "Operations Support",
      "services": [
        {
          "name": "Site Selection Assistance",
          "description": "Professional guidance in selecting optimal franchise locations",
          "duration": "Pre-opening",
          "location": "Prospective locations",
          "included": true
        },
        {
          "name": "Equipment & Supply Chain",
          "description": "Access to approved vendors and equipment suppliers at negotiated rates",
          "duration": "Ongoing",
          "location": "Nationwide",
          "included": true
        },
        {
          "name": "Quality Assurance Program",
          "description": "Regular inspections and compliance monitoring to maintain brand standards",
          "duration": "Quarterly",
          "location": "Franchise locations",
          "included": true
        }
      ]
    }
  ];

  List<Map<String, dynamic>> growthOpportunities = [
    {
      "region": "Southeast",
      "states": ["Florida", "Georgia", "North Carolina", "South Carolina"],
      "availableTerritories": 12,
      "estimatedInvestment": "150K - 250K",
      "projectedROI": "18-25%",
      "marketPotential": "high",
      "demographics": "Growing suburban markets with strong food service demand",
      "supportLevel": "Full corporate support with dedicated regional manager",
      "timeline": "6-9 months to opening"
    },
    {
      "region": "Southwest",
      "states": ["Texas", "Arizona", "New Mexico", "Nevada"],
      "availableTerritories": 8,
      "estimatedInvestment": "175K - 300K",
      "projectedROI": "20-28%",
      "marketPotential": "excellent",
      "demographics": "Rapidly expanding metropolitan areas with diverse dining preferences",
      "supportLevel": "Enhanced support with bi-weekly check-ins and local marketing co-op",
      "timeline": "4-7 months to opening"
    },
    {
      "region": "Northeast",
      "states": ["Massachusetts", "Connecticut", "Rhode Island", "Vermont"],
      "availableTerritories": 6,
      "estimatedInvestment": "200K - 350K",
      "projectedROI": "15-22%",
      "marketPotential": "good",
      "demographics": "Established markets with strong economic base and dining culture",
      "supportLevel": "Standard support with quarterly business reviews",
      "timeline": "8-12 months to opening"
    }
  ];

  List<Map<String, dynamic>> get filteredFranchises {
    return franchiseLocations.where((franchise) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${franchise["franchiseName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${franchise["franchisee"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${franchise["city"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${franchise["id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "all" || franchise["status"] == selectedStatus;
      bool matchesRegion = selectedRegion == "all" || "${franchise["state"]}".contains(selectedRegion);
      bool matchesPerformance = selectedPerformance == "all" || franchise["performance"] == selectedPerformance;

      return matchesSearch && matchesStatus && matchesRegion && matchesPerformance;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "under_review":
        return warningColor;
      case "suspended":
        return dangerColor;
      case "new":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "under_review":
        return "Under Review";
      case "suspended":
        return "Suspended";
      case "new":
        return "New";
      default:
        return "Unknown";
    }
  }

  Color _getPerformanceColor(String performance) {
    switch (performance) {
      case "excellent":
        return successColor;
      case "good":
        return primaryColor;
      case "average":
        return warningColor;
      case "needs_improvement":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getPerformanceText(String performance) {
    switch (performance) {
      case "excellent":
        return "Excellent";
      case "good":
        return "Good";
      case "average":
        return "Average";
      case "needs_improvement":
        return "Needs Improvement";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Franchise Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Locations", icon: Icon(Icons.store)),
        Tab(text: "Support Services", icon: Icon(Icons.support_agent)),
        Tab(text: "Growth Opportunities", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildFranchiseLocationsTab(),
        _buildSupportServicesTab(),
        _buildGrowthOpportunitiesTab(),
      ],
    );
  }

  Widget _buildFranchiseLocationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search franchises, owners, or locations",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: [
                          {"label": "All Status", "value": "all"},
                          {"label": "Active", "value": "active"},
                          {"label": "Under Review", "value": "under_review"},
                          {"label": "Suspended", "value": "suspended"},
                          {"label": "New", "value": "new"},
                        ],
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Performance",
                        items: [
                          {"label": "All Performance", "value": "all"},
                          {"label": "Excellent", "value": "excellent"},
                          {"label": "Good", "value": "good"},
                          {"label": "Average", "value": "average"},
                          {"label": "Needs Improvement", "value": "needs_improvement"},
                        ],
                        value: selectedPerformance,
                        onChanged: (value, label) {
                          selectedPerformance = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Franchise Network Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Franchise Network Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredFranchises.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Locations",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${((filteredFranchises.fold(0.0, (sum, franchise) => sum + (franchise["yearlyRevenue"] as double))) / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${(filteredFranchises.fold(0.0, (sum, franchise) => sum + (franchise["customerRating"] as double)) / filteredFranchises.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Franchise Locations List
          ...filteredFranchises.map((franchise) {
            return Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${franchise["franchiseName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${franchise["id"]} • ${franchise["franchisee"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPerformanceColor("${franchise["performance"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getPerformanceText("${franchise["performance"]}"),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: _getPerformanceColor("${franchise["performance"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${franchise["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusText("${franchise["status"]}"),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${franchise["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${franchise["city"]}, ${franchise["state"]}",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Opening Date",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${franchise["openingDate"]}T00:00:00Z").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Employees",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${franchise["employeeCount"]} staff",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
                              "Monthly Revenue",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((franchise["monthlyRevenue"] as double) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Rating",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${franchise["customerRating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Compliance",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${franchise["complianceScore"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (franchise["complianceScore"] as int) >= 90 ? successColor : 
                                       (franchise["complianceScore"] as int) >= 80 ? warningColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to franchise details
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSupportServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Support Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Franchise Support Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Comprehensive support system designed to ensure franchise success. Our experienced team provides ongoing assistance in all aspects of restaurant operations, marketing, and growth strategies.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Support Categories
          ...franchiseSupport.map((category) {
            return Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(
                        category["category"] == "Training & Development" ? Icons.school :
                        category["category"] == "Marketing & Advertising" ? Icons.campaign :
                        Icons.build,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to detailed support info
                        },
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  ...(category["services"] as List).map((service) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${service["name"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: service["included"] == true ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  service["included"] == true ? "INCLUDED" : "PREMIUM",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: service["included"] == true ? successColor : warningColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${service["duration"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${service["location"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),

          // Support Contact
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.support,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "24/7 Franchise Support",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Our dedicated franchise support team is available around the clock to assist with any operational, technical, or business challenges. Contact us anytime for immediate assistance.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call Support",
                        size: bs.sm,
                        onPressed: () {
                          // Call support hotline
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Live Chat",
                        size: bs.sm,
                        onPressed: () {
                          // Open live chat
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
    );
  }

  Widget _buildGrowthOpportunitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Growth Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Franchise Growth Opportunities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Expand your investment portfolio with prime franchise territories across growing markets. Each opportunity includes comprehensive market analysis and projected returns.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${growthOpportunities.fold(0, (sum, region) => sum + (region["availableTerritories"] as int))}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available Territories",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${growthOpportunities.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Target Regions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Regional Opportunities
          ...growthOpportunities.map((opportunity) {
            return Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${opportunity["region"]} Region",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(opportunity["states"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: opportunity["marketPotential"] == "excellent" ? successColor.withAlpha(20) :
                                 opportunity["marketPotential"] == "high" ? primaryColor.withAlpha(20) :
                                 warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${opportunity["marketPotential"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: opportunity["marketPotential"] == "excellent" ? successColor :
                                   opportunity["marketPotential"] == "high" ? primaryColor :
                                   warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Territories",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${opportunity["availableTerritories"]} locations",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Investment Range",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${opportunity["estimatedInvestment"]}",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Projected ROI",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${opportunity["projectedROI"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Market Demographics:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "${opportunity["demographics"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Support Level:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${opportunity["supportLevel"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Timeline to Opening",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${opportunity["timeline"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Request Info",
                        size: bs.sm,
                        onPressed: () {
                          // Request franchise information
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // Franchise Investment Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Investment & Financing",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Investment packages include:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Initial franchise fee and territory rights\n• Equipment package and kitchen setup\n• Initial inventory and supplies\n• Training and operational support\n• Marketing launch package\n• Working capital recommendations",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Financing options available through our preferred lending partners. SBA loans and alternative financing solutions to qualified candidates.",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
