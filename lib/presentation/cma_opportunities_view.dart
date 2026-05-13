import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOpportunitiesView extends StatefulWidget {
  const CmaOpportunitiesView({super.key});

  @override
  State<CmaOpportunitiesView> createState() => _CmaOpportunitiesViewState();
}

class _CmaOpportunitiesViewState extends State<CmaOpportunitiesView> {
  String selectedStage = "All";
  String selectedProbability = "All";
  String selectedOwner = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> stageItems = [
    {"label": "All", "value": "All"},
    {"label": "Prospecting", "value": "Prospecting"},
    {"label": "Qualification", "value": "Qualification"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
    {"label": "Closed Won", "value": "Closed Won"},
    {"label": "Closed Lost", "value": "Closed Lost"},
  ];
  
  List<Map<String, dynamic>> probabilityItems = [
    {"label": "All", "value": "All"},
    {"label": "High (80-100%)", "value": "High"},
    {"label": "Medium (50-79%)", "value": "Medium"},
    {"label": "Low (0-49%)", "value": "Low"},
  ];
  
  List<Map<String, dynamic>> ownerItems = [
    {"label": "All", "value": "All"},
    {"label": "John Anderson", "value": "John Anderson"},
    {"label": "Sarah Mitchell", "value": "Sarah Mitchell"},
    {"label": "Michael Chen", "value": "Michael Chen"},
    {"label": "Emily Davis", "value": "Emily Davis"},
  ];

  List<Map<String, dynamic>> opportunities = [
    {
      "id": "1",
      "name": "Enterprise CRM Implementation",
      "company": "Tech Solutions Inc",
      "contact": "John Smith",
      "email": "john.smith@techsolutions.com",
      "stage": "Negotiation",
      "probability": 85,
      "value": 125000,
      "expectedCloseDate": "2024-02-15",
      "owner": "Sarah Mitchell",
      "lastActivity": "2024-01-16",
      "nextActivity": "Contract Review Meeting",
      "nextActivityDate": "2024-01-18",
      "daysInStage": 12,
      "source": "Website",
      "products": ["CRM Enterprise", "Support Package"],
      "notes": "Ready to sign pending legal review",
      "avatar": "https://picsum.photos/50/50?random=1",
      "priority": "High",
    },
    {
      "id": "2",
      "name": "Marketing Automation Setup",
      "company": "Marketing Pro",
      "contact": "Sarah Johnson",
      "email": "sarah.j@marketingpro.com",
      "stage": "Proposal",
      "probability": 65,
      "value": 75000,
      "expectedCloseDate": "2024-02-28",
      "owner": "John Anderson",
      "lastActivity": "2024-01-15",
      "nextActivity": "Proposal Presentation",
      "nextActivityDate": "2024-01-19",
      "daysInStage": 8,
      "source": "Referral",
      "products": ["Marketing Automation", "Analytics"],
      "notes": "Waiting for budget approval",
      "avatar": "https://picsum.photos/50/50?random=2",
      "priority": "Medium",
    },
    {
      "id": "3",
      "name": "Global ERP Integration",
      "company": "Innovation Startup",
      "contact": "Michael Chen",
      "email": "m.chen@innovationstartup.io",
      "stage": "Qualification",
      "probability": 40,
      "value": 250000,
      "expectedCloseDate": "2024-03-30",
      "owner": "Michael Chen",
      "lastActivity": "2024-01-14",
      "nextActivity": "Technical Requirements Review",
      "nextActivityDate": "2024-01-20",
      "daysInStage": 15,
      "source": "Trade Show",
      "products": ["ERP Enterprise", "Integration Services"],
      "notes": "Large deal, needs executive buy-in",
      "avatar": "https://picsum.photos/50/50?random=3",
      "priority": "High",
    },
    {
      "id": "4",
      "name": "Small Business Package",
      "company": "Local Business Co",
      "contact": "Emma Wilson",
      "email": "emma@localbiz.com",
      "stage": "Prospecting",
      "probability": 25,
      "value": 15000,
      "expectedCloseDate": "2024-02-10",
      "owner": "Emily Davis",
      "lastActivity": "2024-01-13",
      "nextActivity": "Discovery Call",
      "nextActivityDate": "2024-01-17",
      "daysInStage": 5,
      "source": "Cold Call",
      "products": ["Basic Package"],
      "notes": "Price sensitive customer",
      "avatar": "https://picsum.photos/50/50?random=4",
      "priority": "Low",
    },
    {
      "id": "5",
      "name": "Healthcare Platform Upgrade",
      "company": "MedTech Solutions",
      "contact": "Dr. Lisa Park",
      "email": "lisa.park@medtech.com",
      "stage": "Closed Won",
      "probability": 100,
      "value": 180000,
      "expectedCloseDate": "2024-01-10",
      "owner": "Sarah Mitchell",
      "lastActivity": "2024-01-10",
      "nextActivity": "Implementation Kickoff",
      "nextActivityDate": "2024-01-22",
      "daysInStage": 0,
      "source": "Referral",
      "products": ["Healthcare Platform", "Training"],
      "notes": "Contract signed, implementation starting",
      "avatar": "https://picsum.photos/50/50?random=5",
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> get filteredOpportunities {
    List<Map<String, dynamic>> filtered = opportunities;
    
    if (selectedStage != "All") {
      filtered = filtered.where((opp) => opp["stage"] == selectedStage).toList();
    }
    
    if (selectedProbability != "All") {
      filtered = filtered.where((opp) {
        int probability = opp["probability"];
        switch (selectedProbability) {
          case "High":
            return probability >= 80;
          case "Medium":
            return probability >= 50 && probability < 80;
          case "Low":
            return probability < 50;
          default:
            return true;
        }
      }).toList();
    }
    
    if (selectedOwner != "All") {
      filtered = filtered.where((opp) => opp["owner"] == selectedOwner).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((opp) =>
        "${opp["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${opp["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${opp["contact"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  double get totalPipelineValue {
    return filteredOpportunities
        .where((opp) => opp["stage"] != "Closed Lost")
        .fold(0.0, (sum, opp) => sum + (opp["value"] as int));
  }

  double get weightedPipelineValue {
    return filteredOpportunities
        .where((opp) => opp["stage"] != "Closed Lost" && opp["stage"] != "Closed Won")
        .fold(0.0, (sum, opp) => 
            sum + ((opp["value"] as int) * (opp["probability"] as int) / 100));
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

  Color _getProbabilityColor(int probability) {
    if (probability >= 80) return successColor;
    if (probability >= 50) return warningColor;
    return dangerColor;
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

  void _addOpportunity() {
    //navigateTo('CmaAddOpportunityView')
  }

  void _viewOpportunity(Map<String, dynamic> opportunity) {
    //navigateTo('CmaOpportunityDetailView')
  }

  void _editOpportunity(Map<String, dynamic> opportunity) {
    //navigateTo('CmaEditOpportunityView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opportunities"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _addOpportunity,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              //navigateTo('CmaPipelineAnalyticsView')
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
            _buildHeader(),
            _buildPipelineStats(),
            _buildFilters(),
            _buildSearchBar(),
            _buildStageOverview(),
            _buildOpportunitiesList(),
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
          colors: [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sales Opportunities",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Track and manage your sales pipeline",
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
              "${filteredOpportunities.length} Active",
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

  Widget _buildPipelineStats() {
    int activeOpportunities = filteredOpportunities
        .where((opp) => opp["stage"] != "Closed Won" && opp["stage"] != "Closed Lost")
        .length;
    int wonOpportunities = filteredOpportunities
        .where((opp) => opp["stage"] == "Closed Won")
        .length;
    double avgDealSize = filteredOpportunities.isNotEmpty
        ? filteredOpportunities.fold(0.0, (sum, opp) => sum + (opp["value"] as int)) / filteredOpportunities.length
        : 0.0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Pipeline Value",
            value: "\$${(totalPipelineValue / 1000).toStringAsFixed(0)}K",
            icon: Icons.attach_money,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Weighted Value",
            value: "\$${(weightedPipelineValue / 1000).toStringAsFixed(0)}K",
            icon: Icons.balance,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Active Deals",
            value: "$activeOpportunities",
            icon: Icons.handshake,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Avg Deal Size",
            value: "\$${(avgDealSize / 1000).toStringAsFixed(0)}K",
            icon: Icons.trending_up,
            color: successColor,
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
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
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

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Stage",
            items: stageItems,
            value: selectedStage,
            onChanged: (value, label) {
              selectedStage = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Probability",
            items: probabilityItems,
            value: selectedProbability,
            onChanged: (value, label) {
              selectedProbability = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Owner",
            items: ownerItems,
            value: selectedOwner,
            onChanged: (value, label) {
              selectedOwner = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
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
        QButton(
          icon: Icons.search,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildStageOverview() {
    Map<String, int> stageCount = {};
    Map<String, double> stageValue = {};
    
    for (String stage in ["Prospecting", "Qualification", "Proposal", "Negotiation"]) {
      stageCount[stage] = opportunities
          .where((opp) => opp["stage"] == stage)
          .length;
      stageValue[stage] = opportunities
          .where((opp) => opp["stage"] == stage)
          .fold(0.0, (sum, opp) => sum + (opp["value"] as int));
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timeline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Pipeline by Stage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: ["Prospecting", "Qualification", "Proposal", "Negotiation"].map((stage) {
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStageColor(stage).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStageColor(stage),
                    width: 2,
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.circle,
                      color: _getStageColor(stage),
                      size: 16,
                    ),
                    Text(
                      stage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStageColor(stage),
                      ),
                    ),
                    Text(
                      "${stageCount[stage]} deals",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((stageValue[stage] ?? 0) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStageColor(stage),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesList() {
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
        return _buildOpportunityCard(opportunity);
      }),
    );
  }

  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
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
                            "${opportunity["priority"]}",
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
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: _getProbabilityColor(opportunity["probability"]),
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
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${opportunity["expectedCloseDate"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Expected Close",
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
                "Next: ${opportunity["nextActivity"]}",
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
