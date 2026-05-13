import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaContractorsView extends StatefulWidget {
  const ReaContractorsView({super.key});

  @override
  State<ReaContractorsView> createState() => _ReaContractorsViewState();
}

class _ReaContractorsViewState extends State<ReaContractorsView> {
  List<Map<String, dynamic>> contractors = [
    {
      "id": 1,
      "name": "Premier Construction Co.",
      "rating": 4.9,
      "reviews": 234,
      "experience": 18,
      "specialties": ["General Contracting", "Kitchen Remodel", "Bathroom Remodel", "Home Additions"],
      "description": "Full-service construction company with expertise in residential renovations",
      "phone": "(555) 123-4567",
      "email": "info@premierconstruction.com",
      "license": "GC-2024-12345",
      "insurance": "Fully Insured & Bonded",
      "portfolio": [
        "https://picsum.photos/200/150?random=1&keyword=construction",
        "https://picsum.photos/200/150?random=2&keyword=renovation",
        "https://picsum.photos/200/150?random=3&keyword=kitchen",
        "https://picsum.photos/200/150?random=4&keyword=bathroom",
      ],
      "certifications": ["Licensed General Contractor", "EPA Lead-Safe Certified", "OSHA 30"],
      "availability": "Available next month",
      "location": "Metro Area",
      "distance": 4.2,
      "completedProjects": 150,
      "averageProjectValue": 45000,
      "isVerified": true,
      "estimateFee": 0,
      "workType": "Commercial & Residential",
    },
    {
      "id": 2,
      "name": "Craftsman Home Builders",
      "rating": 4.7,
      "reviews": 189,
      "experience": 12,
      "specialties": ["Custom Homes", "Additions", "Roofing", "Siding"],
      "description": "Specializing in custom home construction and major renovations",
      "phone": "(555) 234-5678",
      "email": "contact@craftsmanhomes.com",
      "license": "GC-2024-23456",
      "insurance": "Licensed & Insured",
      "portfolio": [
        "https://picsum.photos/200/150?random=5&keyword=house",
        "https://picsum.photos/200/150?random=6&keyword=roof",
        "https://picsum.photos/200/150?random=7&keyword=addition",
        "https://picsum.photos/200/150?random=8&keyword=exterior",
      ],
      "certifications": ["Licensed Contractor", "Roofing Specialist", "Energy Star Builder"],
      "availability": "Available in 3 weeks",
      "location": "North District",
      "distance": 6.8,
      "completedProjects": 98,
      "averageProjectValue": 65000,
      "isVerified": true,
      "estimateFee": 100,
      "workType": "Residential Only",
    },
    {
      "id": 3,
      "name": "Rapid Repair Solutions",
      "rating": 4.5,
      "reviews": 156,
      "experience": 8,
      "specialties": ["Handyman Services", "Repairs", "Maintenance", "Small Projects"],
      "description": "Quick and reliable handyman services for home repairs and maintenance",
      "phone": "(555) 345-6789",
      "email": "service@rapidrepair.com",
      "license": "HM-2024-34567",
      "insurance": "Liability Insured",
      "portfolio": [
        "https://picsum.photos/200/150?random=9&keyword=repair",
        "https://picsum.photos/200/150?random=10&keyword=handyman",
        "https://picsum.photos/200/150?random=11&keyword=maintenance",
        "https://picsum.photos/200/150?random=12&keyword=fix",
      ],
      "certifications": ["Handyman License", "Basic Electrical", "Plumbing Repairs"],
      "availability": "Available this week",
      "location": "City Wide",
      "distance": 2.1,
      "completedProjects": 285,
      "averageProjectValue": 1200,
      "isVerified": true,
      "estimateFee": 50,
      "workType": "Residential Repairs",
    },
    {
      "id": 4,
      "name": "Elite Renovations Group",
      "rating": 4.8,
      "reviews": 97,
      "experience": 15,
      "specialties": ["Luxury Renovations", "High-End Finishes", "Custom Millwork", "Whole House"],
      "description": "Premium renovation services for luxury homes and high-end finishes",
      "phone": "(555) 456-7890",
      "email": "luxury@eliterenovations.com",
      "license": "GC-2024-45678",
      "insurance": "Comprehensive Coverage",
      "portfolio": [
        "https://picsum.photos/200/150?random=13&keyword=luxury",
        "https://picsum.photos/200/150?random=14&keyword=elegant",
        "https://picsum.photos/200/150?random=15&keyword=highend",
        "https://picsum.photos/200/150?random=16&keyword=custom",
      ],
      "certifications": ["Master Contractor", "Green Building Certified", "Custom Millwork"],
      "availability": "Booking for next quarter",
      "location": "Upscale Districts",
      "distance": 8.5,
      "completedProjects": 72,
      "averageProjectValue": 125000,
      "isVerified": true,
      "estimateFee": 250,
      "workType": "High-End Residential",
    },
  ];

  String selectedFilter = "All";
  String sortBy = "Rating";
  String selectedSpecialty = "All Specialties";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Contractors", "value": "All"},
    {"label": "Verified Only", "value": "Verified"},
    {"label": "Available Soon", "value": "Available"},
    {"label": "Free Estimates", "value": "FreeEstimate"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "Rating"},
    {"label": "Experience", "value": "Experience"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Project Value", "value": "Value"},
  ];
  
  List<Map<String, dynamic>> specialtyOptions = [
    {"label": "All Specialties", "value": "All Specialties"},
    {"label": "General Contracting", "value": "General Contracting"},
    {"label": "Kitchen Remodel", "value": "Kitchen Remodel"},
    {"label": "Bathroom Remodel", "value": "Bathroom Remodel"},
    {"label": "Roofing", "value": "Roofing"},
    {"label": "Custom Homes", "value": "Custom Homes"},
  ];

  List<Map<String, dynamic>> getFilteredContractors() {
    List<Map<String, dynamic>> filtered = List.from(contractors);
    
    // Apply filters
    switch (selectedFilter) {
      case "Verified":
        filtered = filtered.where((contractor) => contractor["isVerified"] == true).toList();
        break;
      case "Available":
        filtered = filtered.where((contractor) => 
          contractor["availability"].toString().contains("week") || 
          contractor["availability"].toString().contains("today")).toList();
        break;
      case "FreeEstimate":
        filtered = filtered.where((contractor) => (contractor["estimateFee"] as int) == 0).toList();
        break;
    }
    
    // Apply specialty filter
    if (selectedSpecialty != "All Specialties") {
      filtered = filtered.where((contractor) => 
        (contractor["specialties"] as List).any((specialty) => 
          specialty.toString().contains(selectedSpecialty))).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Experience":
        filtered.sort((a, b) => (b["experience"] as int).compareTo(a["experience"] as int));
        break;
      case "Distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "Value":
        filtered.sort((a, b) => (b["averageProjectValue"] as int).compareTo(a["averageProjectValue"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredContractors = getFilteredContractors();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Contractors"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              si("Search contractors");
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
                      Icons.construction,
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
                          "Licensed Contractors",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Find qualified contractors for your construction and renovation projects",
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
                            "${contractors.length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Contractors",
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
                            "${contractors.where((c) => c["isVerified"]).length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Licensed",
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
                            "${((contractors.map((c) => c["completedProjects"] as int).reduce((a, b) => a + b)) / contractors.length).toInt()}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg. Projects",
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
                    label: "Specialty",
                    items: specialtyOptions,
                    value: selectedSpecialty,
                    onChanged: (value, label) {
                      selectedSpecialty = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Contractors List
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Contractors (${filteredContractors.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ...filteredContractors.map((contractor) => Container(
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
                  // Contractor Header
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${(contractor["portfolio"] as List)[0]}"),
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
                                    "${contractor["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (contractor["isVerified"])
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
                                          "Licensed",
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
                                  "${contractor["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " (${contractor["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${contractor["experience"]} years exp.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                    "${contractor["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  // Specialties
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (contractor["specialties"] as List).map((specialty) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        specialty,
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
                      children: (contractor["portfolio"] as List).map((image) => Container(
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
                  
                  // Project Info
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${contractor["completedProjects"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Projects",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${((contractor["averageProjectValue"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg. Value",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                contractor["estimateFee"] == 0 ? "Free" : "\$${contractor["estimateFee"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: contractor["estimateFee"] == 0 ? successColor : infoColor,
                                ),
                              ),
                              Text(
                                "Estimate",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // License & Insurance
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${contractor["license"]} • ${contractor["insurance"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${contractor["availability"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
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
                          label: "Get Estimate",
                          size: bs.sm,
                          onPressed: () {
                            _requestEstimate(contractor);
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.photo_library,
                        size: bs.sm,
                        onPressed: () {
                          _viewPortfolio(contractor);
                        },
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          _showContractorOptions(contractor);
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

  void _requestEstimate(Map<String, dynamic> contractor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Request Estimate"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Request an estimate from ${contractor["name"]}?",
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
                    "Estimate includes:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text("• Project scope assessment", style: TextStyle(fontSize: 14)),
                  Text("• Detailed cost breakdown", style: TextStyle(fontSize: 14)),
                  Text("• Timeline and milestones", style: TextStyle(fontSize: 14)),
                  Text("• Material specifications", style: TextStyle(fontSize: 14)),
                  if (contractor["estimateFee"] > 0)
                    Text("• Fee: \$${contractor["estimateFee"]}", style: TextStyle(fontSize: 14)),
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
              ss("Estimate request sent to ${contractor["name"]}");
            },
            child: Text("Request Estimate"),
          ),
        ],
      ),
    );
  }

  void _viewPortfolio(Map<String, dynamic> contractor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${contractor["name"]} Portfolio"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spSm,
              mainAxisSpacing: spSm,
            ),
            itemCount: (contractor["portfolio"] as List).length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${(contractor["portfolio"] as List)[index]}"),
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

  void _showContractorOptions(Map<String, dynamic> contractor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${contractor["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.business),
              title: Text("Company Profile"),
              onTap: () {
                Navigator.pop(context);
                si("View company profile");
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
              leading: Icon(Icons.contact_phone),
              title: Text("Contact Info"),
              onTap: () {
                Navigator.pop(context);
                si("View contact information");
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Contractor"),
              onTap: () {
                Navigator.pop(context);
                ss("Contractor profile shared");
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
