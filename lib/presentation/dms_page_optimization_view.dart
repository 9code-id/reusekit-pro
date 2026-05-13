import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsPageOptimizationView extends StatefulWidget {
  const DmsPageOptimizationView({super.key});

  @override
  State<DmsPageOptimizationView> createState() => _DmsPageOptimizationViewState();
}

class _DmsPageOptimizationViewState extends State<DmsPageOptimizationView> {
  String selectedOptimizationType = "all";
  String selectedPriority = "all";
  int selectedOptimizationFilter = 0;

  List<Map<String, dynamic>> optimizationTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Content", "value": "content"},
    {"label": "Technical", "value": "technical"},
    {"label": "Performance", "value": "performance"},
    {"label": "User Experience", "value": "ux"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> optimizationTasks = [
    {
      "task_id": 1,
      "title": "Optimize Homepage Title Tag",
      "description": "Update homepage title to include primary keyword and stay under 60 characters",
      "page_url": "/",
      "optimization_type": "content",
      "priority": "high",
      "estimated_impact": "high",
      "estimated_hours": 1,
      "current_state": "Title too long (67 characters)",
      "target_state": "Optimized title with primary keyword (55-60 characters)",
      "before_metrics": {
        "title_length": 67,
        "keyword_present": false,
        "ctr_estimate": 2.1,
      },
      "after_metrics": {
        "title_length": 58,
        "keyword_present": true,
        "ctr_estimate": 3.4,
      },
      "steps": [
        "Identify primary keyword for homepage",
        "Research competitor title tags",
        "Write compelling title under 60 characters",
        "Include primary keyword naturally",
        "Test title in SERP preview tool",
      ],
      "tools_needed": ["SERP Preview Tool", "Keyword Research Tool"],
      "status": "pending",
      "completion_percentage": 0,
    },
    {
      "task_id": 2,
      "title": "Improve Page Loading Speed",
      "description": "Optimize images and reduce server response time to improve Core Web Vitals",
      "page_url": "/services/ppc-advertising",
      "optimization_type": "performance",
      "priority": "high",
      "estimated_impact": "high",
      "estimated_hours": 4,
      "current_state": "Page loads in 4.2 seconds, poor LCP score",
      "target_state": "Page loads under 3 seconds, good Core Web Vitals",
      "before_metrics": {
        "page_speed": 42,
        "lcp": 4.2,
        "fid": 180,
        "cls": 0.15,
      },
      "after_metrics": {
        "page_speed": 75,
        "lcp": 2.8,
        "fid": 120,
        "cls": 0.08,
      },
      "steps": [
        "Compress and optimize all images",
        "Enable browser caching",
        "Minify CSS and JavaScript",
        "Optimize server response time",
        "Test Core Web Vitals scores",
      ],
      "tools_needed": ["PageSpeed Insights", "GTmetrix", "Image Optimization Tool"],
      "status": "in_progress",
      "completion_percentage": 35,
    },
    {
      "task_id": 3,
      "title": "Add Schema Markup for Services",
      "description": "Implement structured data for service pages to enhance SERP appearance",
      "page_url": "/services/*",
      "optimization_type": "technical",
      "priority": "medium",
      "estimated_impact": "medium",
      "estimated_hours": 3,
      "current_state": "No structured data implemented",
      "target_state": "Service schema markup on all service pages",
      "before_metrics": {
        "rich_snippets": false,
        "serp_features": 0,
        "click_through_rate": 2.8,
      },
      "after_metrics": {
        "rich_snippets": true,
        "serp_features": 3,
        "click_through_rate": 4.2,
      },
      "steps": [
        "Research appropriate schema types",
        "Create schema markup templates",
        "Implement schema on service pages",
        "Test markup with Google's Rich Results Test",
        "Monitor SERP appearance changes",
      ],
      "tools_needed": ["Schema.org", "Google Rich Results Test", "JSON-LD Generator"],
      "status": "pending",
      "completion_percentage": 0,
    },
    {
      "task_id": 4,
      "title": "Expand About Page Content",
      "description": "Increase content length and improve structure to meet SEO standards",
      "page_url": "/about",
      "optimization_type": "content",
      "priority": "high",
      "estimated_impact": "medium",
      "estimated_hours": 2,
      "current_state": "320 words, poor heading structure",
      "target_state": "800+ words with proper H2/H3 structure",
      "before_metrics": {
        "word_count": 320,
        "h2_count": 0,
        "h3_count": 1,
        "seo_score": 58,
      },
      "after_metrics": {
        "word_count": 850,
        "h2_count": 4,
        "h3_count": 6,
        "seo_score": 78,
      },
      "steps": [
        "Outline new content structure",
        "Write additional sections (team, history, values)",
        "Add proper H2 and H3 headings",
        "Include relevant keywords naturally",
        "Add internal links to services",
      ],
      "tools_needed": ["Content Editor", "Keyword Research Tool"],
      "status": "completed",
      "completion_percentage": 100,
    },
    {
      "task_id": 5,
      "title": "Optimize Image Alt Tags",
      "description": "Add descriptive alt text to all images for accessibility and SEO",
      "page_url": "/*",
      "optimization_type": "content",
      "priority": "medium",
      "estimated_impact": "low",
      "estimated_hours": 2,
      "current_state": "15 images missing alt text",
      "target_state": "All images have descriptive alt text",
      "before_metrics": {
        "images_with_alt": 45,
        "images_without_alt": 15,
        "accessibility_score": 78,
      },
      "after_metrics": {
        "images_with_alt": 60,
        "images_without_alt": 0,
        "accessibility_score": 95,
      },
      "steps": [
        "Audit all images across the site",
        "Write descriptive alt text for each image",
        "Include relevant keywords where appropriate",
        "Test accessibility improvements",
        "Update image optimization guidelines",
      ],
      "tools_needed": ["Site Audit Tool", "Accessibility Checker"],
      "status": "in_progress",
      "completion_percentage": 60,
    },
    {
      "task_id": 6,
      "title": "Improve Internal Linking Structure",
      "description": "Add strategic internal links to improve page authority distribution",
      "page_url": "/*",
      "optimization_type": "technical",
      "priority": "medium",
      "estimated_impact": "medium",
      "estimated_hours": 3,
      "current_state": "Average 8 internal links per page",
      "target_state": "15-20 relevant internal links per page",
      "before_metrics": {
        "avg_internal_links": 8,
        "orphan_pages": 3,
        "link_equity_distribution": 65,
      },
      "after_metrics": {
        "avg_internal_links": 17,
        "orphan_pages": 0,
        "link_equity_distribution": 85,
      },
      "steps": [
        "Map current internal linking structure",
        "Identify high-authority pages",
        "Create internal linking strategy",
        "Add contextual internal links",
        "Monitor link equity distribution",
      ],
      "tools_needed": ["Site Crawler", "Link Analysis Tool"],
      "status": "pending",
      "completion_percentage": 0,
    },
  ];

  List<Map<String, dynamic>> get filteredOptimizationTasks {
    List<Map<String, dynamic>> filtered = optimizationTasks;

    if (selectedOptimizationType != "all") {
      filtered = filtered.where((task) => task["optimization_type"] == selectedOptimizationType).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((task) => task["priority"] == selectedPriority).toList();
    }

    switch (selectedOptimizationFilter) {
      case 1: // High Impact
        filtered = filtered.where((task) => task["estimated_impact"] == "high").toList();
        break;
      case 2: // In Progress
        filtered = filtered.where((task) => task["status"] == "in_progress").toList();
        break;
      case 3: // Quick Wins
        filtered = filtered.where((task) => (task["estimated_hours"] as int) <= 2).toList();
        break;
    }

    // Sort by priority and then by estimated impact
    filtered.sort((a, b) {
      Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
      Map<String, int> impactOrder = {"high": 3, "medium": 2, "low": 1};
      
      int priorityComparison = (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
      if (priorityComparison != 0) return priorityComparison;
      
      return (impactOrder[b["estimated_impact"]] ?? 0).compareTo(impactOrder[a["estimated_impact"]] ?? 0);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_task),
            onPressed: () {
              _showAddTaskDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export optimization plan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Optimization Type",
                    items: optimizationTypeOptions,
                    value: selectedOptimizationType,
                    onChanged: (value, label) {
                      selectedOptimizationType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Optimization Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Tasks", "value": 0},
                {"label": "High Impact", "value": 1},
                {"label": "In Progress", "value": 2},
                {"label": "Quick Wins", "value": 3},
              ],
              value: selectedOptimizationFilter,
              onChanged: (index, label, value, item) {
                selectedOptimizationFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Optimization Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Optimization Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Tasks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${optimizationTasks.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${optimizationTasks.where((t) => t["status"] == "completed").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${optimizationTasks.where((t) => t["status"] == "in_progress").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Est. Hours",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${optimizationTasks.where((t) => t["status"] != "completed").map((t) => t["estimated_hours"] as int).fold(0, (a, b) => a + b)}h",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
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
            SizedBox(height: spMd),

            // Optimization Tasks
            Text(
              "Optimization Tasks",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredOptimizationTasks.map((task) {
              Color priorityColor = task["priority"] == "high" 
                  ? dangerColor 
                  : task["priority"] == "medium" 
                      ? warningColor 
                      : successColor;

              Color statusColor = task["status"] == "completed" 
                  ? successColor 
                  : task["status"] == "in_progress" 
                      ? warningColor 
                      : disabledBoldColor;

              Color impactColor = task["estimated_impact"] == "high" 
                  ? dangerColor 
                  : task["estimated_impact"] == "medium" 
                      ? warningColor 
                      : infoColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                  ),
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
                                "${task["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${task["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${task["priority"]} priority",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: priorityColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: impactColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${task["estimated_impact"]} impact",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: impactColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${task["status"].replaceAll('_', ' ')}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${task["estimated_hours"]}h",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Est. Time",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Progress Bar
                    if (task["status"] != "pending")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${task["completion_percentage"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (task["completion_percentage"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                        ],
                      ),

                    // Current vs Target State
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current State",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${task["current_state"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Target State",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${task["target_state"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Action Steps
                    Text(
                      "Action Steps:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(task["steps"] as List).take(3).map((step) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$step",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    if ((task["steps"] as List).length > 3)
                      Text(
                        "+ ${(task["steps"] as List).length - 3} more steps",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    SizedBox(height: spSm),

                    // Tools Needed
                    Text(
                      "Tools Required:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (task["tools_needed"] as List).map((tool) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$tool",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: task["status"] == "pending" 
                                ? "Start Task" 
                                : task["status"] == "in_progress" 
                                    ? "Update Progress" 
                                    : "View Details",
                            size: bs.sm,
                            onPressed: () {
                              _showTaskDetails(task);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            _showTaskOptions(task);
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
    );
  }

  void _showAddTaskDialog() {
    String taskTitle = "";
    String taskDescription = "";
    String selectedPriorityNew = "medium";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Optimization Task"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QTextField(
                  label: "Task Title",
                  value: taskTitle,
                  hint: "Enter optimization task title...",
                  onChanged: (value) {
                    taskTitle = value;
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Description",
                  value: taskDescription,
                  hint: "Describe the optimization task...",
                  onChanged: (value) {
                    taskDescription = value;
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  value: selectedPriorityNew,
                  onChanged: (value, label) {
                    selectedPriorityNew = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Add Task",
              size: bs.sm,
              onPressed: () {
                if (taskTitle.isNotEmpty && taskDescription.isNotEmpty) {
                  // Add new task
                  Navigator.pop(context);
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showTaskDetails(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${task["title"]}"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Page: ${task["page_url"]}"),
                SizedBox(height: spSm),
                Text("All Steps:"),
                SizedBox(height: spXs),
                ...(task["steps"] as List).map((step) {
                  return Text("• $step", style: TextStyle(fontSize: 12));
                }).toList(),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showTaskOptions(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Task Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Task"),
                onTap: () {
                  Navigator.pop(context);
                  // Edit task
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete Task"),
                onTap: () {
                  Navigator.pop(context);
                  // Delete task
                },
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text("Duplicate Task"),
                onTap: () {
                  Navigator.pop(context);
                  // Duplicate task
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
