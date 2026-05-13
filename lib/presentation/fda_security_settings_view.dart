import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSecuritySettingsView extends StatefulWidget {
  const FdaSecuritySettingsView({super.key});

  @override
  State<FdaSecuritySettingsView> createState() => _FdaSecuritySettingsViewState();
}

class _FdaSecuritySettingsViewState extends State<FdaSecuritySettingsView> {
  // Password & Authentication
  bool enableTwoFactor = true;
  bool enableBiometric = false;
  bool enablePinLock = true;
  String sessionTimeout = "30";
  bool enableAutoLogout = true;
  
  // Account Security
  bool enableLoginAlerts = true;
  bool enablePasswordExpiry = false;
  String passwordExpiryDays = "90";
  bool enableAccountLockout = true;
  String maxLoginAttempts = "5";
  
  // Privacy Settings
  bool shareLocationData = false;
  bool shareAnalyticsData = true;
  bool enableCookies = true;
  bool enablePersonalization = true;
  bool allowMarketingEmails = false;
  
  // Payment Security
  bool savePaymentMethods = true;
  bool enablePaymentNotifications = true;
  bool requireCVVForSavedCards = true;
  bool enablePaymentLimits = false;
  String dailyPaymentLimit = "500";
  
  // Device & App Security
  bool enableDeviceVerification = true;
  bool allowMultipleDevices = true;
  String maxDevices = "3";
  bool enableAppLock = false;
  bool enableScreenshotBlocking = false;
  
  // Data Backup
  bool enableAutoBackup = true;
  String backupFrequency = "weekly";
  bool encryptBackup = true;
  bool includePaymentData = false;

  DateTime lastPasswordChange = DateTime.now().subtract(Duration(days: 45));
  DateTime lastSecurityReview = DateTime.now().subtract(Duration(days: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: _runSecurityScan,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSecurityOverviewCard(),
            _buildPasswordAuthenticationSection(),
            _buildAccountSecuritySection(),
            _buildPrivacySettingsSection(),
            _buildPaymentSecuritySection(),
            _buildDeviceAppSecuritySection(),
            _buildDataBackupSection(),
            _buildSecurityActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityOverviewCard() {
    int securityScore = _calculateSecurityScore();
    Color scoreColor = _getSecurityScoreColor(securityScore);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scoreColor, scoreColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Security Score",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "$securityScore/100",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  _getScoreLevel(securityScore),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildSecurityMetric("Last password change", "${lastPasswordChange.dMMMy}"),
                _buildSecurityMetric("Last security review", "${lastSecurityReview.dMMMy}"),
                _buildSecurityMetric("Active sessions", "2 devices"),
                _buildSecurityMetric("Account status", "Verified"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityMetric(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordAuthenticationSection() {
    return _buildSection(
      "Password & Authentication",
      Icons.password,
      [
        _buildSettingRow(
          "Two-Factor Authentication",
          "Add extra security to your account",
          enableTwoFactor,
          (value) {
            enableTwoFactor = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Biometric Login",
          "Use fingerprint or face unlock",
          enableBiometric,
          (value) {
            enableBiometric = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "PIN Lock",
          "Require PIN for app access",
          enablePinLock,
          (value) {
            enablePinLock = value;
            setState(() {});
          },
        ),
        _buildDropdownSetting(
          "Session Timeout",
          sessionTimeout,
          [
            {"label": "15 minutes", "value": "15"},
            {"label": "30 minutes", "value": "30"},
            {"label": "1 hour", "value": "60"},
            {"label": "Never", "value": "never"},
          ],
          (value) {
            sessionTimeout = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Auto-logout on inactivity",
          "Automatically log out after timeout",
          enableAutoLogout,
          (value) {
            enableAutoLogout = value;
            setState(() {});
          },
        ),
        _buildActionButton("Change Password", Icons.edit, _changePassword),
        _buildActionButton("Setup 2FA", Icons.security, _setup2FA),
      ],
    );
  }

  Widget _buildAccountSecuritySection() {
    return _buildSection(
      "Account Security",
      Icons.account_circle,
      [
        _buildSettingRow(
          "Login Alerts",
          "Get notified of new device logins",
          enableLoginAlerts,
          (value) {
            enableLoginAlerts = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Password Expiry",
          "Require password change periodically",
          enablePasswordExpiry,
          (value) {
            enablePasswordExpiry = value;
            setState(() {});
          },
        ),
        if (enablePasswordExpiry)
          _buildTextFieldSetting(
            "Password expires every (days)",
            passwordExpiryDays,
            (value) {
              passwordExpiryDays = value;
              setState(() {});
            },
          ),
        _buildSettingRow(
          "Account Lockout",
          "Lock account after failed attempts",
          enableAccountLockout,
          (value) {
            enableAccountLockout = value;
            setState(() {});
          },
        ),
        if (enableAccountLockout)
          _buildTextFieldSetting(
            "Max login attempts",
            maxLoginAttempts,
            (value) {
              maxLoginAttempts = value;
              setState(() {});
            },
          ),
        _buildActionButton("View Login History", Icons.history, _viewLoginHistory),
        _buildActionButton("Revoke All Sessions", Icons.logout, _revokeAllSessions),
      ],
    );
  }

  Widget _buildPrivacySettingsSection() {
    return _buildSection(
      "Privacy Settings",
      Icons.privacy_tip,
      [
        _buildSettingRow(
          "Share Location Data",
          "Allow location-based features",
          shareLocationData,
          (value) {
            shareLocationData = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Analytics Data",
          "Help improve app experience",
          shareAnalyticsData,
          (value) {
            shareAnalyticsData = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Cookies",
          "Allow cookies for better experience",
          enableCookies,
          (value) {
            enableCookies = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Personalization",
          "Personalize recommendations",
          enablePersonalization,
          (value) {
            enablePersonalization = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Marketing Emails",
          "Receive promotional emails",
          allowMarketingEmails,
          (value) {
            allowMarketingEmails = value;
            setState(() {});
          },
        ),
        _buildActionButton("Download My Data", Icons.download, _downloadData),
        _buildActionButton("Delete Account", Icons.delete_forever, _deleteAccount),
      ],
    );
  }

  Widget _buildPaymentSecuritySection() {
    return _buildSection(
      "Payment Security",
      Icons.payment,
      [
        _buildSettingRow(
          "Save Payment Methods",
          "Store cards for faster checkout",
          savePaymentMethods,
          (value) {
            savePaymentMethods = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Payment Notifications",
          "Get alerts for all transactions",
          enablePaymentNotifications,
          (value) {
            enablePaymentNotifications = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Require CVV for saved cards",
          "Always ask for CVV verification",
          requireCVVForSavedCards,
          (value) {
            requireCVVForSavedCards = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Daily Payment Limits",
          "Set maximum daily spending",
          enablePaymentLimits,
          (value) {
            enablePaymentLimits = value;
            setState(() {});
          },
        ),
        if (enablePaymentLimits)
          _buildTextFieldSetting(
            "Daily limit (\$)",
            dailyPaymentLimit,
            (value) {
              dailyPaymentLimit = value;
              setState(() {});
            },
          ),
        _buildActionButton("Manage Payment Methods", Icons.credit_card, _managePaymentMethods),
        _buildActionButton("View Transaction History", Icons.receipt, _viewTransactionHistory),
      ],
    );
  }

  Widget _buildDeviceAppSecuritySection() {
    return _buildSection(
      "Device & App Security",
      Icons.devices,
      [
        _buildSettingRow(
          "Device Verification",
          "Verify new devices before login",
          enableDeviceVerification,
          (value) {
            enableDeviceVerification = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Multiple Devices",
          "Allow login from multiple devices",
          allowMultipleDevices,
          (value) {
            allowMultipleDevices = value;
            setState(() {});
          },
        ),
        if (allowMultipleDevices)
          _buildTextFieldSetting(
            "Maximum devices",
            maxDevices,
            (value) {
              maxDevices = value;
              setState(() {});
            },
          ),
        _buildSettingRow(
          "App Lock",
          "Lock app when in background",
          enableAppLock,
          (value) {
            enableAppLock = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Screenshot Blocking",
          "Prevent screenshots in app",
          enableScreenshotBlocking,
          (value) {
            enableScreenshotBlocking = value;
            setState(() {});
          },
        ),
        _buildActionButton("Manage Devices", Icons.smartphone, _manageDevices),
        _buildActionButton("App Permissions", Icons.settings_applications, _appPermissions),
      ],
    );
  }

  Widget _buildDataBackupSection() {
    return _buildSection(
      "Data Backup & Recovery",
      Icons.backup,
      [
        _buildSettingRow(
          "Automatic Backup",
          "Backup data to cloud storage",
          enableAutoBackup,
          (value) {
            enableAutoBackup = value;
            setState(() {});
          },
        ),
        _buildDropdownSetting(
          "Backup Frequency",
          backupFrequency,
          [
            {"label": "Daily", "value": "daily"},
            {"label": "Weekly", "value": "weekly"},
            {"label": "Monthly", "value": "monthly"},
          ],
          (value) {
            backupFrequency = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Encrypt Backup",
          "Encrypt backed up data",
          encryptBackup,
          (value) {
            encryptBackup = value;
            setState(() {});
          },
        ),
        _buildSettingRow(
          "Include Payment Data",
          "Backup saved payment methods",
          includePaymentData,
          (value) {
            includePaymentData = value;
            setState(() {});
          },
        ),
        _buildActionButton("Backup Now", Icons.cloud_upload, _backupNow),
        _buildActionButton("Restore Data", Icons.cloud_download, _restoreData),
      ],
    );
  }

  Widget _buildSecurityActionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor),
              SizedBox(width: spSm),
              Text(
                "Security Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: [
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Run Security Scan",
                  icon: Icons.security,
                  size: bs.sm,
                  onPressed: _runSecurityScan,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Report Security Issue",
                      size: bs.sm,
                      onPressed: _reportSecurityIssue,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Contact Support",
                      size: bs.sm,
                      onPressed: _contactSupport,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(icon, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
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

  Widget _buildDropdownSetting(String label, String value, List<Map<String, String>> items, Function(String) onChanged) {
    return QDropdownField(
      label: label,
      items: items,
      value: value,
      onChanged: (newValue, label) {
        onChanged(newValue);
      },
    );
  }

  Widget _buildTextFieldSetting(String label, String value, Function(String) onChanged) {
    return QNumberField(
      label: label,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: label,
        icon: icon,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  int _calculateSecurityScore() {
    int score = 0;
    
    // Authentication factors (40 points)
    if (enableTwoFactor) score += 20;
    if (enableBiometric) score += 10;
    if (enablePinLock) score += 10;
    
    // Account security (30 points)
    if (enableLoginAlerts) score += 10;
    if (enablePasswordExpiry) score += 10;
    if (enableAccountLockout) score += 10;
    
    // Privacy & data protection (20 points)
    if (!shareLocationData) score += 5;
    if (encryptBackup) score += 10;
    if (enableScreenshotBlocking) score += 5;
    
    // Payment security (10 points)
    if (requireCVVForSavedCards) score += 5;
    if (enablePaymentNotifications) score += 5;
    
    return score;
  }

  String _getScoreLevel(int score) {
    if (score >= 80) return "Excellent";
    if (score >= 60) return "Good";
    if (score >= 40) return "Fair";
    return "Poor";
  }

  Color _getSecurityScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return infoColor;
    if (score >= 40) return warningColor;
    return dangerColor;
  }

  void _changePassword() {
    // navigateTo(ChangePasswordView())
    ss("Password change initiated");
  }

  void _setup2FA() {
    // navigateTo(Setup2FAView())
    ss("2FA setup initiated");
  }

  void _viewLoginHistory() {
    // navigateTo(LoginHistoryView())
  }

  void _revokeAllSessions() async {
    bool isConfirmed = await confirm("This will log you out from all devices. Continue?");
    if (isConfirmed) {
      ss("All sessions revoked successfully");
    }
  }

  void _downloadData() {
    ss("Data download request submitted");
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to permanently delete your account?");
    if (isConfirmed) {
      se("Account deletion is irreversible. Please contact support.");
    }
  }

  void _managePaymentMethods() {
    // navigateTo(PaymentMethodsView())
  }

  void _viewTransactionHistory() {
    // navigateTo(TransactionHistoryView())
  }

  void _manageDevices() {
    // navigateTo(DeviceManagementView())
  }

  void _appPermissions() {
    // navigateTo(AppPermissionsView())
  }

  void _backupNow() {
    ss("Backup started. You'll be notified when complete.");
  }

  void _restoreData() {
    // navigateTo(RestoreDataView())
  }

  void _runSecurityScan() {
    showLoading();
    
    // Simulate security scan
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Security scan completed. No issues found.");
    });
  }

  void _reportSecurityIssue() {
    // navigateTo(ReportSecurityIssueView())
  }

  void _contactSupport() {
    // navigateTo(ContactSupportView())
  }
}
