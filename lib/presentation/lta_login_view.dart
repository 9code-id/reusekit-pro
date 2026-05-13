import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaLoginView extends StatefulWidget {
  const LtaLoginView({super.key});

  @override
  State<LtaLoginView> createState() => _LtaLoginViewState();
}

class _LtaLoginViewState extends State<LtaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  List<Map<String, dynamic>> userTypes = [
    {
      "title": "Customer",
      "description": "Book and track your shipments",
      "icon": Icons.person,
      "color": primaryColor,
    },
    {
      "title": "Driver",
      "description": "Manage deliveries and routes",
      "icon": Icons.local_shipping,
      "color": successColor,
    },
    {
      "title": "Admin",
      "description": "System administration",
      "icon": Icons.admin_panel_settings,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + spLg),
            
            // Logo Section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.local_shipping,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "LogiTrans",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "Welcome back! Sign in to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // User Type Selection
            Text(
              "Select Login Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: userTypes.map((type) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        if (type["title"] == "Customer") {
                          // ss('Next page'));
                        } else if (type["title"] == "Driver") {
                          // ss('Next page'));
                        } else if (type["title"] == "Admin") {
                          // ss('Next page'));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (type["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                type["icon"] as IconData,
                                size: 24,
                                color: type["color"] as Color,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Text(
                              "${type["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${type["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
            
            SizedBox(height: spXl),
            
            // Quick Login Form (Demo)
            Container(
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
                  children: [
                    Text(
                      "Quick Demo Login",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Email Field
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "Enter your email",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Password Field
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
                    
                    SizedBox(height: spMd),
                    
                    // Remember Me & Forgot Password
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
                              setState(() {
                                rememberMe = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle forgot password
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
                    
                    SizedBox(height: spLg),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In",
                        size: bs.md,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle login
                          }
                        },
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Register Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // ss('Next page'));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
