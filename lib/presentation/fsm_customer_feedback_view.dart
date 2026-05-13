import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerFeedbackView extends StatefulWidget {
  const FsmCustomerFeedbackView({super.key});

  @override
  State<FsmCustomerFeedbackView> createState() => _FsmCustomerFeedbackViewState();
}

class _FsmCustomerFeedbackViewState extends State<FsmCustomerFeedbackView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedPriority = "all";
  bool autoResponseEnabled = true;
  bool emailNotificationsEnabled = true;
  bool smsNotificationsEnabled = false;
  double responseTimeTarget = 24.0;
  double satisfactionThreshold = 4.0;

  List<Map<String, dynamic>> feedbackData = [
    {
      "id": "FB001",
      "customer": "Sarah Johnson",
      "service": "HVAC Repair",
      "technician": "Mike Chen",
      "rating": 5,
      "comment": "Excellent service! Mike was professional and fixed the issue quickly.",
      "date": "2024-01-15",
      "status": "reviewed",
      "priority": "low",
      "category": "service_quality",
      "response": "Thank you for your positive feedback!",
      "responseDate": "2024-01-15",
      "tags": ["professional", "quick", "satisfied"]
    },
    {
      "id": "FB002", 
      "customer": "Robert Davis",
      "service": "Plumbing Installation",
      "technician": "John Smith",
      "rating": 2,
      "comment": "Service was delayed and the technician didn't have all necessary parts.",
      "date": "2024-01-14",
      "status": "pending",
      "priority": "high",
      "category": "service_delay",
      "response": "",
      "responseDate": "",
      "tags": ["delayed", "unprepared", "dissatisfied"]
    },
    {
      "id": "FB003",
      "customer": "Emily Wilson",
      "service": "Electrical Maintenance",
      "technician": "Alex Rodriguez",
      "rating": 4,
      "comment": "Good work overall, but arrived 30 minutes late.",
      "date": "2024-01-13",
      "status": "reviewed",
      "priority": "medium",
      "category": "punctuality",
      "response": "We apologize for the delay. We're working to improve our scheduling.",
      "responseDate": "2024-01-13",
      "tags": ["good_work", "late_arrival", "scheduling"]
    },
    {
      "id": "FB004",
      "customer": "Michael Brown",
      "service": "Generator Service",
      "technician": "Lisa Wang",
      "rating": 5,
      "comment": "Lisa was very knowledgeable and explained everything clearly.",
      "date": "2024-01-12",
      "status": "reviewed",
      "priority": "low",
      "category": "communication",
      "response": "Thank you! We'll share your feedback with Lisa.",
      "responseDate": "2024-01-12",
      "tags": ["knowledgeable", "clear_communication", "satisfied"]
    },
    {
      "id": "FB005",
      "customer": "Jennifer Lee",
      "service": "Security System Install",
      "technician": "David Kim",
      "rating": 1,
      "comment": "Very disappointed. System not working properly after installation.",
      "date": "2024-01-11",
      "status": "escalated",
      "priority": "critical",
      "category": "technical_issue",
      "response": "We sincerely apologize. A supervisor will contact you within 2 hours.",
      "responseDate": "2024-01-11",
      "tags": ["technical_failure", "escalated", "urgent"]
    }
  ];

  List<Map<String, dynamic>> feedbackTemplates = [
    {
      "id": "T001",
      "name": "Positive Response",
      "category": "appreciation",
      "rating_range": "4-5",
      "template": "Thank you for your positive feedback! We're delighted to hear about your experience with {technician}. We'll make sure to share your kind words with our team.",
      "auto_send": true,
      "tags": ["appreciation", "positive", "team_recognition"]
    },
    {
      "id": "T002",
      "name": "Service Recovery",
      "category": "complaint",
      "rating_range": "1-2", 
      "template": "We sincerely apologize for not meeting your expectations. Your feedback is important to us and we're taking immediate action to address the issues you've raised. A supervisor will contact you within 24 hours.",
      "auto_send": false,
      "tags": ["apology", "recovery", "escalation"]
    },
    {
      "id": "T003",
      "name": "Improvement Acknowledgment",
      "category": "suggestion",
      "rating_range": "3-4",
      "template": "Thank you for your feedback and suggestions. We appreciate your input and are continuously working to improve our services. Your experience matters to us.",
      "auto_send": true,
      "tags": ["improvement", "acknowledgment", "continuous"]
    }
  ];

  List<Map<String, dynamic>> feedbackAnalytics = [
    {
      "metric": "Average Rating",
      "value": 3.4,
      "target": 4.5,
      "trend": "increasing",
      "period": "This Month",
      "change": "+0.3"
    },
    {
      "metric": "Response Rate",
      "value": 89.5,
      "target": 95.0,
      "trend": "stable",
      "period": "This Month", 
      "change": "+1.2%"
    },
    {
      "metric": "Resolution Time",
      "value": 18.5,
      "target": 24.0,
      "trend": "decreasing",
      "period": "Average Hours",
      "change": "-2.5h"
    },
    {
      "metric": "Satisfaction Score",
      "value": 4.2,
      "target": 4.7,
      "trend": "increasing",
      "period": "Overall",
      "change": "+0.4"
    }
  ];

  List<Map<String, dynamic>> get filteredFeedback {
    return feedbackData.where((feedback) {
      bool matchesSearch = searchQuery.isEmpty ||
          feedback["customer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          feedback["service"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          feedback["technician"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" || feedback["status"] == selectedFilter;
      bool matchesPriority = selectedPriority == "all" || feedback["priority"] == selectedPriority;
      
      return matchesSearch && matchesFilter && matchesPriority;
    }).toList();
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating >= 3) return warningColor;
    return dangerColor;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical": return dangerColor;
      case "high": return warningColor;
      case "medium": return infoColor;
      default: return successColor;
    }
  }

  Widget _buildFeedbackOverview() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search feedback...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Pending", "value": "pending"},
                    {"label": "Reviewed", "value": "reviewed"},
                    {"label": "Escalated", "value": "escalated"},
                  ],
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "All Priority", "value": "all"},
                    {"label": "Critical", "value": "critical"},
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: feedbackAnalytics.map((metric) {
              Color trendColor = metric["trend"] == "increasing" ? successColor :
                                metric["trend"] == "decreasing" ? dangerColor : warningColor;
              
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
                        Expanded(
                          child: Text(
                            "${metric["metric"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Icon(
                          metric["trend"] == "increasing" ? Icons.trending_up :
                          metric["trend"] == "decreasing" ? Icons.trending_down : Icons.trending_flat,
                          color: trendColor,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["value"]}${metric["metric"].contains("Rate") ? "%" : metric["metric"].contains("Time") ? "h" : ""}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "Target: ${metric["target"]}${metric["metric"].contains("Rate") ? "%" : metric["metric"].contains("Time") ? "h" : ""}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${metric["change"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: trendColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Feedback List
          ...filteredFeedback.map((feedback) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${feedback["priority"]}"),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${feedback["customer"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${feedback["service"]} • ${feedback["technician"]}",
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
                          color: _getRatingColor(feedback["rating"] as int).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: _getRatingColor(feedback["rating"] as int),
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${feedback["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _getRatingColor(feedback["rating"] as int),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Comment
                  Text(
                    "${feedback["comment"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (feedback["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),

                  // Response Section
                  if (feedback["response"] != "")
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Our Response:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${feedback["response"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Footer
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${feedback["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (feedback["status"] == "pending")
                        QButton(
                          label: "Respond",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplateManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  "Response Templates",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Template",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Template Settings
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
                  "Auto-Response Settings",
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
                      child: Text(
                        "Enable Auto Response",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: autoResponseEnabled,
                      onChanged: (value) {
                        autoResponseEnabled = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                Text(
                  "Response Time Target (hours)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Slider(
                  value: responseTimeTarget,
                  min: 1,
                  max: 72,
                  divisions: 71,
                  label: "${responseTimeTarget.round()}h",
                  onChanged: (value) {
                    responseTimeTarget = value;
                    setState(() {});
                  },
                ),
                Text(
                  "Current: ${responseTimeTarget.round()} hours",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Template List
          ...feedbackTemplates.map((template) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "For ratings: ${template["rating_range"]}",
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
                          color: template["auto_send"] ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          template["auto_send"] ? "Auto Send" : "Manual",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: template["auto_send"] ? successColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${template["template"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (template["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Spacer(),
                      QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Test",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFeedbackSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Notification Settings
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
                  "Notification Preferences",
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
                      child: Text(
                        "Email Notifications",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: emailNotificationsEnabled,
                      onChanged: (value) {
                        emailNotificationsEnabled = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "SMS Notifications",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: smsNotificationsEnabled,
                      onChanged: (value) {
                        smsNotificationsEnabled = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Response Quality Settings
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
                  "Quality Standards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                Text(
                  "Satisfaction Threshold",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Slider(
                  value: satisfactionThreshold,
                  min: 1,
                  max: 5,
                  divisions: 8,
                  label: "${satisfactionThreshold.toStringAsFixed(1)} stars",
                  onChanged: (value) {
                    satisfactionThreshold = value;
                    setState(() {});
                  },
                ),
                Text(
                  "Ratings below ${satisfactionThreshold.toStringAsFixed(1)} stars will be flagged for review",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Escalation Rules
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
                  "Escalation Rules",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                _buildEscalationRule("1-2 Star Ratings", "Immediate supervisor notification", dangerColor),
                SizedBox(height: spSm),
                _buildEscalationRule("No Response >24h", "Auto-escalate to management", warningColor),
                SizedBox(height: spSm),
                _buildEscalationRule("Multiple Complaints", "Flag for service review", infoColor),
              ],
            ),
          ),

          // Data Management
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
                  "Data Management",
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
                        label: "Export Feedback",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Generate Report",
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Archive Old Feedback",
                    icon: Icons.archive,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEscalationRule(String condition, String action, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  condition,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  action,
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Feedback",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Feedback", icon: Icon(Icons.feedback)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildFeedbackOverview(),
        _buildTemplateManagement(),
        _buildFeedbackSettings(),
      ],
    );
  }
}
