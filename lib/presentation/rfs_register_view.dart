import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsRegisterView extends StatefulWidget {
  const RfsRegisterView({super.key});

  @override
  State<RfsRegisterView> createState() => _RfsRegisterViewState();
}

class _RfsRegisterViewState extends State<RfsRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool acceptTerms = false;
  bool receiveNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      if (!acceptTerms) {
        se("Please accept the terms and conditions to continue");
        return;
      }
      
      if (password != confirmPassword) {
        se("Passwords do not match");
        return;
      }
      
      loading = true;
      setState(() {});
      
      // Simulate registration API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Account created successfully! Please check your email for verification.");
      // Navigate to restaurant setup
      //navigateTo(RfsRestaurantSetupView());
    }
  }

  void _handleSocialRegister(String provider) {
    ss("Signing up with $provider...");
    // Handle social registration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spMd),
              
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        color: primaryColor,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Join RestaurantFlow",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Create your account to get started",
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
              
              Column(
                spacing: spMd,
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
                    validator: Validator.required,
                    onChanged: (value) {
                      phone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
              
              SizedBox(height: spLg),
              
              // Password Section
              Text(
                "Security",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Column(
                spacing: spMd,
                children: [
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
                              "Password must be at least 8 characters",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
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
                                fontSize: 12,
                                color: primaryColor,
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
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: spLg),
              
              // Terms and Preferences
              Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "I accept the Terms and Conditions and Privacy Policy",
                        "value": true,
                        "checked": acceptTerms,
                      }
                    ],
                    value: [
                      if (acceptTerms)
                        {
                          "label": "I accept the Terms and Conditions and Privacy Policy",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      acceptTerms = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Receive newsletters and product updates",
                        "value": true,
                        "checked": receiveNewsletter,
                      }
                    ],
                    value: [
                      if (receiveNewsletter)
                        {
                          "label": "Receive newsletters and product updates",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      receiveNewsletter = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
              
              SizedBox(height: spLg),
              
              // Register Button
              Container(
                width: double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : QButton(
                        label: "Create Account",
                        size: bs.md,
                        onPressed: _handleRegister,
                      ),
              ),
              
              SizedBox(height: spLg),
              
              // Divider
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
                      "OR",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
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
              
              SizedBox(height: spLg),
              
              // Social Registration Options
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _handleSocialRegister("Google"),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(spMd),
                        side: BorderSide(color: disabledColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.g_mobiledata,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Sign up with Google",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _handleSocialRegister("Apple"),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(spMd),
                        side: BorderSide(color: disabledColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.apple,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Sign up with Apple",
                            style: TextStyle(
                              fontSize: 16,
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
              
              SizedBox(height: spLg),
              
              // Login Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login
                      //navigateTo(RfsLoginView());
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Security Notice
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: successColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your data is encrypted and secure. We never share your information with third parties.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
