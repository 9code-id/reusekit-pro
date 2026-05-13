import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaOnboardingView extends StatefulWidget {
  const BfaOnboardingView({super.key});

  @override
  State<BfaOnboardingView> createState() => _BfaOnboardingViewState();
}

class _BfaOnboardingViewState extends State<BfaOnboardingView> {
  int currentStep = 0;
  
  // Step 1: Welcome
  bool hasReadTerms = false;
  
  // Step 2: Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String dateOfBirth = "";
  String address = "";
  String city = "";
  String zipCode = "";
  String occupation = "";
  
  // Step 3: Identity Verification
  String idType = "";
  String idNumber = "";
  String profilePhoto = "";
  String idFrontPhoto = "";
  String idBackPhoto = "";
  
  // Step 4: Banking Preferences
  String accountType = "";
  String initialDeposit = "";
  String monthlyIncome = "";
  String sourceOfIncome = "";
  bool hasExistingAccount = false;
  List<String> selectedServices = [];
  
  // Step 5: Security Setup
  String pin = "";
  String confirmPin = "";
  bool enableBiometric = false;
  bool enableSMSNotifications = true;
  bool enableEmailNotifications = true;
  bool enablePushNotifications = true;

  List<Map<String, dynamic>> onboardingSteps = [
    {
      "title": "Welcome to BFA",
      "subtitle": "Digital Banking Made Simple",
      "description": "Join thousands of customers who trust BFA for their banking needs. Get started in just a few simple steps.",
      "icon": Icons.account_balance,
      "color": Colors.blue
    },
    {
      "title": "Personal Information",
      "subtitle": "Tell us about yourself",
      "description": "We need some basic information to create your account and verify your identity.",
      "icon": Icons.person,
      "color": Colors.green
    },
    {
      "title": "Identity Verification",
      "subtitle": "Verify your identity",
      "description": "Upload your ID and take a selfie to verify your identity securely.",
      "icon": Icons.verified_user,
      "color": Colors.orange
    },
    {
      "title": "Banking Preferences",
      "subtitle": "Choose your banking options",
      "description": "Select the account type and services that best suit your needs.",
      "icon": Icons.settings,
      "color": Colors.purple
    },
    {
      "title": "Security Setup",
      "subtitle": "Secure your account",
      "description": "Set up your PIN and security preferences to protect your account.",
      "icon": Icons.security,
      "color": Colors.red
    }
  ];

  List<Map<String, dynamic>> accountTypes = [
    {
      "type": "Basic Checking",
      "description": "Perfect for everyday banking with no monthly fees",
      "minimumDeposit": 25,
      "features": ["Free debit card", "Online banking", "Mobile app", "ATM access"]
    },
    {
      "type": "Premium Checking",
      "description": "Enhanced features for active users",
      "minimumDeposit": 100,
      "features": ["Free checks", "Higher withdrawal limits", "Premium support", "Rewards program"]
    },
    {
      "type": "Savings Account",
      "description": "Grow your money with competitive interest rates",
      "minimumDeposit": 50,
      "features": ["High interest rates", "No monthly fees", "Automatic savings", "Goal tracking"]
    }
  ];

  List<Map<String, dynamic>> additionalServices = [
    {
      "name": "Credit Card",
      "description": "Build credit with our secured credit card",
      "icon": Icons.credit_card
    },
    {
      "name": "Personal Loan",
      "description": "Quick approval for personal loans up to \$10,000",
      "icon": Icons.attach_money
    },
    {
      "name": "Investment Account",
      "description": "Start investing with low fees and expert guidance",
      "icon": Icons.trending_up
    },
    {
      "name": "Insurance",
      "description": "Protect what matters most with our insurance products",
      "icon": Icons.security
    }
  ];

  bool get canProceedToNext {
    switch (currentStep) {
      case 0:
        return hasReadTerms;
      case 1:
        return firstName.isNotEmpty && lastName.isNotEmpty && 
               email.isNotEmpty && phoneNumber.isNotEmpty && 
               dateOfBirth.isNotEmpty;
      case 2:
        return idType.isNotEmpty && idNumber.isNotEmpty && 
               profilePhoto.isNotEmpty && idFrontPhoto.isNotEmpty;
      case 3:
        return accountType.isNotEmpty && initialDeposit.isNotEmpty;
      case 4:
        return pin.isNotEmpty && confirmPin.isNotEmpty && pin == confirmPin;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusLg),
                  bottomRight: Radius.circular(radiusLg),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (currentStep > 0)
                        GestureDetector(
                          onTap: () => _previousStep(),
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      Spacer(),
                      Text(
                        "BFA Digital Banking",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentStep + 1}/${onboardingSteps.length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Progress Bar
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (currentStep + 1) / onboardingSteps.length,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildCurrentStep(),
              ),
            ),
            
            // Bottom Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: () => _previousStep(),
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spMd),
                  Expanded(
                    flex: currentStep == 0 ? 1 : 2,
                    child: QButton(
                      label: currentStep == onboardingSteps.length - 1 ? "Complete Setup" : "Continue",
                      size: bs.md,
                      onPressed: canProceedToNext ? () => _nextStep() : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    final step = onboardingSteps[currentStep];
    
    return Column(
      children: [
        // Step Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: (step["color"] as Color).withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                step["icon"] as IconData,
                size: 64,
                color: step["color"] as Color,
              ),
              SizedBox(height: spMd),
              Text(
                "${step["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${step["subtitle"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: step["color"] as Color,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${step["description"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Step Content
        _buildStepContent(),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildPersonalInfoStep();
      case 2:
        return _buildIdentityVerificationStep();
      case 3:
        return _buildBankingPreferencesStep();
      case 4:
        return _buildSecuritySetupStep();
      default:
        return Container();
    }
  }

  Widget _buildWelcomeStep() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(Icons.verified, color: successColor),
                  SizedBox(width: spSm),
                  Text(
                    "What You'll Get",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              _buildFeatureItem("Instant account opening", "Open your account in minutes, not days", Icons.flash_on),
              _buildFeatureItem("24/7 mobile banking", "Bank anytime, anywhere with our mobile app", Icons.phone_android),
              _buildFeatureItem("Fee-free banking", "No hidden fees or monthly maintenance charges", Icons.money_off),
              _buildFeatureItem("Secure transactions", "Bank-level security with encryption", Icons.security),
              _buildFeatureItem("Customer support", "Get help when you need it, 24/7", Icons.support_agent),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: infoColor),
                  SizedBox(width: spSm),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              Text(
                "By proceeding, you agree to our Terms of Service and Privacy Policy. Please read them carefully.",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I have read and agree to the Terms & Conditions",
                    "value": true,
                    "checked": hasReadTerms,
                  }
                ],
                value: [
                  if (hasReadTerms)
                    {
                      "label": "I have read and agree to the Terms & Conditions",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  hasReadTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "First Name",
                  value: firstName,
                  validator: Validator.required,
                  onChanged: (value) {
                    firstName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Last Name",
                  value: lastName,
                  validator: Validator.required,
                  onChanged: (value) {
                    lastName = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            validator: Validator.required,
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),
          
          QDatePicker(
            label: "Date of Birth",
            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
            onChanged: (value) {
              dateOfBirth = value.toString();
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Street Address",
            value: address,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: city,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Occupation",
            value: occupation,
            onChanged: (value) {
              occupation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityVerificationStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: warningColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "We need to verify your identity to comply with banking regulations and keep your account secure.",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          QDropdownField(
            label: "ID Type",
            items: [
              {"label": "Driver's License", "value": "drivers_license"},
              {"label": "Passport", "value": "passport"},
              {"label": "State ID", "value": "state_id"},
              {"label": "Military ID", "value": "military_id"},
            ],
            value: idType,
            onChanged: (value, label) {
              idType = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "ID Number",
            value: idNumber,
            validator: Validator.required,
            onChanged: (value) {
              idNumber = value;
              setState(() {});
            },
          ),
          
          QImagePicker(
            label: "Profile Photo",
            value: profilePhoto,
            hint: "Take a clear selfie",
            validator: Validator.required,
            onChanged: (value) {
              profilePhoto = value;
              setState(() {});
            },
          ),
          
          QImagePicker(
            label: "ID Front Photo",
            value: idFrontPhoto,
            hint: "Photo of the front of your ID",
            validator: Validator.required,
            onChanged: (value) {
              idFrontPhoto = value;
              setState(() {});
            },
          ),
          
          QImagePicker(
            label: "ID Back Photo",
            value: idBackPhoto,
            hint: "Photo of the back of your ID",
            onChanged: (value) {
              idBackPhoto = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBankingPreferencesStep() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Choose Your Account Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ...accountTypes.map((account) => _buildAccountTypeCard(account)),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QNumberField(
                label: "Initial Deposit (\$)",
                value: initialDeposit,
                validator: Validator.required,
                onChanged: (value) {
                  initialDeposit = value;
                  setState(() {});
                },
              ),
              
              QNumberField(
                label: "Monthly Income (\$)",
                value: monthlyIncome,
                onChanged: (value) {
                  monthlyIncome = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Source of Income",
                value: sourceOfIncome,
                onChanged: (value) {
                  sourceOfIncome = value;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I have an existing account with another bank",
                    "value": true,
                    "checked": hasExistingAccount,
                  }
                ],
                value: [
                  if (hasExistingAccount)
                    {
                      "label": "I have an existing account with another bank",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  hasExistingAccount = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Additional Services (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ...additionalServices.map((service) => _buildServiceCard(service)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySetupStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          QTextField(
            label: "Create 6-digit PIN",
            value: pin,
            obscureText: true,
            validator: Validator.required,
            onChanged: (value) {
              pin = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Confirm PIN",
            value: confirmPin,
            obscureText: true,
            validator: Validator.required,
            onChanged: (value) {
              confirmPin = value;
              setState(() {});
            },
          ),
          
          if (pin.isNotEmpty && confirmPin.isNotEmpty && pin != confirmPin)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: dangerColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "PINs do not match",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          
          QSwitch(
            items: [
              {
                "label": "Enable biometric authentication (fingerprint/face)",
                "value": "biometric",
                "checked": enableBiometric,
              },
              {
                "label": "Enable SMS notifications",
                "value": "sms",
                "checked": enableSMSNotifications,
              },
              {
                "label": "Enable email notifications",
                "value": "email",
                "checked": enableEmailNotifications,
              },
              {
                "label": "Enable push notifications",
                "value": "push",
                "checked": enablePushNotifications,
              }
            ],
            value: [
              if (enableBiometric) {"label": "Enable biometric authentication (fingerprint/face)", "value": "biometric", "checked": true},
              if (enableSMSNotifications) {"label": "Enable SMS notifications", "value": "sms", "checked": true},
              if (enableEmailNotifications) {"label": "Enable email notifications", "value": "email", "checked": true},
              if (enablePushNotifications) {"label": "Enable push notifications", "value": "push", "checked": true},
            ],
            onChanged: (values, ids) {
              enableBiometric = values.any((v) => v["value"] == "biometric");
              enableSMSNotifications = values.any((v) => v["value"] == "sms");
              enableEmailNotifications = values.any((v) => v["value"] == "email");
              enablePushNotifications = values.any((v) => v["value"] == "push");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

  Widget _buildAccountTypeCard(Map<String, dynamic> account) {
    bool isSelected = accountType == account["type"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(radiusXs),
        color: isSelected ? primaryColor.withAlpha(10) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusXs),
          onTap: () {
            accountType = account["type"];
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${account["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: primaryColor),
                  ],
                ),
                Text(
                  "${account["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Minimum deposit: \$${account["minimumDeposit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  children: (account["features"] as List).map((feature) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      margin: EdgeInsets.only(top: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    bool isSelected = selectedServices.contains(service["name"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusXs),
          onTap: () {
            if (isSelected) {
              selectedServices.remove(service["name"]);
            } else {
              selectedServices.add(service["name"]);
            }
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(
                  service["icon"] as IconData,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${service["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${service["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _nextStep() async {
    if (currentStep < onboardingSteps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      // Complete onboarding
      await _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    bool isConfirmed = await confirm("Complete account setup and create your BFA account?");
    if (isConfirmed) {
      showLoading();
      
      // Simulate account creation
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      
      ss("Account created successfully! Welcome to BFA Digital Banking.");
      
      // Navigate to main app
      await offAll(BfaHomeView());
    }
  }
}
