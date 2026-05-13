import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaRegisterView extends StatefulWidget {
  const NmaRegisterView({Key? key}) : super(key: key);

  @override
  State<NmaRegisterView> createState() => _NmaRegisterViewState();
}

class _NmaRegisterViewState extends State<NmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  List<Map<String, dynamic>> interests = [
    {"label": "Politics", "value": "politics", "selected": false},
    {"label": "Technology", "value": "technology", "selected": true},
    {"label": "Sports", "value": "sports", "selected": false},
    {"label": "Business", "value": "business", "selected": true},
    {"label": "Entertainment", "value": "entertainment", "selected": false},
    {"label": "Science", "value": "science", "selected": false},
    {"label": "Health", "value": "health", "selected": true},
    {"label": "Travel", "value": "travel", "selected": false},
  ];

  List<Map<String, dynamic>> socialRegisters = [
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
              primaryColor.withAlpha(20),
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
                _buildRegistrationForm(),
                _buildInterestsSelection(),
                _buildSocialRegister(),
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
              "Join NewsMax",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Create your account and start reading personalized news",
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

  Widget _buildRegistrationForm() {
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
              "Create Account",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Name Fields
            Row(
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
                SizedBox(width: spSm),
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
                  hint: "Enter password",
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
                          fontSize: 12,
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
            
            // Confirm Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                QTextField(
                  label: "Confirm Password",
                  value: confirmPassword,
                  hint: "Confirm your password",
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
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Terms & Newsletter
            Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "I agree to Terms of Service and Privacy Policy",
                      "value": true,
                      "checked": agreeToTerms,
                    }
                  ],
                  value: [
                    if (agreeToTerms)
                      {
                        "label": "I agree to Terms of Service and Privacy Policy",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      agreeToTerms = values.isNotEmpty;
                    });
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Subscribe to newsletter for latest updates",
                      "value": true,
                      "checked": subscribeNewsletter,
                    }
                  ],
                  value: [
                    if (subscribeNewsletter)
                      {
                        "label": "Subscribe to newsletter for latest updates",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      subscribeNewsletter = values.isNotEmpty;
                    });
                  },
                ),
              ],
            ),
            
            // Register Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Creating Account..." : "Create Account",
                size: bs.md,
                onPressed: loading || !agreeToTerms ? null : _handleRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsSelection() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Select Your Interests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Choose topics you're interested in to personalize your news feed",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          // Interest Categories
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: interests.map((interest) {
              final isSelected = interest["selected"] as bool;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    interest["selected"] = !isSelected;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor 
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected 
                          ? primaryColor 
                          : disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "${interest["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected 
                          ? Colors.white 
                          : disabledBoldColor,
                      fontWeight: isSelected 
                          ? FontWeight.w600 
                          : FontWeight.normal,
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

  Widget _buildSocialRegister() {
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
                  "Or register with",
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
          
          // Social Register Buttons
          Row(
            children: socialRegisters.map((social) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  child: GestureDetector(
                    onTap: () => _handleSocialRegister(social["name"]),
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
                back();
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        
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
      ],
    );
  }

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    try {
      // Simulate registration process
      await Future.delayed(Duration(seconds: 3));
      
      // Get selected interests
      List<String> selectedInterests = interests
          .where((interest) => interest["selected"] as bool)
          .map((interest) => interest["label"] as String)
          .toList();
      
      ss("Account created successfully! Welcome to NewsMax");
      // ss('Next page'));
      
    } catch (e) {
      se("Registration failed. Please try again.");
    } finally {
      loading = false;
      setState(() {});
    }
  }

  void _handleSocialRegister(String provider) {
    si("Registering with $provider...");
    
    // Simulate social registration
    Future.delayed(Duration(seconds: 1), () {
      ss("Successfully registered with $provider");
      // ss('Next page'));
    });
  }
}
