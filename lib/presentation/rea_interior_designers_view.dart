import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaInteriorDesignersView extends StatefulWidget {
  const ReaInteriorDesignersView({super.key});

  @override
  State<ReaInteriorDesignersView> createState() => _ReaInteriorDesignersViewState();
}

class _ReaInteriorDesignersViewState extends State<ReaInteriorDesignersView> {
  List<Map<String, dynamic>> designers = [
    {
      "id": 1,
      "name": "Sarah Miller Design Studio",
      "rating": 4.9,
      "reviews": 127,
      "experience": 12,
      "hourlyRate": 125,
      "projectTypes": ["Residential", "Modern", "Luxury", "Kitchen Remodel"],
      "description": "Award-winning interior designer specializing in contemporary luxury homes",
      "phone": "(555) 123-4567",
      "email": "sarah@millerdesign.com",
      "portfolio": [
        "https://picsum.photos/200/150?random=1&keyword=interior",
        "https://picsum.photos/200/150?random=2&keyword=living",
        "https://picsum.photos/200/150?random=3&keyword=kitchen",
        "https://picsum.photos/200/150?random=4&keyword=bedroom",
      ],
      "certifications": ["NCIDQ Certified", "LEED AP", "Kitchen & Bath Designer"],
      "availability": "Available next week",
      "location": "Downtown",
      "distance": 2.8,
      "completedProjects": 85,
      "averageProjectCost": 25000,
      "isVerified": true,
      "consultationFee": 150,
    },
    {
      "id": 2,
      "name": "Creative Spaces by Alex",
      "rating": 4.7,
      "reviews": 94,
      "experience": 8,
      "hourlyRate": 95,
      "projectTypes": ["Residential", "Bohemian", "Eclectic", "Bathroom Remodel"],
      "description": "Creative interior design with focus on unique and personalized spaces",
      "phone": "(555) 234-5678",
      "email": "alex@creativespaces.com",
      "portfolio": [
        "https://picsum.photos/200/150?random=5&keyword=boho",
        "https://picsum.photos/200/150?random=6&keyword=colorful",
        "https://picsum.photos/200/150?random=7&keyword=artistic",
        "https://picsum.photos/200/150?random=8&keyword=unique",
      ],
      "certifications": ["Interior Design Certificate", "Color Theory Specialist"],
      "availability": "Available this week",
      "location": "Midtown",
      "distance": 5.1,
      "completedProjects": 62,
      "averageProjectCost": 18000,
      "isVerified": true,
      "consultationFee": 100,
    },
    {
      "id": 3,
      "name": "Classic Home Interiors",
      "rating": 4.8,
      "reviews": 156,
      "experience": 15,
      "hourlyRate": 110,
      "projectTypes": ["Traditional", "Classic", "Formal", "Whole Home"],
      "description": "Timeless interior design with traditional elegance and sophistication",
      "phone": "(555) 345-6789",
      "email": "info@classichome.com",
      "portfolio": [
        "https://picsum.photos/200/150?random=9&keyword=classic",
        "https://picsum.photos/200/150?random=10&keyword=traditional",
        "https://picsum.photos/200/150?random=11&keyword=elegant",
        "https://picsum.photos/200/150?random=12&keyword=formal",
      ],
      "certifications": ["ASID Professional Member", "Traditional Design Specialist"],
      "availability": "Booking for next month",
      "location": "Suburbs",
      "distance": 8.2,
      "completedProjects": 120,
      "averageProjectCost": 35000,
      "isVerified": true,
      "consultationFee": 200,
    },
    {
      "id": 4,
      "name": "Modern Minimal Studio",
      "rating": 4.6,
      "reviews": 73,
      "experience": 6,
      "hourlyRate": 85,
      "projectTypes": ["Modern", "Minimal", "Scandinavian", "Small Spaces"],
      "description": "Clean, minimal design approach for modern living spaces",
      "phone": "(555) 456-7890",
      "email": "hello@modernminimal.com",
      "portfolio": [
        "https://picsum.photos/200/150?random=13&keyword=minimal",
        "https://picsum.photos/200/150?random=14&keyword=modern",
        "https://picsum.photos/200/150?random=15&keyword=clean",
        "https://picsum.photos/200/150?random=16&keyword=white",
      ],
      "certifications": ["Modern Design Certificate"],
      "availability": "Available today",
      "location": "City Center",
      "distance": 3.5,
      "completedProjects": 45,
      "averageProjectCost": 15000,
      "isVerified": false,
      "consultationFee": 75,
    },
  ];

  String selectedFilter = "All";
  String sortBy = "Rating";
  String selectedStyle = "All Styles";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Designers", "value": "All"},
    {"label": "Verified Only", "value": "Verified"},
    {"label": "Available This Week", "value": "ThisWeek"},
    {"label": "Budget Friendly", "value": "Budget"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "Rating"},
    {"label": "Experience", "value": "Experience"},
    {"label": "Price (Low to High)", "value": "Price"},
    {"label": "Distance", "value": "Distance"},
  ];
  
  List<Map<String, dynamic>> styleOptions = [
    {"label": "All Styles", "value": "All Styles"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Traditional", "value": "Traditional"},
    {"label": "Luxury", "value": "Luxury"},
    {"label": "Minimal", "value": "Minimal"},
  ];

  List<Map<String, dynamic>> getFilteredDesigners() {
    List<Map<String, dynamic>> filtered = List.from(designers);
    
    // Apply filters
    switch (selectedFilter) {
      case "Verified":
        filtered = filtered.where((designer) => designer["isVerified"] == true).toList();
        break;
      case "ThisWeek":
        filtered = filtered.where((designer) => 
          designer["availability"].toString().contains("this week") || 
          designer["availability"].toString().contains("today")).toList();
        break;
      case "Budget":
        filtered = filtered.where((designer) => (designer["hourlyRate"] as int) < 100).toList();
        break;
    }
    
    // Apply style filter
    if (selectedStyle != "All Styles") {
      filtered = filtered.where((designer) => 
        (designer["projectTypes"] as List).any((type) => 
          type.toString().toLowerCase().contains(selectedStyle.toLowerCase()))).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Experience":
        filtered.sort((a, b) => (b["experience"] as int).compareTo(a["experience"] as int));
        break;
      case "Price":
        filtered.sort((a, b) => (a["hourlyRate"] as int).compareTo(b["hourlyRate"] as int));
        break;
      case "Distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDesigners = getFilteredDesigners();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Interior Designers"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              si("Search interior designers");
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
                      Icons.design_services,
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
                          "Professional Interior Designers",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Transform your space with expert design professionals",
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
                            "${designers.length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Designers",
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
                            "${designers.where((d) => d["isVerified"]).length}",
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
                            "\$${((designers.map((d) => d["hourlyRate"] as int).reduce((a, b) => a + b)) / designers.length).toInt()}",
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
            
            // Filters
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
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
                  QDropdownField(
                    label: "Design Style",
                    items: styleOptions,
                    value: selectedStyle,
                    onChanged: (value, label) {
                      selectedStyle = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Designers List
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Interior Designers (${filteredDesigners.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ...filteredDesigners.map((designer) => Container(
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
                  // Designer Header
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${(designer["portfolio"] as List)[0]}"),
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
                                    "${designer["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (designer["isVerified"])
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
                                  "${designer["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " (${designer["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${designer["hourlyRate"]}/hr",
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
                    "${designer["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  // Project Types
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (designer["projectTypes"] as List).map((type) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  // Portfolio Preview
                  Container(
                    height: 80,
                    child: QHorizontalScroll(
                      children: (designer["portfolio"] as List).map((image) => Container(
                        width: 120,
                        height: 80,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                  
                  // Stats
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.work, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${designer["experience"]} years",
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
                            Icon(Icons.assignment, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${designer["completedProjects"]} projects",
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
                          "${designer["availability"]}",
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
                          label: "Book Consultation",
                          size: bs.sm,
                          onPressed: () {
                            _bookConsultation(designer);
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.photo_library,
                        size: bs.sm,
                        onPressed: () {
                          _viewPortfolio(designer);
                        },
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          _showDesignerOptions(designer);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _bookConsultation(Map<String, dynamic> designer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Book Consultation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Book a consultation with ${designer["name"]}?",
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
                    "Consultation Details:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text("• Duration: 60-90 minutes", style: TextStyle(fontSize: 14)),
                  Text("• Fee: \$${designer["consultationFee"]}", style: TextStyle(fontSize: 14)),
                  Text("• Includes: Design assessment & recommendations", style: TextStyle(fontSize: 14)),
                  Text("• ${designer["availability"]}", style: TextStyle(fontSize: 14)),
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
              ss("Consultation booked with ${designer["name"]}");
            },
            child: Text("Book Now"),
          ),
        ],
      ),
    );
  }

  void _viewPortfolio(Map<String, dynamic> designer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${designer["name"]} Portfolio"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spSm,
              mainAxisSpacing: spSm,
            ),
            itemCount: (designer["portfolio"] as List).length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${(designer["portfolio"] as List)[index]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
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

  void _showDesignerOptions(Map<String, dynamic> designer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${designer["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Designer Profile"),
              onTap: () {
                Navigator.pop(context);
                si("View designer profile");
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
              leading: Icon(Icons.favorite),
              title: Text("Save Designer"),
              onTap: () {
                Navigator.pop(context);
                ss("Designer saved to favorites");
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Designer"),
              onTap: () {
                Navigator.pop(context);
                ss("Designer profile shared");
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
