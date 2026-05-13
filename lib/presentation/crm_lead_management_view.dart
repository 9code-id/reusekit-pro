import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLeadManagementView extends StatefulWidget {
  const CrmLeadManagementView({super.key});

  @override
  State<CrmLeadManagementView> createState() => _CrmLeadManagementViewState();
}

class _CrmLeadManagementViewState extends State<CrmLeadManagementView> {
  int selectedTab = 0;
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedSource = "all";
  String selectedPriority = "all";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "New", "value": "new"},
    {"label": "Contacted", "value": "contacted"},
    {"label": "Qualified", "value": "qualified"},
    {"label": "Proposal", "value": "proposal"},
    {"label": "Negotiation", "value": "negotiation"},
    {"label": "Won", "value": "won"},
    {"label": "Lost", "value": "lost"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "All Sources", "value": "all"},
    {"label": "Website", "value": "website"},
    {"label": "Social Media", "value": "social_media"},
    {"label": "Referral", "value": "referral"},
    {"label": "Cold Call", "value": "cold_call"},
    {"label": "Trade Show", "value": "trade_show"},
    {"label": "Advertisement", "value": "advertisement"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  Map<String, dynamic> pipelineStats = {
    "totalLeads": 245,
    "newLeads": 48,
    "qualifiedLeads": 67,
    "proposalStage": 23,
    "wonThisMonth": 15,
    "conversionRate": 6.1,
    "avgDealSize": 3250.00,
    "pipelineValue": 487500.00
  };

  List<Map<String, dynamic>> pipelineStages = [
    {
      "name": "New",
      "count": 48,
      "value": 120000.00,
      "color": Colors.blue,
      "percentage": 19.6
    },
    {
      "name": "Contacted",
      "count": 35,
      "value": 87500.00,
      "color": Colors.orange,
      "percentage": 14.3
    },
    {
      "name": "Qualified",
      "count": 67,
      "value": 167500.00,
      "color": Colors.green,
      "percentage": 27.3
    },
    {
      "name": "Proposal",
      "count": 23,
      "value": 74750.00,
      "color": Colors.purple,
      "percentage": 9.4
    },
    {
      "name": "Negotiation",
      "count": 18,
      "value": 45000.00,
      "color": Colors.red,
      "percentage": 7.3
    },
    {
      "name": "Won",
      "count": 15,
      "value": 48750.00,
      "color": Colors.teal,
      "percentage": 6.1
    }
  ];

  List<Map<String, dynamic>> recentLeads = [
    {
      "id": "LEAD-001",
      "name": "Sarah Johnson",
      "company": "Tech Innovations Inc",
      "email": "sarah.j@techinnovations.com",
      "phone": "+1 (555) 123-4567",
      "status": "new",
      "priority": "high",
      "source": "website",
      "value": 5000.00,
      "createdDate": "2024-06-18",
      "lastContact": "2024-06-18",
      "assignedTo": "John Sales",
      "notes": "Interested in enterprise package"
    },
    {
      "id": "LEAD-002",
      "name": "Michael Chen",
      "company": "Digital Solutions LLC",
      "email": "m.chen@digitalsol.com",
      "phone": "+1 (555) 987-6543",
      "status": "contacted",
      "priority": "medium",
      "source": "referral",
      "value": 3200.00,
      "createdDate": "2024-06-15",
      "lastContact": "2024-06-16",
      "assignedTo": "Emma Sales",
      "notes": "Follow up next week"
    },
    {
      "id": "LEAD-003",
      "name": "Lisa Rodriguez",
      "company": "Marketing Pro Agency",
      "email": "lisa@marketingpro.com",
      "phone": "+1 (555) 456-7890",
      "status": "qualified",
      "priority": "high",
      "source": "social_media",
      "value": 4500.00,
      "createdDate": "2024-06-12",
      "lastContact": "2024-06-17",
      "assignedTo": "David Sales",
      "notes": "Ready for proposal"
    }
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "id": "TASK-001",
      "leadId": "LEAD-001",
      "leadName": "Sarah Johnson",
      "task": "Send product demo",
      "dueDate": "2024-06-19",
      "priority": "high",
      "assignedTo": "John Sales"
    },
    {
      "id": "TASK-002",
      "leadId": "LEAD-003",
      "leadName": "Lisa Rodriguez",
      "task": "Prepare proposal",
      "dueDate": "2024-06-20",
      "priority": "high",
      "assignedTo": "David Sales"
    },
    {
      "id": "TASK-003",
      "leadId": "LEAD-002",
      "leadName": "Michael Chen",
      "task": "Follow up call",
      "dueDate": "2024-06-21",
      "priority": "medium",
      "assignedTo": "Emma Sales"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addLead(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewAnalytics(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Pipeline Overview
                _buildPipelineOverview(),
                
                // Tab Navigation
                _buildTabNavigation(),
                
                // Tab Content
                Expanded(
                  child: _buildTabContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildPipelineOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Row
          Row(
            children: [
              _buildStatCard("Total Leads", "${pipelineStats["totalLeads"]}", primaryColor, Icons.people),
              SizedBox(width: spSm),
              _buildStatCard("Pipeline Value", "\$${((pipelineStats["pipelineValue"] as double) / 1000).toStringAsFixed(0)}K", successColor, Icons.attach_money),
              SizedBox(width: spSm),
              _buildStatCard("Conversion", "${(pipelineStats["conversionRate"] as double).toStringAsFixed(1)}%", infoColor, Icons.trending_up),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Pipeline Stages
          Text(
            "Sales Pipeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: pipelineStages.map((stage) => _buildPipelineStage(stage)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineStage(Map<String, dynamic> stage) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (stage["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${stage["count"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: stage["color"] as Color,
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${stage["name"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${((stage["value"] as double) / 1000).toStringAsFixed(0)}K",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _buildTabButton("All Leads", 0),
          _buildTabButton("Tasks", 1),
          _buildTabButton("Reports", 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildLeadsTab();
      case 1:
        return _buildTasksTab();
      case 2:
        return _buildReportsTab();
      default:
        return _buildLeadsTab();
    }
  }

  Widget _buildLeadsTab() {
    return Column(
      children: [
        // Search and Filters
        _buildSearchFilters(),
        
        // Leads List
        Expanded(
          child: _buildLeadsList(),
        ),
      ],
    );
  }

  Widget _buildSearchFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search leads",
            value: searchQuery,
            hint: "Search by name, company, or email",
            onChanged: (value) {
              searchQuery = value;
              _filterLeads();
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    _filterLeads();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Source",
                  items: sourceOptions,
                  value: selectedSource,
                  onChanged: (value, label) {
                    selectedSource = value;
                    _filterLeads();
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
                    _filterLeads();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Leads",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${recentLeads.length} leads",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...recentLeads.map((lead) => _buildLeadItem(lead)),
        ],
      ),
    );
  }

  Widget _buildLeadItem(Map<String, dynamic> lead) {
    Color statusColor = _getStatusColor(lead["status"]);
    Color priorityColor = _getPriorityColor(lead["priority"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lead Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${lead["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${lead["company"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${lead["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${lead["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Lead Details
          Row(
            children: [
              Icon(Icons.email, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${lead["email"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(lead["value"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Assigned to: ${lead["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Created: ${DateTime.parse(lead["createdDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          
          if (lead["notes"] != null && lead["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${lead["notes"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewLeadDetails(lead["id"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Contact",
                  size: bs.sm,
                  onPressed: () => _contactLead(lead["id"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Convert",
                  size: bs.sm,
                  onPressed: () => _convertLead(lead["id"]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Upcoming Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Task",
                size: bs.sm,
                onPressed: () => _addTask(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...upcomingTasks.map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.task,
              color: priorityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task["task"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Lead: ${task["leadName"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Assigned to: ${task["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Lead Reports & Analytics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Key Metrics
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
                  "Key Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildMetricCard("Conversion Rate", "${(pipelineStats["conversionRate"] as double).toStringAsFixed(1)}%", successColor),
                    _buildMetricCard("Avg Deal Size", "\$${(pipelineStats["avgDealSize"] as double).currency}", primaryColor),
                  ],
                ),
              ],
            ),
          ),
          
          // Performance Summary
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Detailed Reports",
              size: bs.md,
              onPressed: () => _viewDetailedReports(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "new":
        return infoColor;
      case "contacted":
        return warningColor;
      case "qualified":
        return primaryColor;
      case "proposal":
        return Colors.purple;
      case "negotiation":
        return Colors.orange;
      case "won":
        return successColor;
      case "lost":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _filterLeads() {
    setState(() {});
  }

  void _addLead() {
    si("Add new lead");
  }

  void _viewAnalytics() {
    si("View lead analytics");
  }

  void _viewLeadDetails(String leadId) {
    si("View lead details: $leadId");
  }

  void _contactLead(String leadId) {
    si("Contact lead: $leadId");
  }

  void _convertLead(String leadId) {
    si("Convert lead to customer: $leadId");
  }

  void _addTask() {
    si("Add new task");
  }

  void _viewDetailedReports() {
    si("View detailed lead reports");
  }
}
