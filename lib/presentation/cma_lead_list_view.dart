import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadListView extends StatefulWidget {
  const CmaLeadListView({super.key});

  @override
  State<CmaLeadListView> createState() => _CmaLeadListViewState();
}

class _CmaLeadListViewState extends State<CmaLeadListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSource = "All";
  String selectedPriority = "All";
  String sortBy = "created_date";
  bool ascending = false;
  bool showFilters = false;
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "new"},
    {"label": "Contacted", "value": "contacted"},
    {"label": "Qualified", "value": "qualified"},
    {"label": "Proposal", "value": "proposal"},
    {"label": "Negotiation", "value": "negotiation"},
    {"label": "Closed Won", "value": "closed_won"},
    {"label": "Closed Lost", "value": "closed_lost"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "All", "value": "All"},
    {"label": "Website", "value": "website"},
    {"label": "Social Media", "value": "social_media"},
    {"label": "Referral", "value": "referral"},
    {"label": "Email Campaign", "value": "email_campaign"},
    {"label": "Cold Call", "value": "cold_call"},
    {"label": "Trade Show", "value": "trade_show"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Created Date", "value": "created_date"},
    {"label": "Company Name", "value": "company_name"},
    {"label": "Lead Score", "value": "lead_score"},
    {"label": "Last Activity", "value": "last_activity"},
    {"label": "Value", "value": "estimated_value"},
  ];

  List<Map<String, dynamic>> leads = [
    {
      "id": 1,
      "company_name": "Tech Solutions Inc",
      "contact_name": "John Smith",
      "email": "john@techsolutions.com",
      "phone": "+1 555-0123",
      "status": "qualified",
      "priority": "high",
      "source": "website",
      "estimated_value": 45000.0,
      "lead_score": 85,
      "last_activity": "2024-01-15T10:30:00Z",
      "created_date": "2024-01-10T09:00:00Z",
      "description": "Interested in enterprise software solution",
      "tags": ["Enterprise", "Software", "High Value"],
      "assigned_to": "Sarah Johnson",
    },
    {
      "id": 2,
      "company_name": "Digital Marketing Pro",
      "contact_name": "Emily Davis",
      "email": "emily@digitalmarketingpro.com",
      "phone": "+1 555-0124",
      "status": "contacted",
      "priority": "medium",
      "source": "social_media",
      "estimated_value": 25000.0,
      "lead_score": 65,
      "last_activity": "2024-01-14T14:20:00Z",
      "created_date": "2024-01-12T11:15:00Z",
      "description": "Looking for CRM integration services",
      "tags": ["CRM", "Integration", "Marketing"],
      "assigned_to": "Mike Wilson",
    },
    {
      "id": 3,
      "company_name": "Global Manufacturing",
      "contact_name": "Robert Chen",
      "email": "robert@globalmanuf.com",
      "phone": "+1 555-0125",
      "status": "proposal",
      "priority": "high",
      "source": "referral",
      "estimated_value": 75000.0,
      "lead_score": 92,
      "last_activity": "2024-01-16T09:45:00Z",
      "created_date": "2024-01-08T08:30:00Z",
      "description": "Enterprise automation solution required",
      "tags": ["Enterprise", "Automation", "Manufacturing"],
      "assigned_to": "Sarah Johnson",
    },
    {
      "id": 4,
      "company_name": "StartUp Ventures",
      "contact_name": "Lisa Anderson",
      "email": "lisa@startupventures.com",
      "phone": "+1 555-0126",
      "status": "new",
      "priority": "low",
      "source": "email_campaign",
      "estimated_value": 15000.0,
      "lead_score": 45,
      "last_activity": "2024-01-13T16:10:00Z",
      "created_date": "2024-01-13T16:10:00Z",
      "description": "Basic CRM setup for startup",
      "tags": ["Startup", "Basic", "CRM"],
      "assigned_to": "Tom Brown",
    },
    {
      "id": 5,
      "company_name": "Healthcare Systems",
      "contact_name": "Dr. Michael Johnson",
      "email": "michael@healthcaresys.com",
      "phone": "+1 555-0127",
      "status": "negotiation",
      "priority": "high",
      "source": "cold_call",
      "estimated_value": 95000.0,
      "lead_score": 88,
      "last_activity": "2024-01-17T11:00:00Z",
      "created_date": "2024-01-05T10:00:00Z",
      "description": "Patient management system upgrade",
      "tags": ["Healthcare", "Enterprise", "Upgrade"],
      "assigned_to": "Sarah Johnson",
    },
  ];

  List<Map<String, dynamic>> get filteredLeads {
    return leads.where((lead) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${lead["company_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${lead["contact_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${lead["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || lead["status"] == selectedStatus;
      bool matchesSource = selectedSource == "All" || lead["source"] == selectedSource;
      bool matchesPriority = selectedPriority == "All" || lead["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesSource && matchesPriority;
    }).toList()..sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];
      
      if (sortBy == "estimated_value") {
        aValue = (aValue as num).toDouble();
        bValue = (bValue as num).toDouble();
      } else if (sortBy == "lead_score") {
        aValue = (aValue as int);
        bValue = (bValue as int);
      }
      
      int comparison = ascending ? 
        aValue.toString().compareTo(bValue.toString()) :
        bValue.toString().compareTo(aValue.toString());
      
      return comparison;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "new": return infoColor;
      case "contacted": return warningColor;
      case "qualified": return Colors.blue;
      case "proposal": return Colors.purple;
      case "negotiation": return Colors.orange;
      case "closed_won": return successColor;
      case "closed_lost": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high": return dangerColor;
      case "medium": return warningColor;
      case "low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead List"),
        actions: [
          IconButton(
            icon: Icon(showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add lead
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search leads...",
                        value: searchQuery,
                        hint: "Company, contact name, or email",
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
                
                if (showFilters) ...[
                  SizedBox(height: spMd),
                  // Filter Options
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
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
                          label: "Source",
                          items: sourceOptions,
                          value: selectedSource,
                          onChanged: (value, label) {
                            selectedSource = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      QSwitch(
                        items: [
                          {
                            "label": "Ascending Order",
                            "value": true,
                            "checked": ascending,
                          }
                        ],
                        value: [if (ascending) {"label": "Ascending Order", "value": true, "checked": true}],
                        onChanged: (values, ids) {
                          ascending = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      Spacer(),
                      QButton(
                        label: "Clear Filters",
                        size: bs.sm,
                        onPressed: () {
                          selectedStatus = "All";
                          selectedSource = "All";
                          selectedPriority = "All";
                          sortBy = "created_date";
                          ascending = false;
                          searchQuery = "";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          
          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey.withAlpha(50),
            child: Row(
              children: [
                Text(
                  "${filteredLeads.length} leads found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Total Value: \$${filteredLeads.fold(0.0, (sum, lead) => sum + (lead["estimated_value"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Lead List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredLeads.length,
              itemBuilder: (context, index) {
                final lead = filteredLeads[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor("${lead["status"]}"),
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navigate to lead detail
                    },
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${lead["company_name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${lead["contact_name"]}",
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
                                      color: _getStatusColor("${lead["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${lead["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${lead["status"]}"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${lead["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${lead["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: _getPriorityColor("${lead["priority"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Contact Info
                          Row(
                            children: [
                              Icon(Icons.email, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${lead["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Icon(Icons.phone, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${lead["phone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Description
                          Text(
                            "${lead["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Tags
                          if ((lead["tags"] as List).isNotEmpty)
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (lead["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          
                          SizedBox(height: spSm),
                          
                          // Bottom Row - Stats
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.attach_money, size: 12, color: successColor),
                                    Text(
                                      "\$${(lead["estimated_value"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 12, color: infoColor),
                                    Text(
                                      "${lead["lead_score"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Assigned to: ${lead["assigned_to"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to lead detail
                                },
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to edit lead
                                },
                              ),
                              Spacer(),
                              Text(
                                "Last activity: ${DateTime.parse("${lead["last_activity"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add lead
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
