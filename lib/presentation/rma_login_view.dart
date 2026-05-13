import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaLoginView extends StatefulWidget {
  const RmaLoginView({super.key});

  @override
  State<RmaLoginView> createState() => _RmaLoginViewState();
}

class _RmaLoginViewState extends State<RmaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate login process
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    loading = false;
    setState(() {});
    
    ss("Login successful! Welcome back");
    //navigateTo('RmaHomeView')
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant,
              size: 50,
              color: primaryColor,
            ),
          ),
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Sign in to your restaurant management account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
              "Login to Your Account",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                    //navigateTo('RmaForgotPasswordView')
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
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign In",
                size: bs.md,
                onPressed: _login,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLogin() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Quick Login Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Google",
                  icon: Icons.g_mobiledata,
                  color: dangerColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Signing in with Google");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Apple",
                  icon: Icons.apple,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Signing in with Apple");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoAccounts() {
    final demoAccounts = [
      {
        "title": "Restaurant Owner",
        "email": "owner@restaurant.com",
        "description": "Full access to all features",
        "color": primaryColor,
      },
      {
        "title": "Manager",
        "email": "manager@restaurant.com", 
        "description": "Staff and inventory management",
        "color": successColor,
      },
      {
        "title": "Staff Member",
        "email": "staff@restaurant.com",
        "description": "Basic order and customer access",
        "color": infoColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Demo Accounts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Try different user roles with these demo accounts",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...demoAccounts.map((account) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (account["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: (account["color"] as Color).withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: account["color"] as Color,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${account["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${account["email"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: account["color"] as Color,
                        ),
                      ),
                      Text(
                        "${account["description"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Try",
                  color: account["color"] as Color,
                  size: bs.sm,
                  onPressed: () {
                    email = "${account["email"]}";
                    password = "demo123";
                    setState(() {});
                    ss("Demo account loaded - Password: demo123");
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
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
              //navigateTo('RmaRegisterView')
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            _buildHeader(),
            _buildLoginForm(),
            _buildQuickLogin(),
            _buildDemoAccounts(),
            _buildSignUpSection(),
          ],
        ),
      ),
    );
  }
}
