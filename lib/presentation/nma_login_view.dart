import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaLoginView extends StatefulWidget {
  const NmaLoginView({Key? key}) : super(key: key);

  @override
  State<NmaLoginView> createState() => _NmaLoginViewState();
}

class _NmaLoginViewState extends State<NmaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  List<Map<String, dynamic>> socialLogins = [
    {
      "name": "Google",
      "icon": Icons.g_mobiledata,
      "color": dangerColor,
    },
    {
      "name": "Facebook", 
      "icon": Icons.facebook,
      "color": infoColor,
    },
    {
      "name": "Apple",
      "icon": Icons.apple,
      "color": Colors.black,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(30),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spXl,
              children: [
                _buildHeader(),
                _buildLoginForm(),
                _buildSocialLogin(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      spacing: spLg,
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radius2xl),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.newspaper,
            size: 40,
            color: Colors.white,
          ),
        ),
        
        // Welcome Text
        Column(
          spacing: spSm,
          children: [
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Stay informed with the latest news",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(spLg),
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
              "Sign In",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
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
              spacing: spXs,
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
                    // ss('Next page'));
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
                label: loading ? "Signing In..." : "Sign In",
                size: bs.md,
                onPressed: loading ? null : _handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: disabledColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Text(
                  "Or continue with",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
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
          
          // Social Login Buttons
          Row(
            children: socialLogins.map((social) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  child: GestureDetector(
                    onTap: () => _handleSocialLogin(social["name"]),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Icon(
                            social["icon"] as IconData,
                            size: 24,
                            color: social["color"],
                          ),
                          Text(
                            "${social["name"]}",
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
    );
  }

  Widget _buildFooter() {
    return Column(
      spacing: spLg,
      children: [
        // Guest Mode
        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue as Guest",
            size: bs.md,
            onPressed: () {
              // ss('Next page'));
            },
          ),
        ),
        
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
                // ss('Next page'));
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
        
        // Terms & Privacy
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Text(
            "By signing in, you agree to our Terms of Service and Privacy Policy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    try {
      // Simulate login process
      await Future.delayed(Duration(seconds: 2));
      
      ss("Welcome back! Login successful");
      // ss('Next page'));
      
    } catch (e) {
      se("Login failed. Please check your credentials.");
    } finally {
      loading = false;
      setState(() {});
    }
  }

  void _handleSocialLogin(String provider) {
    si("Signing in with $provider...");
    
    // Simulate social login
    Future.delayed(Duration(seconds: 1), () {
      ss("Successfully signed in with $provider");
      // ss('Next page'));
    });
  }
}
