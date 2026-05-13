import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmDealManagementView extends StatefulWidget {
  const CrmDealManagementView({super.key});

  @override
  State<CrmDealManagementView> createState() => _CrmDealManagementViewState();
}

class _CrmDealManagementViewState extends State<CrmDealManagementView> {
  int currentTab = 0;
  
  // Filters
  String selectedStatus = "all";
  String selectedSalesperson = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  String sortBy = "created_date";
  
  // Deal form
  String companyName = "";
  String contactName = "";
  String contactEmail = "";
  String contactPhone = "";
  double dealValue = 0.0;
  String dealStage = "lead_qualification";
  int probability = 50;
  String dealSource = "website";
  String assignedSalesperson = "sarah_johnson";
  String dealPriority = "medium";
  String dealDescription = "";
  String nextAction = "";
  DateTime nextActionDate = DateTime.now().add(Duration(days: 1));
  
  List<Map<String, dynamic>> deals = [
    {
      "id": 1,
      "company": "TechVision Corp",
      "contact": "Michael Johnson",
      "email": "m.johnson@techvision.com",
      "phone": "+1 555-0123",
      "value": 75000,
      "stage": "Negotiation",
      "probability": 85,
      "priority": "high",
      "source": "Referral",
      "salesperson": "Sarah Johnson",
      "created_date": "2024-01-10",
      "modified_date": "2024-01-18",
      "next_action": "Send final proposal",
      "next_action_date": "2024-01-20",
      "status": "active",
      "notes": "Very interested in enterprise package. Budget approved.",
    },
    {
      "id": 2,
      "company": "Global Solutions Inc",
      "contact": "Emily Davis",
      "email": "e.davis@globalsolutions.com",
      "phone": "+1 555-0234",
      "value": 45000,
      "stage": "Proposal Sent",
      "probability": 70,
      "priority": "high",
      "source": "Website",
      "salesperson": "Mike Wilson",
      "created_date": "2024-01-12",
      "modified_date": "2024-01-19",
      "next_action": "Follow up on proposal",
      "next_action_date": "2024-01-22",
      "status": "active",
      "notes": "Requested custom pricing for multi-year contract.",
    },
    {
      "id": 3,
      "company": "StartupXYZ",
      "contact": "Alex Chen",
      "email": "alex@startupxyz.com",
      "phone": "+1 555-0345",
      "value": 25000,
      "stage": "Initial Contact",
      "probability": 45,
      "priority": "medium",
      "source": "Cold Email",
      "salesperson": "Tom Anderson",
      "created_date": "2024-01-15",
      "modified_date": "2024-01-19",
      "next_action": "Schedule product demo",
      "next_action_date": "2024-01-23",
      "status": "active",
      "notes": "Small team but growing rapidly. Good potential for upsell.",
    },
    {
      "id": 4,
      "company": "Enterprise Group",
      "contact": "Lisa Brown",
      "email": "l.brown@enterprisegroup.com",
      "phone": "+1 555-0456",
      "value": 120000,
      "stage": "Closed Won",
      "probability": 100,
      "priority": "high",
      "source": "Trade Show",
      "salesperson": "Sarah Johnson",
      "created_date": "2024-01-05",
      "modified_date": "2024-01-18",
      "next_action": "Onboarding meeting",
      "next_action_date": "2024-01-25",
      "status": "won",
      "notes": "Large enterprise deal. Implementation starts next month.",
    },
  ];

  List<Map<String, dynamic>> dealActivities = [
    {
      "id": 1,
      "deal_id": 1,
      "type": "call",
      "description": "Initial discovery call with decision maker",
      "user": "Sarah Johnson",
      "date": "2024-01-18 14:30",
      "duration": "45 min",
    },
    {
      "id": 2,
      "deal_id": 1,
      "type": "email",
      "description": "Sent product demo link and pricing information",
      "user": "Sarah Johnson",
      "date": "2024-01-17 09:15",
      "duration": null,
    },
    {
      "id": 3,
      "deal_id": 2,
      "type": "meeting",
      "description": "Product demonstration and Q&A session",
      "user": "Mike Wilson",
      "date": "2024-01-16 16:00",
      "duration": "60 min",
    },
    {
      "id": 4,
      "deal_id": 1,
      "type": "note",
      "description": "Budget confirmed at 75K. Moving to negotiation stage.",
      "user": "Sarah Johnson",
      "date": "2024-01-15 11:30",
      "duration": null,
    },
  ];

  List<Map<String, dynamic>> dealMetrics = [
    {"label": "Total Deals", "value": "156", "change": "+8%", "trend": "up"},
    {"label": "Active Deals", "value": "89", "change": "+12%", "trend": "up"},
    {"label": "Won This Month", "value": "12", "change": "+25%", "trend": "up"},
    {"label": "Lost This Month", "value": "7", "change": "-15%", "trend": "down"},
    {"label": "Total Deal Value", "value": "\$2.4M", "change": "+18%", "trend": "up"},
    {"label": "Average Deal Size", "value": "\$15.4K", "change": "+5%", "trend": "up"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Deal Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Deals", icon: Icon(Icons.handshake)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "New Deal", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildDealsTab(),
        _buildActivitiesTab(),
        _buildAnalyticsTab(),
        _buildNewDealTab(),
      ],
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDealsFiltersCard(),
          _buildDealsListCard(),
        ],
      ),
    );
  }

  Widget _buildDealsFiltersCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Filter & Search",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Search deals",
            value: searchQuery,
            hint: "Company, contact, or deal ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  value: selectedStatus,
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Active", "value": "active"},
                    {"label": "Won", "value": "won"},
                    {"label": "Lost", "value": "lost"},
                    {"label": "On Hold", "value": "on_hold"},
                  ],
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  value: selectedPriority,
                  items: [
                    {"label": "All Priorities", "value": "all"},
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Salesperson",
                  value: selectedSalesperson,
                  items: [
                    {"label": "All Salespeople", "value": "all"},
                    {"label": "Sarah Johnson", "value": "sarah_johnson"},
                    {"label": "Mike Wilson", "value": "mike_wilson"},
                    {"label": "Tom Anderson", "value": "tom_anderson"},
                  ],
                  onChanged: (value, label) {
                    selectedSalesperson = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  value: sortBy,
                  items: [
                    {"label": "Created Date", "value": "created_date"},
                    {"label": "Modified Date", "value": "modified_date"},
                    {"label": "Deal Value", "value": "value"},
                    {"label": "Company Name", "value": "company"},
                    {"label": "Probability", "value": "probability"},
                  ],
                  onChanged: (value, label) {
                    sortBy = value;
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

  Widget _buildDealsListCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  "All Deals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Export",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...deals.map((deal) => _buildDealItem(deal)),
        ],
      ),
    );
  }

  Widget _buildDealItem(Map<String, dynamic> deal) {
    Color statusColor = deal["status"] == "active" 
        ? primaryColor 
        : deal["status"] == "won" 
        ? successColor 
        : deal["status"] == "lost" 
        ? dangerColor 
        : warningColor;

    Color priorityColor = deal["priority"] == "high" 
        ? dangerColor 
        : deal["priority"] == "medium" 
        ? warningColor 
        : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${deal["company"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["priority"]}".toUpperCase(),
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${deal["contact"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(
                Icons.email,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${deal["email"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "\$${((deal["value"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["probability"]}% probability",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: secondaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: secondaryColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Text(
                  "${deal["stage"]}",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: warningColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${deal["next_action"]} - ${deal["next_action_date"]}",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Assigned to: ${deal["salesperson"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if (deal["notes"] != null && deal["notes"].toString().isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${deal["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActivitiesFiltersCard(),
          _buildActivitiesListCard(),
        ],
      ),
    );
  }

  Widget _buildActivitiesFiltersCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Activity Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Activity Type",
                  value: "all",
                  items: [
                    {"label": "All Types", "value": "all"},
                    {"label": "Calls", "value": "call"},
                    {"label": "Emails", "value": "email"},
                    {"label": "Meetings", "value": "meeting"},
                    {"label": "Notes", "value": "note"},
                  ],
                  onChanged: (value, label) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  value: "all_time",
                  items: [
                    {"label": "All Time", "value": "all_time"},
                    {"label": "Today", "value": "today"},
                    {"label": "This Week", "value": "this_week"},
                    {"label": "This Month", "value": "this_month"},
                  ],
                  onChanged: (value, label) {
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

  Widget _buildActivitiesListCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...dealActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData activityIcon;
    Color activityColor;
    
    switch (activity["type"]) {
      case "call":
        activityIcon = Icons.call;
        activityColor = primaryColor;
        break;
      case "email":
        activityIcon = Icons.email;
        activityColor = infoColor;
        break;
      case "meeting":
        activityIcon = Icons.video_call;
        activityColor = successColor;
        break;
      case "note":
        activityIcon = Icons.note;
        activityColor = warningColor;
        break;
      default:
        activityIcon = Icons.history;
        activityColor = disabledBoldColor;
    }

    // Find the associated deal
    Map<String, dynamic>? associatedDeal = deals.firstWhere(
      (deal) => deal["id"] == activity["deal_id"],
      orElse: () => {"company": "Unknown Deal"},
    );

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activityIcon,
              color: activityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${associatedDeal["company"]} • ${activity["user"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${activity["date"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                    if (activity["duration"] != null) ...[
                      Text(
                        " • ${activity["duration"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMetricsCard(),
          _buildPerformanceChartsCard(),
        ],
      ),
    );
  }

  Widget _buildMetricsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Deal Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            spacing: spXs,
            children: dealMetrics.map((metric) {
              Color trendColor = metric["trend"] == "up" 
                  ? successColor 
                  : metric["trend"] == "down" 
                  ? dangerColor 
                  : disabledBoldColor;
              IconData trendIcon = metric["trend"] == "up" 
                  ? Icons.trending_up 
                  : metric["trend"] == "down" 
                  ? Icons.trending_down 
                  : Icons.trending_flat;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${metric["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${metric["value"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            trendIcon,
                            color: trendColor,
                            size: 16,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              color: trendColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

  Widget _buildPerformanceChartsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Performance Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Deal Conversion Funnel",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Text(
                  "• Lead Qualification: 45 deals → 78% conversion",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Initial Contact: 32 deals → 85% conversion",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Proposal Sent: 18 deals → 65% conversion",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Negotiation: 12 deals → 72% conversion",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Top Deal Sources",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Text(
                  "• Website: 35% of total deals, \$890K value",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Referrals: 28% of total deals, \$1.2M value",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Trade Shows: 22% of total deals, \$980K value",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Cold Email: 15% of total deals, \$450K value",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewDealTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCompanyInformationCard(),
          _buildDealDetailsCard(),
          _buildAdditionalInfoCard(),
        ],
      ),
    );
  }

  Widget _buildCompanyInformationCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Company Name",
            value: companyName,
            hint: "Enter company name",
            validator: Validator.required,
            onChanged: (value) {
              companyName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Contact Name",
            value: contactName,
            hint: "Primary contact person",
            validator: Validator.required,
            onChanged: (value) {
              contactName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Contact Email",
                  value: contactEmail,
                  hint: "contact@company.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    contactEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: contactPhone,
                  hint: "+1 555-0123",
                  onChanged: (value) {
                    contactPhone = value;
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

  Widget _buildDealDetailsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Deal Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QNumberField(
            label: "Deal Value (\$)",
            value: dealValue.toString(),
            validator: Validator.required,
            onChanged: (value) {
              dealValue = double.tryParse(value) ?? 0.0;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Deal Stage",
                  value: dealStage,
                  items: [
                    {"label": "Lead Qualification", "value": "lead_qualification"},
                    {"label": "Initial Contact", "value": "initial_contact"},
                    {"label": "Proposal Sent", "value": "proposal_sent"},
                    {"label": "Negotiation", "value": "negotiation"},
                    {"label": "Closed Won", "value": "closed_won"},
                    {"label": "Closed Lost", "value": "closed_lost"},
                  ],
                  onChanged: (value, label) {
                    dealStage = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Probability (%)",
                  value: probability.toString(),
                  onChanged: (value) {
                    probability = int.tryParse(value) ?? 50;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Deal Source",
                  value: dealSource,
                  items: [
                    {"label": "Website", "value": "website"},
                    {"label": "Referral", "value": "referral"},
                    {"label": "Cold Email", "value": "cold_email"},
                    {"label": "Trade Show", "value": "trade_show"},
                    {"label": "Social Media", "value": "social_media"},
                    {"label": "Advertisement", "value": "advertisement"},
                  ],
                  onChanged: (value, label) {
                    dealSource = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  value: dealPriority,
                  items: [
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  onChanged: (value, label) {
                    dealPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Assigned Salesperson",
            value: assignedSalesperson,
            items: [
              {"label": "Sarah Johnson", "value": "sarah_johnson"},
              {"label": "Mike Wilson", "value": "mike_wilson"},
              {"label": "Tom Anderson", "value": "tom_anderson"},
            ],
            onChanged: (value, label) {
              assignedSalesperson = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Additional Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QMemoField(
            label: "Deal Description",
            value: dealDescription,
            hint: "Describe the deal, requirements, and key details",
            onChanged: (value) {
              dealDescription = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Next Action Required",
            value: nextAction,
            hint: "e.g., Send proposal, Schedule demo",
            onChanged: (value) {
              nextAction = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Next Action Date",
            value: nextActionDate,
            onChanged: (value) {
              nextActionDate = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Deal",
              size: bs.md,
              onPressed: () {
                // Handle deal creation
                ss("Deal created successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }
}
