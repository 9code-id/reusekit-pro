import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmAccountSettingsView extends StatefulWidget {
  const TpmAccountSettingsView({super.key});

  @override
  State<TpmAccountSettingsView> createState() => _TpmAccountSettingsViewState();
}

class _TpmAccountSettingsViewState extends State<TpmAccountSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // Account Information
  String firstName = "John";
  String lastName = "Smith";
  String email = "john.smith@company.com";
  String phoneNumber = "+1 (555) 123-4567";
  String jobTitle = "Senior Project Manager";
  String department = "Engineering";
  String companyName = "TechCorp Inc.";
  
  // Security Settings
  bool twoFactorEnabled = true;
  bool loginAlertsEnabled = true;
  String selectedTimezone = "UTC-8";
  String selectedLanguage = "en";
  String selectedDateFormat = "MM/DD/YYYY";
  
  // Subscription Information
  Map<String, dynamic> currentPlan = {
    "name": "Professional",
    "price": 29.99,
    "billing": "monthly",
    "features": ["Unlimited Projects", "Advanced Analytics", "Priority Support", "Custom Integrations"],
    "nextBilling": "2025-07-19",
    "storage": "100 GB",
    "teamMembers": "25 users"
  };
  
  List<Map<String, dynamic>> availablePlans = [
    {
      "name": "Basic",
      "price": 9.99,
      "billing": "monthly",
      "features": ["5 Projects", "Basic Analytics", "Email Support"],
      "storage": "10 GB",
      "teamMembers": "5 users"
    },
    {
      "name": "Professional",
      "price": 29.99,
      "billing": "monthly",
      "features": ["Unlimited Projects", "Advanced Analytics", "Priority Support", "Custom Integrations"],
      "storage": "100 GB",
      "teamMembers": "25 users"
    },
    {
      "name": "Enterprise",
      "price": 99.99,
      "billing": "monthly",
      "features": ["Everything in Pro", "Advanced Security", "Dedicated Manager", "Custom Training"],
      "storage": "1 TB",
      "teamMembers": "Unlimited"
    }
  ];
  
  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "Pacific Time (UTC-8)", "value": "UTC-8"},
    {"label": "Mountain Time (UTC-7)", "value": "UTC-7"},
    {"label": "Central Time (UTC-6)", "value": "UTC-6"},
    {"label": "Eastern Time (UTC-5)", "value": "UTC-5"},
    {"label": "UTC", "value": "UTC"},
    {"label": "Central European Time (UTC+1)", "value": "UTC+1"},
    {"label": "Eastern European Time (UTC+2)", "value": "UTC+2"},
  ];
  
  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];
  
  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
    {"label": "DD MMM YYYY", "value": "DD MMM YYYY"},
  ];
  
  int currentTab = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Account Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Profile", icon: Icon(Icons.person)),
        Tab(text: "Security", icon: Icon(Icons.security)),
        Tab(text: "Subscription", icon: Icon(Icons.payment)),
        Tab(text: "Preferences", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildProfileTab(),
        _buildSecurityTab(),
        _buildSubscriptionTab(),
        _buildPreferencesTab(),
      ],
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Profile Picture",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1&keyword=person"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Change Photo",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            // Personal Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "First Name",
                          value: firstName,
                          validator: Validator.required,
                          onChanged: (value) {
                            firstName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QTextField(
                          label: "Last Name",
                          value: lastName,
                          validator: Validator.required,
                          onChanged: (value) {
                            lastName = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Email Address",
                    value: email,
                    validator: Validator.email,
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Phone Number",
                    value: phoneNumber,
                    onChanged: (value) {
                      phoneNumber = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Work Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Work Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Job Title",
                    value: jobTitle,
                    onChanged: (value) {
                      jobTitle = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Department",
                    value: department,
                    onChanged: (value) {
                      department = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Company Name",
                    value: companyName,
                    onChanged: (value) {
                      companyName = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Save Button
            QButton(
              label: "Save Changes",
              onPressed: _saveProfile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Two-Factor Authentication
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.security, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Two-Factor Authentication",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Add an extra layer of security to your account",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: twoFactorEnabled,
                      onChanged: (value) {
                        twoFactorEnabled = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                if (twoFactorEnabled) ...[
                  Divider(),
                  Text(
                    "Two-factor authentication is enabled. You'll receive a code via SMS when signing in.",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                  QButton(
                    label: "Configure 2FA",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
          
          // Login Alerts
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_active, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Get notified of suspicious login attempts",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: loginAlertsEnabled,
                  onChanged: (value) {
                    loginAlertsEnabled = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Password Change
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Last changed 30 days ago",
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
                QButton(
                  label: "Change Password",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Account Deactivation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Danger Zone",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Once you delete your account, there is no going back. Please be certain.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Deactivate Account",
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to deactivate your account? This action cannot be undone.");
                    if (isConfirmed) {
                      // Handle deactivation
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Plan
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "CURRENT PLAN",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${currentPlan["name"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(currentPlan["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "/${currentPlan["billing"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "Plan Features:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...(currentPlan["features"] as List).map((feature) => Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${feature}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                )),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Storage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${currentPlan["storage"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Team Members",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${currentPlan["teamMembers"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "Next billing date: ${currentPlan["nextBilling"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Available Plans
          Text(
            "Available Plans",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...availablePlans.map((plan) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: plan["name"] == currentPlan["name"] 
                  ? primaryColor 
                  : disabledOutlineBorderColor,
              ),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(plan["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "/${plan["billing"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                ...(plan["features"] as List).take(3).map((feature) => Row(
                  children: [
                    Icon(Icons.check, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${feature}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${plan["storage"]} • ${plan["teamMembers"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    if (plan["name"] != currentPlan["name"])
                      QButton(
                        label: "Upgrade",
                        size: bs.sm,
                        onPressed: () {},
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Current",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )),
          
          // Billing History
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Billing History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All Invoices",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Regional Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Regional Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Timezone",
                  items: timezoneOptions,
                  value: selectedTimezone,
                  onChanged: (value, label) {
                    selectedTimezone = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Language",
                  items: languageOptions,
                  value: selectedLanguage,
                  onChanged: (value, label) {
                    selectedLanguage = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Date Format",
                  items: dateFormatOptions,
                  value: selectedDateFormat,
                  onChanged: (value, label) {
                    selectedDateFormat = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Export Data
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.download, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Export Data",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Download a copy of your project data, tasks, and activities",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Request Export",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Save Changes
          QButton(
            label: "Save Preferences",
            onPressed: _savePreferences,
          ),
        ],
      ),
    );
  }

  void _saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    
    ss("Profile updated successfully");
  }

  void _savePreferences() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    isLoading = false;
    setState(() {});
    
    ss("Preferences saved successfully");
  }
}
