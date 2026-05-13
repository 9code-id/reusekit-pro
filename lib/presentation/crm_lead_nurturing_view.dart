import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLeadNurturingView extends StatefulWidget {
  const CrmLeadNurturingView({super.key});

  @override
  State<CrmLeadNurturingView> createState() => _CrmLeadNurturingViewState();
}

class _CrmLeadNurturingViewState extends State<CrmLeadNurturingView> {
  final formKey = GlobalKey<FormState>();
  String selectedStage = "Cold Lead";
  String selectedProgram = "Basic Nurturing";
  String campaignName = "";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> stageOptions = [
    {"label": "Cold Lead", "value": "cold"},
    {"label": "Warm Lead", "value": "warm"},
    {"label": "Hot Lead", "value": "hot"},
    {"label": "Qualified", "value": "qualified"},
    {"label": "Proposal", "value": "proposal"},
  ];

  List<Map<String, dynamic>> programOptions = [
    {"label": "Basic Nurturing", "value": "basic"},
    {"label": "Advanced Nurturing", "value": "advanced"},
    {"label": "VIP Nurturing", "value": "vip"},
    {"label": "Re-engagement", "value": "reengagement"},
  ];

  List<Map<String, dynamic>> leads = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah@techcorp.com",
      "company": "TechCorp Inc",
      "stage": "Warm Lead",
      "score": 85,
      "program": "Advanced Nurturing",
      "lastActivity": "2024-12-19",
      "nextAction": "Send product demo",
      "status": "active",
      "avatar": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "email": "m.chen@innovate.co",
      "company": "Innovate Co",
      "stage": "Hot Lead",
      "score": 92,
      "program": "VIP Nurturing",
      "lastActivity": "2024-12-18",
      "nextAction": "Schedule sales call",
      "status": "active",
      "avatar": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "email": "emily@startupxyz.com",
      "company": "StartupXYZ",
      "stage": "Cold Lead",
      "score": 45,
      "program": "Basic Nurturing",
      "lastActivity": "2024-12-17",
      "nextAction": "Send welcome series",
      "status": "active",
      "avatar": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": "4",
      "name": "David Wilson",
      "email": "david@enterprise.net",
      "company": "Enterprise Solutions",
      "stage": "Qualified",
      "score": 78,
      "program": "Advanced Nurturing",
      "lastActivity": "2024-12-16",
      "nextAction": "Send case studies",
      "status": "paused",
      "avatar": "https://picsum.photos/100/100?random=4",
    },
  ];

  List<Map<String, dynamic>> programs = [
    {
      "id": "1",
      "name": "Basic Nurturing",
      "description": "Standard email sequence for new leads",
      "emails": 5,
      "duration": "30 days",
      "active": true,
      "leadsEnrolled": 245,
      "openRate": 68.5,
      "clickRate": 24.3,
    },
    {
      "id": "2",
      "name": "Advanced Nurturing",
      "description": "Personalized content for qualified prospects",
      "emails": 8,
      "duration": "45 days",
      "active": true,
      "leadsEnrolled": 156,
      "openRate": 75.2,
      "clickRate": 32.1,
    },
    {
      "id": "3",
      "name": "VIP Nurturing",
      "description": "Premium sequence for high-value leads",
      "emails": 12,
      "duration": "60 days",
      "active": true,
      "leadsEnrolled": 89,
      "openRate": 82.4,
      "clickRate": 45.7,
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredLeads {
    return leads.where((lead) {
      bool matchesSearch = searchQuery.isEmpty ||
          (lead["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (lead["company"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = !showActiveOnly || lead["status"] == "active";
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Leads",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "1,245",
                        style: TextStyle(
                          fontSize: fsH4,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Qualified",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "389",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.autorenew, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "567",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Avg. Time",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "14 days",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nurturing Programs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: programs.map((program) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${program["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${program["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (program["active"] as bool)
                                      ? successColor.withAlpha(10)
                                      : dangerColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  (program["active"] as bool) ? "Active" : "Inactive",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (program["active"] as bool)
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "${program["emails"]} emails • ${program["duration"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${program["leadsEnrolled"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Enrolled",
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
                                  children: [
                                    Text(
                                      "${(program["openRate"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Open Rate",
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
                                  children: [
                                    Text(
                                      "${(program["clickRate"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "Click Rate",
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
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Leads",
                  value: searchQuery,
                  hint: "Search by name or company",
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
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Active Only",
                      "value": true,
                      "checked": showActiveOnly,
                    }
                  ],
                  value: [
                    if (showActiveOnly)
                      {
                        "label": "Show Active Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showActiveOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leads (${filteredLeads.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredLeads.map((lead) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${lead["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getScoreColor(lead["score"] as int).withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Score: ${lead["score"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getScoreColor(lead["score"] as int),
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
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      size: 14,
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
                                SizedBox(height: spSm),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${lead["stage"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${lead["program"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Next: ${lead["nextAction"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Campaign Name",
              value: campaignName,
              hint: "Enter campaign name",
              validator: Validator.required,
              onChanged: (value) {
                campaignName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Target Stage",
              items: stageOptions,
              value: selectedStage,
              onChanged: (value, label) {
                selectedStage = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Nurturing Program",
              items: programOptions,
              value: selectedProgram,
              onChanged: (value, label) {
                selectedProgram = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Campaign Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "This campaign will automatically enroll leads matching the selected stage into the chosen nurturing program. The system will track their progress and move them through the sales funnel.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Campaign",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ss("Nurturing campaign created successfully");
                    back();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Lead Nurturing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Leads", icon: Icon(Icons.people)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildLeadsTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
