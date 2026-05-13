import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaFirstAidGuideView extends StatefulWidget {
  const MhaFirstAidGuideView({super.key});

  @override
  State<MhaFirstAidGuideView> createState() => _MhaFirstAidGuideViewState();
}

class _MhaFirstAidGuideViewState extends State<MhaFirstAidGuideView> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Cardiac", "value": "Cardiac"},
    {"label": "Breathing", "value": "Breathing"},
    {"label": "Bleeding", "value": "Bleeding"},
    {"label": "Burns", "value": "Burns"},
    {"label": "Fractures", "value": "Fractures"},
    {"label": "Poisoning", "value": "Poisoning"},
  ];

  List<Map<String, dynamic>> firstAidGuides = [
    {
      "title": "CPR (Cardiopulmonary Resuscitation)",
      "category": "Cardiac",
      "difficulty": "Critical",
      "duration": "2-3 minutes",
      "priority": "Emergency",
      "image": "https://picsum.photos/300/200?random=1&keyword=cpr",
      "description": "Life-saving technique for cardiac arrest",
      "steps": [
        "Check for responsiveness - tap shoulders and shout",
        "Call 911 immediately or have someone else do it",
        "Place heel of hand on center of chest between nipples",
        "Place other hand on top, interlocking fingers",
        "Push hard and fast at least 2 inches deep",
        "Allow complete chest recoil between compressions",
        "Compress at rate of 100-120 per minute",
        "Give 30 compressions, then 2 rescue breaths",
        "Continue cycles until help arrives"
      ],
      "warnings": [
        "Only perform if person is unresponsive and not breathing normally",
        "Do not be afraid to push hard - broken ribs heal, hearts don't",
        "Switch with someone every 2 minutes to avoid fatigue"
      ]
    },
    {
      "title": "Choking Relief (Heimlich Maneuver)",
      "category": "Breathing",
      "difficulty": "Moderate",
      "duration": "1-2 minutes",
      "priority": "Emergency",
      "image": "https://picsum.photos/300/200?random=2&keyword=choking",
      "description": "Remove airway obstruction in conscious person",
      "steps": [
        "Stand behind the person",
        "Wrap arms around their waist",
        "Make a fist with one hand",
        "Place thumb side against upper abdomen, below ribcage",
        "Grasp fist with other hand",
        "Give quick upward thrusts",
        "Repeat until object is expelled or person becomes unconscious",
        "If unconscious, begin CPR"
      ],
      "warnings": [
        "Do not perform on pregnant women or infants",
        "Use modified technique for obese individuals",
        "Seek medical attention after successful removal"
      ]
    },
    {
      "title": "Severe Bleeding Control",
      "category": "Bleeding",
      "difficulty": "Moderate",
      "duration": "5-10 minutes",
      "priority": "Emergency",
      "image": "https://picsum.photos/300/200?random=3&keyword=bleeding",
      "description": "Stop major bleeding and prevent shock",
      "steps": [
        "Apply direct pressure to wound with clean cloth",
        "Maintain continuous pressure",
        "Add more layers if blood soaks through",
        "Elevate injured area above heart if possible",
        "Apply pressure to pressure points if needed",
        "Use tourniquet only if trained and bleeding won't stop",
        "Do not remove embedded objects",
        "Monitor for signs of shock"
      ],
      "warnings": [
        "Do not remove objects embedded in wounds",
        "Use gloves or barrier when possible",
        "Seek immediate medical attention for severe bleeding"
      ]
    },
    {
      "title": "Burn Treatment",
      "category": "Burns",
      "difficulty": "Easy",
      "duration": "10-15 minutes",
      "priority": "Urgent",
      "image": "https://picsum.photos/300/200?random=4&keyword=burn",
      "description": "Cool and protect burn injuries",
      "steps": [
        "Remove from heat source immediately",
        "Cool burn with cool running water for 10-20 minutes",
        "Remove tight items before swelling begins",
        "Do not break blisters",
        "Cover with sterile gauze loosely",
        "Take over-the-counter pain medication if needed",
        "Protect from further injury",
        "Seek medical care for serious burns"
      ],
      "warnings": [
        "Do not use ice on burns",
        "Do not apply butter, oils, or home remedies",
        "Seek immediate help for large burns or burns on face/hands"
      ]
    },
    {
      "title": "Fracture Stabilization",
      "category": "Fractures",
      "difficulty": "Moderate",
      "duration": "10-20 minutes",
      "priority": "Urgent",
      "image": "https://picsum.photos/300/200?random=5&keyword=fracture",
      "description": "Immobilize suspected broken bones",
      "steps": [
        "Do not move the person unless in immediate danger",
        "Support the injured area",
        "Immobilize above and below the fracture",
        "Use splint materials (boards, magazines, etc.)",
        "Pad splint to prevent pressure sores",
        "Secure splint with bandages or tape",
        "Check circulation below injury frequently",
        "Apply ice pack to reduce swelling"
      ],
      "warnings": [
        "Do not try to straighten broken bones",
        "Do not move person with suspected spine injury",
        "Seek immediate medical attention"
      ]
    },
    {
      "title": "Poisoning Response",
      "category": "Poisoning",
      "difficulty": "Easy",
      "duration": "Immediate",
      "priority": "Emergency",
      "image": "https://picsum.photos/300/200?random=6&keyword=poison",
      "description": "Respond to suspected poisoning",
      "steps": [
        "Call Poison Control: 1-800-222-1222",
        "Identify the poison if possible",
        "Check person's breathing and pulse",
        "Do not induce vomiting unless instructed",
        "If on skin/eyes, flush with water for 15-20 minutes",
        "If inhaled, get to fresh air immediately",
        "Save container/label for medical personnel",
        "Follow Poison Control instructions exactly"
      ],
      "warnings": [
        "Do not give anything by mouth unless instructed",
        "Do not induce vomiting for corrosive substances",
        "Call 911 if person is unconscious or having trouble breathing"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredGuides {
    return firstAidGuides.where((guide) {
      bool matchesSearch = "${guide["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${guide["category"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${guide["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || guide["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Aid Guide"),
        actions: [
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              // Quick emergency access
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Emergency Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Notice",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Call 911 immediately for life-threatening emergencies. These guides are for educational purposes.",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search first aid guides...",
                    value: searchQuery,
                    hint: "Search by condition or category",
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
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Quick Access Emergency Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Emergency Access",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "CPR Guide",
                          icon: Icons.favorite,
                          size: bs.sm,
                          color: dangerColor,
                          onPressed: () {
                            // Navigate to CPR guide
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Choking Help",
                          icon: Icons.air,
                          size: bs.sm,
                          color: warningColor,
                          onPressed: () {
                            // Navigate to choking guide
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "First Aid Guides (${filteredGuides.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Emergency guides available",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // First Aid Guides List
            ...filteredGuides.map((guide) {
              Color priorityColor = guide["priority"] == "Emergency" ? dangerColor : 
                                   guide["priority"] == "Urgent" ? warningColor : infoColor;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: guide["priority"] == "Emergency" ? Border.all(color: dangerColor.withAlpha(100)) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Guide Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${guide["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${guide["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: priorityColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${guide["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${guide["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${guide["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.access_time,
                                    color: disabledBoldColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${guide["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Difficulty and Steps Preview
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(guide["difficulty"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  _getDifficultyIcon(guide["difficulty"] as String),
                                  color: _getDifficultyColor(guide["difficulty"] as String),
                                  size: 20,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${guide["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getDifficultyColor(guide["difficulty"] as String),
                                  ),
                                ),
                                Text(
                                  "Difficulty",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.list_alt,
                                  color: infoColor,
                                  size: 20,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(guide["steps"] as List).length}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Steps",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: warningColor,
                                  size: 20,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(guide["warnings"] as List).length}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Warnings",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Guide",
                            icon: Icons.visibility,
                            size: bs.sm,
                            color: guide["priority"] == "Emergency" ? dangerColor : primaryColor,
                            onPressed: () {
                              // Navigate to full guide
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Practice Mode",
                            icon: Icons.school,
                            size: bs.sm,
                            onPressed: () {
                              // Start practice session
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.bookmark_border,
                          size: bs.sm,
                          onPressed: () {
                            // Bookmark guide
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick emergency call
        },
        backgroundColor: dangerColor,
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return Icons.check_circle;
      case "Moderate":
        return Icons.warning;
      case "Critical":
        return Icons.emergency;
      default:
        return Icons.info;
    }
  }
}
