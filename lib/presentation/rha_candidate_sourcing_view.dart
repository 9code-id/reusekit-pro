import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateSourcingView extends StatefulWidget {
  const RhaCandidateSourcingView({super.key});

  @override
  State<RhaCandidateSourcingView> createState() => _RhaCandidateSourcingViewState();
}

class _RhaCandidateSourcingViewState extends State<RhaCandidateSourcingView> {
  String searchQuery = "";
  String selectedJobRole = "";
  String selectedLocation = "";
  String selectedExperience = "";
  String selectedSkill = "";
  int selectedSourceTab = 0;

  List<Map<String, dynamic>> jobRoles = [
    {"label": "Software Engineer", "value": "software_engineer"},
    {"label": "Product Manager", "value": "product_manager"},
    {"label": "UI/UX Designer", "value": "ui_ux_designer"},
    {"label": "Data Scientist", "value": "data_scientist"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Remote", "value": "remote"},
    {"label": "New York", "value": "new_york"},
    {"label": "San Francisco", "value": "san_francisco"},
    {"label": "London", "value": "london"},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (6-10 years)", "value": "senior"},
    {"label": "Expert Level (10+ years)", "value": "expert"},
  ];

  List<Map<String, dynamic>> sourcingChannels = [
    {
      "name": "LinkedIn",
      "candidates": 1250,
      "active": true,
      "icon": Icons.work,
      "color": primaryColor,
    },
    {
      "name": "Indeed",
      "candidates": 890,
      "active": true,
      "icon": Icons.search,
      "color": successColor,
    },
    {
      "name": "GitHub",
      "candidates": 445,
      "active": false,
      "icon": Icons.code,
      "color": infoColor,
    },
    {
      "name": "Stack Overflow",
      "candidates": 325,
      "active": true,
      "icon": Icons.help,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> candidates = [
    {
      "name": "Sarah Johnson",
      "role": "Senior Software Engineer",
      "location": "San Francisco, CA",
      "experience": "7 years",
      "skills": ["React", "Node.js", "Python", "AWS"],
      "source": "LinkedIn",
      "matchScore": 95,
      "salary": 120000,
      "avatar": "https://picsum.photos/80/80?random=1&person",
      "status": "Available",
    },
    {
      "name": "Michael Chen",
      "role": "Product Manager",
      "location": "New York, NY",
      "experience": "5 years",
      "skills": ["Product Strategy", "Analytics", "Agile", "User Research"],
      "source": "Indeed",
      "matchScore": 88,
      "salary": 110000,
      "avatar": "https://picsum.photos/80/80?random=2&person",
      "status": "Passive",
    },
    {
      "name": "Emily Rodriguez",
      "role": "UI/UX Designer",
      "location": "Remote",
      "experience": "4 years",
      "skills": ["Figma", "Design Systems", "User Testing", "Prototyping"],
      "source": "GitHub",
      "matchScore": 92,
      "salary": 85000,
      "avatar": "https://picsum.photos/80/80?random=3&person",
      "status": "Available",
    },
    {
      "name": "David Kim",
      "role": "Data Scientist",
      "location": "London, UK",
      "experience": "6 years",
      "skills": ["Python", "Machine Learning", "SQL", "Tableau"],
      "source": "Stack Overflow",
      "matchScore": 90,
      "salary": 95000,
      "avatar": "https://picsum.photos/80/80?random=4&person",
      "status": "Available",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidate Sourcing"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showAdvancedFilters(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshSources(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildSourceChannelsSection(),
            _buildFiltersSection(),
            _buildCandidatesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewSource(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchSection() {
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
                "Search Candidates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Keywords, skills, or job titles",
                  value: searchQuery,
                  hint: "e.g., React Developer, Python, Machine Learning",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Search",
                size: bs.sm,
                onPressed: () => _performSearch(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSourceChannelsSection() {
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
              Icon(Icons.source, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Sourcing Channels",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () => _manageChannels(),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: sourcingChannels.map((channel) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (channel["active"] as bool) ? (channel["color"] as Color).withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (channel["active"] as bool) ? (channel["color"] as Color) : disabledColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Icon(
                      channel["icon"] as IconData,
                      color: (channel["active"] as bool) ? (channel["color"] as Color) : disabledColor,
                      size: 24,
                    ),
                    Text(
                      "${channel["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: (channel["active"] as bool) ? primaryColor : disabledColor,
                      ),
                    ),
                    Text(
                      "${channel["candidates"]} candidates",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: (channel["active"] as bool) ? "Active" : "Inactive",
                        size: bs.sm,
                        onPressed: () => _toggleChannel(channel),
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

  Widget _buildFiltersSection() {
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
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Search Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _clearFilters(),
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Job Role",
                items: jobRoles,
                value: selectedJobRole,
                onChanged: (value, label) {
                  selectedJobRole = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Location",
                items: locations,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Experience Level",
                items: experienceLevels,
                value: selectedExperience,
                onChanged: (value, label) {
                  selectedExperience = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Required Skills",
                value: selectedSkill,
                hint: "e.g., React, Python, AWS",
                onChanged: (value) {
                  selectedSkill = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCandidatesList() {
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
                "Found Candidates",
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
                  "${candidates.length} results",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
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
                              Text(
                                "${candidate["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${candidate["role"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(candidate["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${candidate["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(candidate["status"]),
                              fontWeight: FontWeight.w600,
                            ),
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
                          "${candidate["experience"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${candidate["matchScore"]}% match",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                          "Source: ${candidate["source"]}",
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
                            onPressed: () => _viewCandidateProfile(candidate),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Add to Pipeline",
                            size: bs.sm,
                            onPressed: () => _addToPipeline(candidate),
                          ),
                        ),
                      ],
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

  Color _getStatusColor(String status) {
    switch (status) {
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

  void _performSearch() {
    // Handle search functionality
    ss("Search performed for: $searchQuery");
  }

  void _refreshSources() {
    // Handle refresh sources
    ss("Sourcing channels refreshed");
  }

  void _addNewSource() {
    // Handle add new source
    si("Add new sourcing channel feature");
  }

  void _showAdvancedFilters() {
    // Handle advanced filters
    si("Advanced filters dialog");
  }

  void _manageChannels() {
    // Handle manage channels
    si("Manage sourcing channels");
  }

  void _toggleChannel(Map<String, dynamic> channel) {
    setState(() {
      channel["active"] = !(channel["active"] as bool);
    });
    ss("${channel["name"]} ${(channel["active"] as bool) ? 'activated' : 'deactivated'}");
  }

  void _clearFilters() {
    setState(() {
      selectedJobRole = "";
      selectedLocation = "";
      selectedExperience = "";
      selectedSkill = "";
    });
    ss("All filters cleared");
  }

  void _viewCandidateProfile(Map<String, dynamic> candidate) {
    // Handle view candidate profile
    si("View profile for ${candidate["name"]}");
  }

  void _addToPipeline(Map<String, dynamic> candidate) {
    // Handle add to pipeline
    ss("${candidate["name"]} added to pipeline");
  }
}
