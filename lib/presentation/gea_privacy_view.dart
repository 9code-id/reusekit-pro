import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPrivacyView extends StatefulWidget {
  const GeaPrivacyView({Key? key}) : super(key: key);

  @override
  State<GeaPrivacyView> createState() => _GeaPrivacyViewState();
}

class _GeaPrivacyViewState extends State<GeaPrivacyView> {
  bool allowPersonalization = true;
  bool allowAnalytics = false;
  bool allowMarketing = false;
  bool allowLocationTracking = true;
  bool allowDataSharing = false;
  bool allowCookies = true;

  List<Map<String, dynamic>> privacyPolicies = [
    {
      "title": "Data Collection Policy",
      "lastUpdated": "2025-01-15",
      "description": "How we collect and use your personal information",
      "category": "Data Protection"
    },
    {
      "title": "Cookie Policy",
      "lastUpdated": "2025-01-10",
      "description": "Information about cookies and tracking technologies",
      "category": "Cookies"
    },
    {
      "title": "Third-Party Services",
      "lastUpdated": "2025-01-05",
      "description": "How third-party services access your data",
      "category": "Data Sharing"
    },
  ];

  List<Map<String, dynamic>> dataCategories = [
    {
      "category": "Personal Information",
      "items": ["Name", "Email", "Phone Number", "Address"],
      "purpose": "Account management and communication",
      "retention": "As long as account is active"
    },
    {
      "category": "Usage Data",
      "items": ["App interactions", "Feature usage", "Session duration"],
      "purpose": "Improve user experience and app performance",
      "retention": "2 years from collection"
    },
    {
      "category": "Device Information",
      "items": ["Device type", "OS version", "App version"],
      "purpose": "Technical support and compatibility",
      "retention": "1 year from collection"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
        actions: [
          QButton(
            icon: Icons.info_outline,
            size: bs.sm,
            onPressed: () {
              si("Privacy information updated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPrivacyOverview(),
            _buildPrivacyControls(),
            _buildDataCategories(),
            _buildPrivacyPolicies(),
            _buildDataDeletion(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Privacy Control Center",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Manage how your data is collected, used, and shared. Your privacy matters to us.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: successColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Your data is encrypted and secure",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyControls() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Privacy Controls",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPrivacySwitch(
            "Personalization",
            "Customize your experience based on preferences",
            Icons.tune,
            allowPersonalization,
            (value) => setState(() => allowPersonalization = value),
          ),
          _buildPrivacySwitch(
            "Analytics",
            "Help us improve the app with usage analytics",
            Icons.analytics,
            allowAnalytics,
            (value) => setState(() => allowAnalytics = value),
          ),
          _buildPrivacySwitch(
            "Marketing Communications",
            "Receive promotional emails and notifications",
            Icons.campaign,
            allowMarketing,
            (value) => setState(() => allowMarketing = value),
          ),
          _buildPrivacySwitch(
            "Location Tracking",
            "Enable location-based features and services",
            Icons.location_on,
            allowLocationTracking,
            (value) => setState(() => allowLocationTracking = value),
          ),
          _buildPrivacySwitch(
            "Data Sharing",
            "Share anonymized data with research partners",
            Icons.share,
            allowDataSharing,
            (value) => setState(() => allowDataSharing = value),
          ),
          _buildPrivacySwitch(
            "Cookies",
            "Allow cookies for better browsing experience",
            Icons.cookie,
            allowCookies,
            (value) => setState(() => allowCookies = value),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySwitch(
    String title,
    String description,
    IconData icon,
    bool value,
    Function(bool) onChanged, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: value ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: value ? primaryColor : disabledBoldColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDataCategories() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Data We Collect",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...dataCategories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            final isLast = index == dataCategories.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (category["items"] as List).map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$item",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text(
                    "Purpose: ${category["purpose"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Retention: ${category["retention"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicies() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Privacy Policies",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...privacyPolicies.asMap().entries.map((entry) {
            final index = entry.key;
            final policy = entry.value;
            final isLast = index == privacyPolicies.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.policy,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${policy["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${policy["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${policy["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Updated: ${policy["lastUpdated"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      si("Opening ${policy["title"]}");
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDataDeletion() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Data Deletion",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Text(
            "Request complete deletion of your personal data. This action cannot be undone and will permanently remove your account and all associated data.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Request Data Export",
                  size: bs.sm,
                  onPressed: () {
                    si("Data export request submitted");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Delete My Data",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to permanently delete all your data? This action cannot be undone.");
                      if (isConfirmed) {
                        ss("Data deletion request submitted");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
