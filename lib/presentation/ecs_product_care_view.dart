import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductCareView extends StatefulWidget {
  const EcsProductCareView({super.key});

  @override
  State<EcsProductCareView> createState() => _EcsProductCareViewState();
}

class _EcsProductCareViewState extends State<EcsProductCareView> {
  String selectedCategory = "All";
  bool showVideoGuides = true;
  int selectedTipIndex = 0;
  
  Map<String, dynamic> product = {
    "name": "Premium Wireless Headphones",
    "brand": "Sony",
    "model": "WH-1000XM5",
    "image": "https://picsum.photos/400/300?random=1&keyword=headphones",
    "category": "Electronics",
  };

  List<Map<String, dynamic>> careCategories = [
    {
      "name": "All",
      "icon": Icons.list,
      "count": 15,
    },
    {
      "name": "Cleaning",
      "icon": Icons.cleaning_services,
      "count": 5,
    },
    {
      "name": "Storage",
      "icon": Icons.inventory,
      "count": 3,
    },
    {
      "name": "Maintenance",
      "icon": Icons.build,
      "count": 4,
    },
    {
      "name": "Troubleshooting",
      "icon": Icons.help_outline,
      "count": 3,
    },
  ];

  List<Map<String, dynamic>> careTips = [
    {
      "category": "Cleaning",
      "title": "Daily Cleaning Routine",
      "description": "How to properly clean your headphones after each use",
      "importance": "High",
      "duration": "2 min",
      "difficulty": "Easy",
      "steps": [
        "Power off the headphones completely",
        "Use a soft, dry microfiber cloth to wipe exterior surfaces",
        "Clean ear cushions with slightly damp cloth (not soaking)",
        "Allow to air dry for 5 minutes before storing",
        "Avoid getting moisture in ports or openings",
      ],
      "tips": [
        "Never use harsh chemicals or abrasive materials",
        "Replace ear cushions every 6-12 months for hygiene",
        "Store in provided case when not in use",
      ],
      "videoUrl": "https://example.com/cleaning-guide",
      "hasVideo": true,
    },
    {
      "category": "Storage",
      "title": "Proper Storage Guidelines",
      "description": "Best practices for storing your headphones to prevent damage",
      "importance": "Medium",
      "duration": "1 min",
      "difficulty": "Easy",
      "steps": [
        "Always store in the provided carrying case",
        "Ensure headphones are completely dry before storage",
        "Avoid extreme temperatures (below 32°F or above 95°F)",
        "Keep away from direct sunlight and humidity",
        "Don't place heavy objects on top of the case",
      ],
      "tips": [
        "Store in a cool, dry place",
        "Check storage area periodically for moisture",
        "Consider using silica gel packets in humid environments",
      ],
      "videoUrl": "",
      "hasVideo": false,
    },
    {
      "category": "Maintenance",
      "title": "Battery Care and Maintenance",
      "description": "Extending battery life and maintaining optimal performance",
      "importance": "High",
      "duration": "5 min",
      "difficulty": "Easy",
      "steps": [
        "Charge fully before first use",
        "Avoid letting battery completely drain regularly",
        "Charge when battery level drops to 20-30%",
        "Use only the provided USB-C cable",
        "Unplug charger once fully charged (100%)",
      ],
      "tips": [
        "Optimal charging temperature: 32°F to 95°F (0°C to 35°C)",
        "If not using for extended periods, charge to 50% and store",
        "Battery performance may decrease after 2-3 years of regular use",
      ],
      "videoUrl": "https://example.com/battery-care",
      "hasVideo": true,
    },
    {
      "category": "Troubleshooting",
      "title": "Connection Issues",
      "description": "Solving common Bluetooth and connectivity problems",
      "importance": "Medium",
      "duration": "10 min",
      "difficulty": "Medium",
      "steps": [
        "Turn headphones off and on again",
        "Clear Bluetooth cache on your device",
        "Forget and re-pair the headphones",
        "Reset headphones to factory settings if needed",
        "Update firmware if available",
      ],
      "tips": [
        "Keep devices within 30 feet for optimal connection",
        "Avoid interference from other wireless devices",
        "Check for software updates regularly",
      ],
      "videoUrl": "https://example.com/troubleshooting",
      "hasVideo": true,
    },
    {
      "category": "Cleaning",
      "title": "Deep Cleaning Process",
      "description": "Monthly deep cleaning to maintain hygiene and performance",
      "importance": "Medium",
      "duration": "15 min",
      "difficulty": "Medium",
      "steps": [
        "Remove ear cushions if possible",
        "Clean cushions separately with mild soap solution",
        "Use cotton swabs for hard-to-reach areas",
        "Disinfect with 70% isopropyl alcohol on cloth",
        "Let all parts dry completely before reassembly",
      ],
      "tips": [
        "Perform deep cleaning monthly or as needed",
        "Never submerge any electronic parts in liquid",
        "Use antibacterial wipes safe for electronics",
      ],
      "videoUrl": "",
      "hasVideo": false,
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "task": "Daily cleaning after use",
      "frequency": "Daily",
      "lastDone": "Today",
      "nextDue": "Tomorrow",
      "status": "completed",
    },
    {
      "task": "Deep cleaning",
      "frequency": "Monthly",
      "lastDone": "2 weeks ago",
      "nextDue": "In 2 weeks",
      "status": "upcoming",
    },
    {
      "task": "Firmware update check",
      "frequency": "Quarterly",
      "lastDone": "1 month ago",
      "nextDue": "In 2 months",
      "status": "upcoming",
    },
    {
      "task": "Ear cushion replacement",
      "frequency": "Annually",
      "lastDone": "Never",
      "nextDue": "In 8 months",
      "status": "overdue",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTips = selectedCategory == "All" 
        ? careTips 
        : careTips.where((tip) => tip["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Care Guide"),
        actions: [
          IconButton(
            onPressed: () {
              _showMaintenanceSchedule();
            },
            icon: Icon(Icons.schedule),
          ),
        ],
      ),
      body: Column(
        children: [
          // Product Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${product["image"]}",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${product["brand"]} ${product["model"]}",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Care Guide",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: careCategories.length,
              itemBuilder: (context, index) {
                final category = careCategories[index];
                bool isSelected = selectedCategory == category["name"];
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category["name"];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm, top: spSm, bottom: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category["icon"],
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 18,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${category["name"]} (${category["count"]})",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Care Tips List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredTips.length,
              itemBuilder: (context, index) {
                final tip = filteredTips[index];
                bool isExpanded = selectedTipIndex == index;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Tip Header
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTipIndex = isExpanded ? -1 : index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getImportanceColor(tip["importance"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getCategoryIcon(tip["category"]),
                                  color: _getImportanceColor(tip["importance"]),
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${tip["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${tip["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        _buildInfoChip(
                                          "${tip["importance"]}",
                                          _getImportanceColor(tip["importance"]),
                                        ),
                                        SizedBox(width: spSm),
                                        _buildInfoChip(
                                          "${tip["duration"]}",
                                          infoColor,
                                        ),
                                        SizedBox(width: spSm),
                                        _buildInfoChip(
                                          "${tip["difficulty"]}",
                                          warningColor,
                                        ),
                                        if (tip["hasVideo"])
                                          Container(
                                            margin: EdgeInsets.only(left: spSm),
                                            child: Icon(
                                              Icons.play_circle,
                                              color: primaryColor,
                                              size: 16,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: disabledBoldColor,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Expanded Content
                      if (isExpanded)
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Steps
                              Text(
                                "Steps:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              ...(tip["steps"] as List<String>).asMap().entries.map((entry) {
                                int stepIndex = entry.key;
                                String step = entry.value;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spSm),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${stepIndex + 1}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          step,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),

                              // Tips
                              if ((tip["tips"] as List).isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: spMd),
                                    Text(
                                      "Pro Tips:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    ...(tip["tips"] as List<String>).map((tipText) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: spXs),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.lightbulb,
                                              color: warningColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spSm),
                                            Expanded(
                                              child: Text(
                                                tipText,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),

                              // Video Guide
                              if (tip["hasVideo"])
                                Column(
                                  children: [
                                    SizedBox(height: spMd),
                                    QButton(
                                      label: "Watch Video Guide",
                                      icon: Icons.play_arrow,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Playing video guide: ${tip["title"]}");
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuickActions();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.quick_contacts_dialer,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getImportanceColor(String importance) {
    switch (importance.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return infoColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'cleaning':
        return Icons.cleaning_services;
      case 'storage':
        return Icons.inventory;
      case 'maintenance':
        return Icons.build;
      case 'troubleshooting':
        return Icons.help_outline;
      default:
        return Icons.info;
    }
  }

  void _showMaintenanceSchedule() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Maintenance Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: maintenanceSchedule.length,
                  itemBuilder: (context, index) {
                    final task = maintenanceSchedule[index];
                    Color statusColor = task["status"] == "completed" 
                        ? successColor 
                        : task["status"] == "overdue" 
                            ? dangerColor 
                            : warningColor;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: statusColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: statusColor.withAlpha(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${task["task"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${task["frequency"]} • Last: ${task["lastDone"]} • Next: ${task["nextDue"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QButton(
                label: "Set Cleaning Reminder",
                icon: Icons.alarm,
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Cleaning reminder set!");
                },
              ),
              SizedBox(height: spSm),
              QButton(
                label: "Download Care Guide PDF",
                icon: Icons.download,
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Care guide downloaded!");
                },
              ),
              SizedBox(height: spSm),
              QButton(
                label: "Contact Support",
                icon: Icons.support_agent,
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Contacting product support...");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
