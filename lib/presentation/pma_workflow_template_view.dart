import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaWorkflowTemplateView extends StatefulWidget {
  const PmaWorkflowTemplateView({super.key});

  @override
  State<PmaWorkflowTemplateView> createState() => _PmaWorkflowTemplateViewState();
}

class _PmaWorkflowTemplateViewState extends State<PmaWorkflowTemplateView> {
  String searchQuery = "";
  String selectedAutomationLevel = "All";
  String selectedTeamSize = "All";

  List<Map<String, dynamic>> automationLevels = [
    {"label": "All", "value": "All"},
    {"label": "Manual", "value": "Manual"},
    {"label": "Semi-Automated", "value": "Semi-Automated"},
    {"label": "Fully Automated", "value": "Fully Automated"},
  ];

  List<Map<String, dynamic>> teamSizes = [
    {"label": "All", "value": "All"},
    {"label": "Small (1-3)", "value": "Small"},
    {"label": "Medium (4-8)", "value": "Medium"},
    {"label": "Large (9+)", "value": "Large"},
  ];

  List<Map<String, dynamic>> workflowTemplates = [
    {
      "id": 1,
      "name": "Software Development Workflow",
      "description": "Complete SDLC workflow with CI/CD integration",
      "stages": ["Planning", "Development", "Testing", "Deployment", "Monitoring"],
      "automationLevel": "Fully Automated",
      "teamSize": "Medium",
      "duration": "2-4 weeks",
      "efficiency": 95,
      "usageCount": 342,
      "tools": ["Jira", "GitHub", "Jenkins", "Docker"],
      "icon": Icons.code,
      "color": "primary",
      "createdBy": "Tech Lead Team",
      "lastUpdated": "2024-01-20",
    },
    {
      "id": 2,
      "name": "Content Creation Pipeline",
      "description": "Editorial workflow for content creation and publishing",
      "stages": ["Ideation", "Writing", "Review", "Design", "Publishing"],
      "automationLevel": "Semi-Automated",
      "teamSize": "Small",
      "duration": "1-2 weeks",
      "efficiency": 88,
      "usageCount": 567,
      "tools": ["Notion", "Figma", "WordPress", "Buffer"],
      "icon": Icons.edit,
      "color": "success",
      "createdBy": "Content Team",
      "lastUpdated": "2024-01-18",
    },
    {
      "id": 3,
      "name": "Product Launch Workflow",
      "description": "End-to-end product launch coordination",
      "stages": ["Research", "Planning", "Development", "Marketing", "Launch"],
      "automationLevel": "Manual",
      "teamSize": "Large",
      "duration": "8-12 weeks",
      "efficiency": 82,
      "usageCount": 234,
      "tools": ["Asana", "Slack", "HubSpot", "Analytics"],
      "icon": Icons.rocket_launch,
      "color": "warning",
      "createdBy": "Product Team",
      "lastUpdated": "2024-01-15",
    },
    {
      "id": 4,
      "name": "Customer Support Flow",
      "description": "Streamlined customer support ticket handling",
      "stages": ["Intake", "Triage", "Assignment", "Resolution", "Follow-up"],
      "automationLevel": "Fully Automated",
      "teamSize": "Medium",
      "duration": "1-3 days",
      "efficiency": 93,
      "usageCount": 789,
      "tools": ["Zendesk", "Slack", "Salesforce", "AI Chatbot"],
      "icon": Icons.support_agent,
      "color": "info",
      "createdBy": "Support Team",
      "lastUpdated": "2024-01-22",
    },
    {
      "id": 5,
      "name": "HR Onboarding Process",
      "description": "New employee onboarding workflow",
      "stages": ["Pre-boarding", "Welcome", "Training", "Integration", "Review"],
      "automationLevel": "Semi-Automated",
      "teamSize": "Small",
      "duration": "2-4 weeks",
      "efficiency": 90,
      "usageCount": 456,
      "tools": ["BambooHR", "Slack", "LMS", "DocuSign"],
      "icon": Icons.people,
      "color": "secondary",
      "createdBy": "HR Department",
      "lastUpdated": "2024-01-19",
    },
    {
      "id": 6,
      "name": "Quality Assurance Pipeline",
      "description": "Comprehensive QA testing workflow",
      "stages": ["Test Planning", "Manual Testing", "Automated Testing", "Bug Tracking", "Release"],
      "automationLevel": "Fully Automated",
      "teamSize": "Medium",
      "duration": "1-2 weeks",
      "efficiency": 96,
      "usageCount": 123,
      "tools": ["TestRail", "Selenium", "Jira", "CircleCI"],
      "icon": Icons.verified,
      "color": "danger",
      "createdBy": "QA Team",
      "lastUpdated": "2024-01-21",
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return workflowTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          template["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          template["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesAutomation = selectedAutomationLevel == "All" || template["automationLevel"] == selectedAutomationLevel;
      bool matchesTeamSize = selectedTeamSize == "All" || template["teamSize"] == selectedTeamSize;
      
      return matchesSearch && matchesAutomation && matchesTeamSize;
    }).toList();
  }

  Color _getAutomationColor(String automationLevel) {
    switch (automationLevel) {
      case "Manual":
        return warningColor;
      case "Semi-Automated":
        return infoColor;
      case "Fully Automated":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTemplateColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "secondary":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Workflow Templates",
                    value: searchQuery,
                    hint: "Search by name or description...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Automation Level",
                          items: automationLevels,
                          value: selectedAutomationLevel,
                          onChanged: (value, label) {
                            selectedAutomationLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Team Size",
                          items: teamSizes,
                          value: selectedTeamSize,
                          onChanged: (value, label) {
                            selectedTeamSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredTemplates.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Workflows Found",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((workflowTemplates.map((t) => t["efficiency"] as int).reduce((a, b) => a + b)) / workflowTemplates.length).round()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg Efficiency",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((workflowTemplates.map((t) => t["usageCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Usage",
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

            // Workflow Template Grid
            if (filteredTemplates.isNotEmpty)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTemplates.map((template) {
                  Color templateColor = _getTemplateColor(template["color"]);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: templateColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: templateColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  template["icon"],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: templateColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getAutomationColor(template["automationLevel"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: _getAutomationColor(template["automationLevel"]),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${template["automationLevel"]}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: _getAutomationColor(template["automationLevel"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Template Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Description
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Workflow Stages
                              Text(
                                "Workflow Stages",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                height: 40,
                                child: QHorizontalScroll(
                                  children: (template["stages"] as List).asMap().entries.map((entry) {
                                    int index = entry.key;
                                    String stage = entry.value;
                                    return Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: templateColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                            border: Border.all(
                                              color: templateColor.withAlpha(60),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            "$stage",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                              color: templateColor,
                                            ),
                                          ),
                                        ),
                                        if (index < (template["stages"] as List).length - 1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 8,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),

                              // Stats Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.people,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["teamSize"]} team",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Efficiency and Usage
                              Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["efficiency"]}% efficiency",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.download,
                                    size: 14,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["usageCount"]} uses",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              // Tools
                              Text(
                                "Tools & Integrations",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: (template["tools"] as List).map((tool) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$tool",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Creator and Date
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "By ${template["createdBy"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${template["lastUpdated"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Action Buttons
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Use Workflow",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {},
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
              )
            else
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No workflow templates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
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
      ),
    );
  }
}
