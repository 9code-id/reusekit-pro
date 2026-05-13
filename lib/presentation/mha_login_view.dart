import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaLoginView extends StatefulWidget {
  const MhaLoginView({super.key});

  @override
  State<MhaLoginView> createState() => _MhaLoginViewState();
}

class _MhaLoginViewState extends State<MhaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  void _login() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate login process
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Login successful!");
      // navigateTo(MhaHomeView());
    }
  }

  void _socialLogin(String provider) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("$provider login successful!");
    // navigateTo(MhaHomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spXl),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.medical_services,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Sign in to continue your health journey",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXl),
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
              SizedBox(height: spMd),
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
                      // navigateTo(MhaForgotPasswordView());
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
              SizedBox(height: spXl),
              if (loading)
                Center(child: CircularProgressIndicator())
              else
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sign In",
                    size: bs.md,
                    onPressed: _login,
                  ),
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
                      "Or continue with",
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
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(radiusMd),
                          onTap: () => _socialLogin("Google"),
                          child: Center(
                            child: Icon(
                              Icons.g_mobiledata,
                              size: 24,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(radiusMd),
                          onTap: () => _socialLogin("Apple"),
                          child: Center(
                            child: Icon(
                              Icons.apple,
                              size: 24,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // navigateTo(MhaRegisterView());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
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
