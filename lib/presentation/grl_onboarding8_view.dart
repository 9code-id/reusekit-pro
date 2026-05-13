import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding8View extends StatefulWidget {
  const GrlOnboarding8View({super.key});

  @override
  State<GrlOnboarding8View> createState() => _GrlOnboarding8ViewState();
}

class _GrlOnboarding8ViewState extends State<GrlOnboarding8View> {
  List<String> selectedFeatures = [];

  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.notifications_active,
      "title": "Smart Notifications",
      "description": "Get personalized alerts and updates",
      "value": "notifications",
    },
    {
      "icon": Icons.analytics,
      "title": "Advanced Analytics",
      "description": "Track your progress with detailed insights",
      "value": "analytics",
    },
    {
      "icon": Icons.cloud_sync,
      "title": "Cloud Sync",
      "description": "Access your data from anywhere",
      "value": "cloud_sync",
    },
    {
      "icon": Icons.security,
      "title": "Enhanced Security",
      "description": "Two-factor authentication and encryption",
      "value": "security",
    },
    {
      "icon": Icons.share,
      "title": "Social Sharing",
      "description": "Share content with your network",
      "value": "sharing",
    },
    {
      "icon": Icons.offline_bolt,
      "title": "Offline Mode",
      "description": "Work without internet connection",
      "value": "offline",
    },
  ];

  void toggleFeature(String value) {
    if (selectedFeatures.contains(value)) {
      selectedFeatures.remove(value);
    } else {
      selectedFeatures.add(value);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customize Your Experience"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Your Features",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Select the features you'd like to enable. You can always change these settings later in your preferences.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: sp2xl),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: features.map((feature) {
                final isSelected = selectedFeatures.contains(feature["value"]);
                
                return GestureDetector(
                  onTap: () => toggleFeature(feature["value"]),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                feature["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${feature["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
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
                );
              }).toList(),
            ),
            SizedBox(height: sp2xl),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "Selected ${selectedFeatures.length} of ${features.length} features. You can modify these anytime in settings.",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sp2xl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue",
                size: bs.md,
                onPressed: () {
                  //navigateTo('dashboard')
                },
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Select All",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  selectedFeatures = features.map((f) => f["value"] as String).toList();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
