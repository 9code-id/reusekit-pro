import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadQualificationView extends StatefulWidget {
  const CmaLeadQualificationView({super.key});

  @override
  State<CmaLeadQualificationView> createState() => _CmaLeadQualificationViewState();
}

class _CmaLeadQualificationViewState extends State<CmaLeadQualificationView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterItems = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Disqualified", "value": "Disqualified"},
  ];

  List<Map<String, dynamic>> leads = [
    {
      "id": "1",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1 (555) 123-4567",
      "company": "Tech Solutions Inc",
      "position": "CTO",
      "source": "Website",
      "status": "New",
      "score": 85,
      "value": 25000,
      "lastActivity": "2024-01-15",
      "qualificationStatus": "Pending",
      "budget": "High",
      "authority": "Decision Maker",
      "need": "Immediate",
      "timeline": "Q1 2024",
      "notes": "Interested in enterprise solution",
      "avatar": "https://picsum.photos/50/50?random=1",
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "email": "sarah.j@marketing.com",
      "phone": "+1 (555) 987-6543",
      "company": "Marketing Pro",
      "position": "Marketing Director",
      "source": "Referral",
      "status": "In Progress",
      "score": 72,
      "value": 15000,
      "lastActivity": "2024-01-14",
      "qualificationStatus": "Qualified",
      "budget": "Medium",
      "authority": "Influencer",
      "need": "Soon",
      "timeline": "Q2 2024",
      "notes": "Budget approved for digital transformation",
      "avatar": "https://picsum.photos/50/50?random=2",
    },
    {
      "id": "3",
      "name": "Michael Chen",
      "email": "m.chen@startup.io",
      "phone": "+1 (555) 456-7890",
      "company": "Innovation Startup",
      "position": "Founder",
      "source": "Social Media",
      "status": "Qualified",
      "score": 94,
      "value": 50000,
      "lastActivity": "2024-01-13",
      "qualificationStatus": "Qualified",
      "budget": "High",
      "authority": "Decision Maker",
      "need": "Urgent",
      "timeline": "This Month",
      "notes": "Ready to move forward with implementation",
      "avatar": "https://picsum.photos/50/50?random=3",
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "email": "emily.davis@corp.com",
      "phone": "+1 (555) 321-0987",
      "company": "Global Corp",
      "position": "Operations Manager",
      "source": "Trade Show",
      "status": "Disqualified",
      "score": 45,
      "value": 8000,
      "lastActivity": "2024-01-12",
      "qualificationStatus": "Disqualified",
      "budget": "Low",
      "authority": "No Authority",
      "need": "No Need",
      "timeline": "Unknown",
      "notes": "No budget allocated for this year",
      "avatar": "https://picsum.photos/50/50?random=4",
    },
  ];

  List<Map<String, dynamic>> get filteredLeads {
    List<Map<String, dynamic>> filtered = leads;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((lead) => lead["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((lead) =>
        "${lead["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${lead["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${lead["email"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Qualified":
        return successColor;
      case "Disqualified":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  void _qualifyLead(Map<String, dynamic> lead) {
    //navigateTo('CmaLeadQualificationDetailView')
  }

  void _viewLeadDetail(Map<String, dynamic> lead) {
    //navigateTo('CmaLeadDetailView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Qualification"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              //navigateTo('CmaAddLeadView')
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
            _buildFilters(),
            _buildSearchBar(),
            _buildQualificationStats(),
            _buildLeadsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assessment,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead Qualification",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Qualify and score your leads",
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
              "${filteredLeads.length} Leads",
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

  Widget _buildFilters() {
    return QCategoryPicker(
      label: "Filter by Status",
      items: filterItems,
      value: selectedFilter,
      onChanged: (index, label, value, item) {
        selectedFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search leads...",
            value: searchQuery,
            hint: "Search by name, company, or email",
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

  Widget _buildQualificationStats() {
    int totalLeads = leads.length;
    int qualifiedLeads = leads.where((lead) => lead["qualificationStatus"] == "Qualified").length;
    int pendingLeads = leads.where((lead) => lead["qualificationStatus"] == "Pending").length;
    int disqualifiedLeads = leads.where((lead) => lead["qualificationStatus"] == "Disqualified").length;
    
    double avgScore = leads.fold(0.0, (sum, lead) => sum + (lead["score"] as int)) / totalLeads;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Total Leads",
            value: "$totalLeads",
            icon: Icons.people,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Qualified",
            value: "$qualifiedLeads",
            icon: Icons.check_circle,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Pending",
            value: "$pendingLeads",
            icon: Icons.pending,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Avg Score",
            value: "${avgScore.toStringAsFixed(0)}",
            icon: Icons.star,
            color: infoColor,
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

  Widget _buildLeadsList() {
    if (filteredLeads.isEmpty) {
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
              "No leads found",
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
      children: List.generate(filteredLeads.length, (index) {
        final lead = filteredLeads[index];
        return _buildLeadCard(lead);
      }),
    );
  }

  Widget _buildLeadCard(Map<String, dynamic> lead) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(lead["status"]),
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
                    image: NetworkImage("${lead["avatar"]}"),
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
                            "${lead["name"]}",
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
                            color: _getScoreColor(lead["score"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Score: ${lead["score"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getScoreColor(lead["score"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${lead["position"]} at ${lead["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${lead["email"]}",
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
                child: _buildLeadInfo("Budget", "${lead["budget"]}", Icons.attach_money),
              ),
              Expanded(
                child: _buildLeadInfo("Authority", "${lead["authority"]}", Icons.person),
              ),
              Expanded(
                child: _buildLeadInfo("Need", "${lead["need"]}", Icons.priority_high),
              ),
              Expanded(
                child: _buildLeadInfo("Timeline", "${lead["timeline"]}", Icons.schedule),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(lead["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${lead["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(lead["status"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Value: \$${((lead["value"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Qualify",
                size: bs.sm,
                onPressed: () => _qualifyLead(lead),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewLeadDetail(lead),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeadInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
