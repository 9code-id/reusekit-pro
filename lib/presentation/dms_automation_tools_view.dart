import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAutomationToolsView extends StatefulWidget {
  const DmsAutomationToolsView({super.key});

  @override
  State<DmsAutomationToolsView> createState() => _DmsAutomationToolsViewState();
}

class _DmsAutomationToolsViewState extends State<DmsAutomationToolsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  final List<Map<String, dynamic>> automationTools = [
    {
      "id": "doc_approval",
      "name": "Document Approval Workflow",
      "description": "Automated document review and approval process",
      "category": "Workflow",
      "status": "Active",
      "icon": Icons.approval,
      "triggers": 45,
      "completionRate": 92.5,
      "lastRun": "2024-06-19 10:30",
      "color": successColor,
    },
    {
      "id": "email_automation",
      "name": "Email Distribution System",
      "description": "Automated email notifications for document updates",
      "category": "Communication",
      "status": "Active",
      "icon": Icons.email,
      "triggers": 128,
      "completionRate": 98.2,
      "lastRun": "2024-06-19 11:15",
      "color": primaryColor,
    },
    {
      "id": "data_backup",
      "name": "Automated Data Backup",
      "description": "Scheduled backup of critical documents and data",
      "category": "Security",
      "status": "Active",
      "icon": Icons.backup,
      "triggers": 24,
      "completionRate": 100.0,
      "lastRun": "2024-06-19 02:00",
      "color": infoColor,
    },
    {
      "id": "invoice_processing",
      "name": "Invoice Processing Bot",
      "description": "Automated invoice verification and processing",
      "category": "Finance",
      "status": "Paused",
      "icon": Icons.receipt,
      "triggers": 67,
      "completionRate": 85.3,
      "lastRun": "2024-06-18 16:45",
      "color": warningColor,
    },
    {
      "id": "compliance_check",
      "name": "Compliance Monitor",
      "description": "Automated compliance checking for documents",
      "category": "Security",
      "status": "Active",
      "icon": Icons.security,
      "triggers": 89,
      "completionRate": 94.7,
      "lastRun": "2024-06-19 09:20",
      "color": successColor,
    },
    {
      "id": "file_organization",
      "name": "Smart File Organizer",
      "description": "AI-powered document categorization and filing",
      "category": "Organization",
      "status": "Active",
      "icon": Icons.folder_special,
      "triggers": 156,
      "completionRate": 91.8,
      "lastRun": "2024-06-19 11:45",
      "color": primaryColor,
    },
  ];

  final List<String> categories = ["All", "Workflow", "Communication", "Security", "Finance", "Organization"];

  List<Map<String, dynamic>> get filteredTools {
    return automationTools.where((tool) {
      final matchesSearch = (tool["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                           (tool["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || tool["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automation Tools"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CreateAutomationToolView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('AutomationSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Active Tools",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${automationTools.where((tool) => tool["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Triggers",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${automationTools.fold(0, (sum, tool) => sum + (tool["triggers"] as int))}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search automation tools...",
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
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Category Pills
            QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Automation Tools List
            Text(
              "Automation Tools (${filteredTools.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredTools.map((tool) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                            tool["icon"] as IconData,
                            color: tool["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tool["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${tool["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: tool["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tool["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: tool["status"] == "Active" ? successColor : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Triggers: ${tool["triggers"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Success Rate: ${(tool["completionRate"] as double).toStringAsFixed(1)}%",
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
                                "Category: ${tool["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last Run: ${tool["lastRun"]}",
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
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: tool["status"] == "Active" ? "Pause" : "Start",
                            size: bs.sm,
                            onPressed: () {
                              _toggleToolStatus(tool["id"] as String);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('EditAutomationToolView', arguments: tool)
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('AutomationAnalyticsView', arguments: tool)
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

  void _showFilterDialog() {
    // Show filter options dialog
    si("Filter dialog would be shown here");
  }

  void _toggleToolStatus(String toolId) {
    final toolIndex = automationTools.indexWhere((tool) => tool["id"] == toolId);
    if (toolIndex != -1) {
      final currentStatus = automationTools[toolIndex]["status"];
      automationTools[toolIndex]["status"] = currentStatus == "Active" ? "Paused" : "Active";
      setState(() {});
      ss("Tool status updated successfully");
    }
  }
}
