import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRegisterView extends StatefulWidget {
  const LtaRegisterView({super.key});

  @override
  State<LtaRegisterView> createState() => _LtaRegisterViewState();
}

class _LtaRegisterViewState extends State<LtaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  List<Map<String, dynamic>> benefits = [
    {
      "title": "Free Account",
      "description": "No setup fees or monthly charges",
      "icon": Icons.account_balance_wallet,
    },
    {
      "title": "Instant Quotes",
      "description": "Get shipping rates instantly",
      "icon": Icons.flash_on,
    },
    {
      "title": "Package Tracking",
      "description": "Track all your shipments in one place",
      "icon": Icons.track_changes,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
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
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Join LogiTrans",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "Start shipping with confidence today",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Benefits Section
            Text(
              "Membership Benefits",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Column(
              spacing: spSm,
              children: benefits.map((benefit) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          benefit["icon"] as IconData,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${benefit["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${benefit["description"]}",
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
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Registration Form
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
                      "Account Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Full Name
                    QTextField(
                      label: "Full Name",
                      value: fullName,
                      hint: "Enter your full name",
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                    
                    // Email
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
                    
                    // Phone
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      hint: "Enter your phone number",
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                    
                    // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Password",
                          value: password,
                          hint: "Create a strong password",
                          obscureText: obscurePassword,
                          validator: Validator.required,
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Password must be at least 8 characters",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            GestureDetector(
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
                          ],
                        ),
                      ],
                    ),
                    
                    // Confirm Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Confirm Password",
                          value: confirmPassword,
                          hint: "Re-enter your password",
                          obscureText: obscureConfirmPassword,
                          validator: (value) {
                            if (value != password) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              obscureConfirmPassword = !obscureConfirmPassword;
                              setState(() {});
                            },
                            child: Text(
                              obscureConfirmPassword ? "Show" : "Hide",
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
                    
                    // Terms and Newsletter
                    Column(
                      spacing: spSm,
                      children: [
                        QSwitch(
                          items: [
                            {
                              "label": "I agree to the Terms of Service and Privacy Policy",
                              "value": true,
                              "checked": agreeToTerms,
                            }
                          ],
                          value: [
                            if (agreeToTerms)
                              {
                                "label": "I agree to the Terms of Service and Privacy Policy",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              agreeToTerms = values.isNotEmpty;
                            });
                          },
                        ),
                        
                        QSwitch(
                          items: [
                            {
                              "label": "Subscribe to newsletter for updates and offers",
                              "value": true,
                              "checked": subscribeNewsletter,
                            }
                          ],
                          value: [
                            if (subscribeNewsletter)
                              {
                                "label": "Subscribe to newsletter for updates and offers",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              subscribeNewsletter = values.isNotEmpty;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    // Register Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Account",
                        size: bs.md,
                        icon: Icons.person_add,
                        onPressed: () {
                          if (formKey.currentState!.validate() && agreeToTerms) {
                            // Handle registration
                            showLoading();
                            Future.delayed(Duration(seconds: 2), () {
                              hideLoading();
                              ss("Account created successfully!");
                              // ss('Next page'));
                            });
                          } else if (!agreeToTerms) {
                            se("Please agree to the terms and conditions");
                          }
                        },
                      ),
                    ),
                    
                    // Social Registration
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "or sign up with",
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
                              // Handle Google registration
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
                              // Handle Facebook registration
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // Login Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
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
