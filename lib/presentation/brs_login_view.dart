import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsLoginView extends StatefulWidget {
  const BrsLoginView({super.key});

  @override
  State<BrsLoginView> createState() => _BrsLoginViewState();
}

class _BrsLoginViewState extends State<BrsLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
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
                        Icons.content_cut,
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Sign in to your account to continue",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QTextField(
                    label: "Password",
                    value: password,
                    validator: Validator.required,
                    hint: "Enter your password",
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
                  GestureDetector(
                    onTap: () async {},
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
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sign In",
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Login successful!");
                      await offAll(BrsHomeView());
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
                            "Continue with Google",
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
                      "Don't have an account? ",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        
                      },
                      child: Text(
                        "Sign Up",
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
