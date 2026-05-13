import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestLoginView extends StatefulWidget {
  const HhaGuestLoginView({super.key});

  @override
  State<HhaGuestLoginView> createState() => _HhaGuestLoginViewState();
}

class _HhaGuestLoginViewState extends State<HhaGuestLoginView> {
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hotel Logo and Welcome Text
                Container(
                  margin: EdgeInsets.only(bottom: sp2xl),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXl),
                          boxShadow: [shadowLg],
                        ),
                        child: Icon(
                          Icons.hotel,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Welcome to Grand Hotel",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Guest Portal Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Login Form
                Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: spMd,
                      children: [
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
                              obscureText: obscurePassword,
                              hint: "Enter your password",
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

                        // Remember Me and Forgot Password
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
                                ss("Password reset link sent to your email");
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
                            label: loading ? "Signing In..." : "Sign In",
                            size: bs.md,
                            onPressed: loading ? null : () async {
                              if (formKey.currentState!.validate()) {
                                loading = true;
                                setState(() {});

                                // Simulate login process
                                await Future.delayed(Duration(seconds: 2));

                                loading = false;
                                setState(() {});

                                ss("Welcome back! Redirecting to your dashboard...");
                                //ss('Next page'));
                              }
                            },
                          ),
                        ),

                        SizedBox(height: spLg),

                        // Quick Actions
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Quick Access",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                spacing: spSm,
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Room Service",
                                      icon: Icons.room_service,
                                      size: bs.sm,
                                      onPressed: () {
                                        si("Room service feature coming soon");
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: QButton(
                                      label: "Concierge",
                                      icon: Icons.support_agent,  
                                      size: bs.sm,
                                      onPressed: () {
                                        si("Concierge service available 24/7");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: spLg),

                        // Guest Registration
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "First time guest? ",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                si("Guest registration will be handled at check-in");
                              },
                              child: Text(
                                "Contact Reception",
                                style: TextStyle(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
