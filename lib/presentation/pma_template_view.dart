import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTemplateView extends StatefulWidget {
  const PmaTemplateView({super.key});

  @override
  State<PmaTemplateView> createState() => _PmaTemplateViewState();
}

class _PmaTemplateViewState extends State<PmaTemplateView> {
  int currentTab = 0;
  String selectedCategory = "all";
  String searchQuery = "";
  String selectedTemplateType = "project";

  final List<Map<String, dynamic>> templateCategories = [
    {"label": "All Templates", "value": "all"},
    {"label": "Project Management", "value": "project"},
    {"label": "Task Management", "value": "task"},
    {"label": "Team Collaboration", "value": "team"},
    {"label": "Reporting", "value": "reporting"},
    {"label": "Workflow", "value": "workflow"},
    {"label": "Planning", "value": "planning"},
  ];

  final List<Map<String, dynamic>> projectTemplates = [
    {
      "name": "Software Development Project",
      "description": "Complete template for software development lifecycle with sprints, tasks, and milestones",
      "category": "project",
      "tags": ["software", "development", "agile", "scrum"],
      "tasks": 45,
      "milestones": 8,
      "duration": "12 weeks",
      "complexity": "Advanced",
      "rating": 4.8,
      "uses": 1247,
      "featured": true
    },
    {
      "name": "Marketing Campaign Launch",
      "description": "End-to-end marketing campaign template with planning, execution, and analysis phases",
      "category": "project",
      "tags": ["marketing", "campaign", "planning", "analytics"],
      "tasks": 32,
      "milestones": 6,
      "duration": "8 weeks",
      "complexity": "Intermediate",
      "rating": 4.6,
      "uses": 892,
      "featured": true
    },
    {
      "name": "Website Redesign",
      "description": "Comprehensive template for website redesign projects including UX/UI design and development",
      "category": "project",
      "tags": ["web", "design", "ux", "ui", "development"],
      "tasks": 38,
      "milestones": 7,
      "duration": "10 weeks",
      "complexity": "Advanced",
      "rating": 4.7,
      "uses": 634,
      "featured": false
    },
    {
      "name": "Product Launch",
      "description": "Template for launching new products with market research, development, and go-to-market strategy",
      "category": "project",
      "tags": ["product", "launch", "market", "strategy"],
      "tasks": 41,
      "milestones": 9,
      "duration": "16 weeks",
      "complexity": "Advanced",
      "rating": 4.9,
      "uses": 567,
      "featured": true
    },
    {
      "name": "Event Planning",
      "description": "Complete event planning template with vendor management, logistics, and execution",
      "category": "project",
      "tags": ["event", "planning", "logistics", "vendors"],
      "tasks": 28,
      "milestones": 5,
      "duration": "6 weeks",
      "complexity": "Beginner",
      "rating": 4.4,
      "uses": 423,
      "featured": false
    },
    {
      "name": "Content Creation Pipeline",
      "description": "Streamlined template for content creation workflow from ideation to publication",
      "category": "workflow",
      "tags": ["content", "creation", "workflow", "publishing"],
      "tasks": 22,
      "milestones": 4,
      "duration": "4 weeks",
      "complexity": "Beginner",
      "rating": 4.3,
      "uses": 789,
      "featured": false
    },
  ];

  final List<Map<String, dynamic>> taskTemplates = [
    {
      "name": "Bug Tracking Workflow",
      "description": "Standard workflow for tracking and resolving software bugs",
      "category": "task",
      "tags": ["bug", "tracking", "workflow", "software"],
      "steps": 8,
      "assignees": "Development Team",
      "complexity": "Intermediate",
      "rating": 4.5,
      "uses": 2341
    },
    {
      "name": "Code Review Process",
      "description": "Structured process for code reviews with quality gates and approval workflow",
      "category": "task", 
      "tags": ["code", "review", "quality", "approval"],
      "steps": 6,
      "assignees": "Senior Developers",
      "complexity": "Advanced",
      "rating": 4.7,
      "uses": 1876
    },
    {
      "name": "Client Onboarding",
      "description": "Step-by-step client onboarding process with documentation and setup tasks",
      "category": "task",
      "tags": ["client", "onboarding", "process", "documentation"],
      "steps": 12,
      "assignees": "Account Managers",
      "complexity": "Beginner",
      "rating": 4.6,
      "uses": 1523
    },
    {
      "name": "Weekly Sprint Planning",
      "description": "Agile sprint planning template with backlog grooming and estimation",
      "category": "planning",
      "tags": ["sprint", "planning", "agile", "estimation"],
      "steps": 10,
      "assignees": "Scrum Team",
      "complexity": "Intermediate", 
      "rating": 4.8,
      "uses": 2067
    },
  ];

  final List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Weekly Status Report",
      "description": "Standard weekly project status report with KPIs and progress metrics",
      "category": "reporting",
      "tags": ["weekly", "status", "report", "kpi"],
      "sections": 6,
      "frequency": "Weekly",
      "complexity": "Beginner",
      "rating": 4.4,
      "uses": 3421
    },
    {
      "name": "Project Performance Dashboard",
      "description": "Comprehensive dashboard template for project performance monitoring",
      "category": "reporting",
      "tags": ["dashboard", "performance", "monitoring", "metrics"],
      "sections": 8,
      "frequency": "Real-time",
      "complexity": "Advanced",
      "rating": 4.9,
      "uses": 1876
    },
    {
      "name": "Team Productivity Analysis",
      "description": "Template for analyzing team productivity with time tracking and efficiency metrics",
      "category": "reporting",
      "tags": ["team", "productivity", "analysis", "efficiency"],
      "sections": 7,
      "frequency": "Monthly",
      "complexity": "Intermediate",
      "rating": 4.6,
      "uses": 1234
    },
  ];

  final List<Map<String, dynamic>> myTemplates = [
    {
      "name": "Custom Sprint Template",
      "description": "My customized sprint template with specific workflows",
      "category": "project",
      "created": "2024-01-10",
      "lastUsed": "2024-01-15",
      "uses": 12,
      "status": "active"
    },
    {
      "name": "Client Review Process",
      "description": "Customized client review workflow for design projects",
      "category": "task",
      "created": "2024-01-05",
      "lastUsed": "2024-01-14",
      "uses": 8,
      "status": "active"
    },
    {
      "name": "Monthly Report Draft",
      "description": "Work in progress monthly report template",
      "category": "reporting",
      "created": "2024-01-12",
      "lastUsed": "2024-01-12",
      "uses": 0,
      "status": "draft"
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    List<Map<String, dynamic>> allTemplates = [
      ...projectTemplates,
      ...taskTemplates,
      ...reportTemplates,
    ];

    return allTemplates.where((template) {
      bool matchesCategory = selectedCategory == "all" || template["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          template["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          template["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Templates",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.explore)),
        Tab(text: "My Templates", icon: Icon(Icons.folder)),
        Tab(text: "Create", icon: Icon(Icons.add_circle_outline)),
        Tab(text: "Marketplace", icon: Icon(Icons.store)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildMyTemplatesTab(),
        _buildCreateTab(),
        _buildMarketplaceTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search templates...",
                        value: searchQuery,
                        hint: "Search by name, description, or tags",
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
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Category",
                  items: templateCategories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Featured Templates
          if (selectedCategory == "all") ...[
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
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Featured Templates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: projectTemplates
                        .where((template) => template["featured"] == true)
                        .map((template) => _buildFeaturedTemplateCard(template))
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
          ],

          // Template Grid
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
                Row(
                  children: [
                    Icon(Icons.grid_view, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "All Templates (${filteredTemplates.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.tune,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (filteredTemplates.isEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No templates found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your search or filter criteria",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  ResponsiveGridView(
                    padding: EdgeInsets.all(spSm),
                    minItemWidth: 200,
                    children: filteredTemplates.map((template) => _buildTemplateCard(template)).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedTemplateCard(Map<String, dynamic> template) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(10), warningColor.withAlpha(10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 12),
                    SizedBox(width: 2),
                    Text(
                      "FEATURED",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["complexity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${template["name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.task_alt, color: successColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${template["tasks"]} tasks",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.flag, color: infoColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${template["milestones"]} milestones",
                style: TextStyle(
                  fontSize: 11,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 14),
                  SizedBox(width: 2),
                  Text(
                    "${template["rating"]}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Text(
                "${template["uses"]} uses",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getCategoryColor(template["category"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["category"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: _getCategoryColor(template["category"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          if (template["category"] == "project") ...[
            Row(
              children: [
                Icon(Icons.task_alt, color: successColor, size: 12),
                SizedBox(width: spXs),
                Text(
                  "${template["tasks"]}",
                  style: TextStyle(fontSize: 10, color: successColor),
                ),
                SizedBox(width: spSm),
                Icon(Icons.flag, color: infoColor, size: 12),
                SizedBox(width: spXs),
                Text(
                  "${template["milestones"]}",
                  style: TextStyle(fontSize: 10, color: infoColor),
                ),
                SizedBox(width: spSm),
                Icon(Icons.schedule, color: warningColor, size: 12),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${template["duration"]}",
                    style: TextStyle(fontSize: 10, color: warningColor),
                  ),
                ),
              ],
            ),
          ] else if (template["category"] == "task") ...[
            Row(
              children: [
                Icon(Icons.list, color: primaryColor, size: 12),
                SizedBox(width: spXs),
                Text(
                  "${template["steps"]} steps",
                  style: TextStyle(fontSize: 10, color: primaryColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${template["assignees"]}",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ] else if (template["category"] == "reporting") ...[
            Row(
              children: [
                Icon(Icons.dashboard, color: infoColor, size: 12),
                SizedBox(width: spXs),
                Text(
                  "${template["sections"]} sections",
                  style: TextStyle(fontSize: 10, color: infoColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${template["frequency"]}",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 12),
                  SizedBox(width: 2),
                  Text(
                    "${template["rating"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Text(
                "${template["uses"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Use Template",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.all(spSm),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("My Templates", "${myTemplates.length}", Icons.folder, primaryColor),
              _buildSummaryCard("Active", "${myTemplates.where((t) => t["status"] == "active").length}", Icons.check_circle, successColor),
              _buildSummaryCard("Drafts", "${myTemplates.where((t) => t["status"] == "draft").length}", Icons.edit, warningColor),
              _buildSummaryCard("Total Uses", "${myTemplates.fold(0, (sum, t) => sum + (t["uses"] as int))}", Icons.play_arrow, infoColor),
            ],
          ),

          SizedBox(height: spMd),

          // My Templates List
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
                Row(
                  children: [
                    Icon(Icons.folder, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "My Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (myTemplates.isEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 60,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No templates created yet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Create your first template to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Create Template",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  ...myTemplates.map((template) => _buildMyTemplateItem(template)).toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTemplateItem(Map<String, dynamic> template) {
    Color statusColor = template["status"] == "active" ? successColor : warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["status"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Created: ${template["created"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Used: ${template["uses"]} times",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                Row(
                  children: [
                    Icon(Icons.add_circle_outline, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Create New Template",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.all(spSm),
                  minItemWidth: 200,
                  children: [
                    _buildCreateOption(
                      "Project Template",
                      "Create a complete project template with tasks, milestones, and workflows",
                      Icons.work,
                      primaryColor,
                    ),
                    _buildCreateOption(
                      "Task Template",
                      "Create reusable task templates for common workflows",
                      Icons.task_alt,
                      successColor,
                    ),
                    _buildCreateOption(
                      "Report Template",
                      "Create custom report templates for regular reporting",
                      Icons.description,
                      infoColor,
                    ),
                    _buildCreateOption(
                      "From Existing Project",
                      "Convert an existing project into a reusable template",
                      Icons.copy,
                      warningColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateOption(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        ss("Creating $title...");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketplaceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.store, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Template Marketplace",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.store_mall_directory,
                        size: 60,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Coming Soon",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Discover and purchase premium templates from the community",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Notify Me",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "project":
        return primaryColor;
      case "task":
        return successColor;
      case "reporting":
        return infoColor;
      case "workflow":
        return warningColor;
      case "team":
        return dangerColor;
      case "planning":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }
}
