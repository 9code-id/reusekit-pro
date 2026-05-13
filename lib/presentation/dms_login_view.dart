import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsLoginView extends StatefulWidget {
  const DmsLoginView({super.key});

  @override
  State<DmsLoginView> createState() => _DmsLoginViewState();
}

class _DmsLoginViewState extends State<DmsLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      // Navigate to dashboard
      //navigateTo DmsDashboardView
      
      ss("Successfully logged in!");
    }
  }

  void _handleForgotPassword() {
    si("Password reset link has been sent to your email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: spXl),
              
              // Logo Section
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "DealershipFlow",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),

              // Welcome Message
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
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Access your dealership management dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Login Form
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
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
                          onTap: _handleForgotPassword,
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

                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In",
                        size: bs.md,
                        onPressed: _handleLogin,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Quick Access Options
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
                      "Quick Access",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(50)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.person, color: successColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "Demo Account",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "demo@dealership.com",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(50)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.business, color: infoColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "Manager Access",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "manager@dealership.com",
                                style: TextStyle(
                                  fontSize: 10,
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

              SizedBox(height: spMd),

              // Features Preview
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Secure & Reliable",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Bank-level encryption for all data",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Automatic backups and data recovery",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "99.9% uptime guarantee",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "24/7 monitoring and support",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Sign Up Link
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
                      "New to DealershipFlow?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Free Account",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo DmsRegisterView
                        },
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Start your 30-day free trial today",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Support Section
              Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.help, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Need help?",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Contact Support",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          " • ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Help Center",
                            style: TextStyle(
                              fontSize: 12,
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
            ],
          ),
        ),
      ),
    );
  }
}
