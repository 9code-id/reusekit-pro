import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAddWebsiteView extends StatefulWidget {
  const DmsAddWebsiteView({super.key});

  @override
  State<DmsAddWebsiteView> createState() => _DmsAddWebsiteViewState();
}

class _DmsAddWebsiteViewState extends State<DmsAddWebsiteView> {
  final formKey = GlobalKey<FormState>();
  
  String websiteName = "";
  String websiteDomain = "";
  String websiteDescription = "";
  String selectedCategory = "";
  List<String> selectedTags = [];
  bool enableTracking = true;
  bool enableNotifications = true;
  bool enableSEOMonitoring = true;
  bool enablePerformanceTracking = true;
  
  int currentStep = 0;

  final List<Map<String, dynamic>> categories = [
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Blog", "value": "blog"},
    {"label": "Business", "value": "business"},
    {"label": "Portfolio", "value": "portfolio"},
    {"label": "News", "value": "news"},
    {"label": "Education", "value": "education"},
    {"label": "Health & Medical", "value": "health"},
    {"label": "Food & Restaurant", "value": "food"},
    {"label": "Travel", "value": "travel"},
    {"label": "Technology", "value": "technology"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Real Estate", "value": "realestate"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Sports", "value": "sports"},
    {"label": "Other", "value": "other"},
  ];

  final List<Map<String, dynamic>> availableTags = [
    {"label": "WordPress", "value": "wordpress"},
    {"label": "Shopify", "value": "shopify"},
    {"label": "React", "value": "react"},
    {"label": "Vue.js", "value": "vue"},
    {"label": "Angular", "value": "angular"},
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Mobile Friendly", "value": "mobile"},
    {"label": "Progressive Web App", "value": "pwa"},
    {"label": "API", "value": "api"},
    {"label": "CMS", "value": "cms"},
    {"label": "Multi-language", "value": "multilang"},
    {"label": "SSL", "value": "ssl"},
  ];

  void _nextStep() {
    if (currentStep < 2) {
      if (currentStep == 0 && formKey.currentState!.validate()) {
        currentStep++;
        setState(() {});
      } else if (currentStep == 1) {
        currentStep++;
        setState(() {});
      }
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Website added successfully!");
      back();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Enter your website's basic details to get started with monitoring and analytics.",
          style: TextStyle(
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        Form(
          key: formKey,
          child: Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Website Name",
                value: websiteName,
                hint: "e.g., My Online Store",
                validator: Validator.required,
                onChanged: (value) {
                  websiteName = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Website Domain",
                value: websiteDomain,
                hint: "e.g., mystore.com or https://mystore.com",
                validator: Validator.required,
                onChanged: (value) {
                  websiteDomain = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Description",
                value: websiteDescription,
                hint: "Brief description of your website (optional)",
                onChanged: (value) {
                  websiteDescription = value;
                  setState(() {});
                },
              ),
              
              QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsAndOptionsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Tags & Options",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Add relevant tags and configure monitoring options for your website.",
          style: TextStyle(
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Tags",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: availableTags.map((tag) {
                  final isSelected = selectedTags.contains(tag["value"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedTags.remove(tag["value"]);
                      } else {
                        selectedTags.add(tag["value"]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "${tag["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monitoring Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Analytics Tracking",
                        "value": true,
                        "checked": enableTracking,
                      }
                    ],
                    value: [
                      if (enableTracking)
                        {
                          "label": "Enable Analytics Tracking",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableTracking = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Email Notifications",
                        "value": true,
                        "checked": enableNotifications,
                      }
                    ],
                    value: [
                      if (enableNotifications)
                        {
                          "label": "Enable Email Notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable SEO Monitoring",
                        "value": true,
                        "checked": enableSEOMonitoring,
                      }
                    ],
                    value: [
                      if (enableSEOMonitoring)
                        {
                          "label": "Enable SEO Monitoring",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableSEOMonitoring = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Performance Tracking",
                        "value": true,
                        "checked": enablePerformanceTracking,
                      }
                    ],
                    value: [
                      if (enablePerformanceTracking)
                        {
                          "label": "Enable Performance Tracking",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enablePerformanceTracking = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Review & Submit",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Please review your website information before submitting.",
          style: TextStyle(
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(Icons.language, color: primaryColor, size: 24),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          websiteName,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          websiteDomain,
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (websiteDescription.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  websiteDescription,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.category, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    categories.firstWhere((c) => c["value"] == selectedCategory)["label"],
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (selectedTags.isNotEmpty) ...[
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: selectedTags.map((tagValue) {
                    final tag = availableTags.firstWhere((t) => t["value"] == tagValue);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#${tag["label"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monitoring Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: [
                  _buildFeatureRow("Analytics Tracking", enableTracking),
                  _buildFeatureRow("Email Notifications", enableNotifications),
                  _buildFeatureRow("SEO Monitoring", enableSEOMonitoring),
                  _buildFeatureRow("Performance Tracking", enablePerformanceTracking),
                ],
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: infoColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "After submission, we'll start monitoring your website and send verification instructions to your email.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(String feature, bool enabled) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            enabled ? Icons.check_circle : Icons.cancel,
            color: enabled ? successColor : disabledBoldColor,
            size: 16,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 12,
                color: enabled ? primaryColor : disabledBoldColor,
                fontWeight: enabled ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : (isActive ? primaryColor : disabledColor),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 16)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: isActive ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                  ),
                ),
                if (index < 2) ...[
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      decoration: BoxDecoration(
                        color: isCompleted ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      _buildBasicInfoStep(),
      _buildTagsAndOptionsStep(),
      _buildReviewStep(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Website"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Step Indicator
            _buildStepIndicator(),
            
            // Current Step Content
            steps[currentStep],
            
            // Navigation Buttons
            Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      icon: Icons.arrow_back,
                      size: bs.md,
                      onPressed: _previousStep,
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: currentStep == 2 ? "Add Website" : "Next",
                    icon: currentStep == 2 ? Icons.add : Icons.arrow_forward,
                    size: bs.md,
                    onPressed: currentStep == 2 ? _submitForm : _nextStep,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
