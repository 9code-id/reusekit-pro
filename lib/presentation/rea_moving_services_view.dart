import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMovingServicesView extends StatefulWidget {
  const ReaMovingServicesView({super.key});

  @override
  State<ReaMovingServicesView> createState() => _ReaMovingServicesViewState();
}

class _ReaMovingServicesViewState extends State<ReaMovingServicesView> {
  List<Map<String, dynamic>> movingCompanies = [
    {
      "id": 1,
      "name": "Swift Move Solutions",
      "rating": 4.8,
      "reviews": 245,
      "hourlyRate": 120,
      "services": ["Local Moving", "Packing", "Storage", "Insurance"],
      "description": "Professional moving services with 15+ years experience",
      "phone": "(555) 123-4567",
      "email": "info@swiftmove.com",
      "availability": "Available today",
      "image": "https://picsum.photos/100/100?random=1&keyword=truck",
      "isVerified": true,
      "distance": 2.5,
      "estimatedTime": "2-4 hours",
    },
    {
      "id": 2,
      "name": "City Express Movers",
      "rating": 4.6,
      "reviews": 189,
      "hourlyRate": 95,
      "services": ["Local Moving", "Long Distance", "Packing"],
      "description": "Fast and reliable moving services at competitive rates",
      "phone": "(555) 234-5678",
      "email": "contact@cityexpress.com",
      "availability": "Available tomorrow",
      "image": "https://picsum.photos/100/100?random=2&keyword=moving",
      "isVerified": true,
      "distance": 5.2,
      "estimatedTime": "3-5 hours",
    },
    {
      "id": 3,
      "name": "Premium Relocation Co.",
      "rating": 4.9,
      "reviews": 156,
      "hourlyRate": 150,
      "services": ["Full Service", "Packing", "Storage", "Insurance", "White Glove"],
      "description": "Luxury moving services for high-end relocations",
      "phone": "(555) 345-6789",
      "email": "luxury@premiumrelocation.com",
      "availability": "Booking for next week",
      "image": "https://picsum.photos/100/100?random=3&keyword=luxury",
      "isVerified": true,
      "distance": 3.8,
      "estimatedTime": "4-6 hours",
    },
    {
      "id": 4,
      "name": "Budget Movers Plus",
      "rating": 4.2,
      "reviews": 98,
      "hourlyRate": 75,
      "services": ["Local Moving", "Labor Only"],
      "description": "Affordable moving services for budget-conscious customers",
      "phone": "(555) 456-7890",
      "email": "help@budgetmovers.com",
      "availability": "Available this weekend",
      "image": "https://picsum.photos/100/100?random=4&keyword=budget",
      "isVerified": false,
      "distance": 7.1,
      "estimatedTime": "2-3 hours",
    },
  ];

  List<Map<String, dynamic>> movingTips = [
    {
      "title": "Start Planning Early",
      "description": "Begin planning your move at least 8 weeks in advance to secure the best movers and dates.",
      "icon": Icons.schedule,
      "category": "Planning"
    },
    {
      "title": "Declutter Before Moving",
      "description": "Sort through belongings and donate or sell items you don't need to reduce moving costs.",
      "icon": Icons.cleaning_services,
      "category": "Preparation"
    },
    {
      "title": "Pack an Essentials Box",
      "description": "Pack a box with essentials you'll need immediately in your new home.",
      "icon": Icons.inventory,
      "category": "Packing"
    },
    {
      "title": "Take Photos of Electronics",
      "description": "Photograph wiring setups before disconnecting electronics for easy reassembly.",
      "icon": Icons.photo_camera,
      "category": "Electronics"
    },
  ];

  String selectedFilter = "All";
  String sortBy = "Rating";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Services", "value": "All"},
    {"label": "Verified Only", "value": "Verified"},
    {"label": "Available Today", "value": "Today"},
    {"label": "Budget Friendly", "value": "Budget"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "Rating"},
    {"label": "Price (Low to High)", "value": "Price"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Reviews", "value": "Reviews"},
  ];

  List<Map<String, dynamic>> getFilteredCompanies() {
    List<Map<String, dynamic>> filtered = List.from(movingCompanies);
    
    // Apply filters
    switch (selectedFilter) {
      case "Verified":
        filtered = filtered.where((company) => company["isVerified"] == true).toList();
        break;
      case "Today":
        filtered = filtered.where((company) => company["availability"].toString().contains("today")).toList();
        break;
      case "Budget":
        filtered = filtered.where((company) => (company["hourlyRate"] as int) < 100).toList();
        break;
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Price":
        filtered.sort((a, b) => (a["hourlyRate"] as int).compareTo(b["hourlyRate"] as int));
        break;
      case "Distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "Reviews":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCompanies = getFilteredCompanies();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Moving Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              si("View moving companies on map");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.local_shipping,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Professional Moving Services",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Find trusted movers in your area for a stress-free relocation",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Quick Stats
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${movingCompanies.length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Companies",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${movingCompanies.where((c) => c["isVerified"]).length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Verified",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "\$${((movingCompanies.map((c) => c["hourlyRate"] as int).reduce((a, b) => a + b)) / movingCompanies.length).toInt()}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg. Rate/hr",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Filter and Sort
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter",
                      items: filterOptions,
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Sort by",
                      items: sortOptions,
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Moving Companies List
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Moving Companies (${filteredCompanies.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ...filteredCompanies.map((company) => Container(
              margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Company Header
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${company["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${company["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (company["isVerified"])
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 12,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "Verified",
                                          style: TextStyle(
                                            color: successColor,
                                            fontSize: 10,
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
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${company["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " (${company["reviews"]} reviews)",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${company["hourlyRate"]}/hr",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Description
                  Text(
                    "${company["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  // Services
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (company["services"] as List).map((service) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        service,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  // Details
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${company["distance"]} mi",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${company["estimatedTime"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${company["availability"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Action Buttons
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Get Quote",
                          size: bs.sm,
                          onPressed: () {
                            _requestQuote(company);
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${company["name"]}");
                        },
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          _showCompanyOptions(company);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
            
            // Moving Tips Section
            Container(
              margin: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Moving Tips & Advice",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  ...movingTips.map((tip) => Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            tip["icon"],
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tip["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${tip["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestQuote(Map<String, dynamic> company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Request Quote"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Request a quote from ${company["name"]}?",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quote includes:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text("• Detailed cost breakdown", style: TextStyle(fontSize: 14)),
                  Text("• Service timeline", style: TextStyle(fontSize: 14)),
                  Text("• Insurance options", style: TextStyle(fontSize: 14)),
                  Text("• Terms and conditions", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Quote request sent to ${company["name"]}");
            },
            child: Text("Request Quote"),
          ),
        ],
      ),
    );
  }

  void _showCompanyOptions(Map<String, dynamic> company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${company["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Company Details"),
              onTap: () {
                Navigator.pop(context);
                si("View company details");
              },
            ),
            ListTile(
              leading: Icon(Icons.reviews),
              title: Text("Read Reviews"),
              onTap: () {
                Navigator.pop(context);
                si("View customer reviews");
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("View Photos"),
              onTap: () {
                Navigator.pop(context);
                si("View company photos");
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Company"),
              onTap: () {
                Navigator.pop(context);
                ss("Company details shared");
              },
            ),
            ListTile(
              leading: Icon(Icons.report, color: dangerColor),
              title: Text("Report Issue", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                sw("Report submitted for review");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
