import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister1View extends StatefulWidget {
  @override
  State<GrlRegister1View> createState() => _GrlRegister1ViewState();
}

class _GrlRegister1ViewState extends State<GrlRegister1View> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  String confirmPassword = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  bool agreeTerms = false;
  bool receiveUpdates = false;
  bool loading = false;

  void _register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!agreeTerms) {
      se("Please agree to the terms and conditions");
      return;
    }

    if (password != confirmPassword) {
      se("Passwords do not match");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Account created successfully!");
    await Future.delayed(Duration(seconds: 1));
    //navigateTo LoginView
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: loading 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: spMd),
                Text(
                  "Creating your account...",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.person_add,
                          size: 48,
                          color: Colors.white,
                        ),
                        Text(
                          "Join Our Community",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Create your account to get started with amazing features",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          value: phoneNumber,
                          validator: Validator.required,
                          onChanged: (value) {
                            phoneNumber = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Account Security
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Security",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QTextField(
                          label: "Password",
                          value: password,
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
                            color: infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Password must be at least 8 characters long",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Preferences
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "I agree to the Terms of Service and Privacy Policy",
                              "value": true,
                              "checked": agreeTerms,
                            }
                          ],
                          value: [
                            if (agreeTerms)
                              {
                                "label": "I agree to the Terms of Service and Privacy Policy",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            agreeTerms = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "Receive product updates and newsletters",
                              "value": true,
                              "checked": receiveUpdates,
                            }
                          ],
                          value: [
                            if (receiveUpdates)
                              {
                                "label": "Receive product updates and newsletters",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            receiveUpdates = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Action Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create Account",
                      size: bs.md,
                      onPressed: _register,
                    ),
                  ),

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
                          //navigateTo LoginView
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
    );
  }
}
