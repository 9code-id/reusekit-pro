import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmLoginView extends StatefulWidget {
  const TpmLoginView({super.key});

  @override
  State<TpmLoginView> createState() => _TpmLoginViewState();
}

class _TpmLoginViewState extends State<TpmLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  List<Map<String, dynamic>> socialLoginOptions = [
    {
      "name": "Google",
      "icon": Icons.g_mobiledata,
      "color": Colors.red,
    },
    {
      "name": "Microsoft",
      "icon": Icons.business,
      "color": Colors.blue,
    },
    {
      "name": "Apple",
      "icon": Icons.apple,
      "color": Colors.black,
    },
  ];

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Login successful! Welcome back.");
    // Navigate to dashboard
  }

  Future<void> _handleSocialLogin(String provider) async {
    showLoading();
    
    // Simulate social login
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("$provider login successful!");
    // Navigate to dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: 60),
            
            // Logo and Title
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.work,
                      size: 48,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Sign in to your TeamPro Manager account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Login Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  // Email Field
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
                            rememberMe = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to forgot password
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

                  SizedBox(height: spSm),

                  // Login Button
                  if (loading) ...[
                    Container(
                      height: 48,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In",
                        size: bs.md,
                        onPressed: _handleLogin,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Divider
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Social Login Options
            Column(
              spacing: spSm,
              children: [
                Text(
                  "Continue with",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: socialLoginOptions.map((option) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () => _handleSocialLogin("${option["name"]}"),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  option["icon"] as IconData,
                                  color: option["color"] as Color,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${option["name"]}",
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
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Quick Login (Demo)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Demo Account",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Use these credentials to explore the application:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Email: ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "demo@teampro.com",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Password: ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "demo123",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Use Demo Account",
                    size: bs.sm,
                    onPressed: () {
                      email = "demo@teampro.com";
                      password = "demo123";
                      setState(() {});
                      _handleLogin();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to register
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Help and Support
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  " • ",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Support",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  " • ",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Privacy",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
