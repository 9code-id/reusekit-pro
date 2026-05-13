import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaAdminLoginView extends StatefulWidget {
  const LtaAdminLoginView({super.key});

  @override
  State<LtaAdminLoginView> createState() => _LtaAdminLoginViewState();
}

class _LtaAdminLoginViewState extends State<LtaAdminLoginView> {
  final formKey = GlobalKey<FormState>();
  String adminId = "";
  String password = "";
  String accessCode = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool twoFactorEnabled = true;

  List<Map<String, dynamic>> systemStats = [
    {
      "title": "Total Users",
      "value": "15,247",
      "change": "+12%",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Active Deliveries",
      "value": "3,891",
      "change": "+8%",
      "icon": Icons.local_shipping,
      "color": successColor,
    },
    {
      "title": "System Uptime",
      "value": "99.9%",
      "change": "Stable",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Revenue Today",
      "value": "\$45,230",
      "change": "+15%",
      "icon": Icons.attach_money,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Portal"),
        backgroundColor: warningColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: dangerColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: dangerColor,
                    size: 24,
                  ),
                  
                  SizedBox(width: spMd),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Secure Admin Access",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        
                        Text(
                          "This is a restricted area. All activities are logged and monitored.",
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
            ),
            
            SizedBox(height: spLg),
            
            // System Overview
            Text(
              "System Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: systemStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              size: 20,
                              color: stat["color"] as Color,
                            ),
                          ),
                          
                          Spacer(),
                          
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Admin Login Form
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.admin_panel_settings,
                          color: warningColor,
                          size: 28,
                        ),
                        
                        SizedBox(width: spMd),
                        
                        Text(
                          "Administrator Login",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Admin ID Field
                    QTextField(
                      label: "Admin ID",
                      value: adminId,
                      hint: "Enter your admin ID",
                      validator: Validator.required,
                      onChanged: (value) {
                        adminId = value;
                        setState(() {});
                      },
                    ),
                    
                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Password",
                          value: password,
                          hint: "Enter your secure password",
                          obscureText: obscurePassword,
                          validator: Validator.required,
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              obscurePassword = !obscurePassword;
                              setState(() {});
                            },
                            child: Text(
                              obscurePassword ? "Show" : "Hide",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Two-Factor Authentication
                    if (twoFactorEnabled) ...[
                      QTextField(
                        label: "Access Code",
                        value: accessCode,
                        hint: "Enter 6-digit code from authenticator",
                        validator: Validator.required,
                        onChanged: (value) {
                          accessCode = value;
                          setState(() {});
                        },
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
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
                                "Enter the 6-digit code from your authenticator app",
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
                    
                    // Options
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Remember for 30 days",
                                "value": true,
                                "checked": rememberMe,
                              }
                            ],
                            value: [
                              if (rememberMe)
                                {
                                  "label": "Remember for 30 days",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                rememberMe = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle emergency access
                          },
                          child: Text(
                            "Emergency Access",
                            style: TextStyle(
                              fontSize: 14,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Secure Admin Login",
                        size: bs.md,
                        icon: Icons.security,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle admin login
                            showLoading();
                            Future.delayed(Duration(seconds: 2), () {
                              hideLoading();
                              ss("Admin access granted");
                            });
                          }
                        },
                      ),
                    ),
                    
                    // Session Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Session will expire after 4 hours of inactivity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Admin Support
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Administrator Support",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.call,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Emergency",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "+1 (555) 911-0000",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.email,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "IT Support",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "admin@logitrans.com",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.help,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Documentation",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "admin-guide.pdf",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
