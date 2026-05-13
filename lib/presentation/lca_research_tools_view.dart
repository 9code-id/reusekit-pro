import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaResearchToolsView extends StatefulWidget {
  const LcaResearchToolsView({super.key});

  @override
  State<LcaResearchToolsView> createState() => _LcaResearchToolsViewState();
}

class _LcaResearchToolsViewState extends State<LcaResearchToolsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Tools", "value": "All"},
    {"label": "Case Law", "value": "case_law"},
    {"label": "Statutes", "value": "statutes"},
    {"label": "Legal Forms", "value": "forms"},
    {"label": "Citations", "value": "citations"},
    {"label": "Analysis", "value": "analysis"},
    {"label": "Documentation", "value": "documentation"},
  ];

  List<Map<String, dynamic>> researchTools = [
    {
      "id": "1",
      "name": "Case Law Search",
      "description": "Search through millions of case law decisions and court opinions",
      "category": "case_law",
      "icon": Icons.gavel,
      "color": primaryColor,
      "features": ["Advanced Search", "Citation Analysis", "Legal Precedents"],
      "lastUsed": "2025-06-19",
      "usage": 45
    },
    {
      "id": "2",
      "name": "Statute Lookup",
      "description": "Comprehensive database of federal and state statutes",
      "category": "statutes",
      "icon": Icons.book,
      "color": infoColor,
      "features": ["Multi-jurisdiction", "Historical Versions", "Cross-references"],
      "lastUsed": "2025-06-18",
      "usage": 32
    },
    {
      "id": "3",
      "name": "Legal Forms Generator",
      "description": "Generate customized legal documents and forms",
      "category": "forms",
      "icon": Icons.description,
      "color": successColor,
      "features": ["Template Library", "Auto-fill", "E-signature Ready"],
      "lastUsed": "2025-06-17",
      "usage": 28
    },
    {
      "id": "4",
      "name": "Citation Manager",
      "description": "Organize and format legal citations automatically",
      "category": "citations",
      "icon": Icons.format_quote,
      "color": warningColor,
      "features": ["Auto-format", "Style Guides", "Export Options"],
      "lastUsed": "2025-06-19",
      "usage": 19
    },
    {
      "id": "5",
      "name": "Legal Analytics",
      "description": "AI-powered legal research and trend analysis",
      "category": "analysis",
      "icon": Icons.analytics,
      "color": dangerColor,
      "features": ["Trend Analysis", "Predictive Insights", "Success Rates"],
      "lastUsed": "2025-06-16",
      "usage": 15
    },
    {
      "id": "6",
      "name": "Document Assembly",
      "description": "Automated document creation and review tools",
      "category": "documentation",
      "icon": Icons.article,
      "color": secondaryColor,
      "features": ["Template Builder", "Version Control", "Collaboration"],
      "lastUsed": "2025-06-15",
      "usage": 12
    },
    {
      "id": "7",
      "name": "Precedent Search",
      "description": "Find relevant legal precedents and similar cases",
      "category": "case_law",
      "icon": Icons.search,
      "color": primaryColor,
      "features": ["Smart Matching", "Similarity Scores", "Key Factors"],
      "lastUsed": "2025-06-18",
      "usage": 35
    },
    {
      "id": "8",
      "name": "Legal Database",
      "description": "Comprehensive legal research database with advanced filters",
      "category": "analysis",
      "icon": Icons.storage,
      "color": infoColor,
      "features": ["Multi-source", "Real-time Updates", "Export Tools"],
      "lastUsed": "2025-06-19",
      "usage": 41
    },
  ];

  List<Map<String, dynamic>> recentSearches = [
    {
      "query": "contract breach remedies",
      "tool": "Case Law Search",
      "results": 247,
      "timestamp": "2025-06-19 14:30"
    },
    {
      "query": "employment discrimination",
      "tool": "Statute Lookup",
      "results": 89,
      "timestamp": "2025-06-19 11:15"
    },
    {
      "query": "intellectual property filing",
      "tool": "Legal Forms Generator",
      "results": 15,
      "timestamp": "2025-06-18 16:45"
    },
    {
      "query": "personal injury settlements",
      "tool": "Legal Analytics",
      "results": 156,
      "timestamp": "2025-06-18 09:20"
    },
  ];

  List<Map<String, dynamic>> get filteredTools {
    return researchTools.where((tool) {
      bool categoryMatch = selectedCategory == "All" || tool["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          tool["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tool["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Tools"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Show research history
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Tool settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Find Research Tools",
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
                          label: "Search tools...",
                          value: searchQuery,
                          hint: "Enter tool name or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.tune,
                        size: bs.sm,
                        onPressed: () {
                          // Advanced filters
                        },
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Research Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${researchTools.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Tools Available",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(researchTools.map((t) => t["usage"] as int).reduce((a, b) => a + b))}", 
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Uses",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${recentSearches.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Recent Searches",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Research Tools Grid
            Text(
              "Available Tools (${filteredTools.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredTools.map((tool) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      top: BorderSide(
                        width: 4,
                        color: tool["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: (tool["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              tool["icon"] as IconData,
                              color: tool["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tool["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Used ${tool["usage"]} times",
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
                      Text(
                        "${tool["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Key Features:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(tool["features"] as List).map((feature) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last used: ${DateTime.parse(tool["lastUsed"] as String).dMMMy}",
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
                          label: "Open Tool",
                          size: bs.sm,
                          onPressed: () {
                            // Open research tool
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Searches
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Searches",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // View all searches
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentSearches.map((search) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${search["query"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${search["results"]} results",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${search["tool"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "•",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${search["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Advanced Search",
                    icon: Icons.manage_search,
                    size: bs.md,
                    onPressed: () {
                      // Advanced search interface
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Tool Preferences",
                          icon: Icons.tune,
                          size: bs.sm,
                          onPressed: () {
                            // Tool preferences
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Usage Reports",
                          icon: Icons.bar_chart,
                          size: bs.sm,
                          onPressed: () {
                            // Usage statistics
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
      ),
    );
  }
}
