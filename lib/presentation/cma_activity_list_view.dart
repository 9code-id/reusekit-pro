import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaActivityListView extends StatefulWidget {
  const CmaActivityListView({super.key});

  @override
  State<CmaActivityListView> createState() => _CmaActivityListViewState();
}

class _CmaActivityListViewState extends State<CmaActivityListView> {
  String selectedStatus = "All Status";
  String selectedType = "All Types";
  String selectedAssignee = "All Assignees";
  String selectedPriority = "All Priority";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];
  
  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Call", "value": "Call"},
    {"label": "Email", "value": "Email"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Demo", "value": "Demo"},
    {"label": "Follow-up", "value": "Follow-up"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Research", "value": "Research"},
  ];
  
  List<Map<String, dynamic>> assigneeItems = [
    {"label": "All Assignees", "value": "All Assignees"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Emily Davis", "value": "Emily Davis"},
  ];
  
  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All Priority"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];
  
  List<Map<String, dynamic>> activities = [
    {
      "id": "ACT-001",
      "type": "Call",
      "title": "Follow-up call with TechCorp",
      "description": "Discuss contract terms and pricing details for enterprise solution",
      "opportunity": "Enterprise Software Solution",
      "account": "TechCorp Inc.",
      "value": 250000,
      "assignedTo": "John Smith",
      "dueDate": "2024-01-21",
      "dueTime": "10:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-20",
      "createdBy": "John Smith",
      "estimatedDuration": 60,
      "actualDuration": null,
      "outcome": null,
      "notes": "Prepare pricing comparison sheet and ROI analysis",
      "tags": ["negotiation", "pricing"],
    },
    {
      "id": "ACT-002",
      "type": "Meeting",
      "title": "Product demo for Global Industries",
      "description": "Showcase digital transformation capabilities and integration features",
      "opportunity": "Digital Transformation Project",
      "account": "Global Industries",
      "value": 185000,
      "assignedTo": "Sarah Johnson",
      "dueDate": "2024-01-21",
      "dueTime": "2:00 PM",
      "priority": "Critical",
      "status": "Pending",
      "createdDate": "2024-01-19",
      "createdBy": "Sarah Johnson",
      "estimatedDuration": 90,
      "actualDuration": null,
      "outcome": null,
      "notes": "Include ROI calculator and case studies in presentation",
      "tags": ["demo", "integration"],
    },
    {
      "id": "ACT-003",
      "type": "Email",
      "title": "Send proposal to StartupXYZ",
      "description": "Cloud migration services proposal with detailed timeline",
      "opportunity": "Cloud Migration Services",
      "account": "StartupXYZ",
      "value": 75000,
      "assignedTo": "Mike Wilson",
      "dueDate": "2024-01-20",
      "dueTime": "5:00 PM",
      "priority": "Medium",
      "status": "Completed",
      "createdDate": "2024-01-18",
      "createdBy": "Mike Wilson",
      "estimatedDuration": 30,
      "actualDuration": 45,
      "outcome": "Sent comprehensive proposal with 3-phase implementation plan",
      "notes": "Client specifically requested phased approach",
      "tags": ["proposal", "cloud"],
    },
    {
      "id": "ACT-004",
      "type": "Follow-up",
      "title": "Security assessment review",
      "description": "Review security findings and recommendations with client team",
      "opportunity": "Security Audit Package",
      "account": "SecureBank Ltd",
      "value": 125000,
      "assignedTo": "Lisa Chen",
      "dueDate": "2024-01-22",
      "dueTime": "11:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-17",
      "createdBy": "Lisa Chen",
      "estimatedDuration": 45,
      "actualDuration": null,
      "outcome": null,
      "notes": "Prepare security compliance checklist and remediation plan",
      "tags": ["security", "review"],
    },
    {
      "id": "ACT-005",
      "type": "Call",
      "title": "Initial discovery call",
      "description": "Understand requirements for retail management solution",
      "opportunity": "Retail Management System",
      "account": "RetailChain Co",
      "value": 95000,
      "assignedTo": "David Brown",
      "dueDate": "2024-01-19",
      "dueTime": "3:00 PM",
      "priority": "Medium",
      "status": "Overdue",
      "createdDate": "2024-01-15",
      "createdBy": "David Brown",
      "estimatedDuration": 45,
      "actualDuration": null,
      "outcome": null,
      "notes": "Research their current POS system and integration needs",
      "tags": ["discovery", "retail"],
    },
    {
      "id": "ACT-006",
      "type": "Demo",
      "title": "Platform demonstration",
      "description": "Show integration capabilities and API features",
      "opportunity": "Platform Integration Project",
      "account": "Manufacturing Corp",
      "value": 165000,
      "assignedTo": "Emily Davis",
      "dueDate": "2024-01-23",
      "dueTime": "9:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-20",
      "createdBy": "Emily Davis",
      "estimatedDuration": 120,
      "actualDuration": null,
      "outcome": null,
      "notes": "Focus on real-time data synchronization features",
      "tags": ["demo", "integration", "api"],
    },
    {
      "id": "ACT-007",
      "type": "Research",
      "title": "Competitor analysis for HealthTech",
      "description": "Research competitor solutions and pricing for healthcare client",
      "opportunity": "Healthcare Management System",
      "account": "HealthTech Solutions",
      "value": 220000,
      "assignedTo": "John Smith",
      "dueDate": "2024-01-24",
      "dueTime": "4:00 PM",
      "priority": "Medium",
      "status": "In Progress",
      "createdDate": "2024-01-18",
      "createdBy": "Robert Davis",
      "estimatedDuration": 180,
      "actualDuration": null,
      "outcome": null,
      "notes": "Focus on HIPAA compliance and reporting features",
      "tags": ["research", "healthcare", "compliance"],
    },
    {
      "id": "ACT-008",
      "type": "Proposal",
      "title": "Draft contract proposal",
      "description": "Create detailed contract proposal with terms and conditions",
      "opportunity": "Financial Services Platform",
      "account": "InvestBank",
      "value": 450000,
      "assignedTo": "Sarah Johnson",
      "dueDate": "2024-01-25",
      "dueTime": "6:00 PM",
      "priority": "Critical",
      "status": "In Progress",
      "createdDate": "2024-01-19",
      "createdBy": "Robert Davis",
      "estimatedDuration": 240,
      "actualDuration": null,
      "outcome": null,
      "notes": "Include regulatory compliance requirements and SLA terms",
      "tags": ["proposal", "financial", "contract"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredActivities = _getFilteredActivities();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity List"),
        actions: [
          QButton(
            icon: Icons.filter_alt,
            size: bs.sm,
            onPressed: () => _showAdvancedFilters(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Quick Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search activities...",
                          value: searchQuery,
                          hint: "Search by title, account, or description",
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
                        onPressed: () => _performSearch(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Activity Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Activity Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Total",
                          "${filteredActivities.length}",
                          Icons.list,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Pending",
                          "${filteredActivities.where((a) => a["status"] == "Pending").length}",
                          Icons.pending,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Completed",
                          "${filteredActivities.where((a) => a["status"] == "Completed").length}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Overdue",
                          "${filteredActivities.where((a) => a["status"] == "Overdue").length}",
                          Icons.warning,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Activities List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Activities (${filteredActivities.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Add New",
                        size: bs.sm,
                        onPressed: () => _addNewActivity(),
                      ),
                    ],
                  ),
                  if (filteredActivities.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(Icons.event_busy, size: 64, color: disabledBoldColor),
                          SizedBox(height: spSm),
                          Text(
                            "No activities found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredActivities.map((activity) => _buildActivityCard(activity)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredActivities() {
    List<Map<String, dynamic>> filtered = List.from(activities);
    
    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((activity) {
        String searchLower = searchQuery.toLowerCase();
        return (activity["title"] as String).toLowerCase().contains(searchLower) ||
               (activity["account"] as String).toLowerCase().contains(searchLower) ||
               (activity["description"] as String).toLowerCase().contains(searchLower) ||
               (activity["opportunity"] as String).toLowerCase().contains(searchLower);
      }).toList();
    }
    
    // Status filter
    if (selectedStatus != "All Status") {
      filtered = filtered.where((activity) => activity["status"] == selectedStatus).toList();
    }
    
    // Type filter
    if (selectedType != "All Types") {
      filtered = filtered.where((activity) => activity["type"] == selectedType).toList();
    }
    
    // Assignee filter
    if (selectedAssignee != "All Assignees") {
      filtered = filtered.where((activity) => activity["assignedTo"] == selectedAssignee).toList();
    }
    
    // Priority filter
    if (selectedPriority != "All Priority") {
      filtered = filtered.where((activity) => activity["priority"] == selectedPriority).toList();
    }
    
    // Sort by due date and priority
    filtered.sort((a, b) {
      int priorityComparison = _getPriorityWeight(b["priority"] as String)
          .compareTo(_getPriorityWeight(a["priority"] as String));
      if (priorityComparison != 0) return priorityComparison;
      
      return DateTime.parse(a["dueDate"] as String)
          .compareTo(DateTime.parse(b["dueDate"] as String));
    });
    
    return filtered;
  }
  
  int _getPriorityWeight(String priority) {
    switch (priority) {
      case "Critical": return 4;
      case "High": return 3;
      case "Medium": return 2;
      case "Low": return 1;
      default: return 0;
    }
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color priorityColor = _getPriorityColor(activity["priority"] as String);
    Color statusColor = _getStatusColor(activity["status"] as String);
    Color typeColor = _getTypeColor(activity["type"] as String);
    bool isOverdue = DateTime.parse(activity["dueDate"] as String).isBefore(DateTime.now()) 
        && activity["status"] != "Completed";
    
    return GestureDetector(
      onTap: () => _viewActivityDetails(activity),
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isOverdue ? dangerColor : disabledOutlineBorderColor,
            width: isOverdue ? 2 : 1,
          ),
          boxShadow: [shadowXs],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            // Header with tags
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: typeColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["type"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["priority"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            
            // Title and ID
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${activity["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${activity["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontFamily: "monospace",
                  ),
                ),
              ],
            ),
            
            // Description
            Text(
              "${activity["description"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Account and Opportunity
            Row(
              children: [
                Icon(Icons.business, size: 12, color: disabledBoldColor),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "${activity["account"]} • ${activity["opportunity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "\$${((activity["value"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
            
            // Assignee and Due Date
            Row(
              children: [
                Icon(Icons.person, size: 12, color: disabledBoldColor),
                SizedBox(width: 4),
                Text(
                  "${activity["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.schedule,
                  size: 12,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                ),
                SizedBox(width: 4),
                Text(
                  "${activity["dueDate"]} ${activity["dueTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue ? dangerColor : disabledBoldColor,
                    fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
            
            // Duration and Tags
            Row(
              children: [
                Icon(Icons.timer, size: 12, color: disabledBoldColor),
                SizedBox(width: 4),
                Text(
                  "${activity["estimatedDuration"]} min",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                if (activity["actualDuration"] != null) ...[
                  Text(" (${activity["actualDuration"]} actual)", 
                       style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                ],
                Spacer(),
                if (activity["tags"] != null) ...[
                  ...(activity["tags"] as List<String>).take(2).map((tag) => 
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            
            // Outcome (if completed)
            if (activity["outcome"] != null && (activity["outcome"] as String).isNotEmpty)
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 12, color: successColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Outcome: ${activity["outcome"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
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
  
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "In Progress":
        return infoColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getTypeColor(String type) {
    switch (type) {
      case "Call":
        return Colors.blue;
      case "Email":
        return Colors.orange;
      case "Meeting":
        return Colors.purple;
      case "Demo":
        return Colors.green;
      case "Follow-up":
        return Colors.indigo;
      case "Proposal":
        return Colors.teal;
      case "Research":
        return Colors.brown;
      default:
        return disabledBoldColor;
    }
  }
  
  void _performSearch() {
    setState(() {});
    ss("Search performed for: $searchQuery");
  }
  
  void _showAdvancedFilters() {
    ss("Show advanced filter options");
  }
  
  void _addNewActivity() {
    ss("Navigate to add new activity");
  }
  
  void _viewActivityDetails(Map<String, dynamic> activity) {
    ss("View details for ${activity["title"]}");
  }
}
