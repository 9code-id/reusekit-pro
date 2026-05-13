import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOnboardingView extends StatefulWidget {
  const RmaOnboardingView({super.key});

  @override
  State<RmaOnboardingView> createState() => _RmaOnboardingViewState();
}

class _RmaOnboardingViewState extends State<RmaOnboardingView> {
  int currentStep = 0;
  
  final List<Map<String, dynamic>> onboardingSteps = [
    {
      "title": "Manage Your Restaurant",
      "subtitle": "Complete restaurant management solution",
      "description": "Take control of your restaurant operations with our comprehensive management platform designed for modern restaurateurs.",
      "image": "https://picsum.photos/300/250?random=1&keyword=restaurant",
      "icon": Icons.restaurant,
      "color": primaryColor,
    },
    {
      "title": "Track Inventory & Orders",
      "subtitle": "Real-time inventory management",
      "description": "Monitor stock levels, track ingredient usage, and automate ordering to ensure you never run out of essential items.",
      "image": "https://picsum.photos/300/250?random=2&keyword=inventory",
      "icon": Icons.inventory,
      "color": successColor,
    },
    {
      "title": "Manage Staff & Schedules",
      "subtitle": "Efficient workforce management",
      "description": "Create staff schedules, track attendance, monitor performance, and manage payroll with integrated tools.",
      "image": "https://picsum.photos/300/250?random=3&keyword=team",
      "icon": Icons.people,
      "color": infoColor,
    },
    {
      "title": "Analytics & Reports",
      "subtitle": "Data-driven insights",
      "description": "Get detailed analytics on sales, customer behavior, popular dishes, and financial performance to make informed decisions.",
      "image": "https://picsum.photos/300/250?random=4&keyword=analytics",
      "icon": Icons.analytics,
      "color": warningColor,
    },
    {
      "title": "Customer Experience",
      "subtitle": "Enhance customer satisfaction",
      "description": "Manage reservations, track customer preferences, handle feedback, and build loyalty programs to grow your business.",
      "image": "https://picsum.photos/300/250?random=5&keyword=customer",
      "icon": Icons.star,
      "color": secondaryColor,
    },
  ];

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spSm,
        children: List.generate(onboardingSteps.length, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;
          
          return Container(
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive || isCompleted ? primaryColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    final step = onboardingSteps[currentStep];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: (step["color"] as Color).withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              step["icon"] as IconData,
              size: 60,
              color: step["color"] as Color,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${step["image"]}",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              Text(
                "${step["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${step["subtitle"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: step["color"] as Color,
                ),
              ),
              Text(
                "${step["description"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      "Real-time order tracking",
      "Inventory management",
      "Staff scheduling",
      "Sales analytics",
      "Customer management",
      "Menu customization",
      "Payment processing",
      "Delivery coordination",
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Key Features:",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: features.map((feature) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          if (currentStep == onboardingSteps.length - 1) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Get Started",
                size: bs.md,
                onPressed: () {
                  //navigateTo('RmaLoginView')
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Features",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    currentStep = 0;
                  });
                },
              ),
            ),
          ] else ...[
            Row(
              spacing: spSm,
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledBoldColor,
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          currentStep--;
                        });
                      },
                    ),
                  ),
                ],
                Expanded(
                  flex: currentStep > 0 ? 1 : 2,
                  child: QButton(
                    label: currentStep == onboardingSteps.length - 1 ? "Finish" : "Next",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        if (currentStep < onboardingSteps.length - 1) {
                          currentStep++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Skip Tutorial",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaLoginView')
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RestaurantManager",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${currentStep + 1} of ${onboardingSteps.length}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            _buildStepIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildStepContent(),
                    if (currentStep == onboardingSteps.length - 1)
                      _buildFeaturesList(),
                  ],
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }
}
