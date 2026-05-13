import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaForgotPasswordView extends StatefulWidget {
  const RmaForgotPasswordView({super.key});

  @override
  State<RmaForgotPasswordView> createState() => _RmaForgotPasswordViewState();
}

class _RmaForgotPasswordViewState extends State<RmaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  bool emailSent = false;
  int currentStep = 0;

  final List<Map<String, dynamic>> recoveryMethods = [
    {
      "title": "Email Recovery",
      "description": "We'll send a reset link to your email",
      "icon": Icons.email,
      "value": "email",
      "selected": true,
    },
    {
      "title": "SMS Recovery",
      "description": "Get reset code via text message",
      "icon": Icons.sms,
      "value": "sms",
      "selected": false,
    },
    {
      "title": "Security Questions",
      "description": "Answer your security questions",
      "icon": Icons.quiz,
      "value": "questions",
      "selected": false,
    },
  ];

  Future<void> _sendResetEmail() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate sending reset email
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    loading = false;
    emailSent = true;
    setState(() {});
    
    ss("Password reset email sent successfully!");
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_reset,
              size: 50,
              color: warningColor,
            ),
          ),
          Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Don't worry! It happens. Please enter the email associated with your account.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryMethodsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Choose Recovery Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recoveryMethods.map((method) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: (method["selected"] as bool) 
                  ? primaryColor.withAlpha(10) 
                  : Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: (method["selected"] as bool) 
                    ? primaryColor 
                    : disabledOutlineBorderColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (method["selected"] as bool) 
                        ? primaryColor 
                        : disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    method["icon"] as IconData,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${method["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: (method["selected"] as bool) 
                              ? primaryColor 
                              : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${method["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (method["selected"] as bool)
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 20,
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildEmailForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            Text(
              "Enter Your Email",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QTextField(
              label: "Email Address",
              value: email,
              hint: "Enter your registered email address",
              validator: Validator.email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Reset Link",
                size: bs.md,
                onPressed: _sendResetEmail,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read,
              size: 50,
              color: successColor,
            ),
          ),
          Text(
            "Email Sent Successfully!",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Text(
            "We've sent a password reset link to:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              email,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "Please check your email and click the reset link to create a new password. The link will expire in 24 hours.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "What happens next?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInstructionStep(
            "1",
            "Check your email inbox",
            "Look for an email from RestaurantManager with password reset instructions",
            Icons.inbox,
          ),
          _buildInstructionStep(
            "2",
            "Click the reset link",
            "Click on the secure link provided in the email to proceed",
            Icons.link,
          ),
          _buildInstructionStep(
            "3",
            "Create new password",
            "Choose a strong password and confirm your new login credentials",
            Icons.password,
          ),
          _buildInstructionStep(
            "4",
            "Login with new password",
            "Use your new password to access your restaurant management account",
            Icons.login,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          if (emailSent) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Resend Email",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  emailSent = false;
                  setState(() {});
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Open Email App",
                size: bs.sm,
                onPressed: () {
                  si("Opening email application");
                },
              ),
            ),
          ] else ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Try Different Email",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  email = "";
                  setState(() {});
                },
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remember your password? ",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //navigateTo('RmaLoginView')
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Recovery"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            if (!emailSent) ...[
              _buildRecoveryMethodsSection(),
              _buildEmailForm(),
            ] else ...[
              _buildSuccessMessage(),
              _buildInstructions(),
            ],
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
