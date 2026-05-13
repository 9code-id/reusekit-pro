import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaRegisterView extends StatefulWidget {
  const MhaRegisterView({super.key});

  @override
  State<MhaRegisterView> createState() => _MhaRegisterViewState();
}

class _MhaRegisterViewState extends State<MhaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String dateOfBirth = "";
  String gender = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool loading = false;

  final List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

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
      
      // Simulate registration process
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Registration successful!");
      // navigateTo(MhaOtpVerificationView());
    }
  }

  void _socialRegister(String provider) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("$provider registration successful!");
    // navigateTo(MhaHomeView());
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
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "Join HealthCare+",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Create your account to start your health journey",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXl),
              Row(
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
                  SizedBox(width: spMd),
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
                value: phone,
                hint: "Enter your phone number",
                validator: Validator.required,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                onChanged: (value) {
                  dateOfBirth = value.toString();
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Gender",
                items: genderOptions,
                value: gender,
                onChanged: (value, label) {
                  gender = value;
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
                    "label": "I agree to the Terms & Conditions and Privacy Policy",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label": "I agree to the Terms & Conditions and Privacy Policy",
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
              SizedBox(height: spXl),
              if (loading)
                Center(child: CircularProgressIndicator())
              else
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Account",
                    size: bs.md,
                    onPressed: _register,
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
                      "Or register with",
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
                          onTap: () => _socialRegister("Google"),
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
                          onTap: () => _socialRegister("Apple"),
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
                    "Already have an account? ",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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
