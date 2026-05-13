import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCostCalculationView extends StatefulWidget {
  const LtaCostCalculationView({super.key});

  @override
  State<LtaCostCalculationView> createState() => _LtaCostCalculationViewState();
}

class _LtaCostCalculationViewState extends State<LtaCostCalculationView> {
  String origin = "";
  String destination = "";
  String cargoType = "";
  String packageWeight = "";
  String packageDimensions = "";
  String deliveryType = "standard";
  bool insuranceRequired = false;
  bool signatureRequired = false;
  
  List<Map<String, dynamic>> cargoTypes = [
    {"label": "Documents", "value": "documents"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food Items", "value": "food"},
    {"label": "Fragile Items", "value": "fragile"},
    {"label": "Hazardous Materials", "value": "hazardous"},
  ];
  
  List<Map<String, dynamic>> deliveryTypes = [
    {"label": "Standard (3-5 days)", "value": "standard"},
    {"label": "Express (1-2 days)", "value": "express"},
    {"label": "Overnight", "value": "overnight"},
    {"label": "Same Day", "value": "same_day"},
  ];
  
  Map<String, dynamic> calculationResult = {
    "basePrice": 45.0,
    "weightCharge": 12.0,
    "deliveryCharge": 8.0,
    "insuranceCharge": 5.0,
    "signatureCharge": 3.0,
    "totalCost": 73.0,
    "estimatedDelivery": "3-5 business days",
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildShippingDetails(),
            _buildPackageDetails(),
            _buildServiceOptions(),
            _buildCostBreakdown(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildShippingDetails() {
    return Container(
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
          Text(
            "Shipping Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Origin Address",
            value: origin,
            hint: "Enter pickup location",
            onChanged: (value) {
              origin = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Destination Address",
            value: destination,
            hint: "Enter delivery location",
            onChanged: (value) {
              destination = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Cargo Type",
            items: cargoTypes,
            value: cargoType,
            onChanged: (value, label) {
              cargoType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPackageDetails() {
    return Container(
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
          Text(
            "Package Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Weight (kg)",
            value: packageWeight,
            onChanged: (value) {
              packageWeight = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Dimensions (L x W x H cm)",
            value: packageDimensions,
            hint: "e.g., 30 x 20 x 15",
            onChanged: (value) {
              packageDimensions = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Delivery Type",
            items: deliveryTypes,
            value: deliveryType,
            onChanged: (value, label) {
              deliveryType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildServiceOptions() {
    return Container(
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
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Insurance Coverage",
                "value": true,
                "checked": insuranceRequired,
              }
            ],
            value: [
              if (insuranceRequired)
                {
                  "label": "Insurance Coverage",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              insuranceRequired = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Signature Required",
                "value": true,
                "checked": signatureRequired,
              }
            ],
            value: [
              if (signatureRequired)
                {
                  "label": "Signature Required",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              signatureRequired = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildCostBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Cost Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildCostItem("Base Price", calculationResult["basePrice"] as double),
          _buildCostItem("Weight Charge", calculationResult["weightCharge"] as double),
          _buildCostItem("Delivery Charge", calculationResult["deliveryCharge"] as double),
          if (insuranceRequired)
            _buildCostItem("Insurance", calculationResult["insuranceCharge"] as double),
          if (signatureRequired)
            _buildCostItem("Signature Service", calculationResult["signatureCharge"] as double),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Cost",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${(calculationResult["totalCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Estimated Delivery: ${calculationResult["estimatedDelivery"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCostItem(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Calculate",
            onPressed: () {
              ss("Cost calculated successfully!");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Book Shipment",
            onPressed: () {
              //navigateTo('BookingView')
            },
          ),
        ),
      ],
    );
  }
}
