import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRegisterView extends StatefulWidget {
  const RmaRegisterView({super.key});

  @override
  State<RmaRegisterView> createState() => _RmaRegisterViewState();
}

class _RmaRegisterViewState extends State<RmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String restaurantName = "";
  String restaurantType = "fast_food";
  bool acceptTerms = false;
  bool subscribeNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  final List<Map<String, dynamic>> restaurantTypes = [
    {"label": "Fast Food", "value": "fast_food"},
    {"label": "Fine Dining", "value": "fine_dining"},
    {"label": "Casual Dining", "value": "casual_dining"},
    {"label": "Coffee Shop", "value": "coffee_shop"},
    {"label": "Bar & Grill", "value": "bar_grill"},
    {"label": "Bakery", "value": "bakery"},
    {"label": "Food Truck", "value": "food_truck"},
    {"label": "Catering", "value": "catering"},
  ];

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain uppercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain a number";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  Future<void> _register() async {
    if (!formKey.currentState!.validate()) return;
    
    if (!acceptTerms) {
      se("Please accept the terms and conditions");
      return;
    }
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate registration process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    loading = false;
    setState(() {});
    
    ss("Account created successfully! Please verify your email");
    //navigateTo('RmaOtpVerificationView')
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
            "Create Account",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Join thousands of restaurant owners using our platform",
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

  Widget _buildPersonalInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Personal Information",
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
          QTextField(
            label: "Phone Number",
            value: phone,
            hint: "Enter your phone number",
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Restaurant Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Restaurant Name",
            value: restaurantName,
            hint: "Enter your restaurant name",
            validator: Validator.required,
            onChanged: (value) {
              restaurantName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Restaurant Type",
            items: restaurantTypes,
            value: restaurantType,
            onChanged: (value, label) {
              restaurantType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Security",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QTextField(
                label: "Password",
                value: password,
                hint: "Create a strong password",
                obscureText: obscurePassword,
                validator: _validatePassword,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QTextField(
                label: "Confirm Password",
                value: confirmPassword,
                hint: "Confirm your password",
                obscureText: obscureConfirmPassword,
                validator: _validateConfirmPassword,
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
                    obscureConfirmPassword ? "Show Password" : "Hide Password",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Password Requirements:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "• At least 8 characters long",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Contains uppercase letter",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Contains at least one number",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QSwitch(
            items: [
              {
                "label": "I accept the Terms and Conditions",
                "value": "terms",
                "checked": acceptTerms,
              }
            ],
            value: [
              if (acceptTerms)
                {
                  "label": "I accept the Terms and Conditions",
                  "value": "terms",
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
                "label": "Subscribe to newsletter for updates",
                "value": "newsletter",
                "checked": subscribeNewsletter,
              }
            ],
            value: [
              if (subscribeNewsletter)
                {
                  "label": "Subscribe to newsletter for updates",
                  "value": "newsletter",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              subscribeNewsletter = values.isNotEmpty;
              setState(() {});
            },
          ),
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
    );
  }

  Widget _buildLoginSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
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
              //navigateTo('RmaLoginView')
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              SizedBox(height: spLg),
              _buildHeader(),
              _buildPersonalInfoSection(),
              _buildRestaurantInfoSection(),
              _buildPasswordSection(),
              _buildTermsSection(),
              _buildLoginSection(),
            ],
          ),
        ),
      ),
    );
  }
}
