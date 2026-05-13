import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin7View extends StatefulWidget {
  const GrlLogin7View({super.key});

  @override
  State<GrlLogin7View> createState() => _GrlLogin7ViewState();
}

class _GrlLogin7ViewState extends State<GrlLogin7View> {
  String email = "";
  String password = "";
  String selectedRegion = "US";
  
  final List<Map<String, dynamic>> regions = [
    {"label": "United States", "value": "US"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia Pacific", "value": "AP"},
    {"label": "Middle East", "value": "ME"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Section
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius4xl),
                  bottomRight: Radius.circular(radius4xl),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [shadowLg],
                      ),
                      child: Icon(
                        Icons.language,
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "GlobalAuth",
                      style: TextStyle(
                        fontSize: fsH1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    Text(
                      "Worldwide Secure Access",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Login Form Section
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: spMd),
                  
                  Text(
                    "Sign In to Your Account",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "Choose your region and enter your credentials",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Region Selection
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Select Your Region",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        QDropdownField(
                          label: "Region",
                          items: regions,
                          value: selectedRegion,
                          onChanged: (value, label) {
                            selectedRegion = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Login Credentials
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Email Address",
                          value: email,
                          hint: "your.email@company.com",
                          onChanged: (value) {
                            email = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Password",
                          value: password,
                          obscureText: true,
                          hint: "Enter your password",
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.verified_user,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "SSL Secured",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to forgot password
                              },
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Login Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Sign In Securely",
                      size: bs.md,
                      onPressed: () {
                        // Handle login
                      },
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Enterprise Login Options
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: secondaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Enterprise Login",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.business, size: 24, color: secondaryColor),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "SSO",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.vpn_key, size: 24, color: secondaryColor),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "LDAP",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.cloud, size: 24, color: secondaryColor),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "Azure AD",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Footer Links
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New to GlobalAuth? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to sign up
                            },
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spMd,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            "•",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Terms of Service",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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
