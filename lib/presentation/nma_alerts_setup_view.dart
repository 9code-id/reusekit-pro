import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaAlertsSetupView extends StatefulWidget {
  const NmaAlertsSetupView({super.key});

  @override
  State<NmaAlertsSetupView> createState() => _NmaAlertsSetupViewState();
}

class _NmaAlertsSetupViewState extends State<NmaAlertsSetupView> {
  // General Alert Settings
  bool enableAlerts = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  String alertFrequency = "immediate";
  
  // Keywords Alerts
  bool keywordAlerts = true;
  String keywordThreshold = "50";
  
  // Hashtag Alerts
  bool hashtagAlerts = true;
  String hashtagThreshold = "100";
  
  // Competitor Alerts
  bool competitorAlerts = false;
  String competitorName = "";
  
  // Price Alerts
  bool priceAlerts = true;
  String priceThreshold = "5";
  
  // Performance Alerts
  bool performanceAlerts = true;
  String performanceThreshold = "20";
  
  // Custom Alert Settings
  String customAlertName = "";
  String customCondition = "greater_than";
  String customValue = "";
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Immediate", "value": "immediate"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
  ];
  
  List<Map<String, dynamic>> conditionOptions = [
    {"label": "Greater Than", "value": "greater_than"},
    {"label": "Less Than", "value": "less_than"},
    {"label": "Equal To", "value": "equal_to"},
    {"label": "Contains", "value": "contains"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts Setup"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // General Settings
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
                      "General Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Alerts",
                          "value": true,
                          "checked": enableAlerts,
                        }
                      ],
                      value: [if (enableAlerts) {"label": "Enable Alerts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        enableAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (enableAlerts) ...[
                      Text(
                        "Notification Methods",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      QSwitch(
                        items: [
                          {
                            "label": "Email Notifications",
                            "value": "email",
                            "checked": emailNotifications,
                          },
                          {
                            "label": "Push Notifications",
                            "value": "push",
                            "checked": pushNotifications,
                          },
                          {
                            "label": "SMS Notifications",
                            "value": "sms",
                            "checked": smsNotifications,
                          }
                        ],
                        value: [
                          if (emailNotifications) {"label": "Email Notifications", "value": "email", "checked": true},
                          if (pushNotifications) {"label": "Push Notifications", "value": "push", "checked": true},
                          if (smsNotifications) {"label": "SMS Notifications", "value": "sms", "checked": true},
                        ],
                        onChanged: (values, ids) {
                          emailNotifications = values.any((v) => v["value"] == "email");
                          pushNotifications = values.any((v) => v["value"] == "push");
                          smsNotifications = values.any((v) => v["value"] == "sms");
                          setState(() {});
                        },
                      ),
                      
                      QDropdownField(
                        label: "Alert Frequency",
                        items: frequencyOptions,
                        value: alertFrequency,
                        onChanged: (value, label) {
                          alertFrequency = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Keywords Alerts
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
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Keywords Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable keyword volume alerts",
                          "value": true,
                          "checked": keywordAlerts,
                        }
                      ],
                      value: [if (keywordAlerts) {"label": "Enable keyword volume alerts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        keywordAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (keywordAlerts) ...[
                      QNumberField(
                        label: "Volume Change Threshold (%)",
                        value: keywordThreshold,
                        validator: Validator.required,
                        onChanged: (value) {
                          keywordThreshold = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Hashtag Alerts
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
                    Row(
                      children: [
                        Icon(
                          Icons.tag,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Hashtag Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable hashtag trending alerts",
                          "value": true,
                          "checked": hashtagAlerts,
                        }
                      ],
                      value: [if (hashtagAlerts) {"label": "Enable hashtag trending alerts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        hashtagAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (hashtagAlerts) ...[
                      QNumberField(
                        label: "Minimum Post Count",
                        value: hashtagThreshold,
                        validator: Validator.required,
                        onChanged: (value) {
                          hashtagThreshold = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Competitor Alerts
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
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Competitor Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Monitor competitor activities",
                          "value": true,
                          "checked": competitorAlerts,
                        }
                      ],
                      value: [if (competitorAlerts) {"label": "Monitor competitor activities", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        competitorAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (competitorAlerts) ...[
                      QTextField(
                        label: "Competitor Name/Handle",
                        value: competitorName,
                        hint: "Enter competitor name or social media handle",
                        validator: Validator.required,
                        onChanged: (value) {
                          competitorName = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Price Alerts
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
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Price Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable CPC price alerts",
                          "value": true,
                          "checked": priceAlerts,
                        }
                      ],
                      value: [if (priceAlerts) {"label": "Enable CPC price alerts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        priceAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (priceAlerts) ...[
                      QNumberField(
                        label: "Price Change Threshold (%)",
                        value: priceThreshold,
                        validator: Validator.required,
                        onChanged: (value) {
                          priceThreshold = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Performance Alerts
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
                    Row(
                      children: [
                        Icon(
                          Icons.analytics,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Performance Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable performance drop alerts",
                          "value": true,
                          "checked": performanceAlerts,
                        }
                      ],
                      value: [if (performanceAlerts) {"label": "Enable performance drop alerts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        performanceAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (performanceAlerts) ...[
                      QNumberField(
                        label: "Performance Drop Threshold (%)",
                        value: performanceThreshold,
                        validator: Validator.required,
                        onChanged: (value) {
                          performanceThreshold = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Custom Alert
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
                    Row(
                      children: [
                        Icon(
                          Icons.add_alert,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Custom Alert",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Alert Name",
                      value: customAlertName,
                      hint: "Enter custom alert name",
                      onChanged: (value) {
                        customAlertName = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Condition",
                      items: conditionOptions,
                      value: customCondition,
                      onChanged: (value, label) {
                        customCondition = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Value",
                      value: customValue,
                      hint: "Enter threshold value",
                      onChanged: (value) {
                        customValue = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Test Alerts",
                      size: bs.md,
                      onPressed: _testAlerts,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Reset to Default",
                      size: bs.md,
                      onPressed: _resetToDefault,
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

  void _saveSettings() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Alert settings saved successfully!");
      });
    }
  }

  void _testAlerts() {
    showLoading();
    
    // Simulate test alert
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      si("Test alert sent successfully!");
    });
  }

  void _resetToDefault() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default?");
    
    if (isConfirmed) {
      setState(() {
        enableAlerts = true;
        emailNotifications = true;
        pushNotifications = true;
        smsNotifications = false;
        alertFrequency = "immediate";
        keywordAlerts = true;
        keywordThreshold = "50";
        hashtagAlerts = true;
        hashtagThreshold = "100";
        competitorAlerts = false;
        competitorName = "";
        priceAlerts = true;
        priceThreshold = "5";
        performanceAlerts = true;
        performanceThreshold = "20";
        customAlertName = "";
        customCondition = "greater_than";
        customValue = "";
      });
      
      ss("Settings reset to default values");
    }
  }
}
