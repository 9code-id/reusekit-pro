import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin6View extends StatefulWidget {
  const GrlLogin6View({super.key});

  @override
  State<GrlLogin6View> createState() => _GrlLogin6ViewState();
}

class _GrlLogin6ViewState extends State<GrlLogin6View> {
  String username = "";
  String password = "";
  bool rememberCredentials = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/800/1200?random=1&keyword=abstract"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              primaryColor.withAlpha(180),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(100),
                Colors.black.withAlpha(200),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  SizedBox(height: spXl),
                  
                  // Header
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(230),
                          shape: BoxShape.circle,
                          boxShadow: [shadowXl],
                        ),
                        child: Icon(
                          Icons.admin_panel_settings,
                          size: 50,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "Admin Portal",
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      Text(
                        "Secure Administrative Access",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXl * 2),
                  
                  // Login Card with Glassmorphism Effect
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(radius2xl),
                      border: Border.all(
                        color: Colors.white.withAlpha(100),
                        width: 1,
                      ),
                      boxShadow: [shadowXl],
                    ),
                    child: Column(
                      spacing: spMd,
                      children: [
                        Text(
                          "Administrator Login",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Text(
                          "Enter your admin credentials to access the dashboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Username",
                                value: username,
                                hint: "Enter admin username",
                                onChanged: (value) {
                                  username = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.lock,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Password",
                                value: password,
                                obscureText: true,
                                hint: "Enter admin password",
                                onChanged: (value) {
                                  password = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: rememberCredentials ? primaryColor : Colors.transparent,
                                border: Border.all(
                                  color: rememberCredentials ? primaryColor : disabledOutlineBorderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: rememberCredentials
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                rememberCredentials = !rememberCredentials;
                                setState(() {});
                              },
                              child: Text(
                                "Remember credentials",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Access Dashboard",
                            size: bs.md,
                            onPressed: () {
                              // Handle admin login
                            },
                          ),
                        ),
                        
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor.withAlpha(100)),
                            borderRadius: BorderRadius.circular(radiusLg),
                            color: Colors.white.withAlpha(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.security, size: 20, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "Two-Factor Authentication",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Security Notice
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: warningColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "This is a restricted area. All access attempts are logged and monitored.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Additional Options
                  Column(
                    spacing: spSm,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to password recovery
                        },
                        child: Text(
                          "Forgot admin password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Need assistance? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(180),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Contact support
                            },
                            child: Text(
                              "Contact IT Support",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Footer
                  Text(
                    "© 2024 Admin Portal. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
