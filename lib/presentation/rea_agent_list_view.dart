import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAgentListView extends StatefulWidget {
  const ReaAgentListView({super.key});

  @override
  State<ReaAgentListView> createState() => _ReaAgentListViewState();
}

class _ReaAgentListViewState extends State<ReaAgentListView> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedLocation = "All";
  String sortBy = "rating";

  List<Map<String, dynamic>> specialties = [
    {"label": "All", "value": "all"},
    {"label": "Residential", "value": "residential"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Luxury Properties", "value": "luxury"},
    {"label": "Investment", "value": "investment"},
    {"label": "New Projects", "value": "new_projects"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All", "value": "all"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Suburbs", "value": "suburbs"},
    {"label": "Waterfront", "value": "waterfront"},
    {"label": "Business District", "value": "business"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Experienced", "value": "experience"},
    {"label": "Most Properties Sold", "value": "sales"},
    {"label": "Newest First", "value": "newest"},
  ];

  List<Map<String, dynamic>> agents = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "photo": "https://picsum.photos/150/150?random=401&keyword=woman",
      "title": "Senior Real Estate Agent",
      "company": "Premium Properties Inc.",
      "rating": 4.9,
      "reviews": 342,
      "experience": 8,
      "specialties": ["Luxury Properties", "Residential"],
      "location": "Downtown",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@premiumprops.com",
      "languages": ["English", "Spanish"],
      "propertiesSold": 156,
      "totalSalesValue": 45600000,
      "responseTime": "< 30 minutes",
      "isVerified": true,
      "isOnline": true,
      "badges": ["Top Performer", "Client's Choice"],
      "bio": "Specializing in luxury residential properties with over 8 years of experience in high-end real estate transactions.",
      "achievements": [
        "Top 5% agent nationally",
        "Million Dollar Club member",
        "Best Customer Service Award 2024"
      ]
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "photo": "https://picsum.photos/150/150?random=402&keyword=man",
      "title": "Commercial Real Estate Specialist",
      "company": "Metro Commercial Group",
      "rating": 4.7,
      "reviews": 198,
      "experience": 12,
      "specialties": ["Commercial", "Investment"],
      "location": "Business District",
      "phone": "+1 (555) 234-5678",
      "email": "m.chen@metrocommercial.com",
      "languages": ["English", "Mandarin"],
      "propertiesSold": 89,
      "totalSalesValue": 78900000,
      "responseTime": "< 1 hour",
      "isVerified": true,
      "isOnline": false,
      "badges": ["Commercial Expert", "Investment Specialist"],
      "bio": "Expert in commercial real estate with extensive experience in office buildings, retail spaces, and investment properties.",
      "achievements": [
        "Commercial Agent of the Year 2023",
        "Over \$100M in transactions",
        "25+ successful commercial deals"
      ]
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "photo": "https://picsum.photos/150/150?random=403&keyword=professional",
      "title": "First-Time Buyer Specialist",
      "company": "Home Sweet Home Realty",
      "rating": 4.8,
      "reviews": 276,
      "experience": 6,
      "specialties": ["Residential", "New Projects"],
      "location": "Suburbs",
      "phone": "+1 (555) 345-6789",
      "email": "emily.r@homesweethome.com",
      "languages": ["English", "Spanish", "Portuguese"],
      "propertiesSold": 203,
      "totalSalesValue": 32400000,
      "responseTime": "< 15 minutes",
      "isVerified": true,
      "isOnline": true,
      "badges": ["First-Time Buyer Expert", "Quick Response"],
      "bio": "Dedicated to helping first-time buyers navigate the home buying process with patience and expertise.",
      "achievements": [
        "200+ happy families",
        "First-time buyer specialist certification",
        "Community service award"
      ]
    },
    {
      "id": "4",
      "name": "David Thompson",
      "photo": "https://picsum.photos/150/150?random=404&keyword=agent",
      "title": "Luxury Property Consultant",
      "company": "Elite Estates",
      "rating": 4.6,
      "reviews": 124,
      "experience": 15,
      "specialties": ["Luxury Properties", "Waterfront"],
      "location": "Waterfront",
      "phone": "+1 (555) 456-7890",
      "email": "david.t@eliteestates.com",
      "languages": ["English", "French"],
      "propertiesSold": 67,
      "totalSalesValue": 89700000,
      "responseTime": "< 2 hours",
      "isVerified": true,
      "isOnline": false,
      "badges": ["Luxury Specialist", "Waterfront Expert"],
      "bio": "Premier luxury real estate consultant specializing in high-end waterfront properties and exclusive estates.",
      "achievements": [
        "Luxury market leader",
        "Record-breaking sales",
        "Celebrity clientele"
      ]
    },
    {
      "id": "5",
      "name": "Jessica Park",
      "photo": "https://picsum.photos/150/150?random=405&keyword=businesswoman",
      "title": "Investment Property Advisor",
      "company": "Smart Investments Realty",
      "rating": 4.5,
      "reviews": 167,
      "experience": 9,
      "specialties": ["Investment", "Commercial"],
      "location": "Downtown",
      "phone": "+1 (555) 567-8901",
      "email": "j.park@smartinvestments.com",
      "languages": ["English", "Korean"],
      "propertiesSold": 134,
      "totalSalesValue": 56800000,
      "responseTime": "< 45 minutes",
      "isVerified": true,
      "isOnline": true,
      "badges": ["Investment Expert", "ROI Specialist"],
      "bio": "Helping investors build wealth through strategic real estate investments with proven market analysis.",
      "achievements": [
        "Investment portfolio advisor",
        "Market analysis expert",
        "ROI optimization specialist"
      ]
    },
    {
      "id": "6",
      "name": "Robert Wilson",
      "photo": "https://picsum.photos/150/150?random=406&keyword=realtor",
      "title": "New Development Specialist",
      "company": "Future Homes Realty",
      "rating": 4.4,
      "reviews": 89,
      "experience": 4,
      "specialties": ["New Projects", "Residential"],
      "location": "Suburbs",
      "phone": "+1 (555) 678-9012",
      "email": "r.wilson@futurehomes.com",
      "languages": ["English"],
      "propertiesSold": 92,
      "totalSalesValue": 18900000,
      "responseTime": "< 1 hour",
      "isVerified": true,
      "isOnline": true,
      "badges": ["New Development", "Rising Star"],
      "bio": "Specialist in new construction and pre-launch properties, helping buyers get the best deals on new developments.",
      "achievements": [
        "New development expert",
        "Pre-launch specialist",
        "Young achiever award"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredAgents {
    var filtered = agents.where((agent) {
      bool matchesSpecialty = selectedSpecialty == "All" || 
        (agent["specialties"] as List).any((specialty) => 
          specialty.toLowerCase().replaceAll(" ", "_") == selectedSpecialty.toLowerCase().replaceAll(" ", "_"));
      bool matchesLocation = selectedLocation == "All" || agent["location"] == selectedLocation;
      bool matchesSearch = searchQuery.isEmpty || 
        "${agent["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${agent["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (agent["specialties"] as List).any((specialty) => 
          "$specialty".toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesSpecialty && matchesLocation && matchesSearch;
    }).toList();
    
    // Sort agents
    filtered.sort((a, b) {
      switch (sortBy) {
        case "experience":
          return (b["experience"] as int).compareTo(a["experience"] as int);
        case "sales":
          return (b["propertiesSold"] as int).compareTo(a["propertiesSold"] as int);
        case "newest":
          return (a["experience"] as int).compareTo(b["experience"] as int);
        default: // rating
          return (b["rating"] as double).compareTo(a["rating"] as double);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Estate Agents"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search agents",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
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
                  Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Your Perfect Agent",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Connect with verified real estate professionals",
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
            ),
            
            SizedBox(height: spLg),
            
            // Filter Section
            Row(
              children: [
                Expanded(
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
                Expanded(
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
              ],
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredAgents.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Agents",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredAgents.where((a) => a["isOnline"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredAgents.isNotEmpty ? (filteredAgents.map((a) => a["rating"] as double).reduce((a, b) => a > b ? a : b)).toStringAsFixed(1) : '0'}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Top Rated",
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
            
            SizedBox(height: spLg),
            
            // Results Header
            Text(
              "${filteredAgents.length} Agents Available",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            // Agent List
            ...filteredAgents.map((agent) {
              bool isOnline = agent["isOnline"] as bool;
              bool isVerified = agent["isVerified"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isVerified 
                    ? Border.all(color: successColor.withAlpha(100))
                    : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Agent Header
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${agent["photo"]}",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (isOnline)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              if (isVerified)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${agent["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${agent["rating"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${agent["title"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${agent["company"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${agent["experience"]} years exp",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.rate_review,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${agent["reviews"]} reviews",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Bio
                      Text(
                        "${agent["bio"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Specialties
                      QHorizontalScroll(
                        children: (agent["specialties"] as List).map((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$specialty",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Badges
                      QHorizontalScroll(
                        children: (agent["badges"] as List).map((badge) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$badge",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Stats Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatItem(
                              "Properties Sold",
                              "${agent["propertiesSold"]}",
                              Icons.home_work,
                            ),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              "Sales Value",
                              "\$${((agent["totalSalesValue"] as int) / 1000000).toStringAsFixed(1)}M",
                              Icons.attach_money,
                            ),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              "Response Time",
                              "${agent["responseTime"]}",
                              Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Buttons
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
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick contact or filter
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.message),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showFilterBottomSheet() {
    // Implementation for filter bottom sheet
  }
}
