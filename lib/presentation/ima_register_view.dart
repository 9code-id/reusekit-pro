import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaRegisterView extends StatefulWidget {
  const ImaRegisterView({super.key});

  @override
  State<ImaRegisterView> createState() => _ImaRegisterViewState();
}

class _ImaRegisterViewState extends State<ImaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String phone = "";
  String profession = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool loading = false;

  List<Map<String, dynamic>> professionItems = [
    {"label": "Professional Photographer", "value": "professional_photographer"},
    {"label": "Amateur Photographer", "value": "amateur_photographer"},
    {"label": "Photo Editor", "value": "photo_editor"},
    {"label": "Graphic Designer", "value": "graphic_designer"},
    {"label": "Social Media Manager", "value": "social_media_manager"},
    {"label": "Content Creator", "value": "content_creator"},
    {"label": "Student", "value": "student"},
    {"label": "Other", "value": "other"},
  ];

  void _register() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the Terms of Service and Privacy Policy");
        return;
      }
      
      if (password != confirmPassword) {
        se("Passwords do not match");
        return;
      }
      
      loading = true;
      setState(() {});
      
      // Simulate registration process
      await Future.delayed(Duration(seconds: 3));
      
      loading = false;
      setState(() {});
      
      ss("Account created successfully! Welcome to ImageMaster.");
      // Navigate to main app or email verification
    }
  }

  void _registerWithGoogle() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Google registration successful!");
    // Navigate to main app
  }

  void _registerWithApple() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Apple registration successful!");
    // Navigate to main app
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Creating your account...",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Setting up your photography workspace",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              secondaryColor.withAlpha(30),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spMd),
                
                // Back button and logo
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate back to login
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.photo_camera,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 32), // Balance the back button
                  ],
                ),
                
                SizedBox(height: spLg),
                
                // Title and subtitle
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "Join the ImageMaster community",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Registration form
                Form(
                  key: formKey,
                  child: Column(
                    spacing: spSm,
                    children: [
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
                          SizedBox(width: spSm),
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

                      QTextField(
                        label: "Email Address",
                        value: email,
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),

                      QTextField(
                        label: "Phone Number",
                        value: phone,
                        hint: "+1 (555) 123-4567",
                        validator: Validator.required,
                        onChanged: (value) {
                          phone = value;
                          setState(() {});
                        },
                      ),

                      QDropdownField(
                        label: "Profession/Interest",
                        items: professionItems,
                        value: profession,
                        validator: Validator.required,
                        onChanged: (value, label) {
                          profession = value;
                          setState(() {});
                        },
                      ),

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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QTextField(
                            label: "Confirm Password",
                            value: confirmPassword,
                            obscureText: obscureConfirmPassword,
                            validator: Validator.required,
                            onChanged: (value) {
                              confirmPassword = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
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

                      // Terms and conditions
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
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

                            QSwitch(
                              items: [
                                {
                                  "label": "Subscribe to photography tips and updates",
                                  "value": true,
                                  "checked": subscribeNewsletter,
                                }
                              ],
                              value: [
                                if (subscribeNewsletter)
                                  {
                                    "label": "Subscribe to photography tips and updates",
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

                      SizedBox(height: spMd),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Create Account",
                          size: bs.md,
                          onPressed: _register,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
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

                SizedBox(height: spLg),

                // Social registration buttons
                Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                        boxShadow: [shadowSm],
                      ),
                      child: InkWell(
                        onTap: _registerWithGoogle,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Register with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: InkWell(
                        onTap: _registerWithApple,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apple,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Register with Apple",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Sign in link
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      GestureDetector(
                        onTap: () {
                          // Navigate to login
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Bottom benefits
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "What you get with ImageMaster:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(Icons.cloud, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text("Unlimited cloud storage", style: TextStyle(fontSize: 12, color: primaryColor)),
                        ],
                      ),
                      
                      SizedBox(width: spXs),
                      
                      Row(
                        children: [
                          Icon(Icons.tune, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text("Professional editing tools", style: TextStyle(fontSize: 12, color: primaryColor)),
                        ],
                      ),
                      
                      SizedBox(width: spXs),
                      
                      Row(
                        children: [
                          Icon(Icons.share, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text("Easy sharing and collaboration", style: TextStyle(fontSize: 12, color: primaryColor)),
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
}
