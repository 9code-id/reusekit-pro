import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaOnboardingView extends StatefulWidget {
  const ImaOnboardingView({super.key});

  @override
  State<ImaOnboardingView> createState() => _ImaOnboardingViewState();
}

class _ImaOnboardingViewState extends State<ImaOnboardingView> {
  int currentStep = 0;
  String businessType = "";
  String businessSize = "";
  String industryType = "";
  String primaryGoal = "";
  List<String> selectedFeatures = [];
  
  List<Map<String, dynamic>> businessTypes = [
    {
      "label": "Sole Proprietorship",
      "value": "sole_proprietorship",
      "icon": Icons.person,
      "description": "Individual business ownership",
    },
    {
      "label": "Partnership",
      "value": "partnership",
      "icon": Icons.handshake,
      "description": "Business owned by two or more people",
    },
    {
      "label": "LLC",
      "value": "llc",
      "icon": Icons.business,
      "description": "Limited Liability Company",
    },
    {
      "label": "Corporation",
      "value": "corporation",
      "icon": Icons.corporate_fare,
      "description": "Incorporated business entity",
    },
  ];

  List<Map<String, dynamic>> businessSizes = [
    {
      "label": "Just Me",
      "value": "solo",
      "icon": Icons.person,
      "description": "1 person",
    },
    {
      "label": "Small Team",
      "value": "small",
      "icon": Icons.group,
      "description": "2-10 employees",
    },
    {
      "label": "Medium Business",
      "value": "medium",
      "icon": Icons.groups,
      "description": "11-50 employees",
    },
    {
      "label": "Large Enterprise",
      "value": "large",
      "icon": Icons.business_center,
      "description": "50+ employees",
    },
  ];

  List<Map<String, dynamic>> industries = [
    {
      "label": "Technology",
      "value": "technology",
      "icon": Icons.computer,
    },
    {
      "label": "Retail",
      "value": "retail",
      "icon": Icons.store,
    },
    {
      "label": "Healthcare",
      "value": "healthcare",
      "icon": Icons.local_hospital,
    },
    {
      "label": "Finance",
      "value": "finance",
      "icon": Icons.account_balance,
    },
    {
      "label": "Education",
      "value": "education",
      "icon": Icons.school,
    },
    {
      "label": "Manufacturing",
      "value": "manufacturing",
      "icon": Icons.precision_manufacturing,
    },
    {
      "label": "Services",
      "value": "services",
      "icon": Icons.support_agent,
    },
    {
      "label": "Other",
      "value": "other",
      "icon": Icons.more_horiz,
    },
  ];

  List<Map<String, dynamic>> goals = [
    {
      "label": "Streamline Operations",
      "value": "operations",
      "icon": Icons.settings,
      "description": "Optimize business processes and workflow",
    },
    {
      "label": "Increase Sales",
      "value": "sales",
      "icon": Icons.trending_up,
      "description": "Boost revenue and customer acquisition",
    },
    {
      "label": "Improve Customer Service",
      "value": "customer_service",
      "icon": Icons.support_agent,
      "description": "Enhance customer experience and support",
    },
    {
      "label": "Manage Finances",
      "value": "finances",
      "icon": Icons.account_balance_wallet,
      "description": "Better financial tracking and reporting",
    },
    {
      "label": "Scale Business",
      "value": "scale",
      "icon": Icons.rocket_launch,
      "description": "Prepare for growth and expansion",
    },
  ];

  List<Map<String, dynamic>> features = [
    {
      "label": "Inventory Management",
      "value": "inventory",
      "icon": Icons.inventory,
      "description": "Track products and stock levels",
    },
    {
      "label": "Customer Relationship Management",
      "value": "crm",
      "icon": Icons.people,
      "description": "Manage customer interactions and data",
    },
    {
      "label": "Financial Reporting",
      "value": "reporting",
      "icon": Icons.bar_chart,
      "description": "Generate financial reports and analytics",
    },
    {
      "label": "Project Management",
      "value": "projects",
      "icon": Icons.assignment,
      "description": "Plan and track project progress",
    },
    {
      "label": "Team Collaboration",
      "value": "collaboration",
      "icon": Icons.groups,
      "description": "Facilitate team communication",
    },
    {
      "label": "Marketing Automation",
      "value": "marketing",
      "icon": Icons.campaign,
      "description": "Automate marketing campaigns",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      if (currentStep > 0)
                        GestureDetector(
                          onTap: () {
                            currentStep--;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                          ),
                        ),
                      Spacer(),
                      Text(
                        "Step ${currentStep + 1} of 5",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('LoginView')
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (currentStep + 1) / 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
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

            // Bottom Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: currentStep == 4 ? "Get Started" : "Continue",
                      size: bs.md,
                      onPressed: _canContinue() ? () => _nextStep() : null,
                    ),
                  ),
                  if (currentStep > 0)
                    Container(
                      margin: EdgeInsets.only(top: spSm),
                      width: double.infinity,
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: () {
                          currentStep--;
                          setState(() {});
                        },
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
        return _buildBusinessTypeStep();
      case 2:
        return _buildBusinessSizeStep();
      case 3:
        return _buildIndustryStep();
      case 4:
        return _buildGoalsAndFeaturesStep();
      default:
        return Container();
    }
  }

  Widget _buildWelcomeStep() {
    return Column(
      spacing: spMd,
      children: [
        SizedBox(height: spXl),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radius3xl),
          ),
          child: Icon(
            Icons.rocket_launch,
            size: 60,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spLg),
        Text(
          "Welcome to IMA",
          style: TextStyle(
            fontSize: fsH2,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Intelligent Management Assistant",
          style: TextStyle(
            fontSize: fsH5,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: spMd),
        Text(
          "Let's set up your business profile to provide you with personalized insights and recommendations tailored to your needs.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: spLg),
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            _buildFeatureHighlight(
              icon: Icons.analytics,
              title: "Smart Analytics",
              description: "AI-powered business insights",
            ),
            _buildFeatureHighlight(
              icon: Icons.auto_awesome,
              title: "Automation",
              description: "Streamline repetitive tasks",
            ),
            _buildFeatureHighlight(
              icon: Icons.integration_instructions,
              title: "Integration",
              description: "Connect all your tools",
            ),
            _buildFeatureHighlight(
              icon: Icons.security,
              title: "Secure",
              description: "Enterprise-grade security",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        SizedBox(height: spMd),
        Text(
          "What type of business do you have?",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "This helps us understand your business structure and compliance needs.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spLg),
        ...businessTypes.map((type) {
          bool isSelected = businessType == type["value"];
          return GestureDetector(
            onTap: () {
              businessType = type["value"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(20) 
                          : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      type["icon"],
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${type["label"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        Text(
                          "${type["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBusinessSizeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        SizedBox(height: spMd),
        Text(
          "How big is your team?",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "This helps us recommend the right features and pricing for your business size.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spLg),
        ResponsiveGridView(
          minItemWidth: 200,
          children: businessSizes.map((size) {
            bool isSelected = businessSize == size["value"];
            return GestureDetector(
              onTap: () {
                businessSize = size["value"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(20) 
                            : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radius2xl),
                      ),
                      child: Icon(
                        size["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 36,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${size["label"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : primaryColor,
                      ),
                    ),
                    Text(
                      "${size["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (isSelected)
                      Container(
                        margin: EdgeInsets.only(top: spSm),
                        child: Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIndustryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        SizedBox(height: spMd),
        Text(
          "What industry are you in?",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "We'll customize features and recommendations based on your industry.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spLg),
        ResponsiveGridView(
          minItemWidth: 200,
          children: industries.map((industry) {
            bool isSelected = industryType == industry["value"];
            return GestureDetector(
              onTap: () {
                industryType = industry["value"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(20) 
                            : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        industry["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${industry["label"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (isSelected)
                      Container(
                        margin: EdgeInsets.only(top: spSm),
                        child: Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGoalsAndFeaturesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        SizedBox(height: spMd),
        Text(
          "What's your primary goal?",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Choose your main objective so we can prioritize the right features.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spLg),
        ...goals.map((goal) {
          bool isSelected = primaryGoal == goal["value"];
          return GestureDetector(
            onTap: () {
              primaryGoal = goal["value"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(20) 
                          : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      goal["icon"],
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${goal["label"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        Text(
                          "${goal["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: spLg),
        Text(
          "Which features interest you most? (Optional)",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Select any features you'd like to explore first.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: features.map((feature) {
            bool isSelected = selectedFeatures.contains(feature["value"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedFeatures.remove(feature["value"]);
                } else {
                  selectedFeatures.add(feature["value"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      feature["icon"],
                      size: 20,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${feature["label"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? primaryColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureHighlight({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 28,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  bool _canContinue() {
    switch (currentStep) {
      case 0:
        return true;
      case 1:
        return businessType.isNotEmpty;
      case 2:
        return businessSize.isNotEmpty;
      case 3:
        return industryType.isNotEmpty;
      case 4:
        return primaryGoal.isNotEmpty;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (currentStep < 4) {
      currentStep++;
      setState(() {});
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    // Save onboarding data and navigate to main app
    ss("Welcome! Your business profile has been set up successfully.");
    // navigateTo('HomeView')
  }
}
