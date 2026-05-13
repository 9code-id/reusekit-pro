import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaRegisterView extends StatefulWidget {
  const GeaRegisterView({super.key});

  @override
  State<GeaRegisterView> createState() => _GeaRegisterViewState();
}

class _GeaRegisterViewState extends State<GeaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String dateOfBirth = "";
  bool acceptTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  List<Map<String, dynamic>> gamingInterests = [
    {"label": "Action", "value": "action", "checked": false},
    {"label": "Adventure", "value": "adventure", "checked": false},
    {"label": "RPG", "value": "rpg", "checked": false},
    {"label": "Strategy", "value": "strategy", "checked": false},
    {"label": "Sports", "value": "sports", "checked": false},
    {"label": "Racing", "value": "racing", "checked": false},
    {"label": "Puzzle", "value": "puzzle", "checked": false},
    {"label": "Simulation", "value": "simulation", "checked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.games,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Join GameZone",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Start your gaming adventure today",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Full Name",
                value: fullName,
                validator: Validator.required,
                onChanged: (value) {
                  fullName = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Username",
                value: username,
                validator: Validator.required,
                onChanged: (value) {
                  username = value;
                  setState(() {});
                },
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

              QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                onChanged: (value) {
                  dateOfBirth = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),

              // Account Security
              Text(
                "Account Security",
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
                    obscureText: obscurePassword,
                    validator: Validator.required,
                    onChanged: (value) {
                      password = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Text(
                        "Min 8 characters",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
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
                  Align(
                    alignment: Alignment.centerLeft,
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

              // Gaming Preferences
              Text(
                "Gaming Interests (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Text(
                "Select your favorite game genres to get personalized recommendations",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),

              QSwitch(
                items: gamingInterests,
                value: gamingInterests.where((interest) => interest["checked"] == true).toList(),
                onChanged: (values, ids) {
                  for (var interest in gamingInterests) {
                    interest["checked"] = values.any((v) => v["value"] == interest["value"]);
                  }
                  setState(() {});
                },
              ),

              // Terms and Conditions
              QSwitch(
                items: [
                  {
                    "label": "I agree to the Terms of Service and Privacy Policy",
                    "value": true,
                    "checked": acceptTerms,
                  }
                ],
                value: [
                  if (acceptTerms)
                    {
                      "label": "I agree to the Terms of Service and Privacy Policy",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    acceptTerms = values.isNotEmpty;
                  });
                },
              ),

              // Age Verification Notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Users under 13 require parental consent. Age verification may be required for certain content.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Create Account Button
              QButton(
                label: "Create Account",
                size: bs.md,
                onPressed: acceptTerms ? () {
                  if (formKey.currentState!.validate()) {
                    //createAccount()
                  }
                } : null,
              ),

              // Already have account
              Center(
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
                        back();
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
              ),

              // Benefits Preview
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What you'll get:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: [
                        _buildBenefitItem("Access to 10,000+ games"),
                        _buildBenefitItem("Join gaming communities"),
                        _buildBenefitItem("Track achievements and progress"),
                        _buildBenefitItem("Participate in tournaments"),
                        _buildBenefitItem("Exclusive member discounts"),
                      ],
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

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
