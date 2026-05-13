import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRegisterView extends StatefulWidget {
  const ReaRegisterView({super.key});

  @override
  State<ReaRegisterView> createState() => _ReaRegisterViewState();
}

class _ReaRegisterViewState extends State<ReaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  bool agreeTerms = false;
  bool receiveUpdates = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "Join RealEstate Pro",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Create your account to start finding your dream property",
                style: TextStyle(
                  fontSize: fsH6,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),
              QTextField(
                label: "Full Name",
                value: fullName,
                hint: "Enter your full name",
                validator: Validator.required,
                onChanged: (value) {
                  fullName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
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
              SizedBox(height: spMd),
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
              SizedBox(height: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QTextField(
                    label: "Password",
                    value: password,
                    hint: "Create a strong password",
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
              SizedBox(height: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QTextField(
                    label: "Confirm Password",
                    value: confirmPassword,
                    hint: "Re-enter your password",
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
              SizedBox(height: spMd),
              QSwitch(
                items: [
                  {
                    "label": "I agree to Terms & Conditions and Privacy Policy",
                    "value": true,
                    "checked": agreeTerms,
                  }
                ],
                value: [
                  if (agreeTerms)
                    {
                      "label": "I agree to Terms & Conditions and Privacy Policy",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    agreeTerms = values.isNotEmpty;
                  });
                },
              ),
              SizedBox(height: spMd),
              QSwitch(
                items: [
                  {
                    "label": "Receive property updates and market insights",
                    "value": true,
                    "checked": receiveUpdates,
                  }
                ],
                value: [
                  if (receiveUpdates)
                    {
                      "label": "Receive property updates and market insights",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    receiveUpdates = values.isNotEmpty;
                  });
                },
              ),
              SizedBox(height: spLg),
              QButton(
                label: "Create Account",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate() && agreeTerms) {
                    if (password == confirmPassword) {
                      // -- 
                    } else {
                      se("Passwords do not match");
                    }
                  } else if (!agreeTerms) {
                    se("Please agree to Terms & Conditions");
                  }
                },
              ),
              SizedBox(height: spLg),
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
                      "Or sign up with",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                            "Google",
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
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.facebook,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Facebook",
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
                ],
              ),
              SizedBox(height: spLg),
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
            ],
          ),
        ),
      ),
    );
  }
}
