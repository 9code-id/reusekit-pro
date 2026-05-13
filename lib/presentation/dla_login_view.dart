import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaLoginView extends StatefulWidget {
  const DlaLoginView({super.key});

  @override
  State<DlaLoginView> createState() => _DlaLoginViewState();
}

class _DlaLoginViewState extends State<DlaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool isLoading = false;
  
  String selectedLoginMethod = "Email";
  
  List<Map<String, dynamic>> loginMethods = [
    {"label": "Email", "value": "Email"},
    {"label": "Username", "value": "Username"},
    {"label": "Phone", "value": "Phone"},
  ];

  List<Map<String, dynamic>> socialLogins = [
    {
      "name": "Google",
      "icon": Icons.g_mobiledata,
      "color": dangerColor,
    },
    {
      "name": "Microsoft",
      "icon": Icons.computer,
      "color": infoColor,
    },
    {
      "name": "LinkedIn",
      "icon": Icons.business,
      "color": primaryColor,
    },
  ];

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
              Colors.white,
              infoColor.withAlpha(5),
            ],
          ),
        ),
        child: SafeArea(
          child: isLoading 
              ? _buildLoadingState()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildLoginContent(),
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spLg,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 3,
            ),
          ),
          Column(
            spacing: spXs,
            children: [
              Text(
                "Signing you in...",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Please wait while we verify your credentials",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginContent() {
    return Column(
      spacing: spLg,
      children: [
        _buildHeader(),
        _buildLoginForm(),
        _buildSocialLogin(),
        _buildFooter(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      spacing: spMd,
      children: [
        SizedBox(height: spXl),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor,
                primaryColor.withAlpha(180),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [shadowLg],
          ),
          child: Icon(
            Icons.auto_awesome,
            size: 50,
            color: Colors.white,
          ),
        ),
        Column(
          spacing: spXs,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Sign in to DeepLearning Analytics",
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
            _buildLoginMethodSelector(),
            _buildEmailField(),
            _buildPasswordField(),
            _buildOptionsRow(),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Login Method",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        QCategoryPicker(
          items: loginMethods,
          value: selectedLoginMethod,
          onChanged: (index, label, value, item) {
            selectedLoginMethod = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    String label = selectedLoginMethod == "Email" 
        ? "Email Address" 
        : selectedLoginMethod == "Username" 
            ? "Username" 
            : "Phone Number";
    
    return QTextField(
      label: label,
      value: email,
      validator: Validator.required,
      onChanged: (value) {
        email = value;
        setState(() {});
      },
    );
  }

  Widget _buildPasswordField() {
    return Column(
      spacing: spXs,
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
    );
  }

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            value: [if (rememberMe) {"label": "Remember me", "value": true, "checked": true}],
            onChanged: (values, ids) {
              rememberMe = values.isNotEmpty;
              setState(() {});
            },
          ),
        ),
        GestureDetector(
          onTap: () => _showForgotPasswordDialog(),
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
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Sign In",
        size: bs.md,
        onPressed: () => _handleLogin(),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(child: Divider(color: disabledColor)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                child: Text(
                  "Or continue with",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Expanded(child: Divider(color: disabledColor)),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: socialLogins.map((social) {
              return _buildSocialButton(social);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(Map<String, dynamic> social) {
    return GestureDetector(
      onTap: () => _handleSocialLogin(social["name"]),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: social["color"].withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: social["color"].withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              social["icon"] as IconData,
              color: social["color"] as Color,
              size: 24,
            ),
            Text(
              "${social["name"]}",
              style: TextStyle(
                fontSize: 12,
                color: social["color"] as Color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      spacing: spMd,
      children: [
        _buildQuickAccess(),
        _buildSignUpPrompt(),
        _buildVersionInfo(),
      ],
    );
  }

  Widget _buildQuickAccess() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: infoColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: infoColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Demo Account",
                  size: bs.sm,
                  onPressed: () => _loginWithDemo(),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Guest Mode",
                  size: bs.sm,
                  onPressed: () => _loginAsGuest(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: successColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Don't have an account yet?",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Account",
              size: bs.sm,
              onPressed: () => _navigateToSignUp(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Column(
      spacing: spXs,
      children: [
        Text(
          "DeepLearning Analytics v2.1.0",
          style: TextStyle(
            fontSize: 11,
            color: disabledColor,
          ),
        ),
        Text(
          "© 2024 DeepLearning Analytics Inc. All rights reserved.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isLoading = false;
        });
        
        if (email.isNotEmpty && password.isNotEmpty) {
          ss("Login successful! Welcome back.");
          //navigateTo ( DashboardView() );
        } else {
          se("Invalid credentials. Please try again.");
        }
      });
    }
  }

  void _handleSocialLogin(String provider) {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("$provider login successful!");
      //navigateTo ( DashboardView() );
    });
  }

  void _loginWithDemo() {
    setState(() {
      email = "demo@dla.com";
      password = "demo123";
    });
    _handleLogin();
  }

  void _loginAsGuest() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      si("Signed in as guest user");
      //navigateTo ( DashboardView() );
    });
  }

  void _navigateToSignUp() {
    si("Redirecting to sign up page");
    //navigateTo ( SignUpView() );
  }

  void _showForgotPasswordDialog() {
    String resetEmail = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Enter your email address and we'll send you a link to reset your password.",
            ),
            QTextField(
              label: "Email Address",
              value: resetEmail,
              validator: Validator.email,
              onChanged: (value) {
                resetEmail = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send Reset Link",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              if (resetEmail.isNotEmpty) {
                ss("Password reset link sent to $resetEmail");
              }
            },
          ),
        ],
      ),
    );
  }
}
