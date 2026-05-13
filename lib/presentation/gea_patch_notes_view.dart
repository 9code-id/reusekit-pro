import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPatchNotesView extends StatefulWidget {
  const GeaPatchNotesView({super.key});

  @override
  State<GeaPatchNotesView> createState() => _GeaPatchNotesViewState();
}

class _GeaPatchNotesViewState extends State<GeaPatchNotesView> {
  String selectedGame = "All Games";
  String selectedPatchType = "All Types";
  String searchQuery = "";

  List<Map<String, dynamic>> games = [
    {"label": "All Games", "value": "All Games"},
    {"label": "Valorant", "value": "Valorant"},
    {"label": "CS2", "value": "CS2"},
    {"label": "Apex Legends", "value": "Apex Legends"},
    {"label": "Overwatch 2", "value": "Overwatch 2"},
    {"label": "GEA Platform", "value": "GEA Platform"},
  ];

  List<Map<String, dynamic>> patchTypes = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Major Update", "value": "Major Update"},
    {"label": "Balance Patch", "value": "Balance Patch"},
    {"label": "Bug Fix", "value": "Bug Fix"},
    {"label": "Content Update", "value": "Content Update"},
    {"label": "Hotfix", "value": "Hotfix"},
  ];

  List<Map<String, dynamic>> patchNotes = [
    {
      "id": 1,
      "game": "Valorant",
      "version": "8.02.0",
      "title": "Episode 8 Act 2 - Quantum Agent Release",
      "type": "Major Update",
      "releaseDate": "December 15, 2024",
      "status": "Live",
      "summary": "Introducing Quantum, the new agent with reality-bending abilities that will reshape tactical gameplay.",
      "sections": [
        {
          "title": "New Agent: Quantum",
          "type": "addition",
          "content": [
            "Quantum Phase (C) - Briefly phase through walls and obstacles",
            "Reality Rift (Q) - Create a temporary portal between two locations",
            "Temporal Shield (E) - Deploy a shield that blocks incoming damage for 3 seconds",
            "Quantum Collapse (X) - Ultimate ability that teleports all enemies in a large radius to random locations"
          ]
        },
        {
          "title": "Map Updates - Ascent",
          "type": "change",
          "content": [
            "Reworked A site to provide better cover options",
            "Adjusted B main entrance for improved visibility",
            "Updated callouts and signage throughout the map",
            "Optimized lighting in mid area"
          ]
        },
        {
          "title": "Agent Balance Changes",
          "type": "balance",
          "content": [
            "Jett: Dash cooldown increased from 2 to 3 seconds",
            "Sage: Heal ability now heals 80 HP instead of 60 HP",
            "Raze: Grenade damage reduced by 10%",
            "Cypher: Tripwire activation time reduced by 0.5 seconds"
          ]
        },
        {
          "title": "Bug Fixes",
          "type": "fix",
          "content": [
            "Fixed issue where some abilities could clip through walls",
            "Resolved audio desync problems during spectator mode",
            "Fixed ranking display issues in competitive mode",
            "Corrected weapon skin preview glitches"
          ]
        }
      ],
      "impactLevel": "High",
      "playerFeedback": 4.2,
      "isExpanded": false,
    },
    {
      "id": 2,
      "game": "CS2",
      "version": "1.39.8.2",
      "title": "Winter Update - Operation Snowfall",
      "type": "Content Update",
      "releaseDate": "December 13, 2024",
      "status": "Live",
      "summary": "Winter-themed content with new operation missions, weapon skins, and competitive improvements.",
      "sections": [
        {
          "title": "Operation Snowfall",
          "type": "addition",
          "content": [
            "21 new mission objectives across all game modes",
            "Exclusive winter-themed weapon skins",
            "New community maps in operation map pool",
            "Operation coin with upgradeable tiers"
          ]
        },
        {
          "title": "Weapon Balance",
          "type": "balance",
          "content": [
            "AK-47: Reduced first-shot accuracy by 2%",
            "M4A4: Increased damage at long range",
            "AWP: Adjusted movement speed while scoped",
            "Deagle: Improved accuracy recovery time"
          ]
        },
        {
          "title": "Performance Improvements",
          "type": "improvement",
          "content": [
            "Optimized rendering for better FPS on lower-end systems",
            "Reduced memory usage by 15%",
            "Improved matchmaking algorithm for balanced games",
            "Enhanced anti-cheat detection systems"
          ]
        }
      ],
      "impactLevel": "Medium",
      "playerFeedback": 4.0,
      "isExpanded": false,
    },
    {
      "id": 3,
      "game": "GEA Platform",
      "version": "3.15.0",
      "title": "Platform Enhancement Update",
      "type": "Major Update",
      "releaseDate": "December 10, 2024",
      "status": "Live",
      "summary": "Major improvements to streaming quality, community features, and tournament management tools.",
      "sections": [
        {
          "title": "Streaming Enhancements",
          "type": "improvement",
          "content": [
            "4K streaming support for premium users",
            "Improved audio quality with noise cancellation",
            "Enhanced chat moderation tools",
            "Real-time viewer analytics dashboard"
          ]
        },
        {
          "title": "Tournament Features",
          "type": "addition",
          "content": [
            "Advanced bracket management system",
            "Automated score tracking and reporting",
            "Customizable tournament formats",
            "Integrated prize pool management"
          ]
        },
        {
          "title": "Community Hub",
          "type": "change",
          "content": [
            "Redesigned user interface for better navigation",
            "Enhanced search functionality",
            "Improved mobile responsiveness",
            "New notification system for community updates"
          ]
        }
      ],
      "impactLevel": "High",
      "playerFeedback": 4.5,
      "isExpanded": false,
    },
    {
      "id": 4,
      "game": "Apex Legends",
      "version": "20.0.1",
      "title": "Season 20 Hotfix",
      "type": "Hotfix",
      "releaseDate": "December 8, 2024",
      "status": "Live",
      "summary": "Critical bug fixes and balance adjustments for Season 20 launch issues.",
      "sections": [
        {
          "title": "Critical Bug Fixes",
          "type": "fix",
          "content": [
            "Fixed game crashes during legend selection",
            "Resolved infinite loading screen issues",
            "Fixed weapon attachment display problems",
            "Corrected rank point calculation errors"
          ]
        },
        {
          "title": "Legend Adjustments",
          "type": "balance",
          "content": [
            "Phantom: Reduced invisibility duration from 8 to 6 seconds",
            "Wraith: Portal cooldown increased by 10 seconds",
            "Gibby: Dome shield health reduced by 25%"
          ]
        }
      ],
      "impactLevel": "Medium",
      "playerFeedback": 3.8,
      "isExpanded": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPatchNotes {
    return patchNotes.where((patch) {
      bool matchesGame = selectedGame == "All Games" || patch["game"] == selectedGame;
      bool matchesType = selectedPatchType == "All Types" || patch["type"] == selectedPatchType;
      bool matchesSearch = searchQuery.isEmpty || 
          (patch["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (patch["summary"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesGame && matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GEA Patch Notes"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () => _showNotificationSettings(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchAndFilters(),
            _buildPatchSummary(),
            _buildPatchNotesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search patch notes...",
                value: searchQuery,
                hint: "Search by title or content",
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
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter by Game",
                items: games,
                value: selectedGame,
                onChanged: (value, label) {
                  selectedGame = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Filter by Type",
                items: patchTypes,
                value: selectedPatchType,
                onChanged: (value, label) {
                  selectedPatchType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatchSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Updates Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Total Updates", "${patchNotes.length}", Icons.update),
              ),
              Expanded(
                child: _buildSummaryItem("This Week", "3", Icons.schedule),
              ),
              Expanded(
                child: _buildSummaryItem("Major Updates", "2", Icons.stars),
              ),
              Expanded(
                child: _buildSummaryItem("Avg Rating", "4.1", Icons.star),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: primaryColor, size: 20),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: primaryColor,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildPatchNotesList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Patch Notes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredPatchNotes.length} updates",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        ...filteredPatchNotes.map((patch) => _buildPatchNoteCard(patch)).toList(),
      ],
    );
  }

  Widget _buildPatchNoteCard(Map<String, dynamic> patch) {
    bool isExpanded = patch["isExpanded"] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: patch["status"] == "Live" 
            ? Border.all(color: successColor.withAlpha(50), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _toggleExpansion(patch),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(patch["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${patch["status"]}",
                          style: TextStyle(
                            color: _getStatusColor(patch["status"]),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getTypeColor(patch["type"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${patch["type"]}",
                          style: TextStyle(
                            color: _getTypeColor(patch["type"]),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${patch["game"]}",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${patch["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fsH6,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: disabledBoldColor,
                      ),
                    ],
                  ),
                  Text(
                    "${patch["summary"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Version ${patch["version"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "•",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${patch["releaseDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${(patch["playerFeedback"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildExpandedContent(patch),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(Map<String, dynamic> patch) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: _getImpactColor(patch["impactLevel"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.flash_on,
                  color: _getImpactColor(patch["impactLevel"]),
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${patch["impactLevel"]} Impact",
                  style: TextStyle(
                    color: _getImpactColor(patch["impactLevel"]),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ...(patch["sections"] as List<Map<String, dynamic>>)
              .map((section) => _buildPatchSection(section))
              .toList(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Full Details",
                  size: bs.sm,
                  onPressed: () => _viewFullPatchNotes(patch),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () => _sharePatchNotes(patch),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.feedback,
                size: bs.sm,
                onPressed: () => _submitFeedback(patch),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatchSection(Map<String, dynamic> section) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: _getSectionColor(section["type"]).withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getSectionIcon(section["type"]),
                color: _getSectionColor(section["type"]),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${section["title"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _getSectionColor(section["type"]),
                ),
              ),
            ],
          ),
          ...(section["content"] as List<String>).map((item) => Padding(
            padding: EdgeInsets.only(left: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getSectionColor(section["type"]),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live":
        return successColor;
      case "Coming Soon":
        return warningColor;
      case "Beta":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Major Update":
        return dangerColor;
      case "Balance Patch":
        return warningColor;
      case "Bug Fix":
        return successColor;
      case "Content Update":
        return infoColor;
      case "Hotfix":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSectionColor(String type) {
    switch (type) {
      case "addition":
        return successColor;
      case "change":
        return warningColor;
      case "balance":
        return infoColor;
      case "fix":
        return dangerColor;
      case "improvement":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSectionIcon(String type) {
    switch (type) {
      case "addition":
        return Icons.add_circle;
      case "change":
        return Icons.edit;
      case "balance":
        return Icons.scale;
      case "fix":
        return Icons.bug_report;
      case "improvement":
        return Icons.trending_up;
      default:
        return Icons.info;
    }
  }

  void _toggleExpansion(Map<String, dynamic> patch) {
    patch["isExpanded"] = !(patch["isExpanded"] ?? false);
    setState(() {});
  }

  void _showNotificationSettings() {
    ss("Opening patch notes notification settings");
  }

  void _viewFullPatchNotes(Map<String, dynamic> patch) {
    ss("Opening full patch notes for ${patch["title"]}");
  }

  void _sharePatchNotes(Map<String, dynamic> patch) {
    ss("Sharing patch notes: ${patch["title"]}");
  }

  void _submitFeedback(Map<String, dynamic> patch) {
    ss("Opening feedback form for ${patch["title"]}");
  }
}
