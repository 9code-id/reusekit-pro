import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosLoginView extends StatefulWidget {
  const PosLoginView({super.key});

  @override
  State<PosLoginView> createState() => _PosLoginViewState();
}

class _PosLoginViewState extends State<PosLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(10),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: spLg),

                // Logo and Title
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Icon(
                    Icons.point_of_sale,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                SizedBox(height: spMd),

                Text(
                  "SmartPOS",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),

                Text(
                  "Sign in to your account",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXl),

                // Login Form
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: spMd,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        QTextField(
                          label: "Email Address",
                          value: email,
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
                                // navigateTo('ForgotPasswordView')
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

                        if (loading)
                          CircularProgressIndicator()
                        else
                          QButton(
                            label: "Sign In",
                            size: bs.md,
                            onPressed: () {
                              _login();
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spMd),

                // Alternative Login Options
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "PIN Login",
                              size: bs.md,
                              onPressed: () {
                                // navigateTo('PosPinLoginView')
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Demo Mode",
                              size: bs.md,
                              onPressed: () {
                                _loginDemo();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Register Link
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
                        // navigateTo('PosRegisterView')
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
                SizedBox(height: spLg),

                // Features Preview
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: primaryColor.withAlpha(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Why Choose SmartPOS?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: _buildFeatureItem(Icons.speed, "Fast Checkout"),
                          ),
                          Expanded(
                            child: _buildFeatureItem(Icons.inventory, "Inventory"),
                          ),
                          Expanded(
                            child: _buildFeatureItem(Icons.analytics, "Analytics"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Version Info
                Text(
                  "SmartPOS v2.1.0",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _login() {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        loading = false;
        setState(() {});
        
        // Check credentials
        if (email == "admin@smartpos.com" && password == "admin123") {
          ss("Login successful!");
          // navigateTo('PosDashboardView')
        } else {
          se("Invalid email or password");
        }
      });
    }
  }

  void _loginDemo() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Welcome to Demo Mode!");
      // navigateTo('PosDashboardView', arguments: {"mode": "demo"})
    });
  }
}
