import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms4View extends StatefulWidget {
  @override
  State<GrlTerms4View> createState() => _GrlTerms4ViewState();
}

class _GrlTerms4ViewState extends State<GrlTerms4View> {
  String selectedLanguage = "en";
  Map<String, bool> consentStatus = {
    "essential": true,
    "analytics": false,
    "marketing": false,
    "personalization": false,
  };

  List<Map<String, dynamic>> languages = [
    {"code": "en", "name": "English", "flag": "🇺🇸"},
    {"code": "es", "name": "Español", "flag": "🇪🇸"},
    {"code": "fr", "name": "Français", "flag": "🇫🇷"},
    {"code": "de", "name": "Deutsch", "flag": "🇩🇪"},
    {"code": "it", "name": "Italiano", "flag": "🇮🇹"},
    {"code": "pt", "name": "Português", "flag": "🇵🇹"},
  ];

  List<Map<String, dynamic>> consentTypes = [
    {
      "id": "essential",
      "title": "Essential Cookies",
      "description": "Required for basic app functionality and cannot be disabled.",
      "icon": Icons.security,
      "required": true,
      "color": primaryColor,
    },
    {
      "id": "analytics",
      "title": "Analytics & Performance",
      "description": "Help us understand how you use our app to improve performance.",
      "icon": Icons.analytics,
      "required": false,
      "color": infoColor,
    },
    {
      "id": "marketing",
      "title": "Marketing & Advertising",
      "description": "Used to show you relevant ads and measure their effectiveness.",
      "icon": Icons.campaign,
      "required": false,
      "color": warningColor,
    },
    {
      "id": "personalization",
      "title": "Personalization",
      "description": "Customize your experience based on your preferences.",
      "icon": Icons.person,
      "required": false,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Preferences"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Opening privacy help documentation");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(30), primaryColor.withAlpha(10)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your Privacy Matters",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Customize how your data is used to enhance your experience. You can change these preferences anytime in settings.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Select Language",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Choose your preferred language for terms and policies",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: languages.map((language) {
                        bool isSelected = selectedLanguage == language["code"];
                        return GestureDetector(
                          onTap: () {
                            selectedLanguage = language["code"];
                            setState(() {});
                            si("Language changed to ${language["name"]}");
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${language["flag"]}",
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${language["name"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    margin: EdgeInsets.only(top: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Selected",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
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
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Control how your data is used for different purposes",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  ...consentTypes.map((consentType) {
                    String typeId = consentType["id"];
                    bool isEnabled = consentStatus[typeId] ?? false;
                    bool isRequired = consentType["required"] ?? false;
                    Color typeColor = consentType["color"];

                    return Container(
                      margin: EdgeInsets.only(top: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: typeColor.withAlpha(50),
                          width: 1,
                        ),
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
                                  color: typeColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  consentType["icon"],
                                  color: typeColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${consentType["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: typeColor,
                                          ),
                                        ),
                                        if (isRequired)
                                          Container(
                                            margin: EdgeInsets.only(left: spXs),
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: dangerColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "Required",
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      "${consentType["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: isEnabled,
                                onChanged: isRequired ? null : (value) {
                                  consentStatus[typeId] = value;
                                  setState(() {});
                                },
                                activeColor: typeColor,
                                inactiveThumbColor: disabledColor,
                              ),
                            ],
                          ),
                          if (isEnabled && !isRequired)
                            Container(
                              margin: EdgeInsets.only(top: spSm),
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Enabled - Data will be used for ${consentType["title"].toLowerCase()}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Your Rights",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• You can change these preferences anytime in app settings\n• You have the right to access, modify, or delete your data\n• Essential cookies cannot be disabled as they're required for app functionality\n• We will only use your data for the purposes you've agreed to",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Accept Selected",
                    onPressed: () {
                      int enabledCount = consentStatus.values.where((enabled) => enabled).length;
                      ss("Privacy preferences saved - $enabledCount categories enabled");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Accept All",
                    onPressed: () {
                      for (String key in consentStatus.keys) {
                        consentStatus[key] = true;
                      }
                      setState(() {});
                      ss("All privacy preferences accepted");
                    },
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "View Detailed Privacy Policy",
                onPressed: () {
                  si("Opening detailed privacy policy");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
