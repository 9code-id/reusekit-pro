import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaLoginView extends StatefulWidget {
  const TtaLoginView({super.key});

  @override
  State<TtaLoginView> createState() => _TtaLoginViewState();
}

class _TtaLoginViewState extends State<TtaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool isLoading = false;
  String selectedLanguage = "English";

  List<Map<String, dynamic>> languageItems = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Portuguese", "value": "Portuguese"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
  ];

  List<Map<String, dynamic>> quickFeatures = [
    {
      "title": "Secure Authentication",
      "description": "Multi-factor authentication keeps your account safe",
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "title": "Global Access",
      "description": "Access your travel data from anywhere in the world",
      "icon": Icons.public,
      "color": infoColor,
    },
    {
      "title": "Real-time Updates",
      "description": "Get instant notifications about your travel plans",
      "icon": Icons.notifications_active,
      "color": warningColor,
    },
    {
      "title": "24/7 Support",
      "description": "Our support team is available around the clock",
      "icon": Icons.support_agent,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> recentAnnouncements = [
    {
      "title": "New Mobile App Features",
      "description": "Enhanced offline capabilities and improved performance",
      "date": "2024-01-15",
      "type": "Feature",
      "priority": "Medium",
    },
    {
      "title": "System Maintenance",
      "description": "Scheduled maintenance on Jan 20, 2-4 AM EST",
      "date": "2024-01-18",
      "type": "Maintenance",
      "priority": "High",
    },
    {
      "title": "Security Update",
      "description": "Enhanced encryption and security protocols implemented",
      "date": "2024-01-10",
      "type": "Security",
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> loginMethods = [
    {
      "title": "Email & Password",
      "subtitle": "Standard login with your credentials",
      "icon": Icons.email,
      "color": primaryColor,
      "enabled": true,
    },
    {
      "title": "Single Sign-On (SSO)",
      "subtitle": "Login with your organization account",
      "icon": Icons.business,
      "color": infoColor,
      "enabled": true,
    },
    {
      "title": "Biometric Login",
      "subtitle": "Use fingerprint or face recognition",
      "icon": Icons.fingerprint,
      "color": successColor,
      "enabled": false,
    },
    {
      "title": "QR Code Login",
      "subtitle": "Scan QR code from another device",
      "icon": Icons.qr_code,
      "color": warningColor,
      "enabled": false,
    },
  ];

  Color _getAnnouncementColor(String type) {
    switch (type) {
      case "Feature":
        return successColor;
      case "Maintenance":
        return warningColor;
      case "Security":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withAlpha(10),
              successColor.withAlpha(5),
              infoColor.withAlpha(10),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spLg,
              children: [
                _buildHeader(),
                _buildLoginForm(),
                _buildLoginMethods(),
                _buildFeatures(),
                _buildAnnouncements(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, successColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.travel_explore,
              size: 40,
              color: Colors.white,
            ),
          ),
          
          Text(
            "Travel & Tourism Admin",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "TTA Portal",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
          
          Text(
            "Welcome back! Sign in to access your travel management dashboard and explore amazing destinations.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          
          Row(
            children: [
              Text(
                "Language:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "",
                  items: languageItems,
                  value: selectedLanguage,
                  onChanged: (value, label) {
                    selectedLanguage = value;
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

  Widget _buildLoginForm() {
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
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign In to Your Account",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QTextField(
              label: "Email Address",
              value: email,
              hint: "Enter your email address",
              validator: Validator.email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Password",
                  value: password,
                  hint: "Enter your password",
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
                      obscurePassword ? "Show Password" : "Hide Password",
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
            
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Remember me",
                        "value": true,
                        "checked": rememberMe,
                      }
                    ],
                    value: [
                      if (rememberMe)
                        {
                          "label": "Remember me",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      rememberMe = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    si("Forgot password reset link will be sent to your email");
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sign In",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      
                      // Simulate login process
                      await Future.delayed(Duration(seconds: 2));
                      
                      isLoading = false;
                      setState(() {});
                      
                      ss("Login successful! Welcome to TTA Portal");
                    }
                  },
                ),
              ),
            
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create New Account",
                onPressed: () {
                  si("Redirecting to registration page...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginMethods() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alternative Login Methods",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            minItemWidth: 200,
            children: loginMethods.map((method) {
              return Container(
                decoration: BoxDecoration(
                  color: method["enabled"] ? Colors.white : disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: method["enabled"] 
                      ? (method["color"] as Color).withAlpha(50)
                      : disabledColor,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radiusSm),
                    onTap: method["enabled"] ? () {
                      si("${method["title"]} - Coming soon!");
                    } : null,
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: method["enabled"]
                                ? (method["color"] as Color).withAlpha(20)
                                : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              method["icon"],
                              color: method["enabled"] 
                                ? method["color"]
                                : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                          
                          Text(
                            "${method["title"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: method["enabled"] 
                                ? primaryColor
                                : disabledBoldColor,
                            ),
                          ),
                          
                          Text(
                            "${method["subtitle"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          if (!method["enabled"])
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Coming Soon",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Why Choose TTA Portal?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...quickFeatures.map((feature) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (feature["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: (feature["color"] as Color).withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (feature["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      feature["icon"],
                      color: feature["color"],
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${feature["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${feature["description"]}",
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
          }),
        ],
      ),
    );
  }

  Widget _buildAnnouncements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.campaign,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Announcements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          ...recentAnnouncements.map((announcement) {
            Color announcementColor = _getAnnouncementColor(announcement["type"]);
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: announcementColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: announcementColor.withAlpha(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: announcementColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${announcement["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${announcement["date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${announcement["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${announcement["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), successColor.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Need Help?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  si("Opening help documentation...");
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.help_center,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Help Center",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  si("Connecting to live chat...");
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.chat,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Live Chat",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  si("Opening contact form...");
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.contact_support,
                      color: infoColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Divider(),
          
          Text(
            "© 2024 Travel & Tourism Admin Portal. All rights reserved.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          
          Text(
            "Version 2.1.0 | Terms of Service | Privacy Policy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
