import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmLoginView extends StatefulWidget {
  const FsmLoginView({super.key});

  @override
  State<FsmLoginView> createState() => _FsmLoginViewState();
}

class _FsmLoginViewState extends State<FsmLoginView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  
  String loginMethod = "email";
  
  List<Map<String, dynamic>> loginMethods = [
    {"label": "Email", "value": "email"},
    {"label": "Phone", "value": "phone"},
    {"label": "Farm ID", "value": "farm_id"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + spLg),
            _buildHeader(),
            _buildLoginForm(),
            _buildQuickActions(),
            _buildAlternativeLogin(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            successColor.withAlpha(20),
            primaryColor.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.agriculture,
              color: successColor,
              size: 48,
            ),
          ),
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Sign in to access your field management dashboard",
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Login Method",
              items: loginMethods,
              value: loginMethod,
              onChanged: (value, label) {
                loginMethod = value;
                setState(() {});
              },
            ),
            _buildLoginField(),
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
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Signing In..." : "Sign In",
                icon: Icons.login,
                size: bs.md,
                onPressed: loading ? null : _handleLogin,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _forgotPassword();
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
          ],
        ),
      ),
    );
  }

  Widget _buildLoginField() {
    switch (loginMethod) {
      case "phone":
        return QTextField(
          label: "Phone Number",
          value: email,
          validator: Validator.required,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        );
      case "farm_id":
        return QTextField(
          label: "Farm ID",
          value: email,
          validator: Validator.required,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        );
      default:
        return QTextField(
          label: "Email Address",
          value: email,
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        );
    }
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> quickActions = [
      {
        "title": "Field Status",
        "subtitle": "Check current field conditions",
        "icon": Icons.grass,
        "color": successColor,
      },
      {
        "title": "Weather Alert",
        "subtitle": "View weather warnings",
        "icon": Icons.cloud,
        "color": warningColor,
      },
      {
        "title": "Irrigation",
        "subtitle": "Quick irrigation control",
        "icon": Icons.water_drop,
        "color": infoColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
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
            "Access common features without full login",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...quickActions.map((action) => _buildQuickActionItem(action)),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(Map<String, dynamic> action) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (action["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: (action["color"] as Color).withAlpha(30),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (action["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              action["icon"],
              color: action["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${action["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${action["subtitle"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: disabledBoldColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeLogin() {
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
              Expanded(child: Divider(color: disabledOutlineBorderColor)),
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
              Expanded(child: Divider(color: disabledOutlineBorderColor)),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Continue with Demo",
              icon: Icons.play_arrow,
              size: bs.md,
              onPressed: () {
                _demoLogin();
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Biometric",
                  icon: Icons.fingerprint,
                  size: bs.sm,
                  onPressed: () {
                    _biometricLogin();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "QR Code",
                  icon: Icons.qr_code,
                  size: bs.sm,
                  onPressed: () {
                    _qrCodeLogin();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: primaryColor.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Text(
                "New to FieldSmart Manager?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "Join thousands of farmers optimizing their field operations",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Account",
                  icon: Icons.person_add,
                  size: bs.md,
                  onPressed: () {
                    //navigateTo(FsmRegisterView());
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHelpLink("Help Center", Icons.help),
            _buildHelpLink("Contact Support", Icons.support_agent),
            _buildHelpLink("System Status", Icons.health_and_safety),
          ],
        ),
        Text(
          "© 2024 FieldSmart Manager",
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpLink(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle help link
      },
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    showLoading();

    // Simulate login process
    await Future.delayed(Duration(seconds: 2));

    hideLoading();
    loading = false;
    setState(() {});

    ss("Login successful! Welcome back.");
    //navigateTo(FsmDashboardView());
  }

  void _forgotPassword() {
    si("Password reset link will be sent to your email");
  }

  void _demoLogin() {
    ss("Logging in with demo account...");
    //navigateTo(FsmDashboardView());
  }

  void _biometricLogin() {
    ss("Biometric authentication activated");
  }

  void _qrCodeLogin() {
    si("Please scan QR code from another device");
  }
}
