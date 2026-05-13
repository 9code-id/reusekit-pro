import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmLoginView extends StatefulWidget {
  const EcmLoginView({super.key});

  @override
  State<EcmLoginView> createState() => _EcmLoginViewState();
}

class _EcmLoginViewState extends State<EcmLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sp2xl),
              
              // Logo and title
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Icon(
                  Icons.event,
                  size: 64,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spLg),
              
              Text(
                "EventPro Manager",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "Manage your events with ease",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: sp2xl),
              
              // Login form
              Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
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
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Password",
                          value: password,
                          hint: "Enter your password",
                          obscureText: obscurePassword,
                          validator: Validator.required,
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
                              obscurePassword ? "Show" : "Hide",
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
                    
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Remember me",
                                "value": true,
                                "checked": rememberMe,
                              }
                            ],
                            value: [
                              if (rememberMe)
                                {
                                  "label": "Remember me",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                rememberMe = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            ss("Password reset link sent to your email");
                          },
                          child: Text(
                            "Forgot Password?",
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
              SizedBox(height: sp2xl),
              
              // Login button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sign In",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Login successful!");
                      // ss('Next page'));
                    }
                  },
                ),
              ),
              SizedBox(height: spLg),
              
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: disabledColor)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: disabledColor)),
                ],
              ),
              SizedBox(height: spLg),
              
              // Social login buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_mobiledata, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sp2xl),
              
              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ss('Next page'));
                    },
                    child: Text(
                      "Sign Up",
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
