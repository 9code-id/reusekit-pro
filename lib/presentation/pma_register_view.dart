import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaRegisterView extends StatefulWidget {
  const PmaRegisterView({super.key});

  @override
  State<PmaRegisterView> createState() => _PmaRegisterViewState();
}

class _PmaRegisterViewState extends State<PmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String company = "";
  String jobTitle = "";
  bool acceptTerms = false;
  bool subscribeNewsletter = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
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
              secondaryColor,
              secondaryColor.withAlpha(200),
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
                _buildRegistrationForm(),
                _buildSocialSignup(),
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
        SizedBox(height: spLg),
        
        // Logo
        Container(
          width: 80,
          height: 80,
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
              size: 40,
              color: secondaryColor,
            ),
          ),
        ),
        
        // Welcome text
        Column(
          spacing: spSm,
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Join Performance Manager today",
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

  Widget _buildRegistrationForm() {
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
              "Sign Up",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Name fields
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "First Name",
                    value: firstName,
                    hint: "Enter first name",
                    validator: Validator.required,
                    onChanged: (value) {
                      firstName = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QTextField(
                    label: "Last Name",
                    value: lastName,
                    hint: "Enter last name",
                    validator: Validator.required,
                    onChanged: (value) {
                      lastName = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
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
            
            // Company and job title
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Company",
                    value: company,
                    hint: "Enter company name",
                    onChanged: (value) {
                      company = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QTextField(
                    label: "Job Title",
                    value: jobTitle,
                    hint: "Enter job title",
                    onChanged: (value) {
                      jobTitle = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Password field
            Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Password",
                  value: password,
                  hint: "Create a strong password",
                  obscureText: obscurePassword,
                  validator: Validator.required,
                  onChanged: (value) {
                    password = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "At least 8 characters with numbers and symbols",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
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
                          color: secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Confirm password field
            Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Confirm Password",
                  value: confirmPassword,
                  hint: "Re-enter your password",
                  obscureText: obscureConfirmPassword,
                  validator: (value) {
                    if (value != password) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    confirmPassword = value;
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      obscureConfirmPassword = !obscureConfirmPassword;
                      setState(() {});
                    },
                    child: Text(
                      obscureConfirmPassword ? "Show" : "Hide",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Password strength indicator
            _buildPasswordStrength(),
            
            // Terms and newsletter
            Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "I accept the Terms of Service and Privacy Policy",
                      "value": "terms",
                      "checked": acceptTerms,
                    }
                  ],
                  value: acceptTerms ? [{"label": "I accept the Terms of Service and Privacy Policy", "value": "terms", "checked": true}] : [],
                  onChanged: (values, ids) {
                    acceptTerms = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Subscribe to newsletter and updates",
                      "value": "newsletter",
                      "checked": subscribeNewsletter,
                    }
                  ],
                  value: subscribeNewsletter ? [{"label": "Subscribe to newsletter and updates", "value": "newsletter", "checked": true}] : [],
                  onChanged: (values, ids) {
                    subscribeNewsletter = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Register button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Creating Account..." : "Create Account",
                icon: Icons.person_add,
                size: bs.md,
                onPressed: (loading || !acceptTerms) ? null : _register,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrength() {
    double strength = _calculatePasswordStrength(password);
    Color strengthColor = strength < 0.3 ? dangerColor : 
                         strength < 0.7 ? warningColor : successColor;
    String strengthText = strength < 0.3 ? "Weak" : 
                         strength < 0.7 ? "Medium" : "Strong";

    return Column(
      spacing: spXs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Password Strength: ",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              strengthText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: strengthColor,
              ),
            ),
          ],
        ),
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusXs),
            color: disabledColor,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: strength,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusXs),
                color: strengthColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSignup() {
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
          Row(
            children: [
              Expanded(child: Divider(color: Colors.white.withAlpha(100))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                child: Text(
                  "or sign up with",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.white.withAlpha(100))),
            ],
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildSocialButton(
                  "Google",
                  Icons.g_mobiledata,
                  () => _signUpWithSocial("Google"),
                ),
              ),
              Expanded(
                child: _buildSocialButton(
                  "Microsoft",
                  Icons.business,
                  () => _signUpWithSocial("Microsoft"),
                ),
              ),
            ],
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildSocialButton(
                  "LinkedIn",
                  Icons.work,
                  () => _signUpWithSocial("LinkedIn"),
                ),
              ),
              Expanded(
                child: _buildSocialButton(
                  "GitHub",
                  Icons.code,
                  () => _signUpWithSocial("GitHub"),
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
                  color: secondaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: secondaryColor,
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
        // Sign in link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(200),
              ),
            ),
            GestureDetector(
              onTap: _goToLogin,
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        
        // Feature highlights
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: Colors.white.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            spacing: spXs,
            children: [
              Text(
                "What you'll get:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              _buildFeatureHighlight("Advanced analytics and insights"),
              _buildFeatureHighlight("AI-powered recommendations"),
              _buildFeatureHighlight("Real-time collaboration tools"),
              _buildFeatureHighlight("Free 30-day trial"),
            ],
          ),
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

  Widget _buildFeatureHighlight(String feature) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            feature,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ),
      ],
    );
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    
    double strength = 0.0;
    
    // Length check
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.15;
    
    // Character variety checks
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.15;
    
    return strength.clamp(0.0, 1.0);
  }

  void _register() async {
    if (!formKey.currentState!.validate()) return;
    if (!acceptTerms) {
      se("Please accept the Terms of Service");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate registration process
    await Future.delayed(Duration(seconds: 3));

    loading = false;
    setState(() {});

    ss("Account created successfully! Welcome to Performance Manager");
    // Navigate to verification or main app
    // await offAll(EmailVerificationView());
  }

  void _signUpWithSocial(String provider) {
    si("Signing up with $provider...");
    // Implement social signup
  }

  void _goToLogin() {
    // Navigate to login
    // await back();
    si("Opening login...");
  }
}
