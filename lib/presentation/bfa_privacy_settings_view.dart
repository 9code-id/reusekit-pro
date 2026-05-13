import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPrivacySettingsView extends StatefulWidget {
  const BfaPrivacySettingsView({super.key});

  @override
  State<BfaPrivacySettingsView> createState() => _BfaPrivacySettingsViewState();
}

class _BfaPrivacySettingsViewState extends State<BfaPrivacySettingsView> {
  bool dataCollectionEnabled = true;
  bool analyticsEnabled = false;
  bool marketingCommunications = true;
  bool thirdPartySharing = false;
  bool locationTracking = true;
  bool biometricDataStorage = true;
  bool transactionHistory = true;
  bool personalizedOffers = true;
  
  String dataRetentionPeriod = "2_years";
  String communicationPreference = "essential_only";

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 Year", "value": "1_year"},
    {"label": "2 Years", "value": "2_years"},
    {"label": "5 Years", "value": "5_years"},
    {"label": "Maximum Legal Period", "value": "max_legal"},
  ];

  List<Map<String, dynamic>> communicationOptions = [
    {"label": "Essential Only", "value": "essential_only"},
    {"label": "Account Updates", "value": "account_updates"},
    {"label": "Marketing & Promotions", "value": "marketing_promotions"},
    {"label": "All Communications", "value": "all_communications"},
  ];

  List<Map<String, dynamic>> dataCategories = [
    {
      "title": "Personal Information",
      "description": "Name, email, phone number, address",
      "collected": true,
      "required": true,
      "icon": Icons.person,
    },
    {
      "title": "Financial Data",
      "description": "Account balances, transaction history, payment methods",
      "collected": true,
      "required": true,
      "icon": Icons.account_balance,
    },
    {
      "title": "Device Information",
      "description": "Device model, OS version, app usage patterns",
      "collected": true,
      "required": false,
      "icon": Icons.phone_android,
    },
    {
      "title": "Location Data",
      "description": "GPS location for ATM finder and fraud prevention",
      "collected": true,
      "required": false,
      "icon": Icons.location_on,
    },
    {
      "title": "Biometric Data",
      "description": "Fingerprint and face recognition data",
      "collected": true,
      "required": false,
      "icon": Icons.fingerprint,
    },
    {
      "title": "Usage Analytics",
      "description": "App usage patterns and feature interactions",
      "collected": false,
      "required": false,
      "icon": Icons.analytics,
    },
  ];

  List<Map<String, dynamic>> thirdPartyPartners = [
    {
      "name": "Credit Reporting Agencies",
      "purpose": "Credit score monitoring and reporting",
      "dataShared": "Financial history, payment behavior",
      "optOut": false,
    },
    {
      "name": "Anti-Fraud Services",
      "purpose": "Transaction monitoring and fraud prevention",
      "dataShared": "Transaction patterns, device information",
      "optOut": false,
    },
    {
      "name": "Marketing Partners",
      "purpose": "Personalized offers and promotions",
      "dataShared": "Spending patterns, preferences",
      "optOut": true,
    },
    {
      "name": "Analytics Providers",
      "purpose": "App improvement and user experience analysis",
      "dataShared": "Usage patterns, app interactions",
      "optOut": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadPrivacyReport();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            _buildPrivacyOverview(),
            _buildDataCollection(),
            _buildCommunicationPreferences(),
            _buildDataRetention(),
            _buildThirdPartySharing(),
            _buildPrivacyActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: primaryColor, size: 28),
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
          SizedBox(height: spSm),
          Text(
            "We're committed to protecting your personal and financial information. Review and customize your privacy settings below.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Privacy Policy",
                  size: bs.sm,
                  icon: Icons.description,
                  onPressed: () {
                    _viewPrivacyPolicy();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Data Rights",
                  size: bs.sm,
                  icon: Icons.gavel,
                  onPressed: () {
                    _viewDataRights();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataCollection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Data Collection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...dataCategories.map((category) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        category["icon"],
                        color: category["required"] ? primaryColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${category["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (category["required"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "REQUIRED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${category["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!category["required"])
                        Switch(
                          value: category["collected"],
                          onChanged: (value) {
                            category["collected"] = value;
                            setState(() {});
                          },
                        )
                      else
                        Icon(Icons.lock, color: disabledBoldColor, size: 20),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCommunicationPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.notifications, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Communication Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Communication Level",
            items: communicationOptions,
            value: communicationPreference,
            onChanged: (value, label) {
              communicationPreference = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Icon(Icons.email, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Marketing Communications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Receive promotional emails and offers",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: marketingCommunications,
                onChanged: (value) {
                  marketingCommunications = value;
                  setState(() {});
                },
              ),
            ],
          ),

          Divider(color: disabledColor),

          Row(
            children: [
              Icon(Icons.campaign, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personalized Offers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Get offers based on your spending patterns",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: personalizedOffers,
                onChanged: (value) {
                  personalizedOffers = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataRetention() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Data Retention",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Text(
            "Choose how long we keep your data after account closure. Some data may be retained longer for legal compliance.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),

          QDropdownField(
            label: "Data Retention Period",
            items: retentionOptions,
            value: dataRetentionPeriod,
            onChanged: (value, label) {
              dataRetentionPeriod = value;
              setState(() {});
            },
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
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Transaction records may be kept longer for regulatory compliance as required by banking laws.",
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

  Widget _buildThirdPartySharing() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.share, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Third-Party Data Sharing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Text(
            "We work with trusted partners to provide you with better services. You can control some of these data sharing arrangements.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),

          ...thirdPartyPartners.map((partner) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${partner["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (!partner["optOut"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "REQUIRED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${partner["purpose"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Data shared: ${partner["dataShared"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (partner["optOut"])
                        Switch(
                          value: thirdPartySharing,
                          onChanged: (value) {
                            thirdPartySharing = value;
                            setState(() {});
                          },
                        )
                      else
                        Icon(Icons.lock, color: disabledBoldColor, size: 20),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPrivacyActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Privacy Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Download Data",
                  size: bs.md,
                  icon: Icons.download,
                  onPressed: () {
                    _downloadUserData();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Data Report",
                  size: bs.md,
                  icon: Icons.analytics,
                  onPressed: () {
                    _downloadPrivacyReport();
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Request Deletion",
                  size: bs.md,
                  icon: Icons.delete_forever,
                  onPressed: () {
                    _requestDataDeletion();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Privacy Checkup",
                  size: bs.md,
                  icon: Icons.security,
                  onPressed: () {
                    _startPrivacyCheckup();
                  },
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Some privacy settings may affect app functionality. Changes will take effect within 24 hours.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
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

  void _viewPrivacyPolicy() {
    // Navigate to privacy policy view
  }

  void _viewDataRights() {
    // Navigate to data rights information
  }

  void _downloadUserData() {
    showLoading();
    
    // Simulate data preparation
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Your data export request has been submitted. You'll receive a download link via email within 48 hours.");
    });
  }

  void _downloadPrivacyReport() {
    showLoading();
    
    // Simulate report generation
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Privacy report generated successfully. Check your downloads.");
    });
  }

  void _requestDataDeletion() async {
    bool isConfirmed = await confirm("Request deletion of all your data? This action cannot be undone and will close your account permanently.");
    if (isConfirmed) {
      showLoading();
      
      // Simulate deletion request
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Data deletion request submitted. You'll receive confirmation via email.");
      });
    }
  }

  void _startPrivacyCheckup() {
    // Navigate to privacy checkup wizard
  }
}
