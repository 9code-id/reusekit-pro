import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsRegisterView extends StatefulWidget {
  const DmsRegisterView({super.key});

  @override
  State<DmsRegisterView> createState() => _DmsRegisterViewState();
}

class _DmsRegisterViewState extends State<DmsRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String dealershipName = "";
  String phoneNumber = "";
  String selectedPlan = "Starter";
  bool agreeToTerms = false;
  bool subscribeToNewsletter = false;

  List<Map<String, dynamic>> planItems = [
    {"label": "Starter Plan - \$99/month", "value": "Starter"},
    {"label": "Professional Plan - \$199/month", "value": "Professional"},
    {"label": "Enterprise Plan - \$399/month", "value": "Enterprise"},
  ];

  List<Map<String, dynamic>> planFeatures = [
    {
      "plan": "Starter",
      "features": [
        "Up to 100 vehicles in inventory",
        "Basic CRM functionality",
        "Standard reporting",
        "Email support",
        "Mobile app access"
      ],
      "color": successColor,
    },
    {
      "plan": "Professional",
      "features": [
        "Up to 500 vehicles in inventory",
        "Advanced CRM & automation",
        "Detailed analytics & reports",
        "Priority phone support",
        "API integrations",
        "Custom branding"
      ],
      "color": primaryColor,
    },
    {
      "plan": "Enterprise",
      "features": [
        "Unlimited vehicles in inventory",
        "Full CRM suite with AI insights",
        "Advanced analytics & forecasting",
        "24/7 dedicated support",
        "Complete API access",
        "White-label solution",
        "Custom integrations"
      ],
      "color": warningColor,
    },
  ];

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the Terms of Service and Privacy Policy");
        return;
      }

      if (password != confirmPassword) {
        se("Passwords do not match");
        return;
      }

      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      
      // Navigate to dashboard or welcome screen
      //navigateTo DmsDashboardView
      
      ss("Account created successfully! Welcome to DealershipFlow!");
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentPlanFeatures = planFeatures.firstWhere(
      (plan) => plan["plan"] == selectedPlan,
      orElse: () => planFeatures[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //navigateTo DmsLoginView
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Join DealershipFlow",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Start your 30-day free trial today",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

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
                        SizedBox(width: spSm),
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
                      hint: "Enter your business email",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      hint: "Enter your phone number",
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Dealership Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Dealership Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Dealership Name",
                      value: dealershipName,
                      hint: "Enter your dealership name",
                      validator: Validator.required,
                      onChanged: (value) {
                        dealershipName = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Plan Selection
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor),
                        SizedBox(width: spSm),
                        Text(
                          "Choose Your Plan",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    QDropdownField(
                      label: "Subscription Plan",
                      items: planItems,
                      value: selectedPlan,
                      onChanged: (value, label) {
                        selectedPlan = value;
                        setState(() {});
                      },
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (currentPlanFeatures["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: (currentPlanFeatures["color"] as Color).withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$selectedPlan Plan Features:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: currentPlanFeatures["color"] as Color,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Column(
                            spacing: spXs,
                            children: ((currentPlanFeatures["features"] as List<String>).map((feature) {
                              return Row(
                                children: [
                                  Icon(Icons.check_circle, color: successColor, size: 16),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: TextStyle(fontSize: 12, color: primaryColor),
                                    ),
                                  ),
                                ],
                              );
                            }).toList()),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_offer, color: successColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "30-day free trial included • No credit card required • Cancel anytime",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Security Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Account Security",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Password",
                      value: password,
                      hint: "Create a strong password",
                      obscureText: true,
                      validator: Validator.required,
                      onChanged: (value) {
                        password = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Confirm Password",
                      value: confirmPassword,
                      hint: "Confirm your password",
                      obscureText: true,
                      validator: Validator.required,
                      onChanged: (value) {
                        confirmPassword = value;
                        setState(() {});
                      },
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password Requirements:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Column(
                            spacing: 2,
                            children: [
                              Text("• At least 8 characters long", style: TextStyle(fontSize: 10, color: primaryColor)),
                              Text("• Include uppercase and lowercase letters", style: TextStyle(fontSize: 10, color: primaryColor)),
                              Text("• Include at least one number", style: TextStyle(fontSize: 10, color: primaryColor)),
                              Text("• Include at least one special character", style: TextStyle(fontSize: 10, color: primaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Terms and Preferences
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Terms & Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

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
                          "label": "Subscribe to newsletter and product updates",
                          "value": true,
                          "checked": subscribeToNewsletter,
                        }
                      ],
                      value: [
                        if (subscribeToNewsletter)
                          {
                            "label": "Subscribe to newsletter and product updates",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        subscribeToNewsletter = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Terms of Service",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Privacy Policy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Support Center",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Create Account Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Account & Start Trial",
                  size: bs.md,
                  onPressed: _handleRegister,
                ),
              ),

              // Login Link
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    GestureDetector(
                      onTap: () {
                        //navigateTo DmsLoginView
                      },
                      child: Text(
                        "Sign In Here",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Support Information
              Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.support_agent, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Need assistance with setup?",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Contact our onboarding team",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
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
