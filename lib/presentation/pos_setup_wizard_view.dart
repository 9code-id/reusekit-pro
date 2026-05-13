import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosSetupWizardView extends StatefulWidget {
  const PosSetupWizardView({super.key});

  @override
  State<PosSetupWizardView> createState() => _PosSetupWizardViewState();
}

class _PosSetupWizardViewState extends State<PosSetupWizardView> {
  int currentStep = 0;
  
  // Store Setup
  String storeName = "";
  String storeAddress = "";
  String storePhone = "";
  String storeEmail = "";
  String timezone = "America/New_York";
  String currency = "USD";
  
  // Tax Configuration
  bool enableTax = true;
  String taxName = "Sales Tax";
  double taxRate = 8.25;
  bool taxIncluded = false;
  
  // Payment Methods
  bool acceptCash = true;
  bool acceptCard = true;
  bool acceptDigitalWallet = false;
  bool acceptContactless = true;
  
  // Integrations
  bool enableInventory = true;
  bool enableAnalytics = true;
  bool enableCustomerDB = false;
  bool enableLoyalty = false;

  final List<Map<String, dynamic>> timezones = [
    {"label": "Eastern Time (UTC-5)", "value": "America/New_York"},
    {"label": "Central Time (UTC-6)", "value": "America/Chicago"},
    {"label": "Mountain Time (UTC-7)", "value": "America/Denver"},
    {"label": "Pacific Time (UTC-8)", "value": "America/Los_Angeles"},
    {"label": "GMT (UTC+0)", "value": "Europe/London"},
    {"label": "Other", "value": "Other"},
  ];

  final List<Map<String, dynamic>> currencies = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
    {"label": "Australian Dollar (AUD)", "value": "AUD"},
    {"label": "Japanese Yen (JPY)", "value": "JPY"},
  ];

  final List<Map<String, dynamic>> setupSteps = [
    {
      "title": "Store Information",
      "description": "Basic store details and location",
      "icon": Icons.store,
    },
    {
      "title": "Tax Configuration",
      "description": "Setup tax rates and preferences",
      "icon": Icons.receipt_long,
    },
    {
      "title": "Payment Methods",
      "description": "Configure accepted payment types",
      "icon": Icons.payment,
    },
    {
      "title": "Features & Integrations",
      "description": "Enable optional features",
      "icon": Icons.extension,
    },
    {
      "title": "Review & Complete",
      "description": "Review your settings",
      "icon": Icons.check_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(5),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Setup Wizard",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Step ${currentStep + 1} of ${setupSteps.length}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (currentStep > 0)
                      QButton(
                        label: "Skip",
                        size: bs.sm,
                        onPressed: () {
                          _completeSetup();
                        },
                      ),
                  ],
                ),
              ),

              // Progress Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Column(
                  children: [
                    Row(
                      children: List.generate(setupSteps.length, (index) {
                        final isCompleted = index < currentStep;
                        final isCurrent = index == currentStep;
                        
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isCompleted || isCurrent ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: setupSteps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        final isCompleted = index < currentStep;
                        final isCurrent = index == currentStep;
                        
                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isCompleted ? successColor : 
                                         isCurrent ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  isCompleted ? Icons.check : step["icon"] as IconData,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${step["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isCurrent ? primaryColor : disabledBoldColor,
                                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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

              // Navigation
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          size: bs.md,
                          onPressed: () {
                            _previousStep();
                          },
                        ),
                      ),
                    if (currentStep > 0) SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: currentStep == setupSteps.length - 1 ? "Complete Setup" : "Next",
                        size: bs.md,
                        onPressed: () {
                          _nextStep();
                        },
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

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildStoreInfoStep();
      case 1:
        return _buildTaxConfigStep();
      case 2:
        return _buildPaymentMethodsStep();
      case 3:
        return _buildFeaturesStep();
      case 4:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildStoreInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Store Information",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Enter your store details to personalize your POS system",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QTextField(
            label: "Store Name",
            value: storeName,
            onChanged: (value) {
              storeName = value;
              setState(() {});
            },
          ),

          QMemoField(
            label: "Store Address",
            value: storeAddress,
            onChanged: (value) {
              storeAddress = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: storePhone,
                  onChanged: (value) {
                    storePhone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: storeEmail,
                  onChanged: (value) {
                    storeEmail = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timezone",
                  items: timezones,
                  value: timezone,
                  onChanged: (value, label) {
                    timezone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Currency",
                  items: currencies,
                  value: currency,
                  onChanged: (value, label) {
                    currency = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxConfigStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tax Configuration",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Configure tax settings for your business",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QSwitch(
            label: "Tax Settings",
            items: [
              {
                "label": "Enable tax calculation",
                "value": true,
                "checked": enableTax,
              }
            ],
            value: [if (enableTax) {"label": "Enable tax calculation", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableTax = values.isNotEmpty;
              setState(() {});
            },
          ),

          if (enableTax) ...[
            QTextField(
              label: "Tax Name",
              value: taxName,
              onChanged: (value) {
                taxName = value;
                setState(() {});
              },
            ),

            QNumberField(
              label: "Tax Rate (%)",
              value: taxRate.toString(),
              onChanged: (value) {
                taxRate = double.tryParse(value) ?? 0.0;
                setState(() {});
              },
            ),

            QSwitch(
              label: "Tax Options",
              items: [
                {
                  "label": "Tax included in product prices",
                  "value": true,
                  "checked": taxIncluded,
                }
              ],
              value: [if (taxIncluded) {"label": "Tax included in product prices", "value": true, "checked": true}],
              onChanged: (values, ids) {
                taxIncluded = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Payment Methods",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select which payment methods you want to accept",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QSwitch(
            label: "Payment Options",
            items: [
              {
                "label": "Cash payments",
                "value": "cash",
                "checked": acceptCash,
              },
              {
                "label": "Credit/Debit cards",
                "value": "card", 
                "checked": acceptCard,
              },
              {
                "label": "Digital wallets (Apple Pay, Google Pay)",
                "value": "digital",
                "checked": acceptDigitalWallet,
              },
              {
                "label": "Contactless payments",
                "value": "contactless",
                "checked": acceptContactless,
              },
            ],
            value: [
              if (acceptCash) {"label": "Cash payments", "value": "cash", "checked": true},
              if (acceptCard) {"label": "Credit/Debit cards", "value": "card", "checked": true},
              if (acceptDigitalWallet) {"label": "Digital wallets (Apple Pay, Google Pay)", "value": "digital", "checked": true},
              if (acceptContactless) {"label": "Contactless payments", "value": "contactless", "checked": true},
            ],
            onChanged: (values, ids) {
              acceptCash = values.any((v) => v["value"] == "cash");
              acceptCard = values.any((v) => v["value"] == "card");
              acceptDigitalWallet = values.any((v) => v["value"] == "digital");
              acceptContactless = values.any((v) => v["value"] == "contactless");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Features & Integrations",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Choose which features to enable for your business",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QSwitch(
            label: "Business Features",
            items: [
              {
                "label": "Inventory management",
                "value": "inventory",
                "checked": enableInventory,
              },
              {
                "label": "Sales analytics & reporting",
                "value": "analytics",
                "checked": enableAnalytics,
              },
              {
                "label": "Customer database",
                "value": "customer",
                "checked": enableCustomerDB,
              },
              {
                "label": "Loyalty program",
                "value": "loyalty",
                "checked": enableLoyalty,
              },
            ],
            value: [
              if (enableInventory) {"label": "Inventory management", "value": "inventory", "checked": true},
              if (enableAnalytics) {"label": "Sales analytics & reporting", "value": "analytics", "checked": true},
              if (enableCustomerDB) {"label": "Customer database", "value": "customer", "checked": true},
              if (enableLoyalty) {"label": "Loyalty program", "value": "loyalty", "checked": true},
            ],
            onChanged: (values, ids) {
              enableInventory = values.any((v) => v["value"] == "inventory");
              enableAnalytics = values.any((v) => v["value"] == "analytics");
              enableCustomerDB = values.any((v) => v["value"] == "customer");
              enableLoyalty = values.any((v) => v["value"] == "loyalty");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review Your Setup",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Please review your configuration before completing the setup",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),

          _buildReviewSection("Store Information", [
            "Store Name: $storeName",
            "Currency: $currency",
            "Timezone: $timezone",
          ]),

          _buildReviewSection("Tax Configuration", [
            "Tax Enabled: ${enableTax ? 'Yes' : 'No'}",
            if (enableTax) "Tax Rate: ${taxRate.toStringAsFixed(2)}%",
          ]),

          _buildReviewSection("Payment Methods", [
            if (acceptCash) "✓ Cash payments",
            if (acceptCard) "✓ Credit/Debit cards", 
            if (acceptDigitalWallet) "✓ Digital wallets",
            if (acceptContactless) "✓ Contactless payments",
          ]),

          _buildReviewSection("Features", [
            if (enableInventory) "✓ Inventory management",
            if (enableAnalytics) "✓ Sales analytics",
            if (enableCustomerDB) "✓ Customer database",
            if (enableLoyalty) "✓ Loyalty program",
          ]),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, List<String> items) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
              item,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  void _nextStep() {
    if (currentStep < setupSteps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      _completeSetup();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _completeSetup() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Setup completed successfully!");
      // navigateTo('PosDashboardView')
    });
  }
}
