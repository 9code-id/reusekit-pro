import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaRegisterView extends StatefulWidget {
  const PpaRegisterView({super.key});

  @override
  State<PpaRegisterView> createState() => _PpaRegisterViewState();
}

class _PpaRegisterViewState extends State<PpaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String phoneNumber = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  String selectedCountry = "United States";
  String photographyLevel = "Beginner";
  String primaryInterest = "Portrait";

  List<String> countryOptions = [
    "United States", "Canada", "United Kingdom", "Australia", 
    "Germany", "France", "Japan", "South Korea", "Brazil", "Mexico"
  ];

  List<String> levelOptions = ["Beginner", "Intermediate", "Advanced", "Professional"];

  List<String> interestOptions = [
    "Portrait", "Landscape", "Street", "Wildlife", "Macro", 
    "Sports", "Fashion", "Architecture", "Travel", "Abstract"
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
              primaryColor.withAlpha(20),
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
                SizedBox(height: spMd),
                
                // App Logo and Welcome
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Join thousands of photographers worldwide",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: spXl),

                // Registration Form
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information Section
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),

                      // Name Fields
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "First Name",
                              value: firstName,
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
                              validator: Validator.required,
                              onChanged: (value) {
                                lastName = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Email Field
                      QTextField(
                        label: "Email Address",
                        value: email,
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spMd),

                      // Phone Number
                      QTextField(
                        label: "Phone Number (Optional)",
                        value: phoneNumber,
                        onChanged: (value) {
                          phoneNumber = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spMd),

                      // Country Selection
                      QDropdownField(
                        label: "Country",
                        items: countryOptions.map((country) => {
                          "label": country,
                          "value": country,
                        }).toList(),
                        value: selectedCountry,
                        onChanged: (value, label) {
                          selectedCountry = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spXl),

                      // Account Security Section
                      Text(
                        "Account Security",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),

                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                          GestureDetector(
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
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Confirm Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          QTextField(
                            label: "Confirm Password",
                            value: confirmPassword,
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
                          SizedBox(height: spXs),
                          GestureDetector(
                            onTap: () {
                              obscureConfirmPassword = !obscureConfirmPassword;
                              setState(() {});
                            },
                            child: Text(
                              obscureConfirmPassword ? "Show Password" : "Hide Password",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spXl),

                      // Photography Preferences Section
                      Text(
                        "Photography Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),

                      QDropdownField(
                        label: "Photography Level",
                        items: levelOptions.map((level) => {
                          "label": level,
                          "value": level,
                        }).toList(),
                        value: photographyLevel,
                        onChanged: (value, label) {
                          photographyLevel = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spMd),

                      QDropdownField(
                        label: "Primary Interest",
                        items: interestOptions.map((interest) => {
                          "label": interest,
                          "value": interest,
                        }).toList(),
                        value: primaryInterest,
                        onChanged: (value, label) {
                          primaryInterest = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spXl),

                      // Terms and Preferences
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: agreeToTerms,
                                  onChanged: (value) {
                                    agreeToTerms = value ?? false;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      agreeToTerms = !agreeToTerms;
                                      setState(() {});
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        children: [
                                          TextSpan(text: "I agree to the "),
                                          TextSpan(
                                            text: "Terms of Service",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: " and "),
                                          TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: subscribeNewsletter,
                                  onChanged: (value) {
                                    subscribeNewsletter = value ?? false;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      subscribeNewsletter = !subscribeNewsletter;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Send me photography tips and updates",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Register Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Create Account",
                          size: bs.md,
                          onPressed: (loading || !agreeToTerms) ? null : () {
                            _register();
                          },
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Social Registration
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: spMd),
                                child: Text(
                                  "Or register with",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),

                          SizedBox(height: spMd),

                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  "Google",
                                  Icons.g_mobiledata,
                                  Colors.red,
                                  () => _socialRegister("google"),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: _buildSocialButton(
                                  "Apple",
                                  Icons.apple,
                                  Colors.black,
                                  () => _socialRegister("apple"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spXl),

                      // Already have account
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
                              _navigateToLogin();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withAlpha(100)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    if (!formKey.currentState!.validate()) return;

    if (!agreeToTerms) {
      se("Please agree to the Terms of Service to continue");
      return;
    }

    loading = true;
    setState(() {});

    showLoading();
    
    try {
      // Simulate registration API call
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      
      // Show success message and navigate
      ss("Account created successfully! Welcome to PhotoPro.");
      // navigateTo EmailVerificationView or HomeView
      
    } catch (e) {
      hideLoading();
      se("Registration failed. Please try again.");
    } finally {
      loading = false;
      setState(() {});
    }
  }

  void _socialRegister(String provider) async {
    showLoading();
    
    try {
      // Simulate social registration
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("$provider registration successful!");
      // navigateTo HomeView
    } catch (e) {
      hideLoading();
      se("$provider registration failed");
    }
  }

  void _navigateToLogin() {
    // navigateTo LoginView
    ss("Opening login screen");
  }
}
