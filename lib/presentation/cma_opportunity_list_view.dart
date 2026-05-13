import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOpportunityListView extends StatefulWidget {
  const CmaOpportunityListView({super.key});

  @override
  State<CmaOpportunityListView> createState() => _CmaOpportunityListViewState();
}

class _CmaOpportunityListViewState extends State<CmaOpportunityListView> {
  String selectedView = "Pipeline";
  String selectedFilter = "All";
  String sortBy = "Value";
  String searchQuery = "";
  bool isGridView = false;
  
  List<Map<String, dynamic>> viewItems = [
    {"label": "Pipeline", "value": "Pipeline"},
    {"label": "Active", "value": "Active"},
    {"label": "Won", "value": "Won"},
    {"label": "Lost", "value": "Lost"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];
  
  List<Map<String, dynamic>> filterItems = [
    {"label": "All", "value": "All"},
    {"label": "High Priority", "value": "High Priority"},
    {"label": "My Opportunities", "value": "My Opportunities"},
    {"label": "Closing Soon", "value": "Closing Soon"},
    {"label": "Stalled", "value": "Stalled"},
  ];
  
  List<Map<String, dynamic>> sortItems = [
    {"label": "Value (High to Low)", "value": "Value"},
    {"label": "Probability", "value": "Probability"},
    {"label": "Close Date", "value": "Close Date"},
    {"label": "Created Date", "value": "Created Date"},
    {"label": "Stage", "value": "Stage"},
  ];

  List<Map<String, dynamic>> opportunities = [
    {
      "id": "1",
      "name": "Enterprise CRM Implementation",
      "company": "Tech Solutions Inc",
      "contact": "John Smith",
      "email": "john.smith@techsolutions.com",
      "phone": "+1 (555) 123-4567",
      "stage": "Negotiation",
      "probability": 85,
      "value": 125000,
      "expectedCloseDate": "2024-02-15",
      "createdDate": "2023-12-01",
      "owner": "Sarah Mitchell",
      "lastActivity": "2024-01-16",
      "nextActivity": "Contract Review Meeting",
      "nextActivityDate": "2024-01-18",
      "daysInStage": 12,
      "source": "Website",
      "priority": "High",
      "tags": ["Enterprise", "CRM", "Implementation"],
      "activities": 15,
      "documents": 8,
      "avatar": "https://picsum.photos/50/50?random=1",
      "companyLogo": "https://picsum.photos/40/40?random=11",
    },
    {
      "id": "2",
      "name": "Marketing Automation Setup",
      "company": "Marketing Pro",
      "contact": "Sarah Johnson", 
      "email": "sarah.j@marketingpro.com",
      "phone": "+1 (555) 987-6543",
      "stage": "Proposal",
      "probability": 65,
      "value": 75000,
      "expectedCloseDate": "2024-02-28",
      "createdDate": "2023-12-15",
      "owner": "John Anderson",
      "lastActivity": "2024-01-15",
      "nextActivity": "Proposal Presentation",
      "nextActivityDate": "2024-01-19",
      "daysInStage": 8,
      "source": "Referral",
      "priority": "Medium",
      "tags": ["Marketing", "Automation", "Mid-Market"],
      "activities": 12,
      "documents": 5,
      "avatar": "https://picsum.photos/50/50?random=2",
      "companyLogo": "https://picsum.photos/40/40?random=12",
    },
    {
      "id": "3",
      "name": "Global ERP Integration",
      "company": "Innovation Startup",
      "contact": "Michael Chen",
      "email": "m.chen@innovationstartup.io",
      "phone": "+1 (555) 456-7890",
      "stage": "Qualification",
      "probability": 40,
      "value": 250000,
      "expectedCloseDate": "2024-03-30",
      "createdDate": "2023-11-20",
      "owner": "Michael Chen",
      "lastActivity": "2024-01-14",
      "nextActivity": "Technical Requirements Review",
      "nextActivityDate": "2024-01-20",
      "daysInStage": 15,
      "source": "Trade Show",
      "priority": "High",
      "tags": ["ERP", "Enterprise", "Integration"],
      "activities": 8,
      "documents": 12,
      "avatar": "https://picsum.photos/50/50?random=3",
      "companyLogo": "https://picsum.photos/40/40?random=13",
    },
    {
      "id": "4",
      "name": "Small Business Package",
      "company": "Local Business Co",
      "contact": "Emma Wilson",
      "email": "emma@localbiz.com",
      "phone": "+1 (555) 321-0987",
      "stage": "Prospecting",
      "probability": 25,
      "value": 15000,
      "expectedCloseDate": "2024-02-10",
      "createdDate": "2024-01-05",
      "owner": "Emily Davis",
      "lastActivity": "2024-01-13",
      "nextActivity": "Discovery Call",
      "nextActivityDate": "2024-01-17",
      "daysInStage": 5,
      "source": "Cold Call",
      "priority": "Low",
      "tags": ["SMB", "Basic Package"],
      "activities": 3,
      "documents": 2,
      "avatar": "https://picsum.photos/50/50?random=4",
      "companyLogo": "https://picsum.photos/40/40?random=14",
    },
    {
      "id": "5",
      "name": "Healthcare Platform Upgrade",
      "company": "MedTech Solutions",
      "contact": "Dr. Lisa Park",
      "email": "lisa.park@medtech.com",
      "phone": "+1 (555) 654-3210",
      "stage": "Closed Won",
      "probability": 100,
      "value": 180000,
      "expectedCloseDate": "2024-01-10",
      "createdDate": "2023-10-15",
      "owner": "Sarah Mitchell",
      "lastActivity": "2024-01-10",
      "nextActivity": "Implementation Kickoff",
      "nextActivityDate": "2024-01-22",
      "daysInStage": 0,
      "source": "Referral",
      "priority": "High",
      "tags": ["Healthcare", "Platform", "Upgrade"],
      "activities": 25,
      "documents": 15,
      "avatar": "https://picsum.photos/50/50?random=5",
      "companyLogo": "https://picsum.photos/40/40?random=15",
    },
    {
      "id": "6",
      "name": "E-commerce Integration",
      "company": "Online Retail Corp",
      "contact": "David Kim",
      "email": "david.kim@onlineretail.com",
      "phone": "+1 (555) 789-0123",
      "stage": "Closed Lost",
      "probability": 0,
      "value": 95000,
      "expectedCloseDate": "2024-01-05",
      "createdDate": "2023-11-01",
      "owner": "John Anderson",
      "lastActivity": "2024-01-05",
      "nextActivity": "None",
      "nextActivityDate": "",
      "daysInStage": 11,
      "source": "Social Media",
      "priority": "Medium",
      "tags": ["E-commerce", "Integration", "Retail"],
      "activities": 18,
      "documents": 7,
      "avatar": "https://picsum.photos/50/50?random=6",
      "companyLogo": "https://picsum.photos/40/40?random=16",
    },
  ];

  List<Map<String, dynamic>> get filteredOpportunities {
    List<Map<String, dynamic>> filtered = opportunities;
    
    // Filter by view
    switch (selectedView) {
      case "Pipeline":
        filtered = filtered.where((opp) => 
          opp["stage"] != "Closed Won" && opp["stage"] != "Closed Lost").toList();
        break;
      case "Active":
        filtered = filtered.where((opp) => 
          opp["stage"] != "Closed Won" && opp["stage"] != "Closed Lost").toList();
        break;
      case "Won":
        filtered = filtered.where((opp) => opp["stage"] == "Closed Won").toList();
        break;
      case "Lost":
        filtered = filtered.where((opp) => opp["stage"] == "Closed Lost").toList();
        break;
      case "This Quarter":
        // Filter by this quarter's close dates
        break;
    }
    
    // Additional filters
    if (selectedFilter == "High Priority") {
      filtered = filtered.where((opp) => opp["priority"] == "High").toList();
    } else if (selectedFilter == "Closing Soon") {
      // Filter opportunities closing within next 30 days
    } else if (selectedFilter == "Stalled") {
      filtered = filtered.where((opp) => (opp["daysInStage"] as int) > 30).toList();
    }
    
    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((opp) =>
        "${opp["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${opp["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${opp["contact"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort
    switch (sortBy) {
      case "Value":
        filtered.sort((a, b) => (b["value"] as int).compareTo(a["value"] as int));
        break;
      case "Probability":
        filtered.sort((a, b) => (b["probability"] as int).compareTo(a["probability"] as int));
        break;
      case "Close Date":
        filtered.sort((a, b) => a["expectedCloseDate"].compareTo(b["expectedCloseDate"]));
        break;
      case "Created Date":
        filtered.sort((a, b) => b["createdDate"].compareTo(a["createdDate"]));
        break;
    }
    
    return filtered;
  }

  Color _getStageColor(String stage) {
    switch (stage) {
      case "Prospecting":
        return infoColor;
      case "Qualification":
        return secondaryColor;
      case "Proposal":
        return warningColor;
      case "Negotiation":
        return primaryColor;
      case "Closed Won":
        return successColor;
      case "Closed Lost":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _viewOpportunity(Map<String, dynamic> opportunity) {
    //navigateTo('CmaOpportunityDetailView')
  }

  void _editOpportunity(Map<String, dynamic> opportunity) {
    //navigateTo('CmaEditOpportunityView')
  }

  void _addOpportunity() {
    //navigateTo('CmaAddOpportunityView')
  }

  void _bulkActions() {
    //navigateTo('CmaBulkActionsView')
  }

  void _exportData() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Opportunity data exported successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opportunity List"),
        actions: [
          QButton(
            icon: isGridView ? Icons.view_list : Icons.view_module,
            size: bs.sm,
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: _exportData,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _addOpportunity,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildControls(),
            _buildSearchAndSort(),
            _buildQuickStats(),
            isGridView ? _buildGridView() : _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.list_alt,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Opportunity Management",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Comprehensive view of your sales pipeline",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredOpportunities.length} Results",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "View",
            items: viewItems,
            value: selectedView,
            onChanged: (value, label) {
              selectedView = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Filter",
            items: filterItems,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          label: "Bulk Actions",
          size: bs.sm,
          onPressed: _bulkActions,
        ),
      ],
    );
  }

  Widget _buildSearchAndSort() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search opportunities...",
            value: searchQuery,
            hint: "Search by name, company, or contact",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Sort by",
            items: sortItems,
            value: sortBy,
            onChanged: (value, label) {
              sortBy = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    double totalValue = filteredOpportunities.fold(0.0, (sum, opp) => sum + (opp["value"] as int));
    double avgProbability = filteredOpportunities.isNotEmpty 
        ? filteredOpportunities.fold(0.0, (sum, opp) => sum + (opp["probability"] as int)) / filteredOpportunities.length
        : 0.0;
    int highPriority = filteredOpportunities.where((opp) => opp["priority"] == "High").length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Total Value",
            value: "\$${(totalValue / 1000).toStringAsFixed(0)}K",
            icon: Icons.attach_money,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Count",
            value: "${filteredOpportunities.length}",
            icon: Icons.format_list_numbered,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Avg Probability",
            value: "${avgProbability.toStringAsFixed(0)}%",
            icon: Icons.trending_up,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "High Priority",
            value: "$highPriority",
            icon: Icons.priority_high,
            color: dangerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 300,
      children: filteredOpportunities.map((opportunity) {
        return _buildOpportunityGridCard(opportunity);
      }).toList(),
    );
  }

  Widget _buildOpportunityGridCard(Map<String, dynamic> opportunity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            width: 4,
            color: _getStageColor(opportunity["stage"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${opportunity["companyLogo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${opportunity["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${opportunity["company"]}",
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
                  color: _getPriorityColor(opportunity["priority"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${opportunity["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(opportunity["priority"]),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((opportunity["value"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Value",
                      style: TextStyle(
                        fontSize: 10,
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
                      "${opportunity["probability"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Probability",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: _getStageColor(opportunity["stage"]).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${opportunity["stage"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getStageColor(opportunity["stage"]),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Close: ${opportunity["expectedCloseDate"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewOpportunity(opportunity),
                child: Icon(
                  Icons.visibility,
                  size: 16,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    if (filteredOpportunities.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No opportunities found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or search criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: List.generate(filteredOpportunities.length, (index) {
        final opportunity = filteredOpportunities[index];
        return _buildOpportunityListCard(opportunity);
      }),
    );
  }

  Widget _buildOpportunityListCard(Map<String, dynamic> opportunity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStageColor(opportunity["stage"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${opportunity["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${opportunity["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(opportunity["priority"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${opportunity["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(opportunity["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${opportunity["company"]} • ${opportunity["contact"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Owner: ${opportunity["owner"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.source,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${opportunity["source"]}",
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
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((opportunity["value"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Deal Value",
                      style: TextStyle(
                        fontSize: 10,
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
                      "${opportunity["probability"]}%",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Probability",
                      style: TextStyle(
                        fontSize: 10,
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
                      "${opportunity["activities"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Activities",
                      style: TextStyle(
                        fontSize: 10,
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
                      "${opportunity["daysInStage"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Days in Stage",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((opportunity["tags"] as List).isNotEmpty) ...[
            Divider(color: disabledOutlineBorderColor),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (opportunity["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStageColor(opportunity["stage"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${opportunity["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStageColor(opportunity["stage"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Next: ${opportunity["nextActivity"]} (${opportunity["nextActivityDate"]})",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () => _editOpportunity(opportunity),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewOpportunity(opportunity),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
