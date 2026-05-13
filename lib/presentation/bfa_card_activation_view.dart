import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCardActivationView extends StatefulWidget {
  const BfaCardActivationView({super.key});

  @override
  State<BfaCardActivationView> createState() => _BfaCardActivationViewState();
}

class _BfaCardActivationViewState extends State<BfaCardActivationView> {
  int currentStep = 0;
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String pin = "";
  String confirmPin = "";
  String phoneNumber = "";
  String otp = "";
  bool agreeToTerms = false;
  
  List<Map<String, dynamic>> steps = [
    {
      "title": "Card Details",
      "subtitle": "Enter your card information",
      "icon": Icons.credit_card,
    },
    {
      "title": "Set PIN",
      "subtitle": "Create a secure PIN",
      "icon": Icons.pin,
    },
    {
      "title": "Verify Identity",
      "subtitle": "Confirm with OTP",
      "icon": Icons.verified_user,
    },
    {
      "title": "Complete",
      "subtitle": "Activation successful",
      "icon": Icons.check_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Activation"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                final isActive = currentStep == index;
                final isCompleted = currentStep > index;
                
                return Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                  ? successColor
                                  : isActive 
                                    ? primaryColor
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                isCompleted 
                                  ? Icons.check
                                  : step["icon"] as IconData,
                                color: isCompleted || isActive 
                                  ? Colors.white
                                  : Colors.grey.shade600,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${step["title"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isActive ? primaryColor : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      if (index < steps.length - 1) ...[
                        Container(
                          width: 20,
                          height: 2,
                          color: isCompleted 
                            ? successColor
                            : Colors.grey.shade300,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      onPressed: () {
                        if (currentStep > 0) {
                          currentStep--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: currentStep == steps.length - 1 ? "Finish" : "Next",
                    onPressed: _canProceed() ? () {
                      _handleNext();
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildCardDetailsStep();
      case 1:
        return _buildSetPinStep();
      case 2:
        return _buildVerificationStep();
      case 3:
        return _buildCompletionStep();
      default:
        return Container();
    }
  }

  Widget _buildCardDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: spSm),
              Text(
                "Enter Card Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter the details from your new card",
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        QTextField(
          label: "Card Number",
          value: cardNumber,
          hint: "1234 5678 9012 3456",
          validator: Validator.required,
          onChanged: (value) {
            cardNumber = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Expiry Date",
                value: expiryDate,
                hint: "MM/YY",
                validator: Validator.required,
                onChanged: (value) {
                  expiryDate = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "CVV",
                value: cvv,
                hint: "123",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  cvv = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Your card details are encrypted and secure. We never store your CVV.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSetPinStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.pin,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: spSm),
              Text(
                "Set Your PIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Create a secure 4-digit PIN for your card",
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        QTextField(
          label: "Enter PIN",
          value: pin,
          hint: "4-digit PIN",
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            pin = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Confirm PIN",
          value: confirmPin,
          hint: "Re-enter your PIN",
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            confirmPin = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "PIN Security Tips",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "• Use a unique 4-digit combination\n• Avoid using birthdays or sequential numbers\n• Don't share your PIN with anyone\n• Memorize your PIN, don't write it down",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ),
        
        if (pin.isNotEmpty && confirmPin.isNotEmpty && pin != confirmPin) ...[
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "PINs don't match. Please try again.",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [infoColor, infoColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: spSm),
              Text(
                "Verify Your Identity",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "We'll send an OTP to verify your identity",
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        QTextField(
          label: "Phone Number",
          value: phoneNumber,
          hint: "+1 234 567 8900",
          validator: Validator.required,
          onChanged: (value) {
            phoneNumber = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "OTP Code",
                value: otp,
                hint: "Enter 6-digit code",
                validator: Validator.required,
                onChanged: (value) {
                  otp = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Send OTP",
              size: bs.sm,
              onPressed: phoneNumber.isNotEmpty ? () {
                ss("OTP sent to ${phoneNumber}");
              } : null,
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Checkbox(
              value: agreeToTerms,
              onChanged: (value) {
                agreeToTerms = value ?? false;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  agreeToTerms = !agreeToTerms;
                  setState(() {});
                },
                child: Text(
                  "I agree to the Terms & Conditions and Privacy Policy",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.timer,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Didn't receive the code? Resend in 60 seconds",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionStep() {
    return Column(
      children: [
        SizedBox(height: spXl),
        
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: successColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.check_circle,
            color: successColor,
            size: 80,
          ),
        ),
        
        SizedBox(height: spLg),
        
        Text(
          "Card Activated Successfully!",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "Your card is now ready to use. You can start making transactions immediately.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: spLg),
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Text(
                "What's Next?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              _buildNextStepItem(
                Icons.security,
                "Set Up Security",
                "Enable biometric login and transaction alerts"
              ),
              _buildNextStepItem(
                Icons.account_balance_wallet,
                "Add to Wallet",
                "Add your card to Apple Pay or Google Pay"
              ),
              _buildNextStepItem(
                Icons.notifications,
                "Transaction Alerts",
                "Get instant notifications for all transactions"
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextStepItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: disabledBoldColor,
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return cardNumber.isNotEmpty && expiryDate.isNotEmpty && cvv.isNotEmpty;
      case 1:
        return pin.isNotEmpty && confirmPin.isNotEmpty && pin == confirmPin && pin.length == 4;
      case 2:
        return phoneNumber.isNotEmpty && otp.isNotEmpty && agreeToTerms;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < steps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      // Finish activation
      Navigator.pop(context);
      ss("Card activation completed successfully!");
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Activation Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need help with card activation?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "• Make sure you have your physical card\n"
              "• Check card details are entered correctly\n"
              "• Ensure your phone number is active\n"
              "• Contact support if you need assistance",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Contact Support",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Contact support
            },
          ),
        ],
      ),
    );
  }
}
