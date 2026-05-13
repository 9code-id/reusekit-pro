import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaInterestsView extends StatefulWidget {
  const NmaInterestsView({Key? key}) : super(key: key);

  @override
  State<NmaInterestsView> createState() => _NmaInterestsViewState();
}

class _NmaInterestsViewState extends State<NmaInterestsView> {
  List<String> selectedInterests = ["technology", "science", "business", "health"];
  String searchQuery = "";
  bool showOnlySelected = false;
  
  List<Map<String, dynamic>> interestCategories = [
    {
      "category": "Technology",
      "icon": Icons.computer,
      "color": Colors.blue,
      "interests": [
        {"id": "technology", "name": "Technology", "description": "Latest tech news and innovations", "selected": true, "followers": 125000},
        {"id": "ai", "name": "Artificial Intelligence", "description": "AI research and applications", "selected": false, "followers": 98000},
        {"id": "programming", "name": "Programming", "description": "Software development and coding", "selected": false, "followers": 87000},
        {"id": "mobile", "name": "Mobile Development", "description": "iOS and Android development", "selected": false, "followers": 65000},
        {"id": "web", "name": "Web Development", "description": "Frontend and backend web technologies", "selected": false, "followers": 72000},
        {"id": "cybersecurity", "name": "Cybersecurity", "description": "Security, privacy, and data protection", "selected": false, "followers": 54000},
      ]
    },
    {
      "category": "Science",
      "icon": Icons.science,
      "color": Colors.green,
      "interests": [
        {"id": "science", "name": "Science", "description": "General science news and discoveries", "selected": true, "followers": 110000},
        {"id": "physics", "name": "Physics", "description": "Physics research and breakthroughs", "selected": false, "followers": 45000},
        {"id": "biology", "name": "Biology", "description": "Life sciences and biological research", "selected": false, "followers": 52000},
        {"id": "chemistry", "name": "Chemistry", "description": "Chemical research and applications", "selected": false, "followers": 38000},
        {"id": "space", "name": "Space & Astronomy", "description": "Space exploration and astronomy", "selected": false, "followers": 76000},
        {"id": "medicine", "name": "Medical Research", "description": "Medical breakthroughs and healthcare", "selected": false, "followers": 89000},
      ]
    },
    {
      "category": "Business & Finance",
      "icon": Icons.business,
      "color": Colors.orange,
      "interests": [
        {"id": "business", "name": "Business", "description": "Business news and market analysis", "selected": true, "followers": 95000},
        {"id": "finance", "name": "Finance", "description": "Financial markets and investment", "selected": false, "followers": 82000},
        {"id": "entrepreneurship", "name": "Entrepreneurship", "description": "Startup news and business tips", "selected": false, "followers": 67000},
        {"id": "economics", "name": "Economics", "description": "Economic analysis and policy", "selected": false, "followers": 43000},
        {"id": "crypto", "name": "Cryptocurrency", "description": "Digital currencies and blockchain", "selected": false, "followers": 71000},
        {"id": "investing", "name": "Investing", "description": "Investment strategies and tips", "selected": false, "followers": 58000},
      ]
    },
    {
      "category": "Health & Wellness",
      "icon": Icons.health_and_safety,
      "color": Colors.red,
      "interests": [
        {"id": "health", "name": "Health", "description": "Health tips and medical news", "selected": true, "followers": 102000},
        {"id": "fitness", "name": "Fitness", "description": "Exercise and physical wellness", "selected": false, "followers": 78000},
        {"id": "nutrition", "name": "Nutrition", "description": "Diet and healthy eating", "selected": false, "followers": 64000},
        {"id": "mental_health", "name": "Mental Health", "description": "Mental wellness and psychology", "selected": false, "followers": 59000},
        {"id": "wellness", "name": "Wellness", "description": "Overall wellbeing and lifestyle", "selected": false, "followers": 47000},
        {"id": "medical", "name": "Medical News", "description": "Latest medical research and news", "selected": false, "followers": 73000},
      ]
    },
    {
      "category": "Environment",
      "icon": Icons.eco,
      "color": Colors.teal,
      "interests": [
        {"id": "environment", "name": "Environment", "description": "Environmental news and conservation", "selected": false, "followers": 68000},
        {"id": "climate", "name": "Climate Change", "description": "Climate science and policy", "selected": false, "followers": 75000},
        {"id": "sustainability", "name": "Sustainability", "description": "Sustainable living and practices", "selected": false, "followers": 56000},
        {"id": "renewable", "name": "Renewable Energy", "description": "Clean energy and technology", "selected": false, "followers": 49000},
        {"id": "conservation", "name": "Conservation", "description": "Wildlife and nature conservation", "selected": false, "followers": 41000},
      ]
    },
    {
      "category": "Sports & Entertainment",
      "icon": Icons.sports,
      "color": Colors.purple,
      "interests": [
        {"id": "sports", "name": "Sports", "description": "Sports news and updates", "selected": false, "followers": 92000},
        {"id": "entertainment", "name": "Entertainment", "description": "Movies, TV, and celebrity news", "selected": false, "followers": 87000},
        {"id": "gaming", "name": "Gaming", "description": "Video games and gaming industry", "selected": false, "followers": 79000},
        {"id": "music", "name": "Music", "description": "Music industry and artist news", "selected": false, "followers": 63000},
        {"id": "movies", "name": "Movies & TV", "description": "Film and television industry", "selected": false, "followers": 71000},
      ]
    },
  ];

  List<Map<String, dynamic>> recommendedInterests = [
    {"id": "ai", "name": "Artificial Intelligence", "reason": "Based on your Technology interest", "similarity": 95},
    {"id": "space", "name": "Space & Astronomy", "reason": "Popular among Science followers", "similarity": 88},
    {"id": "finance", "name": "Finance", "reason": "Complements your Business interest", "similarity": 82},
    {"id": "mental_health", "name": "Mental Health", "reason": "Trending in Health category", "similarity": 76},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interests"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: Icon(showOnlySelected ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              showOnlySelected = !showOnlySelected;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Interest summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(10), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Your Interests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      _buildSummaryCard("Selected", selectedInterests.length.toString(), Icons.check_circle),
                      SizedBox(width: spSm),
                      _buildSummaryCard("Following", "24.5K", Icons.people),
                      SizedBox(width: spSm),
                      _buildSummaryCard("Articles", "1,247", Icons.article),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Personalized content based on ${selectedInterests.length} selected interests",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Recommended interests
            if (recommendedInterests.isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.recommend,
                    color: primaryColor,
                    size: 18,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Recommended for You",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                height: 120,
                child: QHorizontalScroll(
                  children: recommendedInterests.map((interest) => _buildRecommendedCard(interest)).toList(),
                ),
              ),
            ],

            // Interest categories
            Text(
              showOnlySelected ? "Your Selected Interests" : "All Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...interestCategories.map((category) => _buildCategorySection(category)),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Changes",
                    size: bs.md,
                    onPressed: () => _saveInterests(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Reset to Default",
                    size: bs.md,
                    onPressed: () => _resetToDefault(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor.withAlpha(20)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 16,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedCard(Map<String, dynamic> interest) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Text(
                  "${interest["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${interest["similarity"]}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${interest["reason"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Interest",
              size: bs.sm,
              onPressed: () => _addRecommendedInterest(interest),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> category) {
    List<Map<String, dynamic>> interests = category["interests"];
    
    // Filter interests based on showOnlySelected
    if (showOnlySelected) {
      interests = interests.where((interest) => interest["selected"]).toList();
      if (interests.isEmpty) return SizedBox.shrink();
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (category["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Icon(
                  category["icon"],
                  color: category["color"],
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: category["color"],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: category["color"],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${interests.where((i) => i["selected"]).length}/${interests.length}",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...interests.map((interest) => _buildInterestItem(interest, category["color"])),
        ],
      ),
    );
  }

  Widget _buildInterestItem(Map<String, dynamic> interest, Color categoryColor) {
    bool isSelected = interest["selected"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _toggleInterest(interest),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? categoryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: isSelected ? categoryColor : disabledOutlineBorderColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${interest["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? categoryColor : Colors.black,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${interest["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.people, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${(interest["followers"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} followers",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isSelected)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "FOLLOWING",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _toggleInterest(Map<String, dynamic> interest) {
    interest["selected"] = !interest["selected"];
    
    if (interest["selected"]) {
      selectedInterests.add(interest["id"]);
    } else {
      selectedInterests.remove(interest["id"]);
    }
    
    setState(() {});
  }

  void _addRecommendedInterest(Map<String, dynamic> interest) {
    // Find the interest in categories and mark as selected
    for (var category in interestCategories) {
      var interests = category["interests"] as List<Map<String, dynamic>>;
      var foundInterest = interests.firstWhere(
        (i) => i["id"] == interest["id"],
        orElse: () => {},
      );
      if (foundInterest.isNotEmpty) {
        foundInterest["selected"] = true;
        selectedInterests.add(interest["id"]);
        break;
      }
    }
    
    // Remove from recommendations
    recommendedInterests.removeWhere((r) => r["id"] == interest["id"]);
    
    setState(() {});
    ss("Added ${interest["name"]} to your interests");
  }

  void _saveInterests() {
    ss("Your interests have been saved successfully");
  }

  void _resetToDefault() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset Interests"),
        content: Text("This will reset all your interests to the default selection. Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Reset",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              _performReset();
            },
          ),
        ],
      ),
    );
  }

  void _performReset() {
    // Reset all interests
    for (var category in interestCategories) {
      var interests = category["interests"] as List<Map<String, dynamic>>;
      for (var interest in interests) {
        interest["selected"] = false;
      }
    }
    
    // Set default interests
    selectedInterests = ["technology", "science", "business", "health"];
    
    // Mark default interests as selected
    for (var category in interestCategories) {
      var interests = category["interests"] as List<Map<String, dynamic>>;
      for (var interest in interests) {
        if (selectedInterests.contains(interest["id"])) {
          interest["selected"] = true;
        }
      }
    }
    
    setState(() {});
    ss("Interests have been reset to default");
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Interests"),
        content: QTextField(
          label: "Search interests...",
          value: searchQuery,
          hint: "Enter interest name or keyword",
          onChanged: (value) {
            searchQuery = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              _performSearch();
            },
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    if (searchQuery.trim().isEmpty) return;
    ss("Searching for: $searchQuery");
    // Implement search functionality
  }
}
