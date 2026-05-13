import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCorrespondenceView extends StatefulWidget {
  const LcaCorrespondenceView({super.key});

  @override
  State<LcaCorrespondenceView> createState() => _LcaCorrespondenceViewState();
}

class _LcaCorrespondenceViewState extends State<LcaCorrespondenceView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedPriority = "all";
  
  List<Map<String, dynamic>> correspondence = [
    {
      "id": "corr_001",
      "type": "letter",
      "title": "Demand Letter - Smith Contract Dispute",
      "recipient": "Johnson Legal Services",
      "sender": "Our Law Firm",
      "caseNumber": "LIT-2024-001",
      "clientName": "John Smith",
      "dateCreated": "2024-03-20T10:30:00Z",
      "dateSent": "2024-03-20T14:30:00Z",
      "status": "sent",
      "priority": "high",
      "category": "demand_letter",
      "content": "This letter serves as formal demand for resolution of the contract dispute between our client and your client...",
      "attachments": [
        {
          "name": "Contract_Original.pdf",
          "size": "2.4 MB",
          "type": "pdf"
        },
        {
          "name": "Breach_Evidence.pdf",
          "size": "1.8 MB",
          "type": "pdf"
        }
      ],
      "deliveryMethod": "certified_mail",
      "trackingNumber": "9405123456789012345678",
      "responseRequired": true,
      "responseDeadline": "2024-04-05T00:00:00Z",
      "responseReceived": false,
      "billableHours": 2.5
    },
    {
      "id": "corr_002",
      "type": "email",
      "title": "Discovery Request Response",
      "recipient": "opposing@counsel.com",
      "sender": "litigation@ourlaw.com",
      "caseNumber": "FAM-2024-003",
      "clientName": "Sarah Wilson",
      "dateCreated": "2024-03-19T16:45:00Z",
      "dateSent": "2024-03-19T17:00:00Z",
      "status": "sent",
      "priority": "medium",
      "category": "discovery",
      "content": "Please find attached our client's responses to your discovery requests dated March 15, 2024...",
      "attachments": [
        {
          "name": "Discovery_Responses.pdf",
          "size": "3.2 MB",
          "type": "pdf"
        }
      ],
      "deliveryMethod": "email",
      "trackingNumber": null,
      "responseRequired": false,
      "responseDeadline": null,
      "responseReceived": false,
      "billableHours": 1.5
    },
    {
      "id": "corr_003",
      "type": "notice",
      "title": "Court Filing Notice",
      "recipient": "Superior Court of California",
      "sender": "Our Law Firm",
      "caseNumber": "COR-2024-007",
      "clientName": "Michael Davis",
      "dateCreated": "2024-03-18T11:20:00Z",
      "dateSent": "2024-03-18T15:30:00Z",
      "status": "delivered",
      "priority": "high",
      "category": "court_filing",
      "content": "Motion for Summary Judgment in the matter of Davis v. Corporation Inc...",
      "attachments": [
        {
          "name": "Motion_Summary_Judgment.pdf",
          "size": "4.1 MB",
          "type": "pdf"
        },
        {
          "name": "Supporting_Brief.pdf",
          "size": "2.9 MB",
          "type": "pdf"
        }
      ],
      "deliveryMethod": "electronic_filing",
      "trackingNumber": "EF-2024-00123456",
      "responseRequired": true,
      "responseDeadline": "2024-04-18T00:00:00Z",
      "responseReceived": false,
      "billableHours": 4.0
    },
    {
      "id": "corr_004",
      "type": "response",
      "title": "Settlement Proposal Response",
      "recipient": "settlement@mediation.com",
      "sender": "Our Law Firm",
      "caseNumber": "PER-2024-012",
      "clientName": "Jennifer Brown",
      "dateCreated": "2024-03-17T14:20:00Z",
      "dateSent": null,
      "status": "draft",
      "priority": "medium",
      "category": "settlement",
      "content": "Our client has reviewed your settlement proposal dated March 10, 2024, and responds as follows...",
      "attachments": [],
      "deliveryMethod": "email",
      "trackingNumber": null,
      "responseRequired": false,
      "responseDeadline": null,
      "responseReceived": false,
      "billableHours": 1.0
    }
  ];

  List<Map<String, dynamic>> correspondenceTemplates = [
    {
      "id": "template_001",
      "name": "Demand Letter Template",
      "category": "demand_letter",
      "description": "Standard template for demand letters",
      "lastUsed": "2024-03-20T10:30:00Z",
      "usageCount": 15
    },
    {
      "id": "template_002",
      "name": "Discovery Request Template",
      "category": "discovery",
      "description": "Template for discovery requests",
      "lastUsed": "2024-03-18T14:20:00Z",
      "usageCount": 8
    },
    {
      "id": "template_003",
      "name": "Settlement Offer Template",
      "category": "settlement",
      "description": "Template for settlement offers",
      "lastUsed": "2024-03-15T09:45:00Z",
      "usageCount": 12
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Letters", "value": "letter"},
    {"label": "Emails", "value": "email"},
    {"label": "Notices", "value": "notice"},
    {"label": "Responses", "value": "response"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];

  List<Map<String, dynamic>> get filteredCorrespondence {
    return correspondence.where((corr) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${corr["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${corr["recipient"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${corr["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${corr["caseNumber"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" || corr["type"] == selectedFilter;
      bool matchesPriority = selectedPriority == "all" || corr["priority"] == selectedPriority;
      
      return matchesSearch && matchesFilter && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Correspondence",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Mail", icon: Icon(Icons.mail)),
        Tab(text: "Drafts", icon: Icon(Icons.drafts)),
        Tab(text: "Sent", icon: Icon(Icons.send)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildAllMailTab(),
        _buildDraftsTab(),
        _buildSentTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildAllMailTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          _buildSearchAndFilters(),
          
          SizedBox(height: spLg),
          
          // Quick Stats
          _buildQuickStats(),
          
          SizedBox(height: spLg),
          
          // Correspondence List
          _buildCorrespondenceList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
              Text(
                "Search & Filter",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Correspondence",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _showNewCorrespondenceDialog,
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Search Field
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search correspondence...",
                  value: searchQuery,
                  hint: "Title, recipient, client, case number",
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
                onPressed: () {
                  // Search functionality
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: filterOptions,
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
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    int totalCorrespondence = correspondence.length;
    int draftCount = correspondence.where((corr) => corr["status"] == "draft").length;
    int sentCount = correspondence.where((corr) => corr["status"] == "sent" || corr["status"] == "delivered").length;
    int awaitingResponse = correspondence.where((corr) => corr["responseRequired"] && !corr["responseReceived"]).length;
    
    return ResponsiveGridView(
      padding: EdgeInsets.all(0),
      minItemWidth: 200,
      children: [
        _buildStatCard(
          "Total Items",
          "$totalCorrespondence",
          Icons.mail,
          primaryColor,
        ),
        _buildStatCard(
          "Drafts",
          "$draftCount",
          Icons.drafts,
          warningColor,
        ),
        _buildStatCard(
          "Sent",
          "$sentCount",
          Icons.send,
          successColor,
        ),
        _buildStatCard(
          "Awaiting Response",
          "$awaitingResponse",
          Icons.schedule,
          dangerColor,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorrespondenceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Correspondence (${filteredCorrespondence.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        ...filteredCorrespondence.map((corr) => _buildCorrespondenceCard(corr)).toList(),
      ],
    );
  }

  Widget _buildCorrespondenceCard(Map<String, dynamic> corr) {
    Color priorityColor = corr["priority"] == "high" ? dangerColor :
                         corr["priority"] == "medium" ? warningColor : successColor;
    
    Color statusColor = corr["status"] == "sent" || corr["status"] == "delivered" ? successColor :
                       corr["status"] == "draft" ? warningColor : disabledBoldColor;
    
    IconData typeIcon = corr["type"] == "letter" ? Icons.mail :
                       corr["type"] == "email" ? Icons.email :
                       corr["type"] == "notice" ? Icons.announcement :
                       corr["type"] == "response" ? Icons.reply : Icons.description;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
          // Header Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  typeIcon,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              
              SizedBox(width: spMd),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${corr["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "To: ${corr["recipient"]}",
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
                      "${corr["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                      "${corr["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Case Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Case: ${corr["caseNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Client: ${corr["clientName"]}",
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
                        "Created: ${DateTime.parse("${corr["dateCreated"]}").dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (corr["dateSent"] != null)
                        Text(
                          "Sent: ${DateTime.parse("${corr["dateSent"]}").dMMMy}",
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
          
          SizedBox(height: spSm),
          
          // Content Preview
          Text(
            "${corr["content"]}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Attachments and Delivery Info
          Row(
            children: [
              if ((corr["attachments"] as List).isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 12,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(corr["attachments"] as List).length} attachments",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
              ],
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${corr["deliveryMethod"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              
              if (corr["responseRequired"]) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Response Required",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              Spacer(),
              
              Text(
                "Billable: ${(corr["billableHours"] as double).toStringAsFixed(1)}h",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
          
          if (corr["responseRequired"] && corr["responseDeadline"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Response deadline: ${DateTime.parse("${corr["responseDeadline"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              if (corr["status"] == "draft")
                QButton(
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editCorrespondence(corr),
                )
              else
                QButton(
                  label: "View",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _viewCorrespondence(corr),
                ),
              
              SizedBox(width: spSm),
              
              if (corr["status"] == "draft")
                QButton(
                  label: "Send",
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () => _sendCorrespondence(corr),
                )
              else if (corr["trackingNumber"] != null)
                QButton(
                  label: "Track",
                  icon: Icons.track_changes,
                  size: bs.sm,
                  onPressed: () => _trackCorrespondence(corr),
                ),
              
              Spacer(),
              
              GestureDetector(
                onTap: () => _showCorrespondenceOptions(corr),
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraftsTab() {
    final drafts = correspondence.where((corr) => corr["status"] == "draft").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Draft Correspondence",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          if (drafts.isEmpty)
            Center(
              child: Text(
                "No drafts available",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            )
          else
            ...drafts.map((draft) => _buildCorrespondenceCard(draft)).toList(),
        ],
      ),
    );
  }

  Widget _buildSentTab() {
    final sent = correspondence.where((corr) => corr["status"] == "sent" || corr["status"] == "delivered").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sent Correspondence",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          if (sent.isEmpty)
            Center(
              child: Text(
                "No sent correspondence",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            )
          else
            ...sent.map((item) => _buildCorrespondenceCard(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Correspondence Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Template",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _showNewTemplateDialog,
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          ...correspondenceTemplates.map((template) => _buildTemplateCard(template)).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.description,
              color: primaryColor,
              size: 24,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Used ${template["usageCount"]} times",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Last used: ${DateTime.parse("${template["lastUsed"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          QButton(
            label: "Use Template",
            icon: Icons.launch,
            size: bs.sm,
            onPressed: () => _useTemplate(template),
          ),
        ],
      ),
    );
  }

  void _showNewCorrespondenceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Correspondence"),
        content: Text("Create new correspondence functionality"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("New correspondence created");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showNewTemplateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Template"),
        content: Text("Create new template functionality"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("New template created");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _editCorrespondence(Map<String, dynamic> corr) {
    ss("Editing correspondence: ${corr["title"]}");
  }

  void _viewCorrespondence(Map<String, dynamic> corr) {
    ss("Viewing correspondence: ${corr["title"]}");
  }

  void _sendCorrespondence(Map<String, dynamic> corr) {
    corr["status"] = "sent";
    corr["dateSent"] = DateTime.now().toIso8601String();
    ss("Correspondence sent: ${corr["title"]}");
    setState(() {});
  }

  void _trackCorrespondence(Map<String, dynamic> corr) {
    ss("Tracking: ${corr["trackingNumber"]}");
  }

  void _useTemplate(Map<String, dynamic> template) {
    template["usageCount"] = (template["usageCount"] as int) + 1;
    template["lastUsed"] = DateTime.now().toIso8601String();
    ss("Using template: ${template["name"]}");
    setState(() {});
  }

  void _showCorrespondenceOptions(Map<String, dynamic> corr) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Correspondence Options",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.print),
              title: Text("Print"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
