import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact10View extends StatefulWidget {
  @override
  State<GrlContact10View> createState() => _GrlContact10ViewState();
}

class _GrlContact10ViewState extends State<GrlContact10View> {
  int selectedTab = 0;
  String selectedPrivacy = "public";
  bool allowPhoneAccess = true;
  bool allowEmailAccess = true;
  bool allowLocationAccess = false;
  bool syncContacts = true;
  bool backupContacts = true;
  bool showOnlineStatus = true;
  bool allowContactRequests = true;
  bool enableNotifications = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  String dataRetention = "1_year";
  String exportFormat = "vcf";
  bool enableTwoFactor = false;
  
  List<Map<String, dynamic>> blockedContacts = [
    {
      "id": 1,
      "name": "Spam User",
      "email": "spam@fake.com",
      "phone": "+1 (555) 000-0000",
      "blockedDate": DateTime.now().subtract(Duration(days: 5)),
      "reason": "Spam",
    },
    {
      "id": 2,
      "name": "John Unwanted",
      "email": "john.unwanted@email.com",
      "phone": "+1 (555) 111-1111",
      "blockedDate": DateTime.now().subtract(Duration(days: 12)),
      "reason": "Unwanted contact",
    },
  ];

  List<Map<String, dynamic>> sharePermissions = [
    {
      "app": "WhatsApp",
      "icon": Icons.message,
      "hasAccess": true,
      "permissions": ["read", "sync"],
      "lastAccess": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "app": "Gmail",
      "icon": Icons.email,
      "hasAccess": true,
      "permissions": ["read"],
      "lastAccess": DateTime.now().subtract(Duration(hours: 6)),
    },
    {
      "app": "LinkedIn",
      "icon": Icons.business,
      "hasAccess": false,
      "permissions": [],
      "lastAccess": null,
    },
    {
      "app": "Telegram",
      "icon": Icons.send,
      "hasAccess": true,
      "permissions": ["read", "sync"],
      "lastAccess": DateTime.now().subtract(Duration(days: 1)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Security"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelp(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Privacy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Security",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Sharing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: selectedTab == 0 ? _buildPrivacyTab() : 
                     selectedTab == 1 ? _buildSecurityTab() : 
                     _buildSharingTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Visibility
        _buildSettingsCard(
          "Profile Visibility",
          "Control who can see your contact information",
          Icons.visibility,
          [
            _buildRadioOption(
              "Public",
              "Anyone can find and contact you",
              "public",
              selectedPrivacy,
              (value) {
                selectedPrivacy = value!;
                setState(() {});
              },
            ),
            _buildRadioOption(
              "Friends Only",
              "Only your contacts can see your profile",
              "friends",
              selectedPrivacy,
              (value) {
                selectedPrivacy = value!;
                setState(() {});
              },
            ),
            _buildRadioOption(
              "Private",
              "Your profile is completely private",
              "private",
              selectedPrivacy,
              (value) {
                selectedPrivacy = value!;
                setState(() {});
              },
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Contact Information Access
        _buildSettingsCard(
          "Contact Information Access",
          "Choose what information others can access",
          Icons.contact_phone,
          [
            _buildSwitchOption(
              "Phone Number",
              "Allow others to see your phone number",
              allowPhoneAccess,
              (value) {
                allowPhoneAccess = value;
                setState(() {});
              },
            ),
            _buildSwitchOption(
              "Email Address",
              "Allow others to see your email address",
              allowEmailAccess,
              (value) {
                allowEmailAccess = value;
                setState(() {});
              },
            ),
            _buildSwitchOption(
              "Location",
              "Allow others to see your location",
              allowLocationAccess,
              (value) {
                allowLocationAccess = value;
                setState(() {});
              },
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Data Management
        _buildSettingsCard(
          "Data Management",
          "Control how your data is stored and synchronized",
          Icons.storage,
          [
            _buildSwitchOption(
              "Sync Contacts",
              "Automatically sync contacts across devices",
              syncContacts,
              (value) {
                syncContacts = value;
                setState(() {});
              },
            ),
            _buildSwitchOption(
              "Backup Contacts",
              "Automatically backup contacts to cloud",
              backupContacts,
              (value) {
                backupContacts = value;
                setState(() {});
              },
            ),
            _buildDropdownOption(
              "Data Retention",
              "How long to keep deleted contacts",
              dataRetention,
              [
                {"label": "30 Days", "value": "30_days"},
                {"label": "3 Months", "value": "3_months"},
                {"label": "1 Year", "value": "1_year"},
                {"label": "Forever", "value": "forever"},
              ],
              (value) {
                dataRetention = value;
                setState(() {});
              },
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Online Status
        _buildSettingsCard(
          "Online Status",
          "Control your online presence visibility",
          Icons.circle,
          [
            _buildSwitchOption(
              "Show Online Status",
              "Let others see when you're online",
              showOnlineStatus,
              (value) {
                showOnlineStatus = value;
                setState(() {});
              },
            ),
            _buildSwitchOption(
              "Allow Contact Requests",
              "Allow others to send contact requests",
              allowContactRequests,
              (value) {
                allowContactRequests = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Authentication
        _buildSettingsCard(
          "Authentication",
          "Secure your account with additional security measures",
          Icons.security,
          [
            _buildSwitchOption(
              "Two-Factor Authentication",
              "Add an extra layer of security to your account",
              enableTwoFactor,
              (value) {
                enableTwoFactor = value;
                setState(() {});
                if (value) {
                  _setupTwoFactor();
                }
              },
            ),
            _buildActionOption(
              "Change Password",
              "Update your account password",
              Icons.lock,
              () => _changePassword(),
            ),
            _buildActionOption(
              "Login History",
              "View recent login activities",
              Icons.history,
              () => _showLoginHistory(),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Blocked Contacts
        _buildSettingsCard(
          "Blocked Contacts",
          "Manage contacts you've blocked",
          Icons.block,
          [
            ...blockedContacts.map((contact) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${contact["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${contact["email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Blocked ${_formatDate(contact["blockedDate"])} • ${contact["reason"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Unblock",
                    size: bs.sm,
                    onPressed: () => _unblockContact(contact),
                  ),
                ],
              ),
            )).toList(),
            _buildActionOption(
              "Add Blocked Contact",
              "Block a contact manually",
              Icons.person_add_disabled,
              () => _addBlockedContact(),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Data Export
        _buildSettingsCard(
          "Data Export",
          "Download your contact data",
          Icons.download,
          [
            _buildDropdownOption(
              "Export Format",
              "Choose the format for exported data",
              exportFormat,
              [
                {"label": "vCard (.vcf)", "value": "vcf"},
                {"label": "CSV (.csv)", "value": "csv"},
                {"label": "JSON (.json)", "value": "json"},
                {"label": "Excel (.xlsx)", "value": "xlsx"},
              ],
              (value) {
                exportFormat = value;
                setState(() {});
              },
            ),
            _buildActionOption(
              "Download My Data",
              "Export all your contact information",
              Icons.file_download,
              () => _downloadData(),
            ),
            _buildActionOption(
              "Delete All Data",
              "Permanently delete all your data",
              Icons.delete_forever,
              () => _deleteAllData(),
              isDestructive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSharingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Permissions
        _buildSettingsCard(
          "App Permissions",
          "Manage which apps can access your contacts",
          Icons.apps,
          sharePermissions.map((app) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: app["hasAccess"] ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    app["icon"],
                    color: app["hasAccess"] ? successColor : disabledColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${app["app"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (app["hasAccess"])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Permissions: ${(app["permissions"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (app["lastAccess"] != null)
                              Text(
                                "Last access: ${_formatLastAccess(app["lastAccess"])}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        )
                      else
                        Text(
                          "No access granted",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    QButton(
                      label: app["hasAccess"] ? "Revoke" : "Grant",
                      size: bs.sm,
                      onPressed: () => _toggleAppAccess(app["app"]),
                    ),
                    if (app["hasAccess"])
                      GestureDetector(
                        onTap: () => _configureAppPermissions(app["app"]),
                        child: Container(
                          margin: EdgeInsets.only(top: spSm),
                          child: Text(
                            "Configure",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ),

        SizedBox(height: spMd),

        // Notifications
        _buildSettingsCard(
          "Notifications",
          "Control how you receive contact-related notifications",
          Icons.notifications,
          [
            _buildSwitchOption(
              "Enable Notifications",
              "Receive notifications for contact activities",
              enableNotifications,
              (value) {
                enableNotifications = value;
                setState(() {});
              },
            ),
            if (enableNotifications) ...[
              _buildSwitchOption(
                "Email Notifications",
                "Receive notifications via email",
                emailNotifications,
                (value) {
                  emailNotifications = value;
                  setState(() {});
                },
              ),
              _buildSwitchOption(
                "Push Notifications",
                "Receive push notifications on your device",
                pushNotifications,
                (value) {
                  pushNotifications = value;
                  setState(() {});
                },
              ),
              _buildSwitchOption(
                "SMS Notifications",
                "Receive notifications via SMS",
                smsNotifications,
                (value) {
                  smsNotifications = value;
                  setState(() {});
                },
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsCard(String title, String description, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildRadioOption(String title, String description, String value, String groupValue, Function(String?) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownOption(String title, String description, String value, List<Map<String, dynamic>> items, Function(String) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: title,
            items: items,
            value: value,
            onChanged: (selectedValue, label) {
              onChanged(selectedValue);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionOption(String title, String description, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isDestructive ? dangerColor.withAlpha(10) : Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isDestructive ? dangerColor.withAlpha(40) : Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? dangerColor : null,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: disabledBoldColor,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return date.dMMMy;
  }

  String _formatLastAccess(DateTime date) {
    Duration diff = DateTime.now().difference(date);
    if (diff.inHours < 1) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inDays < 1) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }

  void _setupTwoFactor() {
    ss("Setting up two-factor authentication...");
  }

  void _changePassword() {
    // Navigate to change password
  }

  void _showLoginHistory() {
    // Show login history
  }

  void _unblockContact(Map<String, dynamic> contact) {
    blockedContacts.removeWhere((c) => c["id"] == contact["id"]);
    setState(() {});
    ss("Contact unblocked successfully");
  }

  void _addBlockedContact() {
    // Navigate to add blocked contact
  }

  void _downloadData() {
    ss("Generating export file...");
  }

  void _deleteAllData() async {
    bool isConfirmed = await confirm("Are you sure you want to delete all your data? This action cannot be undone.");
    if (isConfirmed) {
      ss("Deleting all data...");
    }
  }

  void _toggleAppAccess(String appName) {
    int index = sharePermissions.indexWhere((app) => app["app"] == appName);
    if (index != -1) {
      sharePermissions[index]["hasAccess"] = !sharePermissions[index]["hasAccess"];
      if (!sharePermissions[index]["hasAccess"]) {
        sharePermissions[index]["permissions"] = [];
        sharePermissions[index]["lastAccess"] = null;
      }
      setState(() {});
    }
  }

  void _configureAppPermissions(String appName) {
    // Navigate to app permission configuration
  }

  void _showHelp() {
    // Show privacy and security help
  }
}
