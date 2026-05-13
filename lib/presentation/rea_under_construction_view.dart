import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaUnderConstructionView extends StatefulWidget {
  const ReaUnderConstructionView({super.key});

  @override
  State<ReaUnderConstructionView> createState() => _ReaUnderConstructionViewState();
}

class _ReaUnderConstructionViewState extends State<ReaUnderConstructionView> {
  String email = "";
  
  List<Map<String, dynamic>> constructionProjects = [
    {
      "id": 1,
      "name": "Skyline Towers",
      "location": "Downtown Miami, FL",
      "type": "Luxury Condominiums",
      "units": 250,
      "floors": 45,
      "startDate": "January 2024",
      "completionDate": "December 2025",
      "progress": 35,
      "priceRange": "450K - 2.5M",
      "image": "https://picsum.photos/400/300?random=1&keyword=construction",
      "developer": "Premier Development Group",
      "architect": "Modern Design Studio",
      "amenities": [
        "Rooftop Pool",
        "Fitness Center",
        "Concierge Service",
        "Valet Parking",
        "Sky Lounge",
        "Business Center",
      ],
      "description": "A stunning 45-story luxury condominium tower featuring panoramic city and ocean views, world-class amenities, and premium finishes throughout.",
    },
    {
      "id": 2,
      "name": "Oceanview Residences",
      "location": "Miami Beach, FL",
      "type": "Beachfront Villas",
      "units": 75,
      "floors": 3,
      "startDate": "March 2024",
      "completionDate": "September 2025",
      "progress": 20,
      "priceRange": "1.2M - 5M",
      "image": "https://picsum.photos/400/300?random=2&keyword=villa",
      "developer": "Coastal Living Corp",
      "architect": "Ocean View Architects",
      "amenities": [
        "Private Beach",
        "Marina Access",
        "Spa & Wellness",
        "Tennis Court",
        "Kids Club",
        "Restaurant",
      ],
      "description": "Exclusive beachfront villas offering direct ocean access, private pools, and resort-style living just steps from the sand.",
    },
    {
      "id": 3,
      "name": "Garden District Homes",
      "location": "Coral Gables, FL",
      "type": "Single Family Homes",
      "units": 120,
      "floors": 2,
      "startDate": "June 2024",
      "completionDate": "June 2026",
      "progress": 10,
      "priceRange": "800K - 1.8M",
      "image": "https://picsum.photos/400/300?random=3&keyword=homes",
      "developer": "Family First Builders",
      "architect": "Traditional Home Design",
      "amenities": [
        "Community Pool",
        "Playground",
        "Walking Trails",
        "Clubhouse",
        "Dog Park",
        "Security Gate",
      ],
      "description": "Beautiful single-family homes in a gated community featuring traditional architecture, spacious lots, and family-friendly amenities.",
    },
  ];

  List<Map<String, dynamic>> constructionUpdates = [
    {
      "date": "November 15, 2024",
      "project": "Skyline Towers",
      "title": "Floor 15 Completed",
      "description": "Construction team successfully completed the 15th floor concrete pour and steel reinforcement.",
      "image": "https://picsum.photos/300/200?random=10&keyword=building",
      "type": "Progress Update",
    },
    {
      "date": "November 12, 2024",
      "project": "Oceanview Residences",
      "title": "Foundation Work Complete",
      "description": "All foundation work has been completed ahead of schedule. Beginning first floor construction next week.",
      "image": "https://picsum.photos/300/200?random=11&keyword=foundation",
      "type": "Milestone",
    },
    {
      "date": "November 8, 2024",
      "project": "Garden District Homes",
      "title": "Site Preparation Underway",
      "description": "Land clearing and utility installation is in progress. Model home construction to begin December 2024.",
      "image": "https://picsum.photos/300/200?random=12&keyword=site",
      "type": "Progress Update",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Under Construction"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            _buildHeaderSection(),
            _buildProjectsList(),
            _buildConstructionUpdates(),
            _buildNotificationSignup(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.construction,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Under Construction",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Coming Soon Properties",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Discover exclusive pre-construction opportunities with guaranteed pricing and early buyer incentives.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
              height: 1.4,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatsCard("Active Projects", "${constructionProjects.length}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatsCard("Total Units", "${constructionProjects.fold(0, (sum, project) => sum + (project["units"] as int))}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatsCard("Avg. Progress", "${(constructionProjects.fold(0, (sum, project) => sum + (project["progress"] as int)) / constructionProjects.length).round()}%"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Current Projects",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...constructionProjects.map((project) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${project["image"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getProgressColor(project["progress"] as int),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${project["progress"]}% Complete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${project["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${project["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${project["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${project["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      _buildProjectStats(project),
                      _buildProgressBar(project["progress"] as int),
                      _buildProjectTimeline(project),
                      _buildAmenitiesPreview(project["amenities"] as List),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                _viewProjectDetails(project);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Register Interest",
                              size: bs.sm,
                              onPressed: () {
                                _registerInterest(project);
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
        }).toList(),
      ],
    );
  }

  Widget _buildProjectStats(Map<String, dynamic> project) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Units", "${project["units"]}", Icons.home),
          ),
          Expanded(
            child: _buildStatItem("Floors", "${project["floors"]}", Icons.layers),
          ),
          Expanded(
            child: _buildStatItem("Price Range", "${project["priceRange"]}", Icons.attach_money),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(int progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Construction Progress",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "$progress%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(progress)),
        ),
      ],
    );
  }

  Color _getProgressColor(int progress) {
    if (progress < 25) return dangerColor;
    if (progress < 50) return warningColor;
    if (progress < 75) return infoColor;
    return successColor;
  }

  Widget _buildProjectTimeline(Map<String, dynamic> project) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Started",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${project["startDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: disabledColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Completion",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      Icons.flag,
                      color: primaryColor,
                      size: 16,
                    ),
                  ],
                ),
                Text(
                  "${project["completionDate"]}",
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
    );
  }

  Widget _buildAmenitiesPreview(List amenities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Key Amenities",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: amenities.take(4).map((amenity) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Text(
                "$amenity",
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
        if (amenities.length > 4)
          Text(
            "+${amenities.length - 4} more amenities",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildConstructionUpdates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Construction Updates",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to all updates
                ss("View all updates");
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...constructionUpdates.map((update) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${update["image"]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getUpdateTypeColor(update["type"]).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${update["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: _getUpdateTypeColor(update["type"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${update["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${update["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${update["project"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${update["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getUpdateTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'milestone':
        return successColor;
      case 'progress update':
        return infoColor;
      case 'delay':
        return warningColor;
      case 'issue':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildNotificationSignup() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: infoColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Text(
                "Stay Updated",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "Get notified about new pre-construction projects, construction progress updates, and early access opportunities.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          QTextField(
            label: "Email Address",
            value: email,
            hint: "Enter your email for updates",
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Subscribe to Updates",
              icon: Icons.email,
              size: bs.md,
              onPressed: () {
                if (email.isNotEmpty) {
                  ss("Successfully subscribed to construction updates!");
                  email = "";
                  setState(() {});
                } else {
                  se("Please enter your email address");
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your email is secure and will only be used for project updates. Unsubscribe anytime.",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Projects",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text("Property Type:"),
            // Add filter options here
            SizedBox(height: spMd),
            Text("Price Range:"),
            // Add price filter here
            SizedBox(height: spMd),
            Text("Completion Date:"),
            // Add date filter here
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    color: disabledColor,
                    onPressed: () => back(),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Filters applied");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewProjectDetails(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${project["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Developer: ${project["developer"]}"),
              SizedBox(height: spSm),
              Text("Architect: ${project["architect"]}"),
              SizedBox(height: spSm),
              Text("Location: ${project["location"]}"),
              SizedBox(height: spSm),
              Text("Units: ${project["units"]}"),
              SizedBox(height: spSm),
              Text("Completion: ${project["completionDate"]}"),
              SizedBox(height: spMd),
              Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${project["description"]}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _registerInterest(Map<String, dynamic> project) async {
    bool isConfirmed = await confirm("Register your interest in ${project["name"]}? We'll notify you about updates and early access opportunities.");
    if (isConfirmed) {
      ss("Interest registered for ${project["name"]}!");
    }
  }
}
