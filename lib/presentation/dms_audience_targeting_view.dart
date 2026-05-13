import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAudienceTargetingView extends StatefulWidget {
  const DmsAudienceTargetingView({super.key});

  @override
  State<DmsAudienceTargetingView> createState() => _DmsAudienceTargetingViewState();
}

class _DmsAudienceTargetingViewState extends State<DmsAudienceTargetingView> {
  String selectedCampaign = "campaign1";
  String audienceName = "";
  String minAge = "18";
  String maxAge = "65";
  String selectedGender = "all";
  String selectedLocation = "global";
  String interests = "";
  String behaviors = "";
  bool lookalikesEnabled = false;
  bool excludeExistingCustomers = false;
  int currentTab = 0;

  List<Map<String, dynamic>> audiences = [
    {
      "id": "aud1",
      "name": "Young Professionals",
      "size": 2500000,
      "reach": "High",
      "status": "Active",
      "age": "25-35",
      "gender": "All",
      "location": "Urban Areas",
      "interests": "Technology, Business",
      "performance": 8.5,
      "ctr": 3.2,
      "cpc": 1.85,
      "conversions": 1250
    },
    {
      "id": "aud2", 
      "name": "Fashion Enthusiasts",
      "size": 1800000,
      "reach": "Medium",
      "status": "Active",
      "age": "18-45",
      "gender": "Female",
      "location": "Major Cities",
      "interests": "Fashion, Lifestyle",
      "performance": 9.1,
      "ctr": 4.1,
      "cpc": 2.10,
      "conversions": 980
    },
    {
      "id": "aud3",
      "name": "Tech Early Adopters",
      "size": 750000,
      "reach": "Low",
      "status": "Paused",
      "age": "22-40",
      "gender": "Male",
      "location": "Tech Hubs",
      "interests": "Technology, Innovation",
      "performance": 6.8,
      "ctr": 2.8,
      "cpc": 2.55,
      "conversions": 420
    }
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "Summer Sale Campaign", "value": "campaign1"},
    {"label": "Brand Awareness Drive", "value": "campaign2"},
    {"label": "Product Launch", "value": "campaign3"}
  ];

  List<Map<String, dynamic>> genderOptions = [
    {"label": "All Genders", "value": "all"},
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"}
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Global", "value": "global"},
    {"label": "United States", "value": "us"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia Pacific", "value": "apac"},
    {"label": "Custom Locations", "value": "custom"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audience Targeting"),
        actions: [
          IconButton(
            icon: Icon(Icons.people_alt),
            onPressed: () {
              ss("Audience insights loaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildAudienceCreator(),
            _buildExistingAudiences(),
            _buildAudienceInsights(),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.groups,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Audience Targeting",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Reach the right people with precision targeting",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("Active Audiences", "3", Icons.group),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Total Reach", "5.1M", Icons.visibility),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Avg. CTR", "3.4%", Icons.mouse),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceCreator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Audience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Audience Name",
            value: audienceName,
            hint: "Enter descriptive audience name",
            onChanged: (value) {
              audienceName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Target Campaign",
            items: campaignOptions,
            value: selectedCampaign,
            onChanged: (value, label) {
              selectedCampaign = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Min Age",
                  value: minAge,
                  onChanged: (value) {
                    minAge = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Max Age",
                  value: maxAge,
                  onChanged: (value) {
                    maxAge = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Gender",
            items: genderOptions,
            value: selectedGender,
            onChanged: (value, label) {
              selectedGender = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Location",
            items: locationOptions,
            value: selectedLocation,
            onChanged: (value, label) {
              selectedLocation = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Interests",
            value: interests,
            hint: "e.g., Technology, Sports, Fashion",
            onChanged: (value) {
              interests = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Behaviors",
            value: behaviors,
            hint: "e.g., Online shoppers, Mobile users",
            onChanged: (value) {
              behaviors = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Create Lookalike Audience",
                      "value": true,
                      "checked": lookalikesEnabled,
                    }
                  ],
                  value: [
                    if (lookalikesEnabled)
                      {
                        "label": "Create Lookalike Audience",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    lookalikesEnabled = values.isNotEmpty;
                    setState(() {});
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
                      "label": "Exclude Existing Customers",
                      "value": true,
                      "checked": excludeExistingCustomers,
                    }
                  ],
                  value: [
                    if (excludeExistingCustomers)
                      {
                        "label": "Exclude Existing Customers",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    excludeExistingCustomers = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Audience",
              size: bs.md,
              onPressed: () {
                if (audienceName.isNotEmpty) {
                  ss("Audience '$audienceName' created successfully");
                  audienceName = "";
                  setState(() {});
                } else {
                  se("Please enter audience name");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExistingAudiences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Existing Audiences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...audiences.map((audience) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: audience["status"] == "Active" 
                      ? successColor 
                      : disabledColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${audience["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: audience["status"] == "Active" 
                              ? successColor 
                              : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${audience["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAudienceDetail(
                          "Size", 
                          "${((audience["size"] as int) / 1000000).toStringAsFixed(1)}M"
                        ),
                      ),
                      Expanded(
                        child: _buildAudienceDetail(
                          "Age", 
                          "${audience["age"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildAudienceDetail(
                          "Gender", 
                          "${audience["gender"]}"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAudienceDetail(
                          "CTR", 
                          "${(audience["ctr"] as double).toStringAsFixed(1)}%"
                        ),
                      ),
                      Expanded(
                        child: _buildAudienceDetail(
                          "CPC", 
                          "\$${(audience["cpc"] as double).toStringAsFixed(2)}"
                        ),
                      ),
                      Expanded(
                        child: _buildAudienceDetail(
                          "Conversions", 
                          "${audience["conversions"]}"
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Interests: ${audience["interests"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            ss("Editing ${audience["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Duplicate",
                          size: bs.sm,
                          onPressed: () {
                            si("Duplicated ${audience["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("More options for ${audience["name"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAudienceDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAudienceInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Audience Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Best Performing Audience",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Fashion Enthusiasts audience shows highest engagement with 4.1% CTR and 980 conversions. Consider expanding similar targeting.",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildInsightCard(
                  "Peak Age Group",
                  "25-34",
                  "Highest conversion rate",
                  Icons.person,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildInsightCard(
                  "Top Location",
                  "Urban Areas",
                  "73% of conversions",
                  Icons.location_on,
                  infoColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInsightCard(
                  "Device Preference",
                  "Mobile",
                  "68% mobile users",
                  Icons.smartphone,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildInsightCard(
                  "Best Time",
                  "2-6 PM",
                  "Peak engagement hours",
                  Icons.access_time,
                  primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Expand Fashion Enthusiasts",
        "description": "Create lookalike audience based on top performers",
        "type": "Opportunity",
        "impact": "High"
      },
      {
        "title": "Refine Tech Adopters",
        "description": "Narrow age range to 25-35 for better performance",
        "type": "Optimization", 
        "impact": "Medium"
      },
      {
        "title": "Add Interest Targeting",
        "description": "Include 'Sustainable Fashion' for better reach",
        "type": "Expansion",
        "impact": "Medium"
      }
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Targeting Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recommendations.map((rec) {
            Color typeColor = rec["type"] == "Opportunity" 
                ? successColor 
                : rec["type"] == "Optimization" 
                    ? infoColor 
                    : warningColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: typeColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rec["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${rec["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${rec["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: () {
                            ss("Applied: ${rec["title"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Details",
                        size: bs.sm,
                        onPressed: () {
                          si("Showing details for ${rec["title"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
