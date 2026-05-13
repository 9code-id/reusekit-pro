import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOtp9View extends StatefulWidget {
  @override
  State<GrlOtp9View> createState() => _GrlOtp9ViewState();
}

class _GrlOtp9ViewState extends State<GrlOtp9View> {
  String selectedBank = "";
  String accountNumber = "";
  String routingNumber = "";
  String verificationCode = "";
  
  bool isBankSelected = false;
  bool isAccountAdded = false;
  bool isCodeSent = false;
  bool isVerifying = false;
  bool isVerified = false;

  List<Map<String, dynamic>> banks = [
    {
      "name": "Chase Bank",
      "code": "CHASE",
      "icon": "🏦",
      "color": Colors.blue,
    },
    {
      "name": "Bank of America",
      "code": "BOA",
      "icon": "🏛️",
      "color": Colors.red,
    },
    {
      "name": "Wells Fargo",
      "code": "WF",
      "icon": "🏦",
      "color": Colors.orange,
    },
    {
      "name": "Citibank",
      "code": "CITI",
      "icon": "🏛️",
      "color": Colors.blue,
    },
    {
      "name": "Capital One",
      "code": "CAPITAL",
      "icon": "🏦",
      "color": Colors.purple,
    },
    {
      "name": "Other Bank",
      "code": "OTHER",
      "icon": "🏦",
      "color": Colors.grey,
    },
  ];

  List<Map<String, dynamic>> verificationMethods = [
    {
      "id": "micro_deposits",
      "title": "Micro Deposits",
      "description": "We'll send 2 small deposits to your account",
      "icon": Icons.account_balance,
      "timeframe": "1-2 business days",
      "selected": true,
    },
    {
      "id": "instant_verification",
      "title": "Instant Verification",
      "description": "Verify instantly with your online banking",
      "icon": Icons.flash_on,
      "timeframe": "30 seconds",
      "selected": false,
    },
    {
      "id": "manual_verification",
      "title": "Manual Verification",
      "description": "Upload bank statement for manual review",
      "icon": Icons.description,
      "timeframe": "24-48 hours",
      "selected": false,
    },
  ];

  String selectedVerificationMethod = "micro_deposits";

  void _selectBank(String bankCode) {
    selectedBank = bankCode;
    isBankSelected = true;
    setState(() {});
  }

  void _addBankAccount() {
    if (accountNumber.isEmpty || routingNumber.isEmpty) {
      se("Please enter both account and routing numbers");
      return;
    }

    if (accountNumber.length < 8) {
      se("Account number must be at least 8 digits");
      return;
    }

    if (routingNumber.length != 9) {
      se("Routing number must be exactly 9 digits");
      return;
    }

    isAccountAdded = true;
    setState(() {});
    ss("Bank account added successfully");
  }

  void _selectVerificationMethod(String methodId) {
    selectedVerificationMethod = methodId;
    for (var method in verificationMethods) {
      method["selected"] = method["id"] == methodId;
    }
    setState(() {});
  }

  void _startVerification() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    if (selectedVerificationMethod == "micro_deposits") {
      si("Micro deposits will be sent to your account within 1-2 business days");
    } else if (selectedVerificationMethod == "instant_verification") {
      isCodeSent = true;
      setState(() {});
      si("Verification code sent to your registered phone number");
    } else {
      si("Please upload your bank statement for manual verification");
    }
  }

  void _verifyCode() async {
    if (verificationCode.length < 6) {
      se("Please enter the complete verification code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    isVerifying = false;
    setState(() {});

    if (verificationCode == "123456") {
      isVerified = true;
      setState(() {});
      ss("Bank account verified successfully!");
    } else {
      se("Invalid verification code. Please try again.");
      verificationCode = "";
      setState(() {});
    }
  }

  String _maskAccountNumber(String number) {
    if (number.length <= 4) return number;
    return "****${number.substring(number.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Account Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isVerified 
                        ? successColor.withAlpha(15)
                        : primaryColor.withAlpha(15),
                    isVerified 
                        ? successColor.withAlpha(5)
                        : primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isVerified 
                      ? successColor.withAlpha(30)
                      : primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isVerified ? successColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      isVerified ? Icons.verified_user : Icons.account_balance,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isVerified 
                        ? "Account Verified!" 
                        : "Verify Your Bank Account",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: isVerified ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    isVerified 
                        ? "Your bank account has been successfully verified"
                        : "Add and verify your bank account for secure transactions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Bank Selection (Step 1)
            if (!isBankSelected)
              Container(
                width: double.infinity,
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Select Your Bank",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: banks.map((bank) {
                        return GestureDetector(
                          onTap: () => _selectBank(bank["code"]),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              spacing: spSm,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: (bank["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      bank["icon"],
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                                Text(
                                  bank["name"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Bank Account Details (Step 2)
            if (isBankSelected && !isAccountAdded)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.account_balance,
                            size: 20,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Account Details",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              banks.firstWhere((bank) => bank["code"] == selectedBank)["name"],
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Account Number",
                      value: accountNumber,
                      hint: "Enter your account number",
                      onChanged: (value) {
                        accountNumber = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Routing Number",
                      value: routingNumber,
                      hint: "9-digit routing number",
                      onChanged: (value) {
                        routingNumber = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Your banking information is encrypted and secure. We never store your login credentials.",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Add Bank Account",
                        size: bs.md,
                        onPressed: _addBankAccount,
                      ),
                    ),
                  ],
                ),
              ),

            // Verification Method Selection (Step 3)
            if (isAccountAdded && !isCodeSent && !isVerified)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Account Summary
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: successColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Added Successfully",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${banks.firstWhere((bank) => bank["code"] == selectedBank)["name"]} - ${_maskAccountNumber(accountNumber)}",
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
                    ),
                    Text(
                      "Choose Verification Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...verificationMethods.map((method) {
                      bool isSelected = method["selected"];
                      
                      return GestureDetector(
                        onTap: () => _selectVerificationMethod(method["id"]),
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withAlpha(10)
                                : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected 
                                  ? primaryColor 
                                  : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  method["icon"],
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method["title"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      method["description"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: spXs),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? primaryColor.withAlpha(20)
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        method["timeframe"],
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : disabledColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.radio_button_checked,
                                  size: 24,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Verification",
                        size: bs.md,
                        onPressed: _startVerification,
                      ),
                    ),
                  ],
                ),
              ),

            // Verification Code Input (Instant Verification)
            if (isCodeSent && !isVerified)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Instant Verification",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "We've sent a verification code to your registered phone number. Please enter the code to complete verification.",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QTextField(
                      label: "Verification Code",
                      value: verificationCode,
                      hint: "Enter 6-digit code",
                      onChanged: (value) {
                        verificationCode = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: isVerifying ? "Verifying..." : "Verify Account",
                        size: bs.md,
                        onPressed: isVerifying ? null : _verifyCode,
                      ),
                    ),
                  ],
                ),
              ),

            // Success State
            if (isVerified)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.celebration,
                          size: 24,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Account Verified Successfully!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance,
                                size: 18,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Verified Bank Account",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                banks.firstWhere((bank) => bank["code"] == selectedBank)["name"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                _maskAccountNumber(accountNumber),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
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
                        label: "Continue to Dashboard",
                        size: bs.md,
                        color: successColor,
                        onPressed: () {
                          // Navigate to dashboard
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Security Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 18,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Your Security is Our Priority",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "256-bit SSL encryption",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Bank-level security standards",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.shield,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "PCI DSS compliant",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
