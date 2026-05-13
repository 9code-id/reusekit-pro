import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsRegisterView extends StatefulWidget {
  const BrsRegisterView({super.key});

  @override
  State<BrsRegisterView> createState() => _BrsRegisterViewState();
}

class _BrsRegisterViewState extends State<BrsRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
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
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_add,
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Join BarberShop",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Create your account to get started",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QTextField(
                label: "Full Name",
                value: fullName,
                validator: Validator.required,
                hint: "Enter your full name",
                onChanged: (value) {
                  fullName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Email",
                value: email,
                validator: Validator.email,
                hint: "Enter your email address",
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Phone Number",
                value: phoneNumber,
                validator: Validator.required,
                hint: "Enter your phone number",
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QTextField(
                    label: "Password",
                    value: password,
                    validator: Validator.required,
                    hint: "Create a strong password",
                    obscureText: obscurePassword,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != password) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    hint: "Confirm your password",
                    obscureText: obscureConfirmPassword,
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
                        obscureConfirmPassword
                            ? "Show Password"
                            : "Hide Password",
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
                    "label":
                        "I agree to the Terms & Conditions and Privacy Policy",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label":
                          "I agree to the Terms & Conditions and Privacy Policy",
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
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Account",
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (!agreeToTerms) {
                        se("Please agree to Terms & Conditions");
                        return;
                      }
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Account created successfully!");
                    }
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
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
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
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
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusMd),
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
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
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
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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
