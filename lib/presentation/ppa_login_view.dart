import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaLoginView extends StatefulWidget {
  const PpaLoginView({super.key});

  @override
  State<PpaLoginView> createState() => _PpaLoginViewState();
}

class _PpaLoginViewState extends State<PpaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool biometricEnabled = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(20),
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
                SizedBox(height: spXl),
                
                // App Logo and Welcome
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [shadowLg],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Sign in to continue your photography journey",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: spXl),

                // Login Form
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Email Field
                      QTextField(
                        label: "Email Address",
                        value: email,
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spMd),

                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          QTextField(
                            label: "Password",
                            value: password,
                            obscureText: obscurePassword,
                            validator: Validator.required,
                            onChanged: (value) {
                              password = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          GestureDetector(
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
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Remember Me and Forgot Password
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    rememberMe = value ?? false;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                  child: Text(
                                    "Remember me",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _forgotPassword();
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

                      // Login Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Sign In",
                          size: bs.md,
                          onPressed: loading ? null : () {
                            _login();
                          },
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Biometric Login
                      if (biometricEnabled)
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Sign In with Biometrics",
                            size: bs.md,
                            icon: Icons.fingerprint,
                            onPressed: () {
                              _biometricLogin();
                            },
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: spXl),

                // Social Login Options
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    SizedBox(height: spMd),

                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton(
                            "Google",
                            Icons.g_mobiledata,
                            Colors.red,
                            () => _socialLogin("google"),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: _buildSocialButton(
                            "Apple",
                            Icons.apple,
                            Colors.black,
                            () => _socialLogin("apple"),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    Container(
                      width: double.infinity,
                      child: _buildSocialButton(
                        "Facebook",
                        Icons.facebook,
                        Colors.blue,
                        () => _socialLogin("facebook"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spXl),

                // Quick Actions
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickAction(
                              "Guest Mode",
                              Icons.visibility_off,
                              "Try without account",
                              () => _guestMode(),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: _buildQuickAction(
                              "Demo Mode",
                              Icons.play_circle,
                              "Preview features",
                              () => _demoMode(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Sign Up Link
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
                        _navigateToRegister();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Terms and Privacy
                Text(
                  "By signing in, you agree to our Terms of Service and Privacy Policy",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withAlpha(100)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, String subtitle, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    showLoading();
    
    try {
      // Simulate login API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      // Navigate to home or camera view
      ss("Login successful! Welcome back.");
      // navigateTo HomeView or CameraView
      
    } catch (e) {
      hideLoading();
      se("Login failed. Please check your credentials.");
    } finally {
      loading = false;
      setState(() {});
    }
  }

  void _biometricLogin() async {
    showLoading();
    
    try {
      // Simulate biometric authentication
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Biometric authentication successful!");
      // navigateTo HomeView
    } catch (e) {
      hideLoading();
      se("Biometric authentication failed");
    }
  }

  void _socialLogin(String provider) async {
    showLoading();
    
    try {
      // Simulate social login
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("$provider login successful!");
      // navigateTo HomeView
    } catch (e) {
      hideLoading();
      se("$provider login failed");
    }
  }

  void _forgotPassword() {
    // navigateTo ForgotPasswordView
    ss("Opening forgot password screen");
  }

  void _guestMode() {
    // navigateTo HomeView with guest mode
    ss("Entering guest mode");
  }

  void _demoMode() {
    // navigateTo DemoView
    ss("Starting demo mode");
  }

  void _navigateToRegister() {
    // navigateTo RegisterView
    ss("Opening registration screen");
  }
}
