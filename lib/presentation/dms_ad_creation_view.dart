import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAdCreationView extends StatefulWidget {
  const DmsAdCreationView({super.key});

  @override
  State<DmsAdCreationView> createState() => _DmsAdCreationViewState();
}

class _DmsAdCreationViewState extends State<DmsAdCreationView> {
  int selectedTabIndex = 0;

  // Form State
  String campaignName = "";
  String selectedPlatform = "Facebook";
  String adType = "Image";
  String audience = "";
  String headline = "";
  String description = "";
  String callToAction = "Learn More";
  String budget = "";
  String bidding = "Manual";
  String schedulingType = "Run Continuously";
  String objective = "Brand Awareness";
  String location = "";
  bool enableTracking = true;
  bool enableAutoOptimization = false;

  List<String> adImages = [];
  String adVideo = "";

  // Mock Data
  List<Map<String, dynamic>> platformOptions = [
    {"label": "Facebook", "value": "Facebook"},
    {"label": "Instagram", "value": "Instagram"},
    {"label": "Google Ads", "value": "Google Ads"},
    {"label": "LinkedIn", "value": "LinkedIn"},
    {"label": "Twitter", "value": "Twitter"},
    {"label": "TikTok", "value": "TikTok"},
  ];

  List<Map<String, dynamic>> adTypeOptions = [
    {"label": "Image", "value": "Image"},
    {"label": "Video", "value": "Video"},
    {"label": "Carousel", "value": "Carousel"},
    {"label": "Collection", "value": "Collection"},
    {"label": "Story", "value": "Story"},
  ];

  List<Map<String, dynamic>> objectiveOptions = [
    {"label": "Brand Awareness", "value": "Brand Awareness"},
    {"label": "Reach", "value": "Reach"},
    {"label": "Traffic", "value": "Traffic"},
    {"label": "Engagement", "value": "Engagement"},
    {"label": "App Installs", "value": "App Installs"},
    {"label": "Video Views", "value": "Video Views"},
    {"label": "Lead Generation", "value": "Lead Generation"},
    {"label": "Conversions", "value": "Conversions"},
  ];

  List<Map<String, dynamic>> ctaOptions = [
    {"label": "Learn More", "value": "Learn More"},
    {"label": "Shop Now", "value": "Shop Now"},
    {"label": "Sign Up", "value": "Sign Up"},
    {"label": "Download", "value": "Download"},
    {"label": "Contact Us", "value": "Contact Us"},
    {"label": "Get Quote", "value": "Get Quote"},
    {"label": "Apply Now", "value": "Apply Now"},
    {"label": "Watch More", "value": "Watch More"},
  ];

  List<Map<String, dynamic>> biddingOptions = [
    {"label": "Manual", "value": "Manual"},
    {"label": "Automatic", "value": "Automatic"},
    {"label": "Target CPA", "value": "Target CPA"},
    {"label": "Target ROAS", "value": "Target ROAS"},
    {"label": "Maximize Clicks", "value": "Maximize Clicks"},
    {"label": "Maximize Conversions", "value": "Maximize Conversions"},
  ];

  List<Map<String, dynamic>> adTemplates = [
    {
      "id": "1",
      "name": "E-commerce Product",
      "platform": "Facebook",
      "type": "Image",
      "thumbnail": "https://picsum.photos/120/80?random=1",
      "description": "Perfect for showcasing products with compelling visuals",
      "usage": 1247,
    },
    {
      "id": "2",
      "name": "Service Promotion",
      "platform": "Google Ads",
      "type": "Text",
      "thumbnail": "https://picsum.photos/120/80?random=2",
      "description": "Ideal for promoting services and professional solutions",
      "usage": 892,
    },
    {
      "id": "3",
      "name": "App Download",
      "platform": "Instagram",
      "type": "Video",
      "thumbnail": "https://picsum.photos/120/80?random=3",
      "description": "Engaging video format to drive app installations",
      "usage": 756,
    },
    {
      "id": "4",
      "name": "Lead Generation",
      "platform": "LinkedIn",
      "type": "Sponsored Content",
      "thumbnail": "https://picsum.photos/120/80?random=4",
      "description": "Professional format for B2B lead generation",
      "usage": 634,
    },
    {
      "id": "5",
      "name": "Brand Awareness",
      "platform": "TikTok",
      "type": "Video",
      "thumbnail": "https://picsum.photos/120/80?random=5",
      "description": "Creative video content for brand storytelling",
      "usage": 523,
    },
    {
      "id": "6",
      "name": "Event Promotion",
      "platform": "Facebook",
      "type": "Event",
      "thumbnail": "https://picsum.photos/120/80?random=6",
      "description": "Perfect for promoting events and webinars",
      "usage": 445,
    },
  ];

  List<Map<String, dynamic>> savedAds = [
    {
      "id": "1",
      "name": "Summer Sale Campaign",
      "platform": "Facebook",
      "status": "Published",
      "impressions": 125340,
      "clicks": 2847,
      "conversions": 156,
      "spend": 1245.50,
      "date": "2024-03-15",
    },
    {
      "id": "2",
      "name": "Mobile App Launch",
      "platform": "Google Ads",
      "status": "Paused",
      "impressions": 89450,
      "clicks": 1923,
      "conversions": 89,
      "spend": 967.30,
      "date": "2024-03-14",
    },
    {
      "id": "3",
      "name": "B2B Lead Gen",
      "platform": "LinkedIn",
      "status": "Active",
      "impressions": 45670,
      "clicks": 1245,
      "conversions": 67,
      "spend": 543.20,
      "date": "2024-03-13",
    },
    {
      "id": "4",
      "name": "Holiday Collection",
      "platform": "Instagram",
      "status": "Completed",
      "impressions": 156780,
      "clicks": 3456,
      "conversions": 234,
      "spend": 2134.80,
      "date": "2024-03-12",
    },
  ];

  List<Map<String, dynamic>> aiSuggestions = [
    {
      "type": "Headline",
      "suggestion": "Transform Your Business with AI-Powered Solutions",
      "confidence": 92,
      "reason": "High engagement keywords detected",
    },
    {
      "type": "Description",
      "suggestion": "Join thousands of satisfied customers who have revolutionized their workflow. Start your free trial today and experience the difference.",
      "confidence": 88,
      "reason": "Includes social proof and clear CTA",
    },
    {
      "type": "Keywords",
      "suggestion": "AI solutions, business automation, productivity tools, digital transformation",
      "confidence": 85,
      "reason": "Based on industry trends and competitor analysis",
    },
    {
      "type": "Budget",
      "suggestion": "\$50-75 daily budget recommended",
      "confidence": 90,
      "reason": "Optimal performance based on similar campaigns",
    },
    {
      "type": "Audience",
      "suggestion": "Business owners, 25-45, interested in technology and productivity",
      "confidence": 87,
      "reason": "High conversion demographics for this type of campaign",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Ad Creation Studio",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Create", icon: Icon(Icons.add_circle_outline)),
        Tab(text: "Templates", icon: Icon(Icons.dashboard)),
        Tab(text: "AI Assistant", icon: Icon(Icons.psychology)),
        Tab(text: "Preview", icon: Icon(Icons.preview)),
        Tab(text: "Saved Ads", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildCreateTab(),
        _buildTemplatesTab(),
        _buildAIAssistantTab(),
        _buildPreviewTab(),
        _buildSavedAdsTab(),
      ],
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCampaignBasics(),
          _buildAdContent(),
          _buildTargetingSection(),
          _buildBudgetSection(),
          _buildSchedulingSection(),
          _buildTrackingSection(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCampaignBasics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Campaign Basics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Campaign Name",
            value: campaignName,
            hint: "Enter a descriptive campaign name",
            validator: Validator.required,
            onChanged: (value) {
              campaignName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Platform",
                  items: platformOptions,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Ad Type",
                  items: adTypeOptions,
                  value: adType,
                  onChanged: (value, label) {
                    adType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Campaign Objective",
            items: objectiveOptions,
            value: objective,
            onChanged: (value, label) {
              objective = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Ad Content",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (adType == "Image" || adType == "Carousel")
            QMultiImagePicker(
              label: "Ad Images",
              value: adImages,
              maxImages: adType == "Carousel" ? 10 : 1,
              hint: "Upload high-quality images for your ad",
              onChanged: (value) {
                adImages = value;
                setState(() {});
              },
            ),
          if (adType == "Video")
            QAttachmentPicker(
              label: "Ad Video",
              value: adVideo.isNotEmpty ? [adVideo] : [],
              hint: "Upload a compelling video for your ad",
              maxAttachments: 1,
              allowedTypes: ['video'],
              onChanged: (value) {
                adVideo = value.isNotEmpty ? value.first : "";
                setState(() {});
              },
            ),
          QTextField(
            label: "Headline",
            value: headline,
            hint: "Create an attention-grabbing headline",
            validator: Validator.required,
            onChanged: (value) {
              headline = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Write a compelling description that converts",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Call to Action",
            items: ctaOptions,
            value: callToAction,
            onChanged: (value, label) {
              callToAction = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTargetingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Audience Targeting",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Target Audience",
            value: audience,
            hint: "Define your target audience (age, interests, etc.)",
            onChanged: (value) {
              audience = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Location",
            value: location,
            hint: "Geographic targeting (countries, cities, regions)",
            onChanged: (value) {
              location = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Icon(Icons.info_outline, color: infoColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Use AI Assistant for audience suggestions based on your campaign type",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Budget & Bidding",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Daily Budget (\$)",
                  value: budget,
                  hint: "Enter daily budget amount",
                  validator: Validator.required,
                  onChanged: (value) {
                    budget = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Bidding Strategy",
                  items: biddingOptions,
                  value: bidding,
                  onChanged: (value, label) {
                    bidding = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Recommended daily budget: \$50-75 for optimal performance",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Scheduling",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: [
              {"label": "Run Continuously", "value": "Run Continuously"},
              {"label": "Set Start & End Date", "value": "Set Start & End Date"},
              {"label": "Schedule Specific Times", "value": "Schedule Specific Times"},
            ],
            value: schedulingType,
            onChanged: (index, label, value, item) {
              schedulingType = value;
              setState(() {});
            },
          ),
          if (schedulingType != "Run Continuously")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Start Date",
                          value: DateTime.now(),
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDatePicker(
                          label: "End Date",
                          value: DateTime.now().add(Duration(days: 30)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  if (schedulingType == "Schedule Specific Times")
                    Row(
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Start Time",
                            value: TimeOfDay(hour: 9, minute: 0),
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "End Time",
                            value: TimeOfDay(hour: 18, minute: 0),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrackingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tracking & Optimization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Conversion Tracking",
                "value": "tracking",
                "checked": enableTracking,
              }
            ],
            value: enableTracking ? [{"label": "Enable Conversion Tracking", "value": "tracking", "checked": true}] : [],
            onChanged: (values, ids) {
              enableTracking = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-Optimization (AI-powered)",
                "value": "auto_opt",
                "checked": enableAutoOptimization,
              }
            ],
            value: enableAutoOptimization ? [{"label": "Auto-Optimization (AI-powered)", "value": "auto_opt", "checked": true}] : [],
            onChanged: (values, ids) {
              enableAutoOptimization = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Ad Campaign",
            size: bs.md,
            onPressed: () {
              // Create ad campaign logic
              ss("Ad campaign created successfully!");
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save as Draft",
                size: bs.sm,
                color: disabledBoldColor,
                onPressed: () {
                  ss("Campaign saved as draft");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Preview Ad",
                size: bs.sm,
                color: infoColor,
                onPressed: () {
                  selectedTabIndex = 3; // Navigate to preview tab
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ad Templates",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Choose from professionally designed templates to jumpstart your campaign",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: adTemplates.map((template) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${template["thumbnail"]}",
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${template["platform"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${template["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.people, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(template["usage"] as int).toString()} uses",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Use Template",
                          size: bs.sm,
                          onPressed: () {
                            selectedTabIndex = 0; // Navigate to create tab
                            setState(() {});
                            ss("Template applied to ad creation");
                          },
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
    );
  }

  Widget _buildAIAssistantTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.purple.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.purple.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.psychology, color: Colors.purple),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI-Powered Ad Assistant",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        "Get intelligent suggestions to optimize your ad performance",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Campaign Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Describe Your Business/Product",
                  value: "",
                  hint: "E.g., SaaS productivity tool for small businesses",
                  onChanged: (value) {},
                ),
                QTextField(
                  label: "Campaign Goal",
                  value: "",
                  hint: "E.g., increase signups, drive sales, brand awareness",
                  onChanged: (value) {},
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate AI Suggestions",
                    size: bs.sm,
                    color: Colors.purple,
                    onPressed: () {
                      ss("AI analysis complete! Check suggestions below.");
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            spacing: spSm,
            children: aiSuggestions.map((suggestion) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          suggestion["type"] == "Headline" ? Icons.title :
                          suggestion["type"] == "Description" ? Icons.description :
                          suggestion["type"] == "Keywords" ? Icons.tag :
                          suggestion["type"] == "Budget" ? Icons.monetization_on :
                          Icons.people,
                          color: Colors.purple,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${suggestion["type"]} Suggestion",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${suggestion["confidence"]}% confidence",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${suggestion["suggestion"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "💡 ${suggestion["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: () {
                            selectedTabIndex = 0; // Navigate to create tab
                            setState(() {});
                            ss("AI suggestion applied to your ad");
                          },
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
    );
  }

  Widget _buildPreviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.preview, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ad Preview",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "See how your ad will appear across different platforms",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Platform Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QCategoryPicker(
                  items: [
                    {"label": "Facebook", "value": "Facebook"},
                    {"label": "Instagram", "value": "Instagram"},
                    {"label": "Google Ads", "value": "Google Ads"},
                    {"label": "LinkedIn", "value": "LinkedIn"},
                  ],
                  value: selectedPlatform,
                  onChanged: (index, label, value, item) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      selectedPlatform == "Facebook" ? Icons.facebook :
                      selectedPlatform == "Instagram" ? Icons.camera_alt :
                      selectedPlatform == "Google Ads" ? Icons.search :
                      Icons.business,
                      color: selectedPlatform == "Facebook" ? Color(0xFF1877F2) :
                             selectedPlatform == "Instagram" ? Color(0xFFE4405F) :
                             selectedPlatform == "Google Ads" ? Color(0xFF4285F4) :
                             Color(0xFF0A66C2),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "$selectedPlatform Ad Preview",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: _buildPlatformPreview(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Campaign Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildDetailRow("Campaign Name", campaignName.isNotEmpty ? campaignName : "Untitled Campaign"),
                _buildDetailRow("Platform", selectedPlatform),
                _buildDetailRow("Ad Type", adType),
                _buildDetailRow("Objective", objective),
                _buildDetailRow("Daily Budget", budget.isNotEmpty ? "\$$budget" : "Not set"),
                _buildDetailRow("Call to Action", callToAction),
                _buildDetailRow("Auto-Optimization", enableAutoOptimization ? "Enabled" : "Disabled"),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Campaign",
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () {
                    selectedTabIndex = 0; // Navigate to create tab
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Launch Campaign",
                  size: bs.sm,
                  onPressed: () {
                    ss("Campaign launched successfully!");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformPreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          if (adImages.isNotEmpty || adType == "Image")
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 48, color: Colors.grey[600]),
                    Text(
                      "Ad Image Preview",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          Text(
            headline.isNotEmpty ? headline : "Your compelling headline will appear here",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: headline.isNotEmpty ? primaryColor : Colors.grey[600],
            ),
          ),
          Text(
            description.isNotEmpty ? description : "Your ad description will be displayed here to engage your audience",
            style: TextStyle(
              fontSize: 14,
              color: description.isNotEmpty ? disabledBoldColor : Colors.grey[600],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              callToAction,
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedAdsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.bookmark, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Ad Campaigns",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Access your draft and published campaigns",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search campaigns",
                  value: "",
                  hint: "Search by name, platform, or status",
                  onChanged: (value) {},
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
          Column(
            spacing: spSm,
            children: savedAds.map((ad) {
              Color statusColor = ad["status"] == "Active" ? successColor :
                                 ad["status"] == "Published" ? primaryColor :
                                 ad["status"] == "Paused" ? warningColor :
                                 disabledBoldColor;

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${ad["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    ad["platform"] == "Facebook" ? Icons.facebook :
                                    ad["platform"] == "Google Ads" ? Icons.search :
                                    ad["platform"] == "LinkedIn" ? Icons.business :
                                    Icons.camera_alt,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${ad["platform"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${ad["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          color: disabledBoldColor,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildMetricCard("Impressions", "${((ad["impressions"] as int) / 1000).toStringAsFixed(1)}K", Icons.visibility),
                        _buildMetricCard("Clicks", "${ad["clicks"]}", Icons.mouse),
                        _buildMetricCard("Conversions", "${ad["conversions"]}", Icons.trending_up),
                        _buildMetricCard("Spend", "\$${(ad["spend"] as double).toStringAsFixed(2)}", Icons.monetization_on),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Created: ${ad["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Edit",
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            selectedTabIndex = 0; // Navigate to create tab
                            setState(() {});
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Clone",
                          size: bs.sm,
                          color: successColor,
                          onPressed: () {
                            ss("Campaign cloned successfully");
                          },
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
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
