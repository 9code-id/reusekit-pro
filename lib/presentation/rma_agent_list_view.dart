import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAgentListView extends StatefulWidget {
  const RmaAgentListView({Key? key}) : super(key: key);

  @override
  State<RmaAgentListView> createState() => _RmaAgentListViewState();
}

class _RmaAgentListViewState extends State<RmaAgentListView> {
  String searchQuery = "";
  String selectedLocation = "all";
  String selectedSpecialty = "all";
  String selectedExperience = "all";
  String selectedRating = "all";
  String sortBy = "rating";
  
  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Westside", "value": "westside"},
    {"label": "Northside", "value": "northside"},
    {"label": "Eastside", "value": "eastside"},
  ];

  List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": "all"},
    {"label": "First-Time Buyers", "value": "first_time"},
    {"label": "Luxury Homes", "value": "luxury"},
    {"label": "Investment Properties", "value": "investment"},
    {"label": "Commercial", "value": "commercial"},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "All Experience", "value": "all"},
    {"label": "1-3 Years", "value": "1-3"},
    {"label": "4-7 Years", "value": "4-7"},
    {"label": "8-15 Years", "value": "8-15"},
    {"label": "15+ Years", "value": "15+"},
  ];

  List<Map<String, dynamic>> ratings = [
    {"label": "All Ratings", "value": "all"},
    {"label": "4.5+ Stars", "value": "4.5+"},
    {"label": "4.0+ Stars", "value": "4.0+"},
    {"label": "3.5+ Stars", "value": "3.5+"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Experienced", "value": "experience"},
    {"label": "Most Sales", "value": "sales"},
    {"label": "Recently Active", "value": "recent"},
  ];

  List<Map<String, dynamic>> agents = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "title": "Senior Real Estate Agent",
      "photo": "https://picsum.photos/100/100?random=1&keyword=woman",
      "rating": 4.9,
      "reviews": 127,
      "experience": "12 years",
      "specialties": ["First-Time Buyers", "Luxury Homes"],
      "location": "Downtown",
      "phone": "(555) 123-4567",
      "email": "sarah@realestate.com",
      "sales2023": 45,
      "averagePrice": 650000,
      "responseTime": "< 1 hour",
      "featured": true,
      "languages": ["English", "Spanish"],
      "certifications": ["ABR", "CRS", "GRI"],
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "title": "Investment Property Specialist",
      "photo": "https://picsum.photos/100/100?random=2&keyword=man",
      "rating": 4.8,
      "reviews": 89,
      "experience": "8 years",
      "specialties": ["Investment Properties", "Commercial"],
      "location": "Westside",
      "phone": "(555) 234-5678",
      "email": "michael@realestate.com",
      "sales2023": 32,
      "averagePrice": 480000,
      "responseTime": "< 2 hours",
      "featured": false,
      "languages": ["English", "Mandarin"],
      "certifications": ["CCIM", "CRE"],
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "title": "Luxury Home Expert",
      "photo": "https://picsum.photos/100/100?random=3&keyword=woman",
      "rating": 4.9,
      "reviews": 156,
      "experience": "15 years",
      "specialties": ["Luxury Homes", "Waterfront Properties"],
      "location": "Northside",
      "phone": "(555) 345-6789",
      "email": "emily@realestate.com",
      "sales2023": 28,
      "averagePrice": 1200000,
      "responseTime": "< 30 mins",
      "featured": true,
      "languages": ["English", "Spanish", "French"],
      "certifications": ["CRS", "CLHMS", "GRI"],
    },
    {
      "id": "4",
      "name": "David Thompson",
      "title": "First-Time Buyer Advocate",
      "photo": "https://picsum.photos/100/100?random=4&keyword=man",
      "rating": 4.7,
      "reviews": 203,
      "experience": "6 years",
      "specialties": ["First-Time Buyers", "Condos"],
      "location": "Eastside",
      "phone": "(555) 456-7890",
      "email": "david@realestate.com",
      "sales2023": 67,
      "averagePrice": 380000,
      "responseTime": "< 1 hour",
      "featured": false,
      "languages": ["English"],
      "certifications": ["ABR", "e-PRO"],
    },
    {
      "id": "5",
      "name": "Lisa Wang",
      "title": "Commercial Real Estate Expert",
      "photo": "https://picsum.photos/100/100?random=5&keyword=woman",
      "rating": 4.8,
      "reviews": 94,
      "experience": "10 years",
      "specialties": ["Commercial", "Investment Properties"],
      "location": "Downtown",
      "phone": "(555) 567-8901",
      "email": "lisa@realestate.com",
      "sales2023": 22,
      "averagePrice": 850000,
      "responseTime": "< 4 hours",
      "featured": false,
      "languages": ["English", "Mandarin", "Cantonese"],
      "certifications": ["CCIM", "SIOR"],
    },
  ];

  List<Map<String, dynamic>> get filteredAgents {
    return agents.where((agent) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        String query = searchQuery.toLowerCase();
        if (!agent["name"].toString().toLowerCase().contains(query) &&
            !(agent["specialties"] as List).any((s) => s.toString().toLowerCase().contains(query))) {
          return false;
        }
      }
      
      // Location filter
      if (selectedLocation != "all" && agent["location"] != selectedLocation) {
        return false;
      }
      
      // Specialty filter
      if (selectedSpecialty != "all") {
        if (!(agent["specialties"] as List).any((s) => s.toString().toLowerCase().contains(selectedSpecialty.replaceAll("_", " ")))) {
          return false;
        }
      }
      
      // Rating filter
      if (selectedRating != "all") {
        double minRating = double.parse(selectedRating.replaceAll("+", ""));
        if ((agent["rating"] as double) < minRating) {
          return false;
        }
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayAgents = filteredAgents;
    
    // Sort agents
    displayAgents.sort((a, b) {
      switch (sortBy) {
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "experience":
          int aExp = int.parse(a["experience"].toString().split(" ")[0]);
          int bExp = int.parse(b["experience"].toString().split(" ")[0]);
          return bExp.compareTo(aExp);
        case "sales":
          return (b["sales2023"] as int).compareTo(a["sales2023"] as int);
        case "recent":
          return b["responseTime"].toString().compareTo(a["responseTime"].toString());
        default:
          return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Real Estate Agents"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: spSm),
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search agents or specialties",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: disabledBoldColor),
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.sort,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                QHorizontalScroll(
                  children: [
                    Container(
                      width: 150,
                      child: QDropdownField(
                        label: "Location",
                        items: locations,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 150,
                      child: QDropdownField(
                        label: "Specialty",
                        items: specialties,
                        value: selectedSpecialty,
                        onChanged: (value, label) {
                          selectedSpecialty = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 150,
                      child: QDropdownField(
                        label: "Rating",
                        items: ratings,
                        value: selectedRating,
                        onChanged: (value, label) {
                          selectedRating = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 150,
                      child: QDropdownField(
                        label: "Sort By",
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
              ],
            ),
          ),
          
          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${displayAgents.length} agents found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "All verified",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Agent List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: displayAgents.length,
              itemBuilder: (context, index) {
                final agent = displayAgents[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: agent["featured"] ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Featured Badge
                      if (agent["featured"])
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "FEATURED AGENT",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      
                      // Agent Info
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              image: DecorationImage(
                                image: NetworkImage("${agent["photo"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${agent["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${agent["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXxs),
                                    Text(
                                      "${agent["rating"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "(${agent["reviews"]} reviews)",
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
                          Column(
                            children: [
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(height: spXs),
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Experience & Stats
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Experience",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${agent["experience"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
                                  "2023 Sales",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${agent["sales2023"]} homes",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
                                  "Avg. Price",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((agent["averagePrice"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
                                  "Response",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${agent["responseTime"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Specialties
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (agent["specialties"] as List).map<Widget>((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXxs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$specialty",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Languages & Certifications
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Languages: ${(agent["languages"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXxs),
                                Text(
                                  "Certifications: ${(agent["certifications"] as List).join(", ")}",
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

                      // Contact Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Profile",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Contact Agent",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
