import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSkillBasedRoutingView extends StatefulWidget {
  const CrmSkillBasedRoutingView({super.key});

  @override
  State<CrmSkillBasedRoutingView> createState() => _CrmSkillBasedRoutingViewState();
}

class _CrmSkillBasedRoutingViewState extends State<CrmSkillBasedRoutingView> {
  String selectedSkillCategory = "All Categories";
  String selectedPriority = "All Priorities";
  String selectedStatus = "All Statuses";
  String searchQuery = "";
  
  List<Map<String, dynamic>> skillCategories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Customer Service", "value": "Customer Service"},
    {"label": "Billing", "value": "Billing"},
    {"label": "Account Management", "value": "Account Management"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "All Priorities", "value": "All Priorities"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "All Statuses"},
    {"label": "Active", "value": "Active"},
    {"label": "Queued", "value": "Queued"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> routingRules = [
    {
      "id": "rule_001",
      "name": "Premium Customer Support",
      "skill_category": "Customer Service",
      "priority": "Critical",
      "conditions": ["Premium customer", "Account value > \$10,000"],
      "agents": ["Sarah Johnson", "Michael Chen", "Emily Davis"],
      "success_rate": 98.5,
      "avg_response_time": "2 minutes",
      "status": "Active",
      "created_date": "2024-01-15",
    },
    {
      "id": "rule_002", 
      "name": "Technical Issue Escalation",
      "skill_category": "Technical Support",
      "priority": "High",
      "conditions": ["Technical complexity > 7", "Previous escalations"],
      "agents": ["David Wilson", "Lisa Zhang", "Robert Brown"],
      "success_rate": 94.2,
      "avg_response_time": "5 minutes",
      "status": "Active",
      "created_date": "2024-01-10",
    },
    {
      "id": "rule_003",
      "name": "New Customer Onboarding", 
      "skill_category": "Sales",
      "priority": "Medium",
      "conditions": ["New customer", "First interaction"],
      "agents": ["Jennifer Lopez", "Alex Thompson", "Maria Garcia"],
      "success_rate": 89.7,
      "avg_response_time": "8 minutes",
      "status": "Active",
      "created_date": "2024-01-08",
    },
    {
      "id": "rule_004",
      "name": "Billing Dispute Resolution",
      "skill_category": "Billing",
      "priority": "High",
      "conditions": ["Billing dispute", "Amount > \$500"],
      "agents": ["Chris Anderson", "Nicole White", "Kevin Lee"],
      "success_rate": 91.8,
      "avg_response_time": "4 minutes",
      "status": "Active",
      "created_date": "2024-01-05",
    },
    {
      "id": "rule_005",
      "name": "Account Manager Assignment",
      "skill_category": "Account Management",
      "priority": "Medium",
      "conditions": ["Enterprise customer", "Contract renewal period"],
      "agents": ["Amanda Taylor", "Jason Moore", "Rachel Green"],
      "success_rate": 96.3,
      "avg_response_time": "6 minutes",
      "status": "Queued",
      "created_date": "2024-01-03",
    },
    {
      "id": "rule_006",
      "name": "General Inquiry Routing",
      "skill_category": "Customer Service",
      "priority": "Low",
      "conditions": ["General inquiry", "No special requirements"],
      "agents": ["Tom Wilson", "Linda Johnson", "Mark Davis"],
      "success_rate": 87.4,
      "avg_response_time": "12 minutes",
      "status": "Active",
      "created_date": "2024-01-01",
    },
  ];

  List<Map<String, dynamic>> get filteredRules {
    return routingRules.where((rule) {
      bool matchesCategory = selectedSkillCategory == "All Categories" || 
                           rule["skill_category"] == selectedSkillCategory;
      bool matchesPriority = selectedPriority == "All Priorities" || 
                           rule["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All Statuses" || 
                         rule["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
                         rule["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                         rule["skill_category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesPriority && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Queued":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard(Map<String, dynamic> rule) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
                      "${rule["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${rule["skill_category"]}",
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
                  color: _getStatusColor("${rule["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${rule["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor("${rule["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.priority_high,
                      color: _getPriorityColor("${rule["priority"]}"),
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Priority: ${rule["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getPriorityColor("${rule["priority"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${rule["avg_response_time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Conditions:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...((rule["conditions"] as List).map((condition) => Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: disabledBoldColor,
                        size: 8,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$condition",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
              ],
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
                      "Assigned Agents",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(rule["agents"] as List).length} agents",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Success Rate",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(rule["success_rate"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Rule",
                  size: bs.sm,
                  onPressed: () {
                    ss("Editing routing rule: ${rule["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    ss("Viewing details for: ${rule["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skill-Based Routing"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Creating new routing rule");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Active Rules",
                  "${routingRules.where((r) => r["status"] == "Active").length}",
                  "Routing configurations",
                  Icons.rule,
                  primaryColor,
                ),
                _buildStatCard(
                  "Average Success Rate",
                  "${(routingRules.map((r) => r["success_rate"] as num).reduce((a, b) => a + b) / routingRules.length).toStringAsFixed(1)}%",
                  "Overall performance",
                  Icons.trending_up,
                  successColor,
                ),
                _buildStatCard(
                  "Skill Categories",
                  "${skillCategories.length - 1}",
                  "Available categories",
                  Icons.category,
                  infoColor,
                ),
                _buildStatCard(
                  "Avg Response Time",
                  "5.2 min",
                  "Across all rules",
                  Icons.schedule,
                  warningColor,
                ),
              ],
            ),

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
                    label: "Search Rules",
                    value: searchQuery,
                    hint: "Search by rule name or category...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: skillCategories,
                          value: selectedSkillCategory,
                          onChanged: (value, label) {
                            selectedSkillCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: priorityLevels,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
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
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Rule",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Creating new routing rule");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Bulk Edit",
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening bulk edit mode");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export Rules",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            ss("Exporting routing rules");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Analytics",
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening routing analytics");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Routing Rules List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Routing Rules",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredRules.length} rules",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...filteredRules.map((rule) => _buildRuleCard(rule)),
                if (filteredRules.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.rule_folder,
                          color: disabledBoldColor,
                          size: 48,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No routing rules found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your filters or create a new rule",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
