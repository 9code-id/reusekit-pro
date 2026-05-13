import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLeadQualificationView extends StatefulWidget {
  const CrmLeadQualificationView({super.key});

  @override
  State<CrmLeadQualificationView> createState() => _CrmLeadQualificationViewState();
}

class _CrmLeadQualificationViewState extends State<CrmLeadQualificationView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedLeadId = "";
  String budget = "";
  String timeline = "";
  String authority = "";
  String need = "";
  String qualificationStatus = "Under Review";
  String qualificationNotes = "";
  bool hasBudget = false;
  bool hasAuthority = false;
  bool hasNeed = false;
  bool hasTimeline = false;
  int qualificationScore = 0;
  String nextAction = "";
  String followUpDate = "";
  String qualifiedBy = "";

  List<Map<String, dynamic>> leads = [
    {
      "id": "1",
      "name": "John Smith",
      "company": "Acme Corp",
      "email": "john@acme.com",
      "phone": "+1 234 567 8900",
      "source": "Website",
      "status": "New",
      "created": "2024-01-15",
      "value": 25000.0,
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "company": "TechStart Inc",
      "email": "sarah@techstart.com",
      "phone": "+1 234 567 8901",
      "source": "Referral",
      "status": "Contacted",
      "created": "2024-01-14",
      "value": 15000.0,
    },
    {
      "id": "3",
      "name": "Mike Davis",
      "company": "Global Solutions",
      "email": "mike@global.com",
      "phone": "+1 234 567 8902",
      "source": "Cold Call",
      "status": "Qualified",
      "created": "2024-01-13",
      "value": 50000.0,
    },
  ];

  List<Map<String, dynamic>> budgetOptions = [
    {"label": "Under \$10K", "value": "under_10k"},
    {"label": "\$10K - \$50K", "value": "10k_50k"},
    {"label": "\$50K - \$100K", "value": "50k_100k"},
    {"label": "\$100K - \$500K", "value": "100k_500k"},
    {"label": "Over \$500K", "value": "over_500k"},
    {"label": "Not Disclosed", "value": "not_disclosed"},
  ];

  List<Map<String, dynamic>> timelineOptions = [
    {"label": "Immediate (< 1 month)", "value": "immediate"},
    {"label": "Short-term (1-3 months)", "value": "short_term"},
    {"label": "Medium-term (3-6 months)", "value": "medium_term"},
    {"label": "Long-term (6+ months)", "value": "long_term"},
    {"label": "No specific timeline", "value": "no_timeline"},
  ];

  List<Map<String, dynamic>> authorityOptions = [
    {"label": "Decision Maker", "value": "decision_maker"},
    {"label": "Influencer", "value": "influencer"},
    {"label": "Evaluator", "value": "evaluator"},
    {"label": "End User", "value": "end_user"},
    {"label": "Unknown", "value": "unknown"},
  ];

  List<Map<String, dynamic>> qualificationStatusOptions = [
    {"label": "Under Review", "value": "under_review"},
    {"label": "Qualified", "value": "qualified"},
    {"label": "Not Qualified", "value": "not_qualified"},
    {"label": "Requires Follow-up", "value": "requires_followup"},
  ];

  List<Map<String, dynamic>> nextActionOptions = [
    {"label": "Schedule Meeting", "value": "schedule_meeting"},
    {"label": "Send Proposal", "value": "send_proposal"},
    {"label": "Product Demo", "value": "product_demo"},
    {"label": "Follow-up Call", "value": "followup_call"},
    {"label": "Send Information", "value": "send_info"},
    {"label": "Disqualify", "value": "disqualify"},
  ];

  void _calculateQualificationScore() {
    int score = 0;
    if (hasBudget) score += 25;
    if (hasAuthority) score += 25;
    if (hasNeed) score += 25;
    if (hasTimeline) score += 25;
    
    qualificationScore = score;
    
    if (score >= 75) {
      qualificationStatus = "qualified";
    } else if (score >= 50) {
      qualificationStatus = "requires_followup";
    } else {
      qualificationStatus = "not_qualified";
    }
    
    setState(() {});
  }

  void _qualifyLead() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Lead qualification updated successfully");
      back();
    }
  }

  Widget _buildQualificationCriteria() {
    return Container(
      width: double.infinity,
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
            "BANT Qualification Criteria",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Budget, Authority, Need, Timeline",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Budget Confirmed",
                      "value": true,
                      "checked": hasBudget,
                    }
                  ],
                  value: [
                    if (hasBudget)
                      {
                        "label": "Budget Confirmed",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      hasBudget = values.isNotEmpty;
                    });
                    _calculateQualificationScore();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Authority Identified",
                      "value": true,
                      "checked": hasAuthority,
                    }
                  ],
                  value: [
                    if (hasAuthority)
                      {
                        "label": "Authority Identified",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      hasAuthority = values.isNotEmpty;
                    });
                    _calculateQualificationScore();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Need Established",
                      "value": true,
                      "checked": hasNeed,
                    }
                  ],
                  value: [
                    if (hasNeed)
                      {
                        "label": "Need Established",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      hasNeed = values.isNotEmpty;
                    });
                    _calculateQualificationScore();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Timeline Defined",
                      "value": true,
                      "checked": hasTimeline,
                    }
                  ],
                  value: [
                    if (hasTimeline)
                      {
                        "label": "Timeline Defined",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      hasTimeline = values.isNotEmpty;
                    });
                    _calculateQualificationScore();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualificationScore() {
    Color scoreColor = successColor;
    String scoreLabel = "Qualified";
    
    if (qualificationScore < 50) {
      scoreColor = dangerColor;
      scoreLabel = "Not Qualified";
    } else if (qualificationScore < 75) {
      scoreColor = warningColor;
      scoreLabel = "Needs Follow-up";
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Qualification Score",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scoreColor.withAlpha(30),
              border: Border.all(
                color: scoreColor,
                width: 4,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$qualificationScore%",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  Text(
                    scoreLabel,
                    style: TextStyle(
                      fontSize: 12,
                      color: scoreColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadItem(Map<String, dynamic> lead, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: selectedLeadId == lead["id"] ? primaryColor.withAlpha(30) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: selectedLeadId == lead["id"] ? primaryColor : disabledOutlineBorderColor,
        ),
        boxShadow: [shadowSm],
      ),
      child: InkWell(
        onTap: () {
          selectedLeadId = lead["id"];
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${lead["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(lead["status"]),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${lead["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${lead["company"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
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
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 14,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${lead["phone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${((lead["value"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return infoColor;
      case 'contacted':
        return warningColor;
      case 'qualified':
        return successColor;
      case 'proposal':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Qualification"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: QButton(
              label: "Qualify",
              size: bs.sm,
              onPressed: _qualifyLead,
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Select Lead Section
              Container(
                width: double.infinity,
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
                      "Select Lead to Qualify",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...leads.map((lead) => _buildLeadItem(lead, leads.indexOf(lead))).toList(),
                  ],
                ),
              ),

              if (selectedLeadId.isNotEmpty) ...[
                // Qualification Criteria
                _buildQualificationCriteria(),

                // Qualification Details
                Container(
                  width: double.infinity,
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
                        "Qualification Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Budget Range",
                              items: budgetOptions,
                              value: budget,
                              onChanged: (value, label) {
                                budget = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Timeline",
                              items: timelineOptions,
                              value: timeline,
                              onChanged: (value, label) {
                                timeline = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QDropdownField(
                        label: "Authority Level",
                        items: authorityOptions,
                        value: authority,
                        onChanged: (value, label) {
                          authority = value;
                          setState(() {});
                        },
                      ),
                      QMemoField(
                        label: "Identified Need",
                        value: need,
                        hint: "Describe the prospect's specific needs and pain points",
                        onChanged: (value) {
                          need = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                // Qualification Score
                _buildQualificationScore(),

                // Next Steps
                Container(
                  width: double.infinity,
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
                        "Next Steps",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Qualification Status",
                              items: qualificationStatusOptions,
                              value: qualificationStatus,
                              onChanged: (value, label) {
                                qualificationStatus = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Next Action",
                              items: nextActionOptions,
                              value: nextAction,
                              onChanged: (value, label) {
                                nextAction = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QDatePicker(
                        label: "Follow-up Date",
                        value: followUpDate.isNotEmpty ? DateTime.parse(followUpDate) : DateTime.now(),
                        onChanged: (value) {
                          followUpDate = value.toString();
                          setState(() {});
                        },
                      ),
                      QMemoField(
                        label: "Qualification Notes",
                        value: qualificationNotes,
                        hint: "Add notes about the qualification process and findings",
                        onChanged: (value) {
                          qualificationNotes = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
