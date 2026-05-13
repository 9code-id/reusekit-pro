import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaTwoFactorAuthView extends StatefulWidget {
  const SpaTwoFactorAuthView({super.key});

  @override
  State<SpaTwoFactorAuthView> createState() => _SpaTwoFactorAuthViewState();
}

class _SpaTwoFactorAuthViewState extends State<SpaTwoFactorAuthView> {
  bool twoFactorEnabled = false;
  String selectedMethod = "sms";
  String phoneNumber = "+1 (555) 123-4567";
  String backupEmail = "isabella.rodriguez@email.com";
  String verificationCode = "";
  
  bool isSettingUp = false;
  bool isVerifying = false;
  bool setupComplete = false;
  
  List<String> backupCodes = [];
  List<String> trustedDevices = ["iPhone 14 Pro", "MacBook Pro"];
  
  String qrCodeUrl = "https://picsum.photos/200/200?random=1&keyword=qr";
  String secretKey = "JBSWY3DPEHPK3PXP";
  
  List<Map<String, dynamic>> authMethods = [
    {
      "id": "sms",
      "title": "SMS Text Message",
      "description": "Receive verification codes via text message",
      "icon": Icons.sms,
      "recommended": true,
      "setupRequired": true,
    },
    {
      "id": "email",
      "title": "Email Verification",
      "description": "Get verification codes sent to your email",
      "icon": Icons.email,
      "recommended": false,
      "setupRequired": false,
    },
    {
      "id": "authenticator",
      "title": "Authenticator App",
      "description": "Use Google Authenticator or similar apps",
      "icon": Icons.phone_android,
      "recommended": true,
      "setupRequired": true,
    },
    {
      "id": "backup_codes",
      "title": "Backup Codes",
      "description": "One-time use codes for emergency access",
      "icon": Icons.backup,
      "recommended": false,
      "setupRequired": false,
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "id": 1,
      "action": "2FA Setup Initiated",
      "timestamp": "2024-01-19T14:30:00Z",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "status": "success",
    },
    {
      "id": 2,
      "action": "Backup Codes Generated",
      "timestamp": "2024-01-19T14:25:00Z",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "status": "success",
    },
    {
      "id": 3,
      "action": "SMS Verification Sent",
      "timestamp": "2024-01-19T14:20:00Z",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "status": "success",
    },
  ];

  @override
  void initState() {
    super.initState();
    _generateBackupCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication"),
        actions: [
          if (twoFactorEnabled)
            QButton(
              icon: Icons.settings,
              size: bs.sm,
              onPressed: () {
                _showAdvancedSettings();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _build2FAHeader(),
            if (!twoFactorEnabled) ...[
              _buildSetupMethods(),
              if (isSettingUp) _buildSetupProcess(),
            ] else ...[
              _buildEnabledStatus(),
              _buildManageMethods(),
              _buildBackupCodes(),
              _buildTrustedDevices(),
              _buildSecurityActivity(),
            ],
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _build2FAHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            twoFactorEnabled ? successColor : primaryColor,
            (twoFactorEnabled ? successColor : primaryColor).withAlpha(180),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  twoFactorEnabled ? Icons.verified_user : Icons.security,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      twoFactorEnabled ? "2FA Enabled" : "Secure Your Account",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      twoFactorEnabled 
                          ? "Your account is protected with two-factor authentication"
                          : "Add an extra layer of security to your spa account",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.white.withAlpha(100), width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  twoFactorEnabled ? Icons.check_circle : Icons.info,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    twoFactorEnabled 
                        ? "Two-factor authentication is active and protecting your account"
                        : "Two-factor authentication requires a second verification step when signing in",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.4,
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

  Widget _buildSetupMethods() {
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
            "Choose Your 2FA Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Select how you want to receive verification codes",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...authMethods.map((method) {
            return _buildMethodOption(method);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMethodOption(Map<String, dynamic> method) {
    final isSelected = selectedMethod == method["id"];
    final isRecommended = method["recommended"] as bool;
    
    return GestureDetector(
      onTap: () {
        selectedMethod = method["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                method["icon"] as IconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${method["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.black : disabledBoldColor,
                        ),
                      ),
                      if (isRecommended) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "RECOMMENDED",
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${method["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupProcess() {
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
            "Setup ${_getMethodTitle(selectedMethod)}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          if (selectedMethod == "sms") ...[
            QTextField(
              label: "Phone Number",
              value: phoneNumber,
              onChanged: (value) {
                phoneNumber = value;
                setState(() {});
              },
            ),
          ] else if (selectedMethod == "email") ...[
            QTextField(
              label: "Backup Email",
              value: backupEmail,
              onChanged: (value) {
                backupEmail = value;
                setState(() {});
              },
            ),
          ] else if (selectedMethod == "authenticator") ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "1. Download an authenticator app (Google Authenticator, Authy, etc.)",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Text(
                  "2. Scan this QR code with your app:",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                    child: Image.network(qrCodeUrl, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  "3. Or manually enter this secret key:",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          secretKey,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      QButton(
                        icon: Icons.copy,
                        size: bs.sm,
                        onPressed: () {
                          _copySecretKey();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          
          if (isVerifying) ...[
            QTextField(
              label: "Verification Code",
              value: verificationCode,
              onChanged: (value) {
                verificationCode = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEnabledStatus() {
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
              Icon(Icons.verified_user, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "2FA Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Two-Factor Authentication Active",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Primary method: ${_getMethodTitle(selectedMethod)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageMethods() {
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
            "Manage Methods",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Change Method",
                  size: bs.sm,
                  onPressed: () {
                    _changeMethod();
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Test 2FA",
                  size: bs.sm,
                  onPressed: () {
                    _test2FA();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackupCodes() {
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
              Icon(Icons.backup, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Backup Codes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Use these codes if you can't access your primary 2FA method",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                ...backupCodes.take(4).map((code) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          code,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Text(
                        "Unused",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }).toList(),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View All Codes",
                        size: bs.sm,
                        onPressed: () {
                          _viewAllBackupCodes();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Generate New",
                        size: bs.sm,
                        onPressed: () {
                          _generateNewBackupCodes();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedDevices() {
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
              Icon(Icons.devices, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Trusted Devices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Devices that don't require 2FA for ${((30 * 24 * 60) / 1000).toInt()} days",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...trustedDevices.map((device) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.smartphone, color: primaryColor, size: 20),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      device,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      _removeTrustedDevice(device);
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSecurityActivity() {
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
            "Recent 2FA Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          ...securityEvents.map((event) {
            final timestamp = DateTime.parse(event["timestamp"]);
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event["action"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${timestamp.dMMMy} • ${event["device"]}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (!twoFactorEnabled) {
      return Column(
        spacing: spMd,
        children: [
          if (!isSettingUp) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Setup Two-Factor Authentication",
                size: bs.md,
                onPressed: () {
                  _startSetup();
                },
              ),
            ),
          ] else if (!isVerifying) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Verification Code",
                size: bs.md,
                onPressed: () {
                  _sendVerificationCode();
                },
              ),
            ),
          ] else ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify and Enable 2FA",
                size: bs.md,
                onPressed: () {
                  _verifyAndEnable();
                },
              ),
            ),
          ],
        ],
      );
    }
    
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Disable Two-Factor Authentication",
            size: bs.md,
            onPressed: () {
              _disable2FA();
            },
          ),
        ),
      ],
    );
  }

  void _generateBackupCodes() {
    backupCodes = List.generate(8, (index) => 
        "${(index + 1).toString().padLeft(2, '0')}${(DateTime.now().millisecondsSinceEpoch + index).toString().substring(6)}"
    );
  }

  String _getMethodTitle(String methodId) {
    final method = authMethods.firstWhere((m) => m["id"] == methodId);
    return method["title"];
  }

  void _startSetup() {
    isSettingUp = true;
    setState(() {});
  }

  void _sendVerificationCode() {
    isVerifying = true;
    setState(() {});
    ss("Verification code sent to ${_getMethodTitle(selectedMethod)}");
  }

  void _verifyAndEnable() {
    if (verificationCode.length >= 6) {
      twoFactorEnabled = true;
      isSettingUp = false;
      isVerifying = false;
      setupComplete = true;
      setState(() {});
      ss("Two-factor authentication enabled successfully!");
    } else {
      se("Please enter a valid verification code");
    }
  }

  void _disable2FA() {
    twoFactorEnabled = false;
    isSettingUp = false;
    isVerifying = false;
    setupComplete = false;
    setState(() {});
    ss("Two-factor authentication disabled");
  }

  void _changeMethod() {
    ss("Change 2FA method");
    //navigateTo ( Change2FAMethodView )
  }

  void _test2FA() {
    ss("Testing 2FA functionality");
    //navigateTo ( Test2FAView )
  }

  void _copySecretKey() {
    ss("Secret key copied to clipboard");
  }

  void _viewAllBackupCodes() {
    ss("Viewing all backup codes");
    //navigateTo ( BackupCodesView )
  }

  void _generateNewBackupCodes() {
    _generateBackupCodes();
    setState(() {});
    ss("New backup codes generated");
  }

  void _removeTrustedDevice(String device) {
    setState(() {
      trustedDevices.remove(device);
    });
    ss("Trusted device removed: $device");
  }

  void _showAdvancedSettings() {
    ss("Advanced 2FA settings");
    //navigateTo ( Advanced2FASettingsView )
  }
}
