import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoginView extends StatefulWidget {
  const BfaLoginView({super.key});

  @override
  State<BfaLoginView> createState() => _BfaLoginViewState();
}

class _BfaLoginViewState extends State<BfaLoginView> {
  final formKey = GlobalKey<FormState>();
  String customerId = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  List<Map<String, dynamic>> loginMethods = [
    {
      "title": "Customer ID",
      "description": "Use your 12-digit customer ID",
      "icon": Icons.person,
      "value": "customer_id",
    },
    {
      "title": "Mobile Number",
      "description": "Login with registered mobile",
      "icon": Icons.phone,
      "value": "mobile",
    },
    {
      "title": "Account Number",
      "description": "Use your account number",
      "icon": Icons.account_balance,
      "value": "account",
    },
  ];
  
  String selectedLoginMethod = "customer_id";

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Login successful");
    // navigateTo(BfaPinSetupView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spLg),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sp3xl),
              
              // Header
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  
                  SizedBox(width: spMd),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Sign in to your account",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: sp2xl),
              
              // Login Method Selection
              Text(
                "Choose Login Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              ...loginMethods.map((method) {
                bool isSelected = selectedLoginMethod == method["value"];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedLoginMethod = method["value"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              method["icon"] as IconData,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          
                          SizedBox(width: spMd),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${method["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${method["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              
              SizedBox(height: spXl),
              
              // Login Form
              QTextField(
                label: selectedLoginMethod == "customer_id" 
                    ? "Customer ID" 
                    : selectedLoginMethod == "mobile" 
                        ? "Mobile Number" 
                        : "Account Number",
                value: customerId,
                validator: Validator.required,
                hint: selectedLoginMethod == "customer_id" 
                    ? "Enter 12-digit customer ID" 
                    : selectedLoginMethod == "mobile" 
                        ? "Enter mobile number" 
                        : "Enter account number",
                onChanged: (value) {
                  customerId = value;
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
                    validator: Validator.required,
                    hint: "Enter your password",
                    obscureText: obscurePassword,
                    onChanged: (value) {
                      password = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Remember Me & Forgot Password
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              rememberMe = value ?? false;
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: () {
                      // navigateTo(BfaForgotPasswordView());
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
              
              SizedBox(height: sp2xl),
              
              // Login Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Signing In..." : "Sign In",
                  size: bs.md,
                  onPressed: loading ? null : _handleLogin,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Biometric Login
              Container(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Login with Biometric",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Register Link
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
                      // navigateTo(BfaRegisterView());
                    },
                    child: Text(
                      "Register Now",
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
              
              // Customer Support
              Center(
                child: Column(
                  children: [
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    GestureDetector(
                      onTap: () {
                        // navigateTo(BfaHelpSupportView());
                      },
                      child: Text(
                        "Contact Customer Support",
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
