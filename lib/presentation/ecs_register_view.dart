import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRegisterView extends StatefulWidget {
  const EcsRegisterView({super.key});

  @override
  State<EcsRegisterView> createState() => _EcsRegisterViewState();
}

class _EcsRegisterViewState extends State<EcsRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  void _register() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to terms and conditions");
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
      // ss('Next page'));
    }
  }

  void _registerWithGoogle() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Google registration successful!");
    // ss('Next page'));
  }

  void _registerWithFacebook() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Facebook registration successful!");
    // ss('Next page'));
  }

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
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXl),
                  ),
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Center(
                child: Text(
                  "Join ShopMart",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Center(
                child: Text(
                  "Create your account to start shopping",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              SizedBox(height: spXl),
              Row(
                spacing: spMd,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "First Name",
                      value: firstName,
                      hint: "Enter first name",
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
                      hint: "Enter last name",
                      validator: Validator.required,
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
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
                    hint: "Create a password",
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
                    hint: "Confirm your password",
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
                    "label": "I agree to the Terms and Conditions",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label": "I agree to the Terms and Conditions",
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
              SizedBox(height: spSm),
              QSwitch(
                items: [
                  {
                    "label": "Subscribe to newsletter and promotions",
                    "value": true,
                    "checked": subscribeNewsletter,
                  }
                ],
                value: [
                  if (subscribeNewsletter)
                    {
                      "label": "Subscribe to newsletter and promotions",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    subscribeNewsletter = values.isNotEmpty;
                  });
                },
              ),
              SizedBox(height: spXl),
              Container(
                width: double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : QButton(
                        label: "Create Account",
                        size: bs.md,
                        onPressed: _register,
                      ),
              ),
              SizedBox(height: spLg),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: disabledColor),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: disabledColor),
                  ),
                ],
              ),
              SizedBox(height: spLg),
              Row(
                spacing: spMd,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _registerWithGoogle,
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata, color: Colors.red, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Google",
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _registerWithFacebook,
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook, color: Colors.blue, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Facebook",
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXl),
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
