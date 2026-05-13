import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaLoginView extends StatefulWidget {
  const PmaLoginView({super.key});

  @override
  State<PmaLoginView> createState() => _PmaLoginViewState();
}

class _PmaLoginViewState extends State<PmaLoginView> {
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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withAlpha(200),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spLg,
              children: [
                _buildHeader(),
                _buildLoginForm(),
                _buildSocialLogin(),
                _buildFooterLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      spacing: spMd,
      children: [
        SizedBox(height: spXl),
        
        // Logo
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.analytics,
              size: 50,
              color: primaryColor,
            ),
          ),
        ),
        
        // Welcome text
        Column(
          spacing: spSm,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Sign in to Performance Manager",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
                fontWeight: FontWeight.w500,
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
        boxShadow: [shadowLg],
      ),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            // Form title
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Email field
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
            
            // Password field
            Column(
              spacing: spXs,
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
            
            // Remember me and forgot password
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
                    value: rememberMe ? [{"label": "Remember me", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      rememberMe = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                GestureDetector(
                  onTap: _goToForgotPassword,
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
            
            // Login button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Signing In..." : "Sign In",
                icon: Icons.login,
                size: bs.md,
                onPressed: loading ? null : _signIn,
              ),
            ),
            
            // Biometric login
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(child: Divider(color: disabledColor)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: disabledColor)),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Face ID",
                    icon: Icons.face,
                    size: bs.sm,
                    onPressed: _signInWithBiometric,
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Fingerprint",
                    icon: Icons.fingerprint,
                    size: bs.sm,
                    onPressed: _signInWithBiometric,
                  ),
                ),
              ],
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
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: Colors.white.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Continue with",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildSocialButton(
                  "Google",
                  Icons.g_mobiledata,
                  () => _signInWithSocial("Google"),
                ),
              ),
              Expanded(
                child: _buildSocialButton(
                  "Microsoft",
                  Icons.business,
                  () => _signInWithSocial("Microsoft"),
                ),
              ),
            ],
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildSocialButton(
                  "Apple",
                  Icons.apple,
                  () => _signInWithSocial("Apple"),
                ),
              ),
              Expanded(
                child: _buildSocialButton(
                  "LinkedIn",
                  Icons.work,
                  () => _signInWithSocial("LinkedIn"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      spacing: spMd,
      children: [
        // Sign up link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(200),
              ),
            ),
            GestureDetector(
              onTap: _goToRegister,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        
        // Terms and privacy
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              "By signing in, you agree to our ",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(150),
              ),
            ),
            GestureDetector(
              onTap: () => si("Opening Terms of Service..."),
              child: Text(
                "Terms of Service",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              " and ",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(150),
              ),
            ),
            GestureDetector(
              onTap: () => si("Opening Privacy Policy..."),
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Version info
        Text(
          "Performance Manager v2.1.0",
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withAlpha(100),
          ),
        ),
      ],
    );
  }

  void _signIn() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate login process
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Login successful! Welcome back");
    // Navigate to main app
    // await offAll(DashboardView());
  }

  void _signInWithBiometric() {
    si("Authenticating with biometric...");
    // Implement biometric authentication
  }

  void _signInWithSocial(String provider) {
    si("Signing in with $provider...");
    // Implement social login
  }

  void _goToForgotPassword() {
    // Navigate to forgot password
    // ss('Next page'));
    si("Opening forgot password...");
  }

  void _goToRegister() {
    // Navigate to register
    // ss('Next page'));
    si("Opening registration...");
  }
}
