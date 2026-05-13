import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmMatchmakingView extends StatefulWidget {
  const EcmMatchmakingView({super.key});

  @override
  State<EcmMatchmakingView> createState() => _EcmMatchmakingViewState();
}

class _EcmMatchmakingViewState extends State<EcmMatchmakingView> {
  String searchQuery = "";
  String selectedIndustry = "";
  String selectedGoal = "";
  String selectedExperience = "";
  bool enableAutoMatch = true;
  bool enableLocationMatch = false;
  bool enableInterestMatch = true;
  bool showOnlineOnly = false;

  List<Map<String, dynamic>> industryOptions = [
    {"label": "All Industries", "value": ""},
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Real Estate", "value": "real_estate"},
  ];

  List<Map<String, dynamic>> goalOptions = [
    {"label": "All Goals", "value": ""},
    {"label": "Find Investors", "value": "investors"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Mentorship", "value": "mentorship"},
    {"label": "Job Opportunity", "value": "job"},
    {"label": "Knowledge Sharing", "value": "knowledge"},
    {"label": "Business Development", "value": "business"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "All Levels", "value": ""},
    {"label": "Entry Level", "value": "entry"},
    {"label": "Mid Level", "value": "mid"},
    {"label": "Senior Level", "value": "senior"},
    {"label": "Executive", "value": "executive"},
  ];

  List<Map<String, dynamic>> matches = [
    {
      "id": "match_001",
      "name": "Sarah Johnson",
      "title": "Senior Product Manager",
      "company": "TechFlow Solutions",
      "industry": "Technology",
      "location": "San Francisco, CA",
      "goal": "Partnership",
      "experience": "senior",
      "interests": ["AI/ML", "Product Strategy", "Team Leadership"],
      "compatibility": 95,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=professional",
      "isOnline": true,
      "commonConnections": 12,
      "matchReason": "Similar leadership experience and shared interests in AI/ML",
      "availability": "Available for coffee this week",
    },
    {
      "id": "match_002", 
      "name": "Michael Chen",
      "title": "Startup Founder",
      "company": "GreenTech Innovations",
      "industry": "Technology",
      "location": "Austin, TX",
      "goal": "Find Investors",
      "experience": "executive",
      "interests": ["Sustainability", "Clean Energy", "Fundraising"],
      "compatibility": 88,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=business",
      "isOnline": false,
      "commonConnections": 8,
      "matchReason": "Both focused on sustainable technology solutions",
      "availability": "Open to virtual meetings",
    },
    {
      "id": "match_003",
      "name": "Dr. Emily Rodriguez",
      "title": "Research Director",
      "company": "MedTech Labs",
      "industry": "Healthcare",
      "location": "Boston, MA",
      "goal": "Knowledge Sharing",
      "experience": "senior",
      "interests": ["Medical Devices", "Research", "Innovation"],
      "compatibility": 82,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=doctor",
      "isOnline": true,
      "commonConnections": 5,
      "matchReason": "Complementary expertise in technology and healthcare",
      "availability": "Available for lunch meetings",
    },
    {
      "id": "match_004",
      "name": "James Wilson",
      "title": "Investment Manager",
      "company": "Capital Ventures",
      "industry": "Finance",
      "location": "New York, NY", 
      "goal": "Business Development",
      "experience": "mid",
      "interests": ["Fintech", "Investment Strategy", "Market Analysis"],
      "compatibility": 79,
      "avatar": "https://picsum.photos/80/80?random=4&keyword=finance",
      "isOnline": false,
      "commonConnections": 15,
      "matchReason": "Strong background in investment and business growth",
      "availability": "Flexible schedule this month",
    },
    {
      "id": "match_005",
      "name": "Lisa Park",
      "title": "Marketing Director",
      "company": "BrandForward Agency",
      "industry": "Marketing",
      "location": "Los Angeles, CA",
      "goal": "Partnership",
      "experience": "senior",
      "interests": ["Digital Marketing", "Brand Strategy", "Content Creation"],
      "compatibility": 86,
      "avatar": "https://picsum.photos/80/80?random=5&keyword=creative",
      "isOnline": true,
      "commonConnections": 9,
      "matchReason": "Expertise in marketing aligns with your business goals",
      "availability": "Available for video calls",
    },
    {
      "id": "match_006",
      "name": "David Kumar",
      "title": "Software Architect",
      "company": "CloudScale Systems",
      "industry": "Technology",
      "location": "Seattle, WA",
      "goal": "Mentorship",
      "experience": "senior",
      "interests": ["Cloud Computing", "System Architecture", "Team Mentoring"],
      "compatibility": 91,
      "avatar": "https://picsum.photos/80/80?random=6&keyword=tech",
      "isOnline": true,
      "commonConnections": 7,
      "matchReason": "Excellent mentor with strong technical leadership skills",
      "availability": "Open to regular mentoring sessions",
    },
  ];

  List<Map<String, dynamic>> get filteredMatches {
    return matches.where((match) {
      if (searchQuery.isNotEmpty) {
        final searchLower = searchQuery.toLowerCase();
        final matchesSearch = 
          match["name"].toString().toLowerCase().contains(searchLower) ||
          match["title"].toString().toLowerCase().contains(searchLower) ||
          match["company"].toString().toLowerCase().contains(searchLower) ||
          (match["interests"] as List).any((interest) => 
            interest.toString().toLowerCase().contains(searchLower));
        if (!matchesSearch) return false;
      }

      if (selectedIndustry.isNotEmpty && match["industry"] != selectedIndustry) {
        return false;
      }

      if (selectedGoal.isNotEmpty && match["goal"] != selectedGoal) {
        return false;
      }

      if (selectedExperience.isNotEmpty && match["experience"] != selectedExperience) {
        return false;
      }

      if (showOnlineOnly && !(match["isOnline"] as bool)) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Matchmaking"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _showMatchingSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMatchingStats(),
            _buildSearchAndFilters(),
            _buildMatchingSettings(),
            _buildMatchesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchingStats() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people_alt,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${filteredMatches.length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Matches",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(20)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${filteredMatches.where((m) => (m["compatibility"] as int) >= 85).length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "High Compatibility",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.wifi_tethering,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${filteredMatches.where((m) => m["isOnline"] as bool).length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Online Now",
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
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search matches",
          value: searchQuery,
          hint: "Search by name, title, company, or interests",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Industry",
                items: industryOptions,
                value: selectedIndustry,
                onChanged: (value, label) {
                  selectedIndustry = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Goal",
                items: goalOptions,
                value: selectedGoal,
                onChanged: (value, label) {
                  selectedGoal = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Experience",
                items: experienceOptions,
                value: selectedExperience,
                onChanged: (value, label) {
                  selectedExperience = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Online Only",
                    "value": true,
                    "checked": showOnlineOnly,
                  }
                ],
                value: [
                  if (showOnlineOnly)
                    {
                      "label": "Online Only",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  showOnlineOnly = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMatchingSettings() {
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
          Text(
            "Matching Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Match",
                "value": "auto",
                "checked": enableAutoMatch,
              },
              {
                "label": "Location Based",
                "value": "location",
                "checked": enableLocationMatch,
              },
              {
                "label": "Interest Based",
                "value": "interest",
                "checked": enableInterestMatch,
              }
            ],
            value: [
              if (enableAutoMatch)
                {
                  "label": "Auto Match",
                  "value": "auto",
                  "checked": true
                },
              if (enableLocationMatch)
                {
                  "label": "Location Based",
                  "value": "location",
                  "checked": true
                },
              if (enableInterestMatch)
                {
                  "label": "Interest Based",
                  "value": "interest",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableAutoMatch = values.any((v) => v["value"] == "auto");
              enableLocationMatch = values.any((v) => v["value"] == "location");
              enableInterestMatch = values.any((v) => v["value"] == "interest");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recommended Matches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Refresh",
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                si("Refreshing matches...");
              },
            ),
          ],
        ),
        if (filteredMatches.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "No matches found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Try adjusting your search criteria",
                  style: TextStyle(
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredMatches.map((match) => _buildMatchCard(match)).toList(),
      ],
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
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
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${match["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (match["isOnline"] as bool)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${match["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getCompatibilityColor(match["compatibility"] as int)
                                  .withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: _getCompatibilityColor(match["compatibility"] as int)
                                    .withAlpha(20),
                              ),
                            ),
                            child: Text(
                              "${match["compatibility"]}% Match",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getCompatibilityColor(match["compatibility"] as int),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${match["title"]} at ${match["company"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        spacing: spXs,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: disabledColor,
                          ),
                          Text(
                            "${match["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.people,
                            size: 14,
                            color: disabledColor,
                          ),
                          Text(
                            "${match["commonConnections"]} mutual",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(10)),
                  ),
                  child: Text(
                    "${match["matchReason"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (match["interests"] as List).map((interest) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(20)),
                      ),
                      child: Text(
                        "$interest",
                        style: TextStyle(
                          fontSize: 11,
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${match["availability"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Connect",
                    icon: Icons.person_add,
                    size: bs.sm,
                    onPressed: () => _connectWithMatch(match),
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "View Profile",
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () => _viewMatchProfile(match),
                  ),
                ),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () => _messageMatch(match),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCompatibilityColor(int compatibility) {
    if (compatibility >= 90) return successColor;
    if (compatibility >= 80) return infoColor;
    if (compatibility >= 70) return warningColor;
    return disabledBoldColor;
  }

  void _connectWithMatch(Map<String, dynamic> match) {
    ss("Connection request sent to ${match["name"]}");
  }

  void _viewMatchProfile(Map<String, dynamic> match) {
    si("Opening ${match["name"]}'s profile");
  }

  void _messageMatch(Map<String, dynamic> match) {
    si("Starting conversation with ${match["name"]}");
  }

  void _showMatchingSettings() {
    si("Opening matching settings");
  }
}
