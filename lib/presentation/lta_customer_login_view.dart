import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCustomerLoginView extends StatefulWidget {
  const LtaCustomerLoginView({super.key});

  @override
  State<LtaCustomerLoginView> createState() => _LtaCustomerLoginViewState();
}

class _LtaCustomerLoginViewState extends State<LtaCustomerLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  List<Map<String, dynamic>> features = [
    {
      "title": "Easy Booking",
      "description": "Book shipments in just few taps",
      "icon": Icons.touch_app,
      "color": primaryColor,
    },
    {
      "title": "Real-time Tracking",
      "description": "Track your packages live",
      "icon": Icons.gps_fixed,
      "color": successColor,
    },
    {
      "title": "Secure Payment",
      "description": "Multiple payment options",
      "icon": Icons.payment,
      "color": warningColor,
    },
    {
      "title": "24/7 Support",
      "description": "Round the clock assistance",
      "icon": Icons.support_agent,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Login"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, successColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Welcome Customer",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Ship your packages with confidence",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Features Grid
            Text(
              "Why Choose Us",
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
              children: features.map((feature) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (feature["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          feature["icon"] as IconData,
                          size: 28,
                          color: feature["color"] as Color,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "${feature["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Text(
                        "${feature["description"]}",
                        textAlign: TextAlign.center,
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
            
            // Login Form
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
                    Text(
                      "Sign In to Your Account",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
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
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In",
                        size: bs.md,
                        icon: Icons.login,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle customer login
                            ss("Welcome back!");
                          }
                        },
                      ),
                    ),
                    
                    // Social Login
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "or",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Google",
                            size: bs.sm,
                            icon: Icons.g_mobiledata,
                            onPressed: () {
                              // Handle Google login
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QButton(
                            label: "Facebook",
                            size: bs.sm,
                            icon: Icons.facebook,
                            onPressed: () {
                              // Handle Facebook login
                            },
                          ),
                        ),
                      ],
                    ),
                    
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
                                text: "Create Account",
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
            
            SizedBox(height: spLg),
            
            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
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
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Call Support",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "+1 (555) 123-4567",
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
                              Icons.chat,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Live Chat",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Available 24/7",
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
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "FAQ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Get quick answers",
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
