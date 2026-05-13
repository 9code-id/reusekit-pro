import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaResearchToolsView extends StatefulWidget {
  const ElaResearchToolsView({super.key});

  @override
  State<ElaResearchToolsView> createState() => _ElaResearchToolsViewState();
}

class _ElaResearchToolsViewState extends State<ElaResearchToolsView> {
  String searchQuery = "";
  String selectedTool = "All Tools";
  bool loading = false;

  final List<Map<String, dynamic>> toolCategories = [
    {"label": "All Tools", "value": "All Tools"},
    {"label": "Citation", "value": "Citation"},
    {"label": "Research", "value": "Research"},
    {"label": "Analysis", "value": "Analysis"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Grammar", "value": "Grammar"},
  ];

  final List<Map<String, dynamic>> researchTools = [
    {
      "id": 1,
      "name": "Citation Generator",
      "category": "Citation",
      "description": "Generate MLA, APA, and Chicago style citations automatically",
      "icon": Icons.format_quote,
      "color": primaryColor,
      "features": ["MLA Format", "APA Format", "Chicago Style", "Bibliography"],
      "usage": "High",
      "lastUsed": "2024-03-15",
      "isPopular": true,
    },
    {
      "id": 2,
      "name": "Source Validator",
      "category": "Research",
      "description": "Check the credibility and reliability of your sources",
      "icon": Icons.verified_user,
      "color": successColor,
      "features": ["Credibility Check", "Bias Detection", "Source Rating", "Fact Verification"],
      "usage": "Medium",
      "lastUsed": "2024-03-12",
      "isPopular": true,
    },
    {
      "id": 3,
      "name": "Thesis Builder",
      "category": "Writing",
      "description": "Build strong thesis statements with guided prompts",
      "icon": Icons.architecture,
      "color": infoColor,
      "features": ["Guided Prompts", "Thesis Examples", "Strength Analysis", "Revision Suggestions"],
      "usage": "High",
      "lastUsed": "2024-03-14",
      "isPopular": false,
    },
    {
      "id": 4,
      "name": "Plagiarism Checker",
      "category": "Analysis",
      "description": "Scan your work for potential plagiarism and similarity issues",
      "icon": Icons.search,
      "color": warningColor,
      "features": ["Similarity Check", "Citation Gaps", "Paraphrase Suggestions", "Originality Score"],
      "usage": "High",
      "lastUsed": "2024-03-13",
      "isPopular": true,
    },
    {
      "id": 5,
      "name": "Grammar Assistant",
      "category": "Grammar",
      "description": "Advanced grammar and style checking for academic writing",
      "icon": Icons.spellcheck,
      "color": secondaryColor,
      "features": ["Grammar Check", "Style Analysis", "Clarity Suggestions", "Academic Tone"],
      "usage": "Medium",
      "lastUsed": "2024-03-11",
      "isPopular": false,
    },
    {
      "id": 6,
      "name": "Research Organizer",
      "category": "Research",
      "description": "Organize and manage your research materials efficiently",
      "icon": Icons.folder_open,
      "color": Colors.purple,
      "features": ["Note Organization", "Source Management", "Topic Mapping", "Progress Tracking"],
      "usage": "Medium",
      "lastUsed": "2024-03-10",
      "isPopular": false,
    },
    {
      "id": 7,
      "name": "Outline Builder",
      "category": "Writing",
      "description": "Create detailed outlines for essays and research papers",
      "icon": Icons.list_alt,
      "color": Colors.teal,
      "features": ["Template Library", "Auto-Format", "Hierarchical Structure", "Export Options"],
      "usage": "Low",
      "lastUsed": "2024-03-08",
      "isPopular": false,
    },
    {
      "id": 8,
      "name": "Literary Analysis Helper",
      "category": "Analysis",
      "description": "Tools for analyzing themes, characters, and literary devices",
      "icon": Icons.analytics,
      "color": Colors.deepOrange,
      "features": ["Theme Analysis", "Character Mapping", "Device Detection", "Symbol Tracker"],
      "usage": "Medium",
      "lastUsed": "2024-03-09",
      "isPopular": true,
    },
  ];

  List<Map<String, dynamic>> get filteredTools {
    List<Map<String, dynamic>> tools = List.from(researchTools);
    
    if (searchQuery.isNotEmpty) {
      tools = tools.where((tool) {
        return (tool["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (tool["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (tool["features"] as List).any((feature) => 
                   feature.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    if (selectedTool != "All Tools") {
      tools = tools.where((tool) => tool["category"] == selectedTool).toList();
    }
    
    return tools;
  }

  List<Map<String, dynamic>> get popularTools {
    return researchTools.where((tool) => tool["isPopular"] == true).toList();
  }

  List<Map<String, dynamic>> get recentlyUsedTools {
    List<Map<String, dynamic>> tools = List.from(researchTools);
    tools.sort((a, b) => DateTime.parse(b["lastUsed"]).compareTo(DateTime.parse(a["lastUsed"])));
    return tools.take(4).toList();
  }

  void _launchTool(Map<String, dynamic> tool) {
    loading = true;
    setState(() {});
    
    // Simulate tool launch
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Launching ${tool["name"]}...");
      
      // Update last used date
      final toolIndex = researchTools.indexWhere((t) => t["id"] == tool["id"]);
      if (toolIndex != -1) {
        researchTools[toolIndex]["lastUsed"] = DateTime.now().toIso8601String().split('T')[0];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Tools"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showToolsGuide();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search and Filter
                  Container(
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
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Search research tools",
                                value: searchQuery,
                                hint: "Enter tool name or feature",
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
                        QDropdownField(
                          label: "Filter by Category",
                          items: toolCategories,
                          value: selectedTool,
                          onChanged: (value, label) {
                            selectedTool = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Quick Stats
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.construction, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Research Toolkit",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${researchTools.length} tools available • ${popularTools.length} popular • ${recentlyUsedTools.length} recently used",
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
                  ),

                  // Recently Used Tools
                  if (searchQuery.isEmpty && selectedTool == "All Tools") ...[
                    Text(
                      "Recently Used",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QHorizontalScroll(
                      children: recentlyUsedTools.map((tool) {
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
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: (tool["color"] as Color).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      tool["icon"],
                                      color: tool["color"],
                                      size: 24,
                                    ),
                                  ),
                                  Spacer(),
                                  if (tool["isPopular"])
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${tool["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${tool["description"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Last used: ${DateTime.parse(tool["lastUsed"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Launch",
                                  size: bs.sm,
                                  onPressed: () => _launchTool(tool),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    // Popular Tools
                    Text(
                      "Popular Tools",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: popularTools.map((tool) {
                        return _buildToolCard(tool, isPopular: true);
                      }).toList(),
                    ),
                  ],

                  // All Tools
                  Text(
                    searchQuery.isNotEmpty || selectedTool != "All Tools"
                        ? "Search Results (${filteredTools.length})"
                        : "All Research Tools",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  if (filteredTools.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No tools found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your search or filter criteria",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredTools.map((tool) {
                        return _buildToolCard(tool);
                      }).toList(),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildToolCard(Map<String, dynamic> tool, {bool isPopular = false}) {
    Color usageColor;
    switch (tool["usage"]) {
      case "High":
        usageColor = successColor;
        break;
      case "Medium":
        usageColor = warningColor;
        break;
      case "Low":
        usageColor = infoColor;
        break;
      default:
        usageColor = disabledBoldColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isPopular 
            ? Border.all(color: warningColor.withAlpha(100), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (tool["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (tool["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        tool["icon"],
                        color: tool["color"],
                        size: 24,
                      ),
                    ),
                    Spacer(),
                    if (tool["isPopular"])
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${tool["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${tool["category"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tool["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                
                // Features
                Text(
                  "Features:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: 4,
                  children: (tool["features"] as List).take(3).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                if ((tool["features"] as List).length > 3)
                  Text(
                    "+${(tool["features"] as List).length - 3} more",
                    style: TextStyle(
                      fontSize: 9,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Usage and Last Used
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: usageColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tool["usage"]} Usage",
                        style: TextStyle(
                          fontSize: 9,
                          color: usageColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(tool["lastUsed"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 9,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Launch Tool",
                    size: bs.sm,
                    onPressed: () => _launchTool(tool),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showToolsGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Research Tools Guide",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGuideSection(
                        "Citation Tools",
                        "Generate proper citations in MLA, APA, and Chicago styles. Essential for academic integrity.",
                        Icons.format_quote,
                        primaryColor,
                      ),
                      
                      _buildGuideSection(
                        "Research Tools",
                        "Validate sources, organize materials, and track research progress efficiently.",
                        Icons.search,
                        successColor,
                      ),
                      
                      _buildGuideSection(
                        "Analysis Tools",
                        "Check for plagiarism, analyze literary elements, and ensure originality.",
                        Icons.analytics,
                        infoColor,
                      ),
                      
                      _buildGuideSection(
                        "Writing Tools",
                        "Build strong thesis statements, create outlines, and improve your writing structure.",
                        Icons.edit,
                        warningColor,
                      ),
                      
                      _buildGuideSection(
                        "Grammar Tools",
                        "Advanced grammar checking, style analysis, and academic writing assistance.",
                        Icons.spellcheck,
                        secondaryColor,
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: infoColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.lightbulb, color: infoColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Pro Tips",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "• Use multiple tools together for best results\n"
                              "• Save your citations and sources for future reference\n"
                              "• Check tool requirements before starting your research\n"
                              "• Popular tools are highly recommended by students and teachers",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideSection(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
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
    );
  }
}
