import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaExchangeView extends StatefulWidget {
  const SpaExchangeView({super.key});

  @override
  State<SpaExchangeView> createState() => _SpaExchangeViewState();
}

class _SpaExchangeViewState extends State<SpaExchangeView> {
  String selectedExchangeType = "product";
  String orderNumber = "";
  String exchangeReason = "";
  String selectedItem = "";
  String newItem = "";
  int currentStep = 0;

  List<Map<String, dynamic>> exchangeTypes = [
    {
      "label": "Product Exchange",
      "value": "product",
      "icon": Icons.swap_horiz,
      "description": "Exchange spa products for different items",
    },
    {
      "label": "Size Exchange",
      "value": "size",
      "icon": Icons.height,
      "description": "Change size of robes, slippers, or accessories",
    },
    {
      "label": "Service Exchange",
      "value": "service",
      "icon": Icons.spa,
      "description": "Switch to different spa treatment or package",
    },
    {
      "label": "Credit Exchange",
      "value": "credit",
      "icon": Icons.account_balance_wallet,
      "description": "Convert purchase to store credit for future use",
    },
  ];

  List<Map<String, dynamic>> exchangeSteps = [
    {
      "title": "Select Exchange Type",
      "description": "Choose what type of exchange you need",
      "icon": Icons.category,
      "status": "current",
    },
    {
      "title": "Provide Order Details",
      "description": "Enter your order information and reason",
      "icon": Icons.receipt,
      "status": "pending",
    },
    {
      "title": "Choose New Item",
      "description": "Select your replacement item or service",
      "icon": Icons.shopping_cart,
      "status": "pending",
    },
    {
      "title": "Review & Submit",
      "description": "Confirm your exchange request",
      "icon": Icons.check_circle,
      "status": "pending",
    },
  ];

  List<Map<String, dynamic>> availableProducts = [
    {
      "id": 1,
      "name": "Luxury Spa Robe - Medium",
      "price": 89.99,
      "image": "https://picsum.photos/100/100?random=1&keyword=robe",
      "category": "Apparel",
    },
    {
      "id": 2,
      "name": "Aromatherapy Essential Oil Set",
      "price": 45.99,
      "image": "https://picsum.photos/100/100?random=2&keyword=oils",
      "category": "Aromatherapy",
    },
    {
      "id": 3,
      "name": "Bamboo Spa Slippers",
      "price": 24.99,
      "image": "https://picsum.photos/100/100?random=3&keyword=slippers",
      "category": "Footwear",
    },
    {
      "id": 4,
      "name": "Organic Face Mask Kit",
      "price": 39.99,
      "image": "https://picsum.photos/100/100?random=4&keyword=mask",
      "category": "Skincare",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exchange Request"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              _showExchangeHelp();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Exchange Header
          _buildExchangeHeader(),

          // Progress Stepper
          _buildProgressStepper(),

          // Exchange Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStepContent(),
            ),
          ),

          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildExchangeHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horizontal_circle, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product & Service Exchange",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Quick and easy exchanges for your satisfaction",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Exchange Benefits
          Row(
            children: [
              _buildBenefitItem("FREE", "Exchange shipping", Icons.local_shipping),
              SizedBox(width: spSm),
              _buildBenefitItem("30 DAYS", "Exchange window", Icons.schedule),
              SizedBox(width: spSm),
              _buildBenefitItem("EASY", "Online process", Icons.computer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStepper() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.grey[50],
      child: Row(
        children: List.generate(exchangeSteps.length, (index) {
          final step = exchangeSteps[index];
          final isCompleted = index < currentStep;
          final isCurrent = index == currentStep;
          
          return Expanded(
            child: Row(
              children: [
                // Step Indicator
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted 
                        ? successColor 
                        : isCurrent 
                          ? primaryColor 
                          : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 16)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isCurrent ? Colors.white : Colors.grey[600],
                            ),
                          ),
                  ),
                ),
                
                // Connector Line
                if (index < exchangeSteps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      color: isCompleted ? successColor : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildExchangeTypeSelection();
      case 1:
        return _buildOrderDetailsForm();
      case 2:
        return _buildItemSelection();
      case 3:
        return _buildReviewSubmit();
      default:
        return _buildExchangeTypeSelection();
    }
  }

  Widget _buildExchangeTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What would you like to exchange?",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        
        ...exchangeTypes.map((type) {
          bool isSelected = selectedExchangeType == type["value"];
          return GestureDetector(
            onTap: () {
              selectedExchangeType = type["value"];
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      type["icon"] as IconData,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${type["label"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : null,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${type["description"]}",
                          style: TextStyle(
                            fontSize: 13,
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
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOrderDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Order Number",
          value: orderNumber,
          onChanged: (value) {
            orderNumber = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Reason for Exchange",
          value: exchangeReason,
          onChanged: (value) {
            exchangeReason = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Item to Exchange",
          value: selectedItem,
          onChanged: (value) {
            selectedItem = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        
        // Exchange Policy Reminder
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: infoColor.withAlpha(100),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Exchange Policy Reminder",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Exchanges must be initiated within 30 days of purchase. Items must be in original condition.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose New Item",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        
        ...availableProducts.map((product) {
          bool isSelected = newItem == product["id"].toString();
          return GestureDetector(
            onTap: () {
              newItem = product["id"].toString();
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey[300]!,
                  width: 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${product["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${product["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(product["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReviewSubmit() {
    final selectedProduct = availableProducts.firstWhere(
      (p) => p["id"].toString() == newItem,
      orElse: () => {},
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Exchange Request",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        
        // Exchange Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              _buildReviewItem("Exchange Type", _getExchangeTypeLabel()),
              _buildReviewItem("Order Number", orderNumber),
              _buildReviewItem("Current Item", selectedItem),
              if (selectedProduct.isNotEmpty)
                _buildReviewItem("New Item", "${selectedProduct["name"]}"),
              _buildReviewItem("Reason", exchangeReason),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        // Terms Agreement
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: warningColor.withAlpha(100),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.assignment, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Exchange Agreement",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "By submitting this exchange request, you agree to our exchange policy terms and conditions. You will receive an email confirmation with return instructions.",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.sm,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            flex: 2,
            child: QButton(
              label: currentStep == exchangeSteps.length - 1 ? "Submit Exchange" : "Continue",
              size: bs.sm,
              onPressed: () {
                _handleNextStep();
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getExchangeTypeLabel() {
    final type = exchangeTypes.firstWhere(
      (t) => t["value"] == selectedExchangeType,
      orElse: () => {"label": "Unknown"},
    );
    return "${type["label"]}";
  }

  void _handleNextStep() {
    if (currentStep == exchangeSteps.length - 1) {
      _submitExchange();
    } else {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return selectedExchangeType.isNotEmpty;
      case 1:
        if (orderNumber.isEmpty || exchangeReason.isEmpty || selectedItem.isEmpty) {
          se("Please fill in all required fields");
          return false;
        }
        return true;
      case 2:
        if (newItem.isEmpty) {
          se("Please select a new item");
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _submitExchange() {
    if (!_validateCurrentStep()) return;
    
    ss("Exchange request submitted successfully!");
    //navigateTo ( ExchangeStatusView )
  }

  void _showExchangeHelp() {
    ss("Exchange help opened");
  }
}
