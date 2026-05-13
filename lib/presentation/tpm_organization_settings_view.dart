import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmOrganizationSettingsView extends StatefulWidget {
  const TpmOrganizationSettingsView({super.key});

  @override
  State<TpmOrganizationSettingsView> createState() => _TpmOrganizationSettingsViewState();
}

class _TpmOrganizationSettingsViewState extends State<TpmOrganizationSettingsView> {
  String organizationName = "Acme Corporation";
  String organizationWebsite = "https://acme.com";
  String organizationDescription = "Leading technology solutions provider specializing in project management and team collaboration tools.";
  String organizationAddress = "123 Business Ave, Suite 100, New York, NY 10001";
  String organizationPhone = "+1 (555) 123-4567";
  String organizationLogo = "https://picsum.photos/100/100?random=logo";
  String timeZone = "America/New_York";
  String currency = "USD";
  String dateFormat = "MM/DD/YYYY";
  
  bool allowGuestAccess = true;
  bool requireApprovalForNewMembers = false;
  bool enablePublicProjects = true;
  bool allowExternalSharing = false;
  bool enableSSO = false;
  bool require2FA = false;
  bool enableAuditLogs = true;
  bool enableAPIAccess = true;
  
  String defaultUserRole = "Member";
  String maxProjectsPerUser = "50";
  String sessionTimeout = "30";
  
  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "Eastern Time (UTC-5)", "value": "America/New_York"},
    {"label": "Central Time (UTC-6)", "value": "America/Chicago"},
    {"label": "Mountain Time (UTC-7)", "value": "America/Denver"},
    {"label": "Pacific Time (UTC-8)", "value": "America/Los_Angeles"},
    {"label": "UTC", "value": "UTC"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Japanese Yen (JPY)", "value": "JPY"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];

  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
    {"label": "DD-MMM-YYYY", "value": "DD-MMM-YYYY"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Member", "value": "Member"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Admin", "value": "Admin"},
    {"label": "Guest", "value": "Guest"},
  ];

  List<Map<String, dynamic>> projectLimitOptions = [
    {"label": "10 projects", "value": "10"},
    {"label": "25 projects", "value": "25"},
    {"label": "50 projects", "value": "50"},
    {"label": "100 projects", "value": "100"},
    {"label": "Unlimited", "value": "unlimited"},
  ];

  List<Map<String, dynamic>> sessionTimeoutOptions = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "2 hours", "value": "120"},
    {"label": "8 hours", "value": "480"},
    {"label": "Never", "value": "0"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Settings"),
        actions: [
          QButton(
            label: "Save Changes",
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
            spacing: spMd,
            children: [
              _buildOrganizationInfoCard(),
              _buildLocalizationCard(),
              _buildAccessControlCard(),
              _buildSecurityCard(),
              _buildDefaultsCard(),
              _buildDangerZoneCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizationInfoCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Organization Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage(organizationLogo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Organization Logo",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Upload a square image (recommended: 200x200px)",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    QButton(
                      label: "Change Logo",
                      size: bs.sm,
                      onPressed: () {
                        si("Logo upload functionality would be implemented here");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          QTextField(
            label: "Organization Name",
            value: organizationName,
            validator: Validator.required,
            onChanged: (value) {
              organizationName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website URL",
            value: organizationWebsite,
            hint: "https://yourcompany.com",
            onChanged: (value) {
              organizationWebsite = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: organizationDescription,
            hint: "Brief description of your organization",
            onChanged: (value) {
              organizationDescription = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Address",
            value: organizationAddress,
            hint: "Physical address of your organization",
            onChanged: (value) {
              organizationAddress = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: organizationPhone,
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              organizationPhone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocalizationCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Localization & Formatting",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Time Zone",
            items: timezoneOptions,
            value: timeZone,
            onChanged: (value, label) {
              timeZone = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Default Currency",
                  items: currencyOptions,
                  value: currency,
                  onChanged: (value, label) {
                    currency = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Date Format",
                  items: dateFormatOptions,
                  value: dateFormat,
                  onChanged: (value, label) {
                    dateFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccessControlCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Access Control",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Allow guest access to public projects",
                "value": true,
                "checked": allowGuestAccess,
              }
            ],
            value: [if (allowGuestAccess) {"label": "Allow guest access to public projects", "value": true, "checked": true}],
            onChanged: (values, ids) {
              allowGuestAccess = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Require approval for new team members",
                "value": true,
                "checked": requireApprovalForNewMembers,
              }
            ],
            value: [if (requireApprovalForNewMembers) {"label": "Require approval for new team members", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requireApprovalForNewMembers = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable public projects",
                "value": true,
                "checked": enablePublicProjects,
              }
            ],
            value: [if (enablePublicProjects) {"label": "Enable public projects", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enablePublicProjects = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Allow external sharing",
                "value": true,
                "checked": allowExternalSharing,
              }
            ],
            value: [if (allowExternalSharing) {"label": "Allow external sharing", "value": true, "checked": true}],
            onChanged: (values, ids) {
              allowExternalSharing = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Security Settings",
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
                "label": "Enable Single Sign-On (SSO)",
                "value": true,
                "checked": enableSSO,
              }
            ],
            value: [if (enableSSO) {"label": "Enable Single Sign-On (SSO)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableSSO = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (enableSSO) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "SSO configuration requires additional setup. Contact support for assistance.",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Require two-factor authentication for all users",
                "value": true,
                "checked": require2FA,
              }
            ],
            value: [if (require2FA) {"label": "Require two-factor authentication for all users", "value": true, "checked": true}],
            onChanged: (values, ids) {
              require2FA = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable audit logs",
                "value": true,
                "checked": enableAuditLogs,
              }
            ],
            value: [if (enableAuditLogs) {"label": "Enable audit logs", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableAuditLogs = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable API access",
                "value": true,
                "checked": enableAPIAccess,
              }
            ],
            value: [if (enableAPIAccess) {"label": "Enable API access", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableAPIAccess = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Session Timeout",
            items: sessionTimeoutOptions,
            value: sessionTimeout,
            onChanged: (value, label) {
              sessionTimeout = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Default Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Default Role for New Users",
                  items: roleOptions,
                  value: defaultUserRole,
                  onChanged: (value, label) {
                    defaultUserRole = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Max Projects per User",
                  items: projectLimitOptions,
                  value: maxProjectsPerUser,
                  onChanged: (value, label) {
                    maxProjectsPerUser = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZoneCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: dangerColor,
                size: 20,
              ),
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
            "These actions are irreversible. Please proceed with caution.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Divider(color: dangerColor.withAlpha(30)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Export Organization Data",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Download a complete backup of all organization data",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Export Data",
                size: bs.sm,
                onPressed: () {
                  si("Data export started. You'll receive an email when ready.");
                },
              ),
            ],
          ),
          Divider(color: dangerColor.withAlpha(30)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delete Organization",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Permanently delete the organization and all associated data",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Delete Organization",
                size: bs.sm,
                onPressed: () async {
                  bool isConfirmed = await confirm("This will permanently delete your organization and all data. This action cannot be undone. Are you absolutely sure?");
                  if (isConfirmed) {
                    se("Organization deletion cancelled for safety");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    if (formKey.currentState!.validate()) {
      ss("Organization settings saved successfully");
    }
  }
}
