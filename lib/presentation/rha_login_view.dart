import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaLoginView extends StatefulWidget {
  const RhaLoginView({super.key});

  @override
  State<RhaLoginView> createState() => _RhaLoginViewState();
}

class _RhaLoginViewState extends State<RhaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;
  
  String selectedRole = "doctor";
  
  List<Map<String, dynamic>> userRoles = [
    {"label": "Doctor", "value": "doctor"},
    {"label": "Nurse", "value": "nurse"},
    {"label": "Therapist", "value": "therapist"},
    {"label": "Administrator", "value": "admin"},
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
              primaryColor.withAlpha(10),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(spLg),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: spLg,
                      children: [
                        SizedBox(height: spXl),
                        _buildHeader(),
                        _buildLoginForm(),
                        _buildLoginOptions(),
                        _buildLoginButton(),
                        _buildDivider(),
                        _buildQuickAccess(),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
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
            Icons.medical_services,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "Sign in to access your RehabAssist dashboard",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
      ],
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
      child: Column(
        spacing: spMd,
        children: [
          QDropdownField(
            label: "Login as",
            items: userRoles,
            value: selectedRole,
            onChanged: (value, label) {
              selectedRole = value;
              setState(() {});
            },
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
        ],
      ),
    );
  }

  Widget _buildLoginOptions() {
    return Row(
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
          onTap: () => _forgotPassword(),
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
        icon: Icons.login,
        size: bs.md,
        onPressed: () => _handleLogin(),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: disabledOutlineBorderColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Text(
            "or",
            style: TextStyle(
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: disabledOutlineBorderColor)),
      ],
    );
  }

  Widget _buildQuickAccess() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Access",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Use demo credentials for testing purposes",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildQuickAccessButton(
                "Demo Doctor",
                "doctor@demo.com",
                Icons.medical_services,
                primaryColor,
              ),
              _buildQuickAccessButton(
                "Demo Nurse",
                "nurse@demo.com",
                Icons.local_hospital,
                successColor,
              ),
              _buildQuickAccessButton(
                "Demo Therapist",
                "therapist@demo.com",
                Icons.fitness_center,
                warningColor,
              ),
              _buildQuickAccessButton(
                "Demo Admin",
                "admin@demo.com",
                Icons.admin_panel_settings,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(
    String role,
    String demoEmail,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => _useQuickAccess(demoEmail, role.toLowerCase()),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              role,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              demoEmail,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
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
              onTap: () => _navigateToSignUp(),
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
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: infoColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Your data is protected with enterprise-grade security and HIPAA compliance",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "© 2024 RehabAssist Technologies • Version 2.1.0",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate login API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      // Navigate to dashboard
      ss("Login successful! Welcome to RehabAssist");
      // ss('Next page'));
    }
  }

  void _useQuickAccess(String demoEmail, String role) {
    email = demoEmail;
    selectedRole = role;
    password = "demo123";
    setState(() {});
    
    si("Demo credentials loaded for $role");
  }

  void _forgotPassword() {
    // Navigate to forgot password
    si("Forgot password feature");
  }

  void _navigateToSignUp() {
    // Navigate to sign up
    si("Navigate to sign up");
  }
}
