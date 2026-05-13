import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLeadListView extends StatefulWidget {
  const CrmLeadListView({super.key});

  @override
  State<CrmLeadListView> createState() => _CrmLeadListViewState();
}

class _CrmLeadListViewState extends State<CrmLeadListView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedSource = "all";
  String selectedPriority = "all";
  String selectedAssignee = "all";
  String sortBy = "created_date";
  bool sortAscending = false;

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

  List<Map<String, dynamic>> assigneeOptions = [
    {"label": "All Assignees", "value": "all"},
    {"label": "John Sales", "value": "john_sales"},
    {"label": "Emma Sales", "value": "emma_sales"},
    {"label": "David Sales", "value": "david_sales"},
    {"label": "Sarah Manager", "value": "sarah_manager"},
    {"label": "Unassigned", "value": "unassigned"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Created Date", "value": "created_date"},
    {"label": "Last Contact", "value": "last_contact"},
    {"label": "Lead Value", "value": "value"},
    {"label": "Name", "value": "name"},
    {"label": "Company", "value": "company"},
    {"label": "Priority", "value": "priority"},
  ];

  List<Map<String, dynamic>> leads = [
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
      "notes": "Interested in enterprise package",
      "score": 85
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
      "notes": "Follow up next week",
      "score": 72
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
      "notes": "Ready for proposal",
      "score": 91
    },
    {
      "id": "LEAD-004",
      "name": "Robert Wilson",
      "company": "Enterprise Corp",
      "email": "r.wilson@enterprise.com",
      "phone": "+1 (555) 321-0987",
      "status": "proposal",
      "priority": "high",
      "source": "trade_show",
      "value": 7500.00,
      "createdDate": "2024-06-10",
      "lastContact": "2024-06-15",
      "assignedTo": "Sarah Manager",
      "notes": "Reviewing our proposal",
      "score": 88
    },
    {
      "id": "LEAD-005",
      "name": "Jennifer Davis",
      "company": "Startup Ventures",
      "email": "jen@startupventures.com",
      "phone": "+1 (555) 654-3210",
      "status": "negotiation",
      "priority": "medium",
      "source": "cold_call",
      "value": 2800.00,
      "createdDate": "2024-06-08",
      "lastContact": "2024-06-14",
      "assignedTo": "John Sales",
      "notes": "Price negotiations ongoing",
      "score": 75
    },
    {
      "id": "LEAD-006",
      "name": "Mark Thompson",
      "company": "Tech Solutions",
      "email": "mark@techsolutions.com",
      "phone": "+1 (555) 789-4561",
      "status": "won",
      "priority": "high",
      "source": "website",
      "value": 6200.00,
      "createdDate": "2024-06-05",
      "lastContact": "2024-06-13",
      "assignedTo": "Emma Sales",
      "notes": "Deal closed successfully",
      "score": 95
    },
    {
      "id": "LEAD-007",
      "name": "Amanda White",
      "company": "Creative Agency",
      "email": "amanda@creative.com",
      "phone": "+1 (555) 852-9630",
      "status": "lost",
      "priority": "low",
      "source": "advertisement",
      "value": 1500.00,
      "createdDate": "2024-06-03",
      "lastContact": "2024-06-12",
      "assignedTo": "David Sales",
      "notes": "Chose competitor",
      "score": 45
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Leads"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showAdvancedFilters(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addLead(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Quick Stats
                _buildQuickStats(),
                
                // Search and Quick Filters
                _buildSearchFilters(),
                
                // Sort Options
                _buildSortOptions(),
                
                // Leads List
                Expanded(
                  child: _buildLeadsList(),
                ),
              ],
            ),
    );
  }

  Widget _buildQuickStats() {
    Map<String, int> statusCounts = {
      "new": 0,
      "contacted": 0,
      "qualified": 0,
      "proposal": 0,
      "negotiation": 0,
      "won": 0,
      "lost": 0
    };
    
    for (var lead in leads) {
      statusCounts[lead["status"]] = (statusCounts[lead["status"]] ?? 0) + 1;
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              _buildQuickStatItem("Total", "${leads.length}", primaryColor),
              _buildQuickStatItem("New", "${statusCounts["new"]}", infoColor),
              _buildQuickStatItem("Qualified", "${statusCounts["qualified"]}", successColor),
              _buildQuickStatItem("Won", "${statusCounts["won"]}", Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatItem(String label, String value, Color color) {
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
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
            hint: "Search by name, company, email, or phone",
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

  Widget _buildSortOptions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            "Sort by:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                _sortLeads();
              },
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              sortAscending = !sortAscending;
              _sortLeads();
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: primaryColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsList() {
    List<Map<String, dynamic>> filteredLeads = _getFilteredLeads();
    
    if (filteredLeads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No leads found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
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
      );
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Leads",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredLeads.length} of ${leads.length} leads",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...filteredLeads.map((lead) => _buildLeadItem(lead)),
        ],
      ),
    );
  }

  Widget _buildLeadItem(Map<String, dynamic> lead) {
    Color statusColor = _getStatusColor(lead["status"]);
    Color priorityColor = _getPriorityColor(lead["priority"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
                    Row(
                      children: [
                        Text(
                          "${lead["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getScoreColor(lead["score"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Score: ${lead["score"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getScoreColor(lead["score"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${lead["company"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
          
          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${lead["email"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _sendEmail(lead["id"]),
                      child: Icon(Icons.send, size: 16, color: primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${lead["phone"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _makeCall(lead["id"]),
                      child: Icon(Icons.call, size: 16, color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Lead Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Value: \$${(lead["value"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Source: ${_getSourceDisplayName(lead["source"])}",
                      style: TextStyle(
                        fontSize: 11,
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
                      "Assigned to: ${lead["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Created: ${DateTime.parse(lead["createdDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (lead["notes"] != null && lead["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 14, color: infoColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${lead["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
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
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editLead(lead["id"]),
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

  List<Map<String, dynamic>> _getFilteredLeads() {
    List<Map<String, dynamic>> filtered = List.from(leads);
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((lead) {
        String searchLower = searchQuery.toLowerCase();
        return lead["name"].toLowerCase().contains(searchLower) ||
               lead["company"].toLowerCase().contains(searchLower) ||
               lead["email"].toLowerCase().contains(searchLower) ||
               lead["phone"].toLowerCase().contains(searchLower);
      }).toList();
    }
    
    // Filter by status
    if (selectedStatus != "all") {
      filtered = filtered.where((lead) => lead["status"] == selectedStatus).toList();
    }
    
    // Filter by priority
    if (selectedPriority != "all") {
      filtered = filtered.where((lead) => lead["priority"] == selectedPriority).toList();
    }
    
    // Filter by assignee
    if (selectedAssignee != "all") {
      if (selectedAssignee == "unassigned") {
        filtered = filtered.where((lead) => lead["assignedTo"] == null || lead["assignedTo"].isEmpty).toList();
      } else {
        String assigneeName = _getAssigneeDisplayName(selectedAssignee);
        filtered = filtered.where((lead) => lead["assignedTo"] == assigneeName).toList();
      }
    }
    
    return filtered;
  }

  void _sortLeads() {
    List<Map<String, dynamic>> filtered = _getFilteredLeads();
    
    filtered.sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];
      
      int comparison = 0;
      
      if (aValue is String && bValue is String) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is num && bValue is num) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is DateTime && bValue is DateTime) {
        comparison = aValue.compareTo(bValue);
      } else {
        comparison = aValue.toString().compareTo(bValue.toString());
      }
      
      return sortAscending ? comparison : -comparison;
    });
    
    setState(() {});
  }

  String _getSourceDisplayName(String source) {
    switch (source) {
      case "website":
        return "Website";
      case "social_media":
        return "Social Media";
      case "referral":
        return "Referral";
      case "cold_call":
        return "Cold Call";
      case "trade_show":
        return "Trade Show";
      case "advertisement":
        return "Advertisement";
      default:
        return source;
    }
  }

  String _getAssigneeDisplayName(String assigneeValue) {
    switch (assigneeValue) {
      case "john_sales":
        return "John Sales";
      case "emma_sales":
        return "Emma Sales";
      case "david_sales":
        return "David Sales";
      case "sarah_manager":
        return "Sarah Manager";
      default:
        return assigneeValue;
    }
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

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  void _filterLeads() {
    setState(() {});
  }

  void _showAdvancedFilters() {
    si("Show advanced filter options");
  }

  void _addLead() {
    si("Add new lead");
  }

  void _viewLeadDetails(String leadId) {
    si("View lead details: $leadId");
  }

  void _editLead(String leadId) {
    si("Edit lead: $leadId");
  }

  void _convertLead(String leadId) {
    si("Convert lead to customer: $leadId");
  }

  void _sendEmail(String leadId) {
    ss("Email sent to lead: $leadId");
  }

  void _makeCall(String leadId) {
    si("Calling lead: $leadId");
  }
}
