import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaInterestsSelectionView extends StatefulWidget {
  const SmaInterestsSelectionView({super.key});

  @override
  State<SmaInterestsSelectionView> createState() => _SmaInterestsSelectionViewState();
}

class _SmaInterestsSelectionViewState extends State<SmaInterestsSelectionView> {
  List<String> selectedInterests = [];
  String searchQuery = "";
  
  List<Map<String, dynamic>> interestCategories = [
    {
      "category": "Technology",
      "interests": [
        {"name": "Programming", "icon": Icons.code},
        {"name": "Artificial Intelligence", "icon": Icons.psychology},
        {"name": "Mobile Development", "icon": Icons.phone_android},
        {"name": "Web Development", "icon": Icons.web},
        {"name": "Data Science", "icon": Icons.analytics},
        {"name": "Cybersecurity", "icon": Icons.security},
        {"name": "Gaming", "icon": Icons.games},
        {"name": "Blockchain", "icon": Icons.currency_bitcoin},
      ]
    },
    {
      "category": "Arts & Creativity",
      "interests": [
        {"name": "Photography", "icon": Icons.camera_alt},
        {"name": "Painting", "icon": Icons.brush},
        {"name": "Music", "icon": Icons.music_note},
        {"name": "Writing", "icon": Icons.edit},
        {"name": "Design", "icon": Icons.design_services},
        {"name": "Drawing", "icon": Icons.draw},
        {"name": "Dancing", "icon": Icons.music_video},
        {"name": "Crafting", "icon": Icons.handyman},
      ]
    },
    {
      "category": "Sports & Fitness",
      "interests": [
        {"name": "Football", "icon": Icons.sports_football},
        {"name": "Basketball", "icon": Icons.sports_basketball},
        {"name": "Tennis", "icon": Icons.sports_tennis},
        {"name": "Running", "icon": Icons.directions_run},
        {"name": "Yoga", "icon": Icons.self_improvement},
        {"name": "Swimming", "icon": Icons.pool},
        {"name": "Cycling", "icon": Icons.pedal_bike},
        {"name": "Hiking", "icon": Icons.hiking},
      ]
    },
    {
      "category": "Food & Cooking",
      "interests": [
        {"name": "Cooking", "icon": Icons.restaurant},
        {"name": "Baking", "icon": Icons.cake},
        {"name": "Wine Tasting", "icon": Icons.wine_bar},
        {"name": "Vegetarian", "icon": Icons.eco},
        {"name": "International Cuisine", "icon": Icons.public},
        {"name": "Food Photography", "icon": Icons.camera},
        {"name": "Grilling", "icon": Icons.outdoor_grill},
        {"name": "Coffee", "icon": Icons.coffee},
      ]
    },
    {
      "category": "Travel & Adventure",
      "interests": [
        {"name": "Traveling", "icon": Icons.flight},
        {"name": "Backpacking", "icon": Icons.backpack},
        {"name": "Beach", "icon": Icons.beach_access},
        {"name": "Mountains", "icon": Icons.terrain},
        {"name": "Culture", "icon": Icons.museum},
        {"name": "Adventure Sports", "icon": Icons.snowboarding},
        {"name": "Road Trips", "icon": Icons.directions_car},
        {"name": "Camping", "icon": Icons.outdoor_grill},
      ]
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Interests"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          _buildSearchBar(),
          _buildSelectedInterests(),
          Expanded(
            child: _buildInterestsList(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setup Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Step 3 of 4",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QTextField(
              label: "Search interests...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSelectedInterests() {
    if (selectedInterests.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: primaryColor,
                size: 18,
              ),
              SizedBox(width: spXs),
              Text(
                "Selected Interests (${selectedInterests.length})",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: selectedInterests.map((interest) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      interest,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        selectedInterests.remove(interest);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
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
  
  Widget _buildInterestsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        spacing: spMd,
        children: List.generate(interestCategories.length, (categoryIndex) {
          final category = interestCategories[categoryIndex];
          final interests = category["interests"] as List<Map<String, dynamic>>;
          
          // Filter interests based on search query
          final filteredInterests = interests.where((interest) {
            return searchQuery.isEmpty ||
                interest["name"].toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();
          
          if (filteredInterests.isEmpty && searchQuery.isNotEmpty) {
            return SizedBox.shrink();
          }
          
          return _buildInterestCategory(category["category"], filteredInterests);
        }),
      ),
    );
  }
  
  Widget _buildInterestCategory(String categoryName, List<Map<String, dynamic>> interests) {
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
          Text(
            categoryName,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: interests.map((interest) {
              final isSelected = selectedInterests.contains(interest["name"]);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedInterests.remove(interest["name"]);
                  } else {
                    selectedInterests.add(interest["name"]);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        interest["icon"] as IconData,
                        size: 18,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        interest["name"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Continue (${selectedInterests.length} selected)",
              onPressed: selectedInterests.isNotEmpty ? () {
                ss("Interests saved successfully!");
                //navigateTo('ContactsSyncView')
              } : null,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Skip for Now",
              onPressed: () {
                //navigateTo('ContactsSyncView')
              },
            ),
          ),
        ],
      ),
    );
  }
}
