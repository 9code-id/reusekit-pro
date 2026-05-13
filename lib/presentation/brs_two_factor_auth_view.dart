import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTwoFactorAuthView extends StatefulWidget {
  const BrsTwoFactorAuthView({super.key});

  @override
  State<BrsTwoFactorAuthView> createState() => _BrsTwoFactorAuthViewState();
}

class _BrsTwoFactorAuthViewState extends State<BrsTwoFactorAuthView> {
  bool isEnabled = false;
  String selectedMethod = "sms";
  String phoneNumber = "+1 (555) 123-4567";
  String email = "john.doe@email.com";
  String verificationCode = "";
  bool isVerifying = false;
  bool showQrCode = false;

  List<Map<String, dynamic>> authMethods = [
    {
      "id": "sms",
      "title": "SMS Authentication",
      "description": "Receive verification codes via SMS",
      "icon": Icons.sms,
      "recommended": true,
    },
    {
      "id": "email",
      "title": "Email Authentication", 
      "description": "Receive verification codes via email",
      "icon": Icons.email,
      "recommended": false,
    },
    {
      "id": "authenticator",
      "title": "Authenticator App",
      "description": "Use Google Authenticator or similar apps",
      "icon": Icons.security,
      "recommended": false,
    },
  ];

  List<Map<String, dynamic>> backupCodes = [
    {"code": "ABC123-DEF456", "used": false},
    {"code": "GHI789-JKL012", "used": false},
    {"code": "MNO345-PQR678", "used": true},
    {"code": "STU901-VWX234", "used": false},
    {"code": "YZA567-BCD890", "used": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isEnabled ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isEnabled ? successColor : warningColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEnabled ? Icons.shield : Icons.warning,
                    color: isEnabled ? successColor : warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEnabled ? "Two-Factor Authentication Enabled" : "Two-Factor Authentication Disabled",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isEnabled ? successColor : warningColor,
                          ),
                        ),
                        Text(
                          isEnabled 
                            ? "Your account is protected with an extra layer of security."
                            : "Enable 2FA to add an extra layer of security to your account.",
                          style: TextStyle(
                            fontSize: 12,
                            color: isEnabled ? successColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Two-Factor Authentication",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    if (value && !isEnabled) {
                      _showEnableDialog();
                    } else if (!value && isEnabled) {
                      _showDisableDialog();
                    }
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            if (isEnabled) ...[
              SizedBox(height: spLg),
              Text(
                "Authentication Methods",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...authMethods.map((method) {
                bool isSelected = selectedMethod == method["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(spMd),
                    leading: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        method["icon"] as IconData,
                        color: isSelected ? Colors.white : disabledBoldColor,
                        size: 24,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          "${method["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (method["recommended"] as bool) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Recommended",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(
                      "${method["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    trailing: Radio<String>(
                      value: method["id"] as String,
                      groupValue: selectedMethod,
                      onChanged: (value) {
                        selectedMethod = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    onTap: () {
                      selectedMethod = method["id"] as String;
                      setState(() {});
                    },
                  ),
                );
              }).toList(),
              
              if (selectedMethod == "authenticator") ...[
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Setup Authenticator App",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      if (showQrCode) ...[
                        Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 64,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "QR Code",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Manual Entry Key:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "JBSWY3DPEHPK3PXP",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ] else ...[
                        QButton(
                          label: "Show QR Code",
                          size: bs.sm,
                          onPressed: () {
                            showQrCode = true;
                            setState(() {});
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              
              SizedBox(height: spLg),
              Text(
                "Backup Codes",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "These codes can be used to access your account if you lose access to your primary 2FA method.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    ...backupCodes.map((code) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (code["used"] as bool) ? disabledColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${code["code"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'monospace',
                                color: (code["used"] as bool) ? disabledBoldColor : primaryColor,
                                decoration: (code["used"] as bool) ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            Spacer(),
                            if (code["used"] as bool)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Used",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Generate New Codes",
                      size: bs.sm,
                      onPressed: () {
                        _generateNewBackupCodes();
                      },
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spXl),
            if (isEnabled)
              QButton(
                label: "Test Authentication",
                size: bs.md,
                onPressed: () {
                  _testAuthentication();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showEnableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enable Two-Factor Authentication"),
        content: Text("This will add an extra layer of security to your account. You'll need to verify your identity using your chosen method each time you log in."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              isEnabled = true;
              setState(() {});
              ss("Two-factor authentication enabled");
            },
            child: Text("Enable"),
          ),
        ],
      ),
    );
  }

  void _showDisableDialog() async {
    bool isConfirmed = await confirm("Are you sure you want to disable two-factor authentication? This will make your account less secure.");
    if (isConfirmed) {
      isEnabled = false;
      setState(() {});
      sw("Two-factor authentication disabled");
    }
  }

  void _generateNewBackupCodes() async {
    bool isConfirmed = await confirm("Generating new backup codes will invalidate all existing codes. Continue?");
    if (isConfirmed) {
      // Generate new codes logic here
      ss("New backup codes generated");
    }
  }

  void _testAuthentication() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Test Authentication"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Enter the verification code from your ${selectedMethod == 'sms' ? 'SMS' : selectedMethod == 'email' ? 'email' : 'authenticator app'}:"),
            SizedBox(height: spMd),
            QTextField(
              label: "Verification Code",
              value: verificationCode,
              onChanged: (value) {
                verificationCode = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Authentication test successful");
            },
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }
}
