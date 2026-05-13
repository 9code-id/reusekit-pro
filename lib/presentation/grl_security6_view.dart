import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity6View extends StatefulWidget {
  @override
  State<GrlSecurity6View> createState() => _GrlSecurity6ViewState();
}

class _GrlSecurity6ViewState extends State<GrlSecurity6View> {
  bool twoFactorEnabled = true;
  bool smsBackupEnabled = false;
  bool emailBackupEnabled = true;
  String selectedMethod = 'authenticator';
  
  List<Map<String, dynamic>> authMethods = [
    {
      "id": "authenticator",
      "title": "Authenticator App",
      "description": "Use Google Authenticator, Authy, or similar apps",
      "icon": Icons.phone_android,
      "enabled": true,
      "primary": true,
    },
    {
      "id": "sms",
      "title": "SMS Verification",
      "description": "Receive codes via text message",
      "icon": Icons.sms,
      "enabled": false,
      "primary": false,
    },
    {
      "id": "email",
      "title": "Email Backup",
      "description": "Backup verification via email",
      "icon": Icons.email,
      "enabled": true,
      "primary": false,
    },
    {
      "id": "hardware",
      "title": "Hardware Key",
      "description": "Physical security key (YubiKey, etc.)",
      "icon": Icons.usb,
      "enabled": false,
      "primary": false,
    },
  ];

  List<Map<String, dynamic>> backupCodes = [
    {"code": "ABCD-1234-EFGH", "used": false},
    {"code": "IJKL-5678-MNOP", "used": false},
    {"code": "QRST-9012-UVWX", "used": true},
    {"code": "YZAB-3456-CDEF", "used": false},
    {"code": "GHIJ-7890-KLMN", "used": false},
    {"code": "OPQR-1357-STUV", "used": false},
    {"code": "WXYZ-2468-ABCD", "used": false},
    {"code": "EFGH-9753-IJKL", "used": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2FA Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: twoFactorEnabled 
                      ? [successColor, successColor.withAlpha(180)]
                      : [warningColor, warningColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        twoFactorEnabled ? Icons.verified_user : Icons.warning,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "2FA Status",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: twoFactorEnabled,
                        onChanged: (value) async {
                          if (!value) {
                            bool isConfirmed = await confirm("Disabling 2FA will make your account less secure. Continue?");
                            if (!isConfirmed) return;
                          }
                          twoFactorEnabled = value;
                          setState(() {});
                          if (value) {
                            ss("Two-factor authentication enabled");
                          } else {
                            sw("Two-factor authentication disabled");
                          }
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white.withAlpha(102),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    twoFactorEnabled ? "ENABLED" : "DISABLED",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    twoFactorEnabled 
                        ? "Your account is protected with 2FA"
                        : "Enable 2FA for better security",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            if (twoFactorEnabled) ...[
              // Authentication Methods
              Text(
                "Authentication Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              ...authMethods.map((method) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: method["primary"] as bool
                      ? Border.all(color: successColor.withAlpha(102), width: 2)
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (method["enabled"] as bool ? primaryColor : disabledColor).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          method["icon"] as IconData,
                          color: method["enabled"] as bool ? primaryColor : disabledBoldColor,
                          size: 24,
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
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (method["primary"] as bool) ...[
                                  SizedBox(width: spXs),
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
                                      "PRIMARY",
                                      style: TextStyle(
                                        fontSize: 10,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (method["enabled"] as bool)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: QButton(
                            label: method["primary"] as bool ? "Manage" : "Configure",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        )
                      else
                        QButton(
                          label: "Enable",
                          size: bs.sm,
                          onPressed: () {
                            method["enabled"] = true;
                            setState(() {});
                            ss("${method["title"]} enabled successfully");
                          },
                        ),
                    ],
                  ),
                ),
              )).toList(),
              
              SizedBox(height: spMd),
              
              // Backup Codes Section
              Container(
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
                          Icons.backup,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Backup Codes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${backupCodes.where((c) => !(c["used"] as bool)).length} REMAINING",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Use these codes if you can't access your primary 2FA method. Each code can only be used once.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Backup Codes Grid
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: backupCodes.map((backup) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: backup["used"] as bool 
                              ? disabledColor.withAlpha(51)
                              : primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: backup["used"] as bool 
                                ? disabledBoldColor
                                : primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${backup["code"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: backup["used"] as bool 
                                ? disabledBoldColor
                                : primaryColor,
                            decoration: backup["used"] as bool 
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Download Codes",
                            size: bs.sm,
                            onPressed: () {
                              ss("Backup codes downloaded");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: warningColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: QButton(
                              label: "Generate New",
                              size: bs.sm,
                              onPressed: () async {
                                bool isConfirmed = await confirm("This will invalidate all existing backup codes. Continue?");
                                if (isConfirmed) {
                                  // Reset all codes as unused for demo
                                  for (var code in backupCodes) {
                                    code["used"] = false;
                                  }
                                  setState(() {});
                                  ss("New backup codes generated");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Security Tips
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(102)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Security Tips",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Store backup codes in a secure location\n• Use an authenticator app as your primary method\n• Enable multiple backup methods\n• Never share your 2FA codes with anyone",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Setup 2FA Guide
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Why Enable 2FA?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.security,
                            color: successColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enhanced Security",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Adds an extra layer of protection to your account",
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
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.block,
                            color: warningColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prevents Unauthorized Access",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Protects your account even if password is compromised",
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
                    
                    SizedBox(height: spMd),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Set Up 2FA Now",
                        size: bs.md,
                        onPressed: () {
                          twoFactorEnabled = true;
                          setState(() {});
                          ss("Two-factor authentication setup started");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
