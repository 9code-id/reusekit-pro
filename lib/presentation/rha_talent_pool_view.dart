import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTalentPoolView extends StatefulWidget {
  const RhaTalentPoolView({super.key});

  @override
  State<RhaTalentPoolView> createState() => _RhaTalentPoolViewState();
}

class _RhaTalentPoolViewState extends State<RhaTalentPoolView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedSkill = "";
  String selectedExperience = "";
  String selectedLocation = "";
  int selectedViewMode = 0; // 0: List, 1: Grid, 2: Analytics

  List<Map<String, dynamic>> categories = [
    {"label": "All Candidates", "value": ""},
    {"label": "Software Engineers", "value": "software"},
    {"label": "Product Managers", "value": "product"},
    {"label": "Designers", "value": "design"},
    {"label": "Data Scientists", "value": "data"},
    {"label": "DevOps Engineers", "value": "devops"},
  ];

  List<Map<String, dynamic>> talentPool = [
    {
      "id": "TP001",
      "name": "Sarah Johnson",
      "title": "Senior Full Stack Developer",
      "company": "Google",
      "location": "San Francisco, CA",
      "experience": 8,
      "skills": ["React", "Node.js", "Python", "AWS", "Docker"],
      "rating": 4.8,
      "lastContact": "2024-12-15",
      "status": "Active",
      "availability": "Available",
      "salary": 150000,
      "avatar": "https://picsum.photos/80/80?random=1&person",
      "source": "LinkedIn",
      "category": "software",
      "projects": 12,
      "certifications": ["AWS Certified", "React Expert"],
    },
    {
      "id": "TP002",
      "name": "Michael Chen",
      "title": "Senior Product Manager",
      "company": "Microsoft",
      "location": "Seattle, WA",
      "experience": 6,
      "skills": ["Product Strategy", "Analytics", "Agile", "Leadership"],
      "rating": 4.9,
      "lastContact": "2024-12-18",
      "status": "Active",
      "availability": "Passive",
      "salary": 135000,
      "avatar": "https://picsum.photos/80/80?random=2&person",
      "source": "Indeed",
      "category": "product",
      "projects": 8,
      "certifications": ["PMP", "Scrum Master"],
    },
    {
      "id": "TP003",
      "name": "Emily Rodriguez",
      "title": "Lead UX Designer",
      "company": "Adobe",
      "location": "Remote",
      "experience": 7,
      "skills": ["Figma", "Design Systems", "User Research", "Prototyping"],
      "rating": 4.7,
      "lastContact": "2024-12-10",
      "status": "Active",
      "availability": "Available",
      "salary": 120000,
      "avatar": "https://picsum.photos/80/80?random=3&person",
      "source": "Dribbble",
      "category": "design",
      "projects": 15,
      "certifications": ["Adobe Certified", "Google UX"],
    },
    {
      "id": "TP004",
      "name": "David Kim",
      "title": "Senior Data Scientist",
      "company": "Netflix",
      "location": "Los Angeles, CA",
      "experience": 5,
      "skills": ["Python", "Machine Learning", "TensorFlow", "SQL"],
      "rating": 4.6,
      "lastContact": "2024-12-12",
      "status": "Active",
      "availability": "Unavailable",
      "salary": 140000,
      "avatar": "https://picsum.photos/80/80?random=4&person",
      "source": "Kaggle",
      "category": "data",
      "projects": 10,
      "certifications": ["Google Cloud ML", "AWS ML"],
    },
  ];

  List<Map<String, dynamic>> talentStats = [
    {
      "title": "Total Candidates",
      "value": 1250,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Active Candidates",
      "value": 980,
      "icon": Icons.person_add,
      "color": successColor,
    },
    {
      "title": "Available Now",
      "value": 320,
      "icon": Icons.check_circle,
      "color": infoColor,
    },
    {
      "title": "New This Month",
      "value": 85,
      "icon": Icons.trending_up,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Talent Pool"),
        actions: [
          IconButton(
            icon: Icon(selectedViewMode == 0 ? Icons.view_list : selectedViewMode == 1 ? Icons.grid_view : Icons.analytics),
            onPressed: () => _switchViewMode(),
          ),
          IconButton(
            icon: Icon(Icons.import_export),
            onPressed: () => _importExportTalent(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addToTalentPool(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsSection(),
            _buildSearchAndFilters(),
            if (selectedViewMode == 2) _buildAnalyticsView(),
            if (selectedViewMode != 2) _buildTalentList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Talent Pool Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: talentStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (stat["color"] as Color).withAlpha(50),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 24,
                        ),
                        Spacer(),
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: stat["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Search & Filter Talent",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _clearAllFilters(),
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          QTextField(
            label: "Search by name, skills, or company",
            value: searchQuery,
            hint: "e.g., Sarah, React, Google",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Skills",
                value: selectedSkill,
                hint: "e.g., React, Python, AWS",
                onChanged: (value) {
                  selectedSkill = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Experience Level",
                value: selectedExperience,
                hint: "e.g., 3-5 years, Senior",
                onChanged: (value) {
                  selectedExperience = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Location",
                value: selectedLocation,
                hint: "e.g., San Francisco, Remote",
                onChanged: (value) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Talent Pool Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Skills Distribution", Icons.code, [
                "React (45%)",
                "Python (38%)",
                "JavaScript (42%)",
                "AWS (32%)",
                "Node.js (28%)",
              ]),
              _buildAnalyticsCard("Experience Levels", Icons.work, [
                "Junior (25%)",
                "Mid-level (35%)",
                "Senior (30%)",
                "Expert (10%)",
              ]),
              _buildAnalyticsCard("Availability Status", Icons.schedule, [
                "Available (32%)",
                "Passive (45%)",
                "Unavailable (18%)",
                "Unknown (5%)",
              ]),
              _buildAnalyticsCard("Location Distribution", Icons.location_on, [
                "San Francisco (22%)",
                "New York (18%)",
                "Remote (25%)",
                "Seattle (15%)",
                "Other (20%)",
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, IconData icon, List<String> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return Text(
                item,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTalentList() {
    List<Map<String, dynamic>> filteredTalent = talentPool.where((candidate) {
      bool matchesSearch = searchQuery.isEmpty ||
          candidate["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          candidate["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          candidate["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || candidate["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Talent Pool",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${filteredTalent.length} candidates",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (selectedViewMode == 0) _buildListView(filteredTalent),
          if (selectedViewMode == 1) _buildGridView(filteredTalent),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> candidates) {
    return Column(
      spacing: spSm,
      children: candidates.map((candidate) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${candidate["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${candidate["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getAvailabilityColor(candidate["availability"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${candidate["availability"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getAvailabilityColor(candidate["availability"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${candidate["title"]} at ${candidate["company"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${candidate["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Icon(Icons.work, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${candidate["experience"]} years",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: warningColor),
                      SizedBox(width: spXs),
                      Text(
                        "${candidate["rating"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              QHorizontalScroll(
                children: (candidate["skills"] as List).map((skill) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Text(
                    "Last Contact: ${candidate["lastContact"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$${((candidate["salary"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Profile",
                      size: bs.sm,
                      onPressed: () => _viewProfile(candidate),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Contact",
                      size: bs.sm,
                      onPressed: () => _contactCandidate(candidate),
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () => _showMoreOptions(candidate),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> candidates) {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: candidates.map((candidate) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${candidate["avatar"]}"),
              ),
              Text(
                "${candidate["name"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${candidate["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getAvailabilityColor(candidate["availability"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${candidate["availability"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getAvailabilityColor(candidate["availability"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "${candidate["rating"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${candidate["experience"]}y",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () => _viewProfile(candidate),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Passive":
        return warningColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _switchViewMode() {
    setState(() {
      selectedViewMode = (selectedViewMode + 1) % 3;
    });
  }

  void _importExportTalent() {
    si("Import/Export talent pool functionality");
  }

  void _addToTalentPool() {
    si("Add new candidate to talent pool");
  }

  void _clearAllFilters() {
    setState(() {
      searchQuery = "";
      selectedCategory = "";
      selectedSkill = "";
      selectedExperience = "";
      selectedLocation = "";
    });
    ss("All filters cleared");
  }

  void _viewProfile(Map<String, dynamic> candidate) {
    si("View profile for ${candidate["name"]}");
  }

  void _contactCandidate(Map<String, dynamic> candidate) {
    si("Contact ${candidate["name"]}");
  }

  void _showMoreOptions(Map<String, dynamic> candidate) {
    si("Show more options for ${candidate["name"]}");
  }
}
