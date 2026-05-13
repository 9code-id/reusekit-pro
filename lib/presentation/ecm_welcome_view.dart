import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmWelcomeView extends StatefulWidget {
  const EcmWelcomeView({super.key});

  @override
  State<EcmWelcomeView> createState() => _EcmWelcomeViewState();
}

class _EcmWelcomeViewState extends State<EcmWelcomeView> {
  int currentStep = 0;
  String businessName = "";
  String businessType = "";
  String businessSize = "";
  String primaryGoal = "";
  String budget = "";
  String timeframe = "";
  bool setupCompleted = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Retail Store", "value": "retail"},
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Service Business", "value": "service"},
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Professional Services", "value": "professional"},
  ];

  List<Map<String, dynamic>> businessSizes = [
    {"label": "Just Getting Started", "value": "startup"},
    {"label": "Small (1-10 employees)", "value": "small"},
    {"label": "Medium (11-50 employees)", "value": "medium"},
    {"label": "Large (50+ employees)", "value": "large"},
  ];

  List<Map<String, dynamic>> primaryGoals = [
    {"label": "Increase Sales", "value": "sales"},
    {"label": "Improve Customer Experience", "value": "customer_experience"},
    {"label": "Streamline Operations", "value": "operations"},
    {"label": "Expand Market Reach", "value": "market_expansion"},
    {"label": "Digital Transformation", "value": "digital_transformation"},
    {"label": "Cost Reduction", "value": "cost_reduction"},
  ];

  List<Map<String, dynamic>> budgetRanges = [
    {"label": "Under \$1,000", "value": "under_1k"},
    {"label": "\$1,000 - \$5,000", "value": "1k_5k"},
    {"label": "\$5,000 - \$10,000", "value": "5k_10k"},
    {"label": "\$10,000 - \$25,000", "value": "10k_25k"},
    {"label": "Over \$25,000", "value": "over_25k"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Immediate (0-1 months)", "value": "immediate"},
    {"label": "Short-term (1-3 months)", "value": "short_term"},
    {"label": "Medium-term (3-6 months)", "value": "medium_term"},
    {"label": "Long-term (6+ months)", "value": "long_term"},
  ];

  List<Map<String, dynamic>> features = [
    {
      "title": "Smart Analytics",
      "description": "AI-powered insights to grow your business",
      "icon": Icons.analytics,
      "color": primaryColor,
    },
    {
      "title": "Customer Management",
      "description": "Complete CRM solution for customer relationships",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Inventory Control",
      "description": "Real-time inventory tracking and management",
      "icon": Icons.inventory,
      "color": warningColor,
    },
    {
      "title": "Sales Optimization",
      "description": "Boost revenue with intelligent sales tools",
      "icon": Icons.trending_up,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> testimonials = [
    {
      "name": "Sarah Johnson",
      "business": "Bloom Boutique",
      "testimonial": "ECM transformed our business operations. Sales increased by 40% in just 3 months!",
      "rating": 5,
      "image": "https://picsum.photos/60/60?random=1&keyword=woman",
    },
    {
      "name": "Michael Chen",
      "business": "TechStart Solutions",
      "testimonial": "The analytics features helped us understand our customers better and make data-driven decisions.",
      "rating": 5,
      "image": "https://picsum.photos/60/60?random=2&keyword=man",
    },
    {
      "name": "Emily Rodriguez",
      "business": "Café Luna",
      "testimonial": "Customer management became so much easier. We can now provide personalized experiences.",
      "rating": 5,
      "image": "https://picsum.photos/60/60?random=3&keyword=woman",
    },
  ];

  void _nextStep() {
    if (currentStep < 5) {
      setState(() {
        currentStep++;
      });
    } else {
      _completeSetup();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _completeSetup() {
    setState(() {
      setupCompleted = true;
    });
    ss("Welcome setup completed! Let's get started.");
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return true; // Welcome screen
      case 1:
        return businessName.isNotEmpty;
      case 2:
        return businessType.isNotEmpty;
      case 3:
        return businessSize.isNotEmpty;
      case 4:
        return primaryGoal.isNotEmpty;
      case 5:
        return budget.isNotEmpty && timeframe.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (setupCompleted) {
      return _buildCompletionScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ECM Setup",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${currentStep + 1}/6",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / 6,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildStepContent(),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        color: disabledBoldColor,
                        size: bs.md,
                        onPressed: _previousStep,
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spSm),
                  Expanded(
                    flex: currentStep == 0 ? 1 : 2,
                    child: QButton(
                      label: currentStep == 5 ? "Complete Setup" : "Next",
                      size: bs.md,
                      onPressed: _canProceed() ? _nextStep : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildBusinessNameStep();
      case 2:
        return _buildBusinessTypeStep();
      case 3:
        return _buildBusinessSizeStep();
      case 4:
        return _buildGoalsStep();
      case 5:
        return _buildBudgetTimelineStep();
      default:
        return Container();
    }
  }

  Widget _buildWelcomeStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radius2xl),
          ),
          child: Icon(
            Icons.rocket_launch,
            size: 64,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "Welcome to ECM",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Enterprise Customer Management",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        Text(
          "Let's set up your business profile to provide you with personalized recommendations and features that match your needs.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
        
        // Features Preview
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What you'll get:",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...features.map((feature) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (feature["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      feature["icon"] as IconData,
                      color: feature["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${feature["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${feature["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessNameStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.business,
            size: 40,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "What's your business name?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "This helps us personalize your experience",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        QTextField(
          label: "Business Name",
          value: businessName,
          hint: "Enter your business or company name",
          onChanged: (value) {
            businessName = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBusinessTypeStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.category,
            size: 40,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "What type of business do you run?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "We'll customize features based on your industry",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        QDropdownField(
          label: "Business Type",
          items: businessTypes,
          value: businessType,
          onChanged: (value, label) {
            businessType = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBusinessSizeStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.groups,
            size: 40,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "How big is your team?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "This helps us recommend the right plan and features",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        QDropdownField(
          label: "Business Size",
          items: businessSizes,
          value: businessSize,
          onChanged: (value, label) {
            businessSize = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildGoalsStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.flag,
            size: 40,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "What's your primary goal?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "We'll prioritize features that help you achieve this goal",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        QDropdownField(
          label: "Primary Goal",
          items: primaryGoals,
          value: primaryGoal,
          onChanged: (value, label) {
            primaryGoal = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBudgetTimelineStep() {
    return Column(
      spacing: spLg,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.schedule,
            size: 40,
            color: primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              "Budget & Timeline",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Help us recommend the best approach for your needs",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        QDropdownField(
          label: "Budget Range",
          items: budgetRanges,
          value: budget,
          onChanged: (value, label) {
            budget = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Implementation Timeline",
          items: timeframes,
          value: timeframe,
          onChanged: (value, label) {
            timeframe = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              SizedBox(height: spLg),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radius2xl),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 64,
                  color: successColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    "Welcome to ECM, $businessName!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your profile is all set up. Here's what we've prepared for you:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Setup Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Your Business Profile",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    _buildSummaryRow("Business Name", businessName),
                    _buildSummaryRow("Industry", businessTypes.firstWhere((type) => type["value"] == businessType)["label"]),
                    _buildSummaryRow("Team Size", businessSizes.firstWhere((size) => size["value"] == businessSize)["label"]),
                    _buildSummaryRow("Primary Goal", primaryGoals.firstWhere((goal) => goal["value"] == primaryGoal)["label"]),
                    _buildSummaryRow("Budget Range", budgetRanges.firstWhere((b) => b["value"] == budget)["label"]),
                    _buildSummaryRow("Timeline", timeframes.firstWhere((t) => t["value"] == timeframe)["label"]),
                  ],
                ),
              ),

              // Customer Testimonials
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join thousands of satisfied customers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...testimonials.map((testimonial) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${testimonial["image"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${testimonial["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${testimonial["business"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) => Icon(
                                index < (testimonial["rating"] as int) ? Icons.star : Icons.star_border,
                                size: 16,
                                color: warningColor,
                              )),
                            ),
                          ],
                        ),
                        Text(
                          "${testimonial["testimonial"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start Using ECM",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to main dashboard
                        ss("Welcome to ECM! Let's grow your business together.");
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Schedule Demo Call",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        ss("Demo call scheduled. We'll contact you soon!");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
