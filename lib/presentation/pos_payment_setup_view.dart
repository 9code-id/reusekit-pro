import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPaymentSetupView extends StatefulWidget {
  const PosPaymentSetupView({super.key});

  @override
  State<PosPaymentSetupView> createState() => _PosPaymentSetupViewState();
}

class _PosPaymentSetupViewState extends State<PosPaymentSetupView> {
  final formKey = GlobalKey<FormState>();
  String paymentProvider = "stripe";
  String stripePublicKey = "";
  String stripeSecretKey = "";
  String paypalClientId = "";
  String paypalClientSecret = "";
  String squareApplicationId = "";
  String squareAccessToken = "";
  bool enableCashPayments = true;
  bool enableCardPayments = true;
  bool enableDigitalWallets = true;
  bool requireSignature = false;
  bool printReceipts = true;
  bool emailReceipts = false;
  String merchantName = "";
  String merchantPhone = "";
  String merchantAddress = "";
  String taxRate = "0.00";
  String receiptFooter = "";

  final List<Map<String, dynamic>> paymentProviders = [
    {"label": "Stripe", "value": "stripe"},
    {"label": "PayPal", "value": "paypal"},
    {"label": "Square", "value": "square"},
    {"label": "Manual Setup", "value": "manual"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Setup"),
        actions: [
          QButton(
            label: "Save Setup",
            size: bs.sm,
            onPressed: _savePaymentSetup,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Provider Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Provider",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Provider",
                      items: paymentProviders,
                      value: paymentProvider,
                      onChanged: (value, label) {
                        paymentProvider = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Provider Configuration
              if (paymentProvider == "stripe") _buildStripeConfig(),
              if (paymentProvider == "paypal") _buildPayPalConfig(),
              if (paymentProvider == "square") _buildSquareConfig(),

              // Payment Methods Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Methods",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Cash Payments",
                          "value": true,
                          "checked": enableCashPayments,
                        }
                      ],
                      value: enableCashPayments ? [{"label": "Enable Cash Payments", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableCashPayments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Card Payments",
                          "value": true,
                          "checked": enableCardPayments,
                        }
                      ],
                      value: enableCardPayments ? [{"label": "Enable Card Payments", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableCardPayments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Digital Wallets",
                          "value": true,
                          "checked": enableDigitalWallets,
                        }
                      ],
                      value: enableDigitalWallets ? [{"label": "Enable Digital Wallets", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableDigitalWallets = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Transaction Settings
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transaction Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Require Signature for Card Payments",
                          "value": true,
                          "checked": requireSignature,
                        }
                      ],
                      value: requireSignature ? [{"label": "Require Signature for Card Payments", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        requireSignature = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Print Receipts Automatically",
                          "value": true,
                          "checked": printReceipts,
                        }
                      ],
                      value: printReceipts ? [{"label": "Print Receipts Automatically", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        printReceipts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Email Receipts to Customers",
                          "value": true,
                          "checked": emailReceipts,
                        }
                      ],
                      value: emailReceipts ? [{"label": "Email Receipts to Customers", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        emailReceipts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Business Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Business Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Merchant Name",
                      value: merchantName,
                      validator: Validator.required,
                      onChanged: (value) {
                        merchantName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: merchantPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        merchantPhone = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Business Address",
                      value: merchantAddress,
                      validator: Validator.required,
                      onChanged: (value) {
                        merchantAddress = value;
                        setState(() {});
                      },
                    ),
                    QNumberField(
                      label: "Tax Rate (%)",
                      value: taxRate,
                      onChanged: (value) {
                        taxRate = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Receipt Footer Message",
                      value: receiptFooter,
                      hint: "Thank you for your business!",
                      onChanged: (value) {
                        receiptFooter = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Test Payment Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Test Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Test your payment configuration before going live",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    QButton(
                      label: "Run Test Transaction",
                      size: bs.md,
                      onPressed: _runTestTransaction,
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

  Widget _buildStripeConfig() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stripe Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Publishable Key",
            value: stripePublicKey,
            validator: Validator.required,
            onChanged: (value) {
              stripePublicKey = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Secret Key",
            value: stripeSecretKey,
            validator: Validator.required,
            onChanged: (value) {
              stripeSecretKey = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPayPalConfig() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PayPal Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Client ID",
            value: paypalClientId,
            validator: Validator.required,
            onChanged: (value) {
              paypalClientId = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Client Secret",
            value: paypalClientSecret,
            validator: Validator.required,
            onChanged: (value) {
              paypalClientSecret = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSquareConfig() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Square Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Application ID",
            value: squareApplicationId,
            validator: Validator.required,
            onChanged: (value) {
              squareApplicationId = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Access Token",
            value: squareAccessToken,
            validator: Validator.required,
            onChanged: (value) {
              squareAccessToken = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _savePaymentSetup() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Payment setup saved successfully");
    }
  }

  void _runTestTransaction() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    ss("Test transaction completed successfully");
  }
}
