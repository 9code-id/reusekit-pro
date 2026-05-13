import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription4View extends StatefulWidget {
  @override
  State<GrlSubscription4View> createState() => _GrlSubscription4ViewState();
}

class _GrlSubscription4ViewState extends State<GrlSubscription4View> {
  int currentStep = 0;
  bool isProcessing = false;

  // Step 1: Plan Selection
  List<Map<String, dynamic>> plans = [
    {
      "id": "basic",
      "name": "Basic",
      "price": 9.99,
      "features": ["10 GB Storage", "Email Support", "Basic Analytics"],
      "recommended": false,
    },
    {
      "id": "pro",
      "name": "Pro",
      "price": 29.99,
      "features": ["100 GB Storage", "Priority Support", "Advanced Analytics", "API Access"],
      "recommended": true,
    },
    {
      "id": "enterprise",
      "name": "Enterprise",
      "price": 99.99,
      "features": ["Unlimited Storage", "24/7 Support", "Custom Analytics", "Full API", "White Label"],
      "recommended": false,
    },
  ];
  String selectedPlan = "pro";

  // Step 2: Billing Cycle
  String billingCycle = "monthly";
  
  // Step 3: Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";

  // Step 4: Payment Information
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: _buildCurrentStep(),
              ),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    List<String> stepTitles = ["Plan", "Billing", "Info", "Payment", "Complete"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: List.generate(stepTitles.length, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;
              
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: isCompleted || isCurrent ? primaryColor : disabledOutlineBorderColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                    if (index < stepTitles.length - 1) SizedBox(width: spXs),
                  ],
                ),
              );
            }),
          ),
          Row(
            children: List.generate(stepTitles.length, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;
              
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent ? primaryColor : disabledOutlineBorderColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isCompleted
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      stepTitles[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isCompleted || isCurrent ? primaryColor : disabledBoldColor,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPlanSelection();
      case 1:
        return _buildBillingCycle();
      case 2:
        return _buildPersonalInfo();
      case 3:
        return _buildPaymentInfo();
      case 4:
        return _buildCompletion();
      default:
        return Container();
    }
  }

  Widget _buildPlanSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Choose Your Plan",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Select the plan that best fits your needs. You can upgrade or downgrade anytime.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        Column(
          spacing: spSm,
          children: plans.map((plan) {
            bool isSelected = selectedPlan == plan["id"];
            return GestureDetector(
              onTap: () {
                selectedPlan = plan["id"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected ? [shadowMd] : [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${plan["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (plan["recommended"] as bool)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXl),
                                      ),
                                      child: Text(
                                        "RECOMMENDED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(plan["price"] as double).toStringAsFixed(2)}/month",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Radio<String>(
                          value: plan["id"],
                          groupValue: selectedPlan,
                          onChanged: (value) {
                            selectedPlan = value!;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: (plan["features"] as List<String>).map((feature) {
                        return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              feature,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBillingCycle() {
    double selectedPlanPrice = plans.firstWhere((plan) => plan["id"] == selectedPlan)["price"];
    double annualPrice = selectedPlanPrice * 12 * 0.8; // 20% discount
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Choose Billing Cycle",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Save 20% with annual billing. You can change this later in your account settings.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        Column(
          spacing: spSm,
          children: [
            GestureDetector(
              onTap: () {
                billingCycle = "monthly";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: billingCycle == "monthly" ? primaryColor.withAlpha(10) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: billingCycle == "monthly" ? primaryColor : disabledOutlineBorderColor,
                    width: billingCycle == "monthly" ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Monthly Billing",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Billed every month",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${selectedPlanPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per month",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Radio<String>(
                      value: "monthly",
                      groupValue: billingCycle,
                      onChanged: (value) {
                        billingCycle = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                billingCycle = "annual";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: billingCycle == "annual" ? primaryColor.withAlpha(10) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: billingCycle == "annual" ? primaryColor : disabledOutlineBorderColor,
                    width: billingCycle == "annual" ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Annual Billing",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "SAVE 20%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Billed once per year",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${annualPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per year",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Radio<String>(
                      value: "annual",
                      groupValue: billingCycle,
                      onChanged: (value) {
                        billingCycle = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "We need this information to create your account and send you important updates.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        Row(
          spacing: spSm,
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
          value: phone,
          hint: "+1 (555) 123-4567",
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        QTextField(
          label: "Company (Optional)",
          value: company,
          hint: "Your company name",
          onChanged: (value) {
            company = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Payment Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Enter your payment details to complete the subscription setup.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
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
        Row(
          spacing: spSm,
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
            Expanded(
              child: QTextField(
                label: "CVV",
                value: cvv,
                hint: "123",
                validator: Validator.required,
                onChanged: (value) {
                  cvv = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QTextField(
          label: "Cardholder Name",
          value: cardholderName,
          hint: "John Doe",
          validator: Validator.required,
          onChanged: (value) {
            cardholderName = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildCompletion() {
    final selectedPlanData = plans.firstWhere((plan) => plan["id"] == selectedPlan);
    final planPrice = selectedPlanData["price"] as double;
    final finalPrice = billingCycle == "annual" ? planPrice * 12 * 0.8 : planPrice;
    
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spXl),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXl),
          ),
          child: Icon(
            Icons.check_circle,
            color: successColor,
            size: 80,
          ),
        ),
        Text(
          "Subscription Complete!",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Welcome to ${selectedPlanData["name"]} plan! Your subscription is now active.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Plan:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${selectedPlanData["name"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Billing:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${billingCycle.toString().toUpperCase()}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Amount:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$${finalPrice.toStringAsFixed(2)}/${billingCycle == "annual" ? "year" : "month"}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Go to Dashboard",
            size: bs.md,
            onPressed: () {
              ss("Welcome! Redirecting to dashboard...");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        spacing: spSm,
        children: [
          if (currentStep > 0)
            Expanded(
              child: Container(
                child: QButton(
                  label: "Back",
                  size: bs.md,
                  onPressed: () {
                    if (currentStep > 0) {
                      currentStep--;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          Expanded(
            flex: currentStep == 0 ? 1 : 2,
            child: Container(
              child: QButton(
                label: currentStep == 4 
                    ? "Complete" 
                    : currentStep == 3 
                        ? isProcessing 
                            ? "Processing..." 
                            : "Subscribe"
                        : "Continue",
                size: bs.md,
                onPressed: isProcessing ? null : _handleNextStep,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNextStep() async {
    if (currentStep < 4) {
      // Validate current step
      if (currentStep == 2 || currentStep == 3) {
        if (!formKey.currentState!.validate()) {
          se("Please fill in all required fields");
          return;
        }
      }

      if (currentStep == 3) {
        // Process payment
        isProcessing = true;
        setState(() {});

        await Future.delayed(Duration(seconds: 2));

        isProcessing = false;
        setState(() {});
      }

      currentStep++;
      setState(() {});
    }
  }
}
