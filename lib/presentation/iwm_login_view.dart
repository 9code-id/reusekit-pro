import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmLoginView extends StatefulWidget {
  const IwmLoginView({Key? key}) : super(key: key);

  @override
  State<IwmLoginView> createState() => _IwmLoginViewState();
}

class _IwmLoginViewState extends State<IwmLoginView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool obscurePassword = true;
  bool rememberMe = false;
  
  String email = "";
  String password = "";

  // Demo login options
  List<Map<String, dynamic>> demoAccounts = [
    {
      "title": "Warehouse Manager",
      "email": "manager@warehouse.com",
      "password": "manager123",
      "description": "Full access to all warehouse operations",
      "icon": Icons.admin_panel_settings,
      "color": primaryColor,
    },
    {
      "title": "Inventory Clerk",
      "email": "clerk@warehouse.com", 
      "password": "clerk123",
      "description": "Stock management and basic operations",
      "icon": Icons.inventory_2,
      "color": secondaryColor,
    },
    {
      "title": "Operations Staff",
      "email": "staff@warehouse.com",
      "password": "staff123", 
      "description": "Limited access for daily operations",
      "icon": Icons.people,
      "color": infoColor,
    },
  ];

  void _login() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      // Check demo credentials
      bool validCredentials = demoAccounts.any((account) => 
        account["email"] == email && account["password"] == password);
      
      if (validCredentials || (email == "admin@iwm.com" && password == "admin123")) {
        ss("Login successful! Welcome to IWM Pro");
        // Navigate to dashboard
      } else {
        se("Invalid credentials. Try demo accounts or admin@iwm.com / admin123");
      }
    }
  }

  void _loginWithDemo(Map<String, dynamic> account) {
    setState(() {
      email = account["email"];
      password = account["password"];
    });
    _login();
  }

  void _forgotPassword() {
    si("Password reset link sent to your email");
  }

  void _signUp() {
    si("Redirecting to registration...");
  }

  void _biometricLogin() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Biometric authentication successful");
    });
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.warehouse,
            color: Colors.white,
            size: 50,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "IWM Pro",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Intelligent Warehouse Management",
          style: TextStyle(
            fontSize: 14,
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Sign in to your account",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),

            // Email Field
            QTextField(
              label: "Email Address",
              value: email,
              validator: Validator.email,
              hint: "Enter your email address",
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Password",
                  value: password,
                  validator: Validator.required,
                  obscureText: obscurePassword,
                  hint: "Enter your password",
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
            SizedBox(height: spSm),

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
                  onTap: _forgotPassword,
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
            SizedBox(height: spMd),

            // Login Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Signing In..." : "Sign In",
                size: bs.md,
                onPressed: loading ? null : _login,
              ),
            ),
            SizedBox(height: spSm),

            // Biometric Login
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign in with Biometrics",
                icon: Icons.fingerprint,
                size: bs.md,
                onPressed: _biometricLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoAccounts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Demo Accounts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Try the app with these demo accounts",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),

          ...demoAccounts.map((account) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(radiusSm),
                onTap: () => _loginWithDemo(account),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (account["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          account["icon"] as IconData,
                          color: account["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${account["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${account["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${account["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: disabledColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: disabledColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Text(
                "OR",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(child: Divider(color: disabledColor)),
          ],
        ),
        SizedBox(height: spMd),

        // Social Login Options
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, size: 20, color: dangerColor),
                    SizedBox(width: spXs),
                    Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, size: 20, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "Apple",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),

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
              onTap: _signUp,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spXl),
            _buildLogo(),
            SizedBox(height: spLg),
            _buildLoginForm(),
            SizedBox(height: spMd),
            _buildDemoAccounts(),
            SizedBox(height: spMd),
            _buildFooter(),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
