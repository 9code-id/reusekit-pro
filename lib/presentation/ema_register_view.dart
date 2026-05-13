import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaRegisterView extends StatefulWidget {
  const EmaRegisterView({super.key});

  @override
  State<EmaRegisterView> createState() => _EmaRegisterViewState();
}

class _EmaRegisterViewState extends State<EmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    // App Logo
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withAlpha(180)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusXl),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.person_add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Welcome Text
                    Text(
                      "Join Email Manager",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Create your account to get started with powerful email management",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Registration Form
              Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    // Name Fields
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
                            hint: "Enter your first name",
                            validator: Validator.required,
                            onChanged: (value) {
                              firstName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QTextField(
                            label: "Last Name",
                            value: lastName,
                            hint: "Enter your last name",
                            validator: Validator.required,
                            onChanged: (value) {
                              lastName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
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
                        SizedBox(height: spSm),
                        Row(
                          children: [
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
                            Spacer(),
                            Text(
                              "Minimum 8 characters",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Confirm Password Field
                    Column(
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
                            return Validator.required(value);
                          },
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spSm),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              obscureConfirmPassword = !obscureConfirmPassword;
                              setState(() {});
                            },
                            child: Text(
                              obscureConfirmPassword ? "Show" : "Hide",
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
                    
                    // Password Strength Indicator
                    _buildPasswordStrengthIndicator(),
                    
                    // Terms and Newsletter
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          // Terms Agreement
                          QSwitch(
                            items: [
                              {
                                "label": "I agree to the Terms of Service and Privacy Policy",
                                "value": true,
                                "checked": agreeToTerms,
                              }
                            ],
                            value: [
                              if (agreeToTerms)
                                {
                                  "label": "I agree to the Terms of Service and Privacy Policy",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              agreeToTerms = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Newsletter Subscription
                          QSwitch(
                            items: [
                              {
                                "label": "Subscribe to our newsletter for updates and tips",
                                "value": true,
                                "checked": subscribeNewsletter,
                              }
                            ],
                            value: [
                              if (subscribeNewsletter)
                                {
                                  "label": "Subscribe to our newsletter for updates and tips",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              subscribeNewsletter = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Register Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Account",
                        size: bs.md,
                        onPressed: (isLoading || !agreeToTerms) ? null : _handleRegister,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "Or sign up with",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Social Registration Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton(
                            "Google",
                            Icons.g_mobiledata,
                            () => _handleSocialRegister("Google"),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: _buildSocialButton(
                            "Microsoft",
                            Icons.business,
                            () => _handleSocialRegister("Microsoft"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPasswordStrengthIndicator() {
    int strength = _calculatePasswordStrength(password);
    Color strengthColor = strength < 2 
        ? dangerColor 
        : strength < 4 
            ? warningColor 
            : successColor;
    
    String strengthText = strength < 2 
        ? "Weak" 
        : strength < 4 
            ? "Medium" 
            : "Strong";
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: strengthColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Password Strength: ",
                style: TextStyle(
                  fontSize: 12,
                  color: strengthColor,
                ),
              ),
              Text(
                strengthText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: strengthColor,
                ),
              ),
              Spacer(),
              ...List.generate(5, (index) => Container(
                width: 20,
                height: 4,
                margin: EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: index < strength ? strengthColor : strengthColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              )),
            ],
          ),
          if (password.isNotEmpty) ...[
            SizedBox(height: spSm),
            _buildPasswordRequirements(),
          ],
        ],
      ),
    );
  }
  
  Widget _buildPasswordRequirements() {
    List<Map<String, dynamic>> requirements = [
      {"text": "At least 8 characters", "met": password.length >= 8},
      {"text": "Contains uppercase letter", "met": password.contains(RegExp(r'[A-Z]'))},
      {"text": "Contains lowercase letter", "met": password.contains(RegExp(r'[a-z]'))},
      {"text": "Contains number", "met": password.contains(RegExp(r'[0-9]'))},
      {"text": "Contains special character", "met": password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))},
    ];
    
    return Column(
      children: requirements.map((req) => Row(
        children: [
          Icon(
            req["met"] ? Icons.check : Icons.close,
            size: 14,
            color: req["met"] ? successColor : dangerColor,
          ),
          SizedBox(width: spSm),
          Text(
            req["text"],
            style: TextStyle(
              fontSize: 11,
              color: req["met"] ? successColor : dangerColor,
            ),
          ),
        ],
      )).toList(),
    );
  }
  
  Widget _buildSocialButton(String label, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: disabledOutlineBorderColor),
          boxShadow: [shadowSm],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
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
    );
  }
  
  int _calculatePasswordStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;
    return strength;
  }
  
  void _handleRegister() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreeToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    // Simulate registration process
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    
    ss("Account created successfully! Please verify your email.");
  }
  
  void _handleSocialRegister(String provider) {
    ss("Creating account with $provider");
  }
}
