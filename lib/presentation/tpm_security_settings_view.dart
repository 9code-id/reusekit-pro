import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmSecuritySettingsView extends StatefulWidget {
  const TpmSecuritySettingsView({super.key});

  @override
  State<TpmSecuritySettingsView> createState() => _TpmSecuritySettingsViewState();
}

class _TpmSecuritySettingsViewState extends State<TpmSecuritySettingsView> {
  bool twoFactorEnabled = true;
  bool emailNotifications = true;
  bool smsAlerts = false;
  bool sessionTimeout = true;
  bool deviceTracking = true;
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  String sessionTimeoutValue = "30";
  
  List<Map<String, dynamic>> sessionTimeoutOptions = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "2 hours", "value": "120"},
    {"label": "Never", "value": "0"},
  ];

  List<Map<String, dynamic>> trustedDevices = [
    {
      "id": 1,
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "lastAccess": "2025-06-19 10:30:00",
      "status": "Active",
    },
    {
      "id": 2,
      "device": "MacBook Air M2",
      "location": "New York, NY",
      "lastAccess": "2025-06-19 09:15:00",
      "status": "Active",
    },
    {
      "id": 3,
      "device": "Chrome Browser",
      "location": "Boston, MA",
      "lastAccess": "2025-06-18 16:45:00",
      "status": "Inactive",
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPasswordSection(),
            _buildTwoFactorSection(),
            _buildSessionSection(),
            _buildTrustedDevicesSection(),
            _buildPrivacySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Change Password",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QTextField(
              label: "Current Password",
              value: currentPassword,
              obscureText: true,
              validator: Validator.required,
              onChanged: (value) {
                currentPassword = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "New Password",
              value: newPassword,
              obscureText: true,
              validator: Validator.required,
              hint: "Minimum 8 characters with special characters",
              onChanged: (value) {
                newPassword = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Confirm New Password",
              value: confirmPassword,
              obscureText: true,
              validator: Validator.required,
              onChanged: (value) {
                confirmPassword = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Update Password",
                size: bs.sm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (newPassword == confirmPassword) {
                      ss("Password updated successfully");
                    } else {
                      se("Passwords do not match");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTwoFactorSection() {
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
            "Two-Factor Authentication",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Two-Factor Authentication",
                "value": true,
                "checked": twoFactorEnabled,
              }
            ],
            value: [if (twoFactorEnabled) {"label": "Enable Two-Factor Authentication", "value": true, "checked": true}],
            onChanged: (values, ids) {
              twoFactorEnabled = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (twoFactorEnabled) ...[
            QSwitch(
              items: [
                {
                  "label": "Email notifications for login attempts",
                  "value": true,
                  "checked": emailNotifications,
                }
              ],
              value: [if (emailNotifications) {"label": "Email notifications for login attempts", "value": true, "checked": true}],
              onChanged: (values, ids) {
                emailNotifications = values.isNotEmpty;
                setState(() {});
              },
            ),
            QSwitch(
              items: [
                {
                  "label": "SMS alerts for suspicious activity",
                  "value": true,
                  "checked": smsAlerts,
                }
              ],
              value: [if (smsAlerts) {"label": "SMS alerts for suspicious activity", "value": true, "checked": true}],
              onChanged: (values, ids) {
                smsAlerts = values.isNotEmpty;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Configure 2FA",
                size: bs.sm,
                onPressed: () {
                  si("Redirecting to 2FA setup");
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSessionSection() {
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
            "Session Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-logout on inactivity",
                "value": true,
                "checked": sessionTimeout,
              }
            ],
            value: [if (sessionTimeout) {"label": "Auto-logout on inactivity", "value": true, "checked": true}],
            onChanged: (values, ids) {
              sessionTimeout = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (sessionTimeout) ...[
            QDropdownField(
              label: "Session Timeout",
              items: sessionTimeoutOptions,
              value: sessionTimeoutValue,
              onChanged: (value, label) {
                sessionTimeoutValue = value;
                setState(() {});
              },
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Track device locations",
                "value": true,
                "checked": deviceTracking,
              }
            ],
            value: [if (deviceTracking) {"label": "Track device locations", "value": true, "checked": true}],
            onChanged: (values, ids) {
              deviceTracking = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Terminate All Sessions",
              size: bs.sm,
              onPressed: () async {
                bool isConfirmed = await confirm("This will log you out of all devices. Continue?");
                if (isConfirmed) {
                  ss("All sessions terminated successfully");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedDevicesSection() {
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
              Expanded(
                child: Text(
                  "Trusted Devices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  si("Refreshing device list");
                },
              ),
            ],
          ),
          ...trustedDevices.map((device) => _buildDeviceCard(device)),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                Icons.devices,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${device["device"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${device["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: device["status"] == "Active" ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${device["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Last access: ${DateTime.parse(device["lastAccess"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool isConfirmed = await confirm("Remove this device from trusted list?");
                  if (isConfirmed) {
                    trustedDevices.removeWhere((d) => d["id"] == device["id"]);
                    setState(() {});
                    ss("Device removed successfully");
                  }
                },
                child: Text(
                  "Remove",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
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
            "Privacy & Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Download Personal Data",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Export all your data in JSON format",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Export",
                size: bs.sm,
                onPressed: () {
                  si("Data export started. You'll receive an email when ready.");
                },
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Permanently delete your account and all data",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Delete",
                size: bs.sm,
                onPressed: () async {
                  bool isConfirmed = await confirm("This action cannot be undone. Delete your account permanently?");
                  if (isConfirmed) {
                    se("Account deletion cancelled for safety");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
