import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSponsorProfilesView extends StatefulWidget {
  const EcmSponsorProfilesView({super.key});

  @override
  State<EcmSponsorProfilesView> createState() => _EcmSponsorProfilesViewState();
}

class _EcmSponsorProfilesViewState extends State<EcmSponsorProfilesView> {
  String searchQuery = "";
  String selectedTier = "All";
  String selectedIndustry = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> sponsors = [
    {
      "id": 1,
      "name": "Microsoft Corporation",
      "tier": "Platinum",
      "industry": "Technology",
      "logo": "https://picsum.photos/100/100?random=1&keyword=microsoft",
      "description": "Leading technology company providing cloud computing, productivity software, and enterprise solutions worldwide",
      "website": "https://microsoft.com",
      "founded": 1975,
      "employees": "220,000+",
      "headquarters": "Redmond, WA, USA",
      "contact": {
        "name": "John Smith",
        "title": "Partnership Manager",
        "email": "john.smith@microsoft.com",
        "phone": "+1-555-0123",
        "linkedin": "linkedin.com/in/johnsmith"
      },
      "products": [
        "Azure Cloud Platform",
        "Microsoft 365",
        "Windows OS",
        "SQL Server",
        "Power Platform"
      ],
      "achievements": [
        "Fortune 500 Company",
        "Carbon Neutral by 2030",
        "100+ Patents Filed Annually",
        "Global Market Leader"
      ],
      "socialMedia": {
        "twitter": "@Microsoft",
        "linkedin": "microsoft",
        "facebook": "Microsoft"
      },
      "sponsorshipHistory": [
        {"year": 2023, "amount": 45000, "tier": "Platinum"},
        {"year": 2022, "amount": 40000, "tier": "Gold"},
        {"year": 2021, "amount": 35000, "tier": "Gold"}
      ],
      "rating": 4.9,
      "isVerified": true,
      "lastContact": "2024-06-18",
    },
    {
      "id": 2,
      "name": "Google LLC",
      "tier": "Gold",
      "industry": "Technology",
      "logo": "https://picsum.photos/100/100?random=2&keyword=google",
      "description": "Multinational technology company specializing in Internet-related services and products",
      "website": "https://google.com",
      "founded": 1998,
      "employees": "174,000+",
      "headquarters": "Mountain View, CA, USA",
      "contact": {
        "name": "Sarah Johnson",
        "title": "Event Partnerships Lead",
        "email": "sarah.j@google.com",
        "phone": "+1-555-0456",
        "linkedin": "linkedin.com/in/sarahjohnson"
      },
      "products": [
        "Google Search",
        "Google Cloud",
        "Android OS",
        "YouTube",
        "Google Ads"
      ],
      "achievements": [
        "2+ Billion Active Users",
        "AI/ML Innovation Leader",
        "Green Energy Initiatives",
        "Global Infrastructure"
      ],
      "socialMedia": {
        "twitter": "@Google",
        "linkedin": "google",
        "facebook": "Google"
      },
      "sponsorshipHistory": [
        {"year": 2023, "amount": 30000, "tier": "Gold"},
        {"year": 2022, "amount": 25000, "tier": "Silver"},
      ],
      "rating": 4.8,
      "isVerified": true,
      "lastContact": "2024-06-15",
    },
    {
      "id": 3,
      "name": "Johnson & Johnson",
      "tier": "Silver",
      "industry": "Healthcare",
      "logo": "https://picsum.photos/100/100?random=3&keyword=healthcare",
      "description": "American multinational corporation developing medical devices, pharmaceuticals, and consumer goods",
      "website": "https://jnj.com",
      "founded": 1886,
      "employees": "140,000+",
      "headquarters": "New Brunswick, NJ, USA",
      "contact": {
        "name": "Dr. Michael Brown",
        "title": "Corporate Relations Director",
        "email": "m.brown@jnj.com",
        "phone": "+1-555-0789",
        "linkedin": "linkedin.com/in/drmichaelbrown"
      },
      "products": [
        "Medical Devices",
        "Pharmaceuticals",
        "Consumer Products",
        "Vaccines",
        "Surgical Equipment"
      ],
      "achievements": [
        "130+ Years of Innovation",
        "Global Health Impact",
        "R&D Investment Leader",
        "Sustainable Practices"
      ],
      "socialMedia": {
        "twitter": "@JNJNews",
        "linkedin": "johnson-johnson",
        "facebook": "JNJ"
      },
      "sponsorshipHistory": [
        {"year": 2023, "amount": 15000, "tier": "Silver"},
      ],
      "rating": 4.7,
      "isVerified": true,
      "lastContact": "2024-06-12",
    },
    {
      "id": 4,
      "name": "Tesla Inc.",
      "tier": "Gold",
      "industry": "Automotive",
      "logo": "https://picsum.photos/100/100?random=4&keyword=tesla",
      "description": "Electric vehicle and clean energy company revolutionizing transportation and energy",
      "website": "https://tesla.com",
      "founded": 2003,
      "employees": "127,000+",
      "headquarters": "Austin, TX, USA",
      "contact": {
        "name": "Emma Wilson",
        "title": "Strategic Partnerships Manager",
        "email": "e.wilson@tesla.com",
        "phone": "+1-555-0321",
        "linkedin": "linkedin.com/in/emmawilson"
      },
      "products": [
        "Electric Vehicles",
        "Energy Storage",
        "Solar Panels",
        "Charging Infrastructure",
        "Autonomous Driving"
      ],
      "achievements": [
        "EV Market Leader",
        "Sustainable Transportation",
        "Innovation Awards",
        "Global Expansion"
      ],
      "socialMedia": {
        "twitter": "@Tesla",
        "linkedin": "tesla-motors",
        "facebook": "Tesla"
      },
      "sponsorshipHistory": [
        {"year": 2023, "amount": 28000, "tier": "Gold"},
        {"year": 2022, "amount": 20000, "tier": "Silver"},
      ],
      "rating": 4.6,
      "isVerified": true,
      "lastContact": "2024-06-10",
    },
    {
      "id": 5,
      "name": "Goldman Sachs",
      "tier": "Bronze",
      "industry": "Finance",
      "logo": "https://picsum.photos/100/100?random=5&keyword=finance",
      "description": "Leading global investment banking, securities and investment management firm",
      "website": "https://goldmansachs.com",
      "founded": 1869,
      "employees": "49,000+",
      "headquarters": "New York, NY, USA",
      "contact": {
        "name": "Robert Davis",
        "title": "Corporate Engagement Lead",
        "email": "r.davis@gs.com",
        "phone": "+1-555-0654",
        "linkedin": "linkedin.com/in/robertdavis"
      },
      "products": [
        "Investment Banking",
        "Securities Trading",
        "Asset Management",
        "Consumer Banking",
        "Risk Management"
      ],
      "achievements": [
        "150+ Years in Business",
        "Global Financial Leader",
        "Innovation in FinTech",
        "Sustainable Finance"
      ],
      "socialMedia": {
        "twitter": "@GoldmanSachs",
        "linkedin": "goldman-sachs",
        "facebook": "GoldmanSachs"
      },
      "sponsorshipHistory": [
        {"year": 2023, "amount": 8000, "tier": "Bronze"},
      ],
      "rating": 4.5,
      "isVerified": true,
      "lastContact": "2024-06-08",
    },
  ];

  List<String> tierOptions = ["All", "Platinum", "Gold", "Silver", "Bronze"];
  List<String> industryOptions = ["All", "Technology", "Healthcare", "Automotive", "Finance"];
  List<String> sortOptions = ["Name", "Tier", "Industry", "Rating", "Last Contact"];

  List<Map<String, dynamic>> get filteredAndSortedSponsors {
    List<Map<String, dynamic>> filtered = sponsors.where((sponsor) {
      bool matchesSearch = sponsor["name"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      bool matchesTier = selectedTier == "All" || sponsor["tier"] == selectedTier;
      bool matchesIndustry = selectedIndustry == "All" || sponsor["industry"] == selectedIndustry;
      return matchesSearch && matchesTier && matchesIndustry;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Name":
          return a["name"].compareTo(b["name"]);
        case "Tier":
          List<String> tierOrder = ["Platinum", "Gold", "Silver", "Bronze"];
          return tierOrder.indexOf(a["tier"]).compareTo(tierOrder.indexOf(b["tier"]));
        case "Industry":
          return a["industry"].compareTo(b["industry"]);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Last Contact":
          return b["lastContact"].compareTo(a["lastContact"]);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsor Profiles"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new sponsor profile");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildSearchAndFilters(),
            SizedBox(height: spMd),
            _buildSponsorStats(),
            SizedBox(height: spMd),
            _buildSponsorsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        QTextField(
          label: "Search Sponsors",
          value: searchQuery,
          hint: "Enter sponsor name or industry...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Tier",
                items: tierOptions.map((tier) => {
                  "label": tier,
                  "value": tier,
                }).toList(),
                value: selectedTier,
                onChanged: (value, label) {
                  selectedTier = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Industry",
                items: industryOptions.map((industry) => {
                  "label": industry,
                  "value": industry,
                }).toList(),
                value: selectedIndustry,
                onChanged: (value, label) {
                  selectedIndustry = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        QDropdownField(
          label: "Sort By",
          items: sortOptions.map((sort) => {
            "label": sort,
            "value": sort,
          }).toList(),
          value: sortBy,
          onChanged: (value, label) {
            sortBy = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSponsorStats() {
    Map<String, int> tierCounts = {};
    Map<String, int> industryCounts = {};
    
    for (var sponsor in sponsors) {
      String tier = sponsor["tier"];
      String industry = sponsor["industry"];
      tierCounts[tier] = (tierCounts[tier] ?? 0) + 1;
      industryCounts[industry] = (industryCounts[industry] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Sponsors", "${sponsors.length}", primaryColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatItem("Verified", "${sponsors.where((s) => s["isVerified"]).length}", successColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatItem("Industries", "${industryOptions.length - 1}", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSponsorsList() {
    return Column(
      children: filteredAndSortedSponsors.map((sponsor) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildSponsorHeader(sponsor),
              _buildSponsorDetails(sponsor),
              _buildSponsorActions(sponsor),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSponsorHeader(Map<String, dynamic> sponsor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusMd),
          topRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${sponsor["logo"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
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
                        "${sponsor["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (sponsor["isVerified"])
                      Icon(Icons.verified, color: Colors.white, size: 16),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildHeaderBadge(sponsor["tier"], _getTierColor(sponsor["tier"])),
                    SizedBox(width: spXs),
                    _buildHeaderBadge(sponsor["industry"], Colors.white.withAlpha(200)),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 14),
                    SizedBox(width: 2),
                    Text(
                      "${sponsor["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.business, color: Colors.white, size: 14),
                    SizedBox(width: 2),
                    Text(
                      "Since ${sponsor["founded"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
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

  Widget _buildHeaderBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(200),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case "Platinum":
        return Color(0xFF8E44AD);
      case "Gold":
        return Color(0xFFFFD700);
      case "Silver":
        return Color(0xFFC0C0C0);
      case "Bronze":
        return Color(0xFFCD7F32);
      default:
        return disabledColor;
    }
  }

  Widget _buildSponsorDetails(Map<String, dynamic> sponsor) {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${sponsor["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildInfoGrid(sponsor),
          SizedBox(height: spSm),
          _buildContactInfo(sponsor["contact"]),
          SizedBox(height: spSm),
          _buildProductsAndAchievements(sponsor),
          SizedBox(height: spSm),
          _buildSponsorshipHistory(sponsor["sponsorshipHistory"]),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(Map<String, dynamic> sponsor) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInfoItem("Website", "${sponsor["website"]}")),
              Expanded(child: _buildInfoItem("Employees", "${sponsor["employees"]}")),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(child: _buildInfoItem("Founded", "${sponsor["founded"]}")),
              Expanded(child: _buildInfoItem("HQ", "${sponsor["headquarters"]}")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(Map<String, dynamic> contact) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Primary Contact",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${contact["name"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${contact["title"]}",
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
                    "${contact["email"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${contact["phone"]}",
                    style: TextStyle(
                      fontSize: 11,
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
  }

  Widget _buildProductsAndAchievements(Map<String, dynamic> sponsor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Products",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(sponsor["products"] as List).take(3).map((product) {
                return Row(
                  children: [
                    Icon(Icons.arrow_right, color: successColor, size: 12),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "$product",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(sponsor["achievements"] as List).take(3).map((achievement) {
                return Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 12),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "$achievement",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSponsorshipHistory(List<dynamic> history) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sponsorship History",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          SizedBox(height: spXs),
          QHorizontalScroll(
            children: history.map<Widget>((entry) {
              return Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Text(
                      "${entry["year"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "${entry["tier"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((entry["amount"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
  }

  Widget _buildSponsorActions(Map<String, dynamic> sponsor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusMd),
          bottomRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {
                ss("Viewing ${sponsor["name"]} full profile");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Contact",
              size: bs.sm,
              onPressed: () {
                ss("Contacting ${sponsor["contact"]["name"]}");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Edit",
              size: bs.sm,
              onPressed: () {
                ss("Editing ${sponsor["name"]} profile");
              },
            ),
          ),
        ],
      ),
    );
  }
}
