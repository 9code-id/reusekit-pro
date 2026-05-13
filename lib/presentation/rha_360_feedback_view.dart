import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class Rha360FeedbackView extends StatefulWidget {
  const Rha360FeedbackView({super.key});

  @override
  State<Rha360FeedbackView> createState() => _Rha360FeedbackViewState();
}

class _Rha360FeedbackViewState extends State<Rha360FeedbackView> {
  String selectedEmployee = "john_doe";
  String selectedFeedbackType = "full_360";
  int currentTab = 0;

  List<Map<String, dynamic>> employees = [
    {"label": "John Doe - Software Engineer", "value": "john_doe"},
    {"label": "Sarah Chen - Engineering Manager", "value": "sarah_chen"},
    {"label": "Mike Rodriguez - Senior Developer", "value": "mike_rodriguez"},
    {"label": "Emily Davis - Frontend Developer", "value": "emily_davis"},
    {"label": "David Kim - Product Manager", "value": "david_kim"},
  ];

  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "Full 360° Feedback", "value": "full_360"},
    {"label": "Manager Feedback Only", "value": "manager_only"},
    {"label": "Peer Feedback Only", "value": "peer_only"},
    {"label": "Direct Report Feedback", "value": "direct_reports"},
  ];

  Map<String, dynamic> feedbackData = {
    "employee": {
      "name": "John Doe",
      "position": "Software Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=developer",
    },
    "feedback_sources": {
      "manager": {
        "name": "Sarah Chen",
        "position": "Engineering Manager",
        "avatar": "https://picsum.photos/80/80?random=2&keyword=manager",
        "status": "completed",
        "submitted_date": "2024-06-15"
      },
      "peers": [
        {
          "name": "Mike Rodriguez",
          "position": "Senior Developer",
          "avatar": "https://picsum.photos/80/80?random=3&keyword=senior",
          "status": "completed",
          "submitted_date": "2024-06-14"
        },
        {
          "name": "Emily Davis",
          "position": "Frontend Developer",
          "avatar": "https://picsum.photos/80/80?random=4&keyword=frontend",
          "status": "pending",
          "submitted_date": null
        },
        {
          "name": "Lisa Wang",
          "position": "DevOps Engineer",
          "avatar": "https://picsum.photos/80/80?random=5&keyword=devops",
          "status": "completed",
          "submitted_date": "2024-06-13"
        }
      ],
      "direct_reports": [
        {
          "name": "Alex Turner",
          "position": "Junior Developer",
          "avatar": "https://picsum.photos/80/80?random=6&keyword=junior",
          "status": "in_progress",
          "submitted_date": null
        }
      ],
      "customers": [
        {
          "name": "Internal Product Team",
          "position": "Stakeholder",
          "avatar": "https://picsum.photos/80/80?random=7&keyword=customer",
          "status": "completed",
          "submitted_date": "2024-06-12"
        }
      ]
    }
  };

  List<Map<String, dynamic>> feedbackCategories = [
    {
      "category": "Technical Skills",
      "icon": Icons.code,
      "color": Colors.blue,
      "ratings": {
        "manager": 4.5,
        "peers": 4.2,
        "direct_reports": 4.0,
        "customers": 4.3
      },
      "comments": [
        {
          "source": "Manager",
          "comment": "Excellent technical expertise and problem-solving abilities"
        },
        {
          "source": "Peer",
          "comment": "Always willing to help with complex technical challenges"
        }
      ]
    },
    {
      "category": "Communication",
      "icon": Icons.chat,
      "color": Colors.green,
      "ratings": {
        "manager": 4.0,
        "peers": 4.1,
        "direct_reports": 3.8,
        "customers": 4.2
      },
      "comments": [
        {
          "source": "Manager",
          "comment": "Clear and concise in technical discussions"
        },
        {
          "source": "Customer",
          "comment": "Explains technical concepts well to non-technical stakeholders"
        }
      ]
    },
    {
      "category": "Leadership",
      "icon": Icons.people,
      "color": Colors.purple,
      "ratings": {
        "manager": 3.8,
        "peers": 3.9,
        "direct_reports": 4.2,
        "customers": 3.7
      },
      "comments": [
        {
          "source": "Direct Report",
          "comment": "Provides good guidance and mentorship"
        },
        {
          "source": "Peer",
          "comment": "Takes initiative on cross-team projects"
        }
      ]
    },
    {
      "category": "Collaboration",
      "icon": Icons.group,
      "color": Colors.orange,
      "ratings": {
        "manager": 4.3,
        "peers": 4.4,
        "direct_reports": 4.1,
        "customers": 4.0
      },
      "comments": [
        {
          "source": "Peer",
          "comment": "Great team player, always supportive"
        },
        {
          "source": "Manager",
          "comment": "Collaborates effectively across departments"
        }
      ]
    },
    {
      "category": "Innovation",
      "icon": Icons.lightbulb,
      "color": Colors.teal,
      "ratings": {
        "manager": 4.2,
        "peers": 4.0,
        "direct_reports": 3.9,
        "customers": 4.1
      },
      "comments": [
        {
          "source": "Manager",
          "comment": "Brings creative solutions to technical challenges"
        },
        {
          "source": "Customer",
          "comment": "Innovative approach to feature development"
        }
      ]
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  double _calculateOverallRating(Map<String, dynamic> ratings) {
    double total = 0.0;
    int count = 0;
    ratings.forEach((key, value) {
      if (value != null) {
        total += value;
        count++;
      }
    });
    return count > 0 ? total / count : 0.0;
  }

  Widget _buildRatingChart(Map<String, dynamic> category) {
    Map<String, dynamic> ratings = category["ratings"];
    double overall = _calculateOverallRating(ratings);
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  category["icon"],
                  color: category["color"],
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Overall Rating: ${overall.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: category["color"],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${overall.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Individual Ratings
          ...ratings.entries.map((entry) {
            String source = entry.key.replaceAll('_', ' ').toUpperCase();
            double rating = entry.value ?? 0.0;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        source,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${rating.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: category["color"],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: rating / 5,
                    backgroundColor: disabledColor.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(category["color"]),
                  ),
                ],
              ),
            );
          }).toList(),
          
          SizedBox(height: spMd),
          
          // Comments
          if ((category["comments"] as List).isNotEmpty) ...[
            Text(
              "Key Feedback:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...(category["comments"] as List).map((comment) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comment["source"]}:",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: category["color"],
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${comment["comment"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final employee = feedbackData["employee"];
    final sources = feedbackData["feedback_sources"];
    
    return QTabBar(
      title: "360° Feedback",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Feedback", icon: Icon(Icons.feedback)),
        Tab(text: "Sources", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Employee Selection
              QDropdownField(
                label: "Select Employee",
                items: employees,
                value: selectedEmployee,
                onChanged: (value, label) {
                  selectedEmployee = value;
                  setState(() {});
                },
              ),

              // Employee Info
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage("${employee["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${employee["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${employee["position"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${employee["department"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Feedback Progress
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feedback Collection Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Manager Feedback
                    Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(sources["manager"]["status"]).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getStatusColor(sources["manager"]["status"]).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${sources["manager"]["avatar"]}"),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sources["manager"]["name"]} (Manager)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${sources["manager"]["position"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(sources["manager"]["status"]),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              _getStatusText(sources["manager"]["status"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Peer Feedback Summary
                    Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.group, color: primaryColor, size: 24),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Peer Feedback",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(sources["peers"] as List).where((p) => p["status"] == "completed").length} of ${(sources["peers"] as List).length} completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              currentTab = 2;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Direct Reports Summary
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.people_outline, color: primaryColor, size: 24),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Direct Report Feedback",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(sources["direct_reports"] as List).where((p) => p["status"] == "completed").length} of ${(sources["direct_reports"] as List).length} completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              currentTab = 2;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Actions
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Send Reminders",
                            icon: Icons.notifications,
                            size: bs.md,
                            onPressed: () {
                              ss("Reminders sent to pending reviewers");
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Generate Report",
                            icon: Icons.assessment,
                            size: bs.md,
                            onPressed: () {
                              //navigateTo('360FeedbackReportView')
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

        // Feedback Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Detailed Feedback Analysis",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...feedbackCategories.map((category) {
                return _buildRatingChart(category);
              }).toList(),
            ],
          ),
        ),

        // Sources Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Peer Feedback
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.group, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Peer Feedback",
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
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${(sources["peers"] as List).length} reviewers",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...(sources["peers"] as List).map((peer) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getStatusColor(peer["status"]).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getStatusColor(peer["status"]).withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${peer["avatar"]}"),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${peer["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${peer["position"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (peer["submitted_date"] != null)
                                    Text(
                                      "Submitted: ${peer["submitted_date"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(peer["status"]),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    _getStatusText(peer["status"]),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (peer["status"] == "pending") ...[
                                  SizedBox(height: spSm),
                                  QButton(
                                    label: "Remind",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Reminder sent to ${peer["name"]}");
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Direct Reports
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.people_outline, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Direct Reports",
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
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${(sources["direct_reports"] as List).length} reports",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...(sources["direct_reports"] as List).map((report) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getStatusColor(report["status"]).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getStatusColor(report["status"]).withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${report["avatar"]}"),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${report["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${report["position"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(report["status"]),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                _getStatusText(report["status"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Customer/Stakeholder Feedback
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.business, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Customer/Stakeholder Feedback",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...(sources["customers"] as List).map((customer) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getStatusColor(customer["status"]).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getStatusColor(customer["status"]).withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${customer["avatar"]}"),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${customer["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${customer["position"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (customer["submitted_date"] != null)
                                    Text(
                                      "Submitted: ${customer["submitted_date"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(customer["status"]),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                _getStatusText(customer["status"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
