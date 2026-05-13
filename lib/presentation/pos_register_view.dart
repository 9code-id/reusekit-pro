import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosRegisterView extends StatefulWidget {
  const PosRegisterView({super.key});

  @override
  State<PosRegisterView> createState() => _PosRegisterViewState();
}

class _PosRegisterViewState extends State<PosRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String businessName = "";
  String ownerName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String businessType = "Retail Store";
  String country = "United States";
  bool acceptTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  final List<Map<String, dynamic>> businessTypes = [
    {"label": "Retail Store", "value": "Retail Store"},
    {"label": "Restaurant", "value": "Restaurant"},
    {"label": "Cafe", "value": "Cafe"},
    {"label": "Grocery Store", "value": "Grocery Store"},
    {"label": "Fashion Store", "value": "Fashion Store"},
    {"label": "Electronics Store", "value": "Electronics Store"},
    {"label": "Pharmacy", "value": "Pharmacy"},
    {"label": "Bookstore", "value": "Bookstore"},
    {"label": "Beauty Salon", "value": "Beauty Salon"},
    {"label": "Service Business", "value": "Service Business"},
    {"label": "Other", "value": "Other"},
  ];

  final List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Singapore", "value": "Singapore"},
    {"label": "Other", "value": "Other"},
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
              primaryColor.withAlpha(10),
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
                // Header
                Row(
                  children: [
                    QButton(
                      icon: Icons.arrow_back,
                      size: bs.sm,
                      onPressed: () {
                        back();
                      },
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.store,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Setup your POS account",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spLg),

                // Registration Form
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: spSm,
                      children: [
                        Text(
                          "Business Information",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        QTextField(
                          label: "Business Name",
                          value: businessName,
                          validator: Validator.required,
                          onChanged: (value) {
                            businessName = value;
                            setState(() {});
                          },
                        ),

                        QDropdownField(
                          label: "Business Type",
                          items: businessTypes,
                          value: businessType,
                          onChanged: (value, label) {
                            businessType = value;
                            setState(() {});
                          },
                        ),

                        QDropdownField(
                          label: "Country",
                          items: countries,
                          value: country,
                          onChanged: (value, label) {
                            country = value;
                            setState(() {});
                          },
                        ),

                        Divider(),

                        Text(
                          "Owner Information",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        QTextField(
                          label: "Owner Full Name",
                          value: ownerName,
                          validator: Validator.required,
                          onChanged: (value) {
                            ownerName = value;
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

                        QTextField(
                          label: "Phone Number",
                          value: phone,
                          validator: Validator.required,
                          onChanged: (value) {
                            phone = value;
                            setState(() {});
                          },
                        ),

                        Divider(),

                        Text(
                          "Account Security",
                          style: TextStyle(
                            fontSize: fsH5,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
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

                        QSwitch(
                          items: [
                            {
                              "label": "I accept the Terms of Service and Privacy Policy",
                              "value": true,
                              "checked": acceptTerms,
                            }
                          ],
                          value: [
                            if (acceptTerms)
                              {
                                "label": "I accept the Terms of Service and Privacy Policy",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            acceptTerms = values.isNotEmpty;
                            setState(() {});
                          },
                        ),

                        if (loading)
                          CircularProgressIndicator()
                        else
                          QButton(
                            label: "Create Account",
                            size: bs.md,
                            onPressed: () {
                              _register();
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spMd),

                // Benefits Section
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "What You Get",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      _buildBenefitItem(Icons.cloud, "Cloud-based system"),
                      _buildBenefitItem(Icons.devices, "Multi-device support"),
                      _buildBenefitItem(Icons.support, "24/7 customer support"),
                      _buildBenefitItem(Icons.security, "Bank-level security"),
                      _buildBenefitItem(Icons.analytics, "Advanced analytics"),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

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
                        // navigateTo('PosLoginView')
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            icon,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() {
    if (formKey.currentState!.validate()) {
      if (!acceptTerms) {
        se("Please accept the Terms of Service and Privacy Policy");
        return;
      }

      loading = true;
      setState(() {});
      
      // Simulate API call
      Future.delayed(Duration(seconds: 3), () {
        loading = false;
        setState(() {});
        
        ss("Account created successfully!");
        // navigateTo('PosSetupWizardView', arguments: {
        //   "businessName": businessName,
        //   "businessType": businessType,
        //   "ownerName": ownerName,
        //   "email": email,
        // })
      });
    }
  }
}
