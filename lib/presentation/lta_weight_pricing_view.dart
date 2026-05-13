import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaWeightPricingView extends StatefulWidget {
  const LtaWeightPricingView({super.key});

  @override
  State<LtaWeightPricingView> createState() => _LtaWeightPricingViewState();
}

class _LtaWeightPricingViewState extends State<LtaWeightPricingView> {
  String selectedZone = "domestic";
  String selectedService = "standard";
  
  List<Map<String, dynamic>> zones = [
    {"label": "Domestic", "value": "domestic"},
    {"label": "International", "value": "international"},
    {"label": "Express Zone", "value": "express"},
  ];
  
  List<Map<String, dynamic>> services = [
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Premium Service", "value": "premium"},
  ];
  
  List<Map<String, dynamic>> weightRanges = [
    {
      "range": "0 - 1 kg",
      "domestic": 12.50,
      "international": 25.00,
      "express": 35.00,
    },
    {
      "range": "1 - 5 kg",
      "domestic": 18.75,
      "international": 42.50,
      "express": 55.00,
    },
    {
      "range": "5 - 10 kg",
      "domestic": 28.50,
      "international": 67.50,
      "express": 85.00,
    },
    {
      "range": "10 - 20 kg",
      "domestic": 45.00,
      "international": 95.00,
      "express": 125.00,
    },
    {
      "range": "20 - 50 kg",
      "domestic": 75.00,
      "international": 165.00,
      "express": 220.00,
    },
    {
      "range": "50+ kg",
      "domestic": 125.00,
      "international": 285.00,
      "express": 375.00,
    },
  ];
  
  List<Map<String, dynamic>> additionalServices = [
    {
      "service": "Insurance Coverage",
      "description": "Protect your package value",
      "price": 5.00,
    },
    {
      "service": "Signature Required",
      "description": "Ensure secure delivery",
      "price": 3.50,
    },
    {
      "service": "Package Tracking",
      "description": "Real-time tracking updates",
      "price": 2.00,
    },
    {
      "service": "SMS Notifications",
      "description": "Delivery status updates",
      "price": 1.50,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight-Based Pricing"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildServiceSelector(),
            _buildPricingTable(),
            _buildAdditionalServices(),
            _buildDiscountInfo(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceSelector() {
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
            "Select Service Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: [
              {"label": "Domestic", "value": "domestic"},
              {"label": "International", "value": "international"},
              {"label": "Express", "value": "express"},
            ],
            value: selectedZone,
            onChanged: (index, label, value, item) {
              selectedZone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPricingTable() {
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
          Row(
            children: [
              Icon(
                Icons.scale,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Weight-Based Pricing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                ...List.generate(weightRanges.length, (index) {
                  final range = weightRanges[index];
                  return _buildTableRow(
                    range["range"],
                    (range[selectedZone] as double),
                    index % 2 == 0,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(30),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusSm),
          topRight: Radius.circular(radiusSm),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Weight Range",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Price (\$)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTableRow(String range, double price, bool isEven) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isEven ? Colors.grey.shade50 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              range,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "\$${price.currency}",
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
  
  Widget _buildAdditionalServices() {
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
          ...List.generate(additionalServices.length, (index) {
            final service = additionalServices[index];
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${service["service"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
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
                  Text(
                    "+\$${(service["price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildDiscountInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Volume Discounts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          _buildDiscountItem("10+ shipments/month", "5% discount"),
          _buildDiscountItem("50+ shipments/month", "10% discount"),
          _buildDiscountItem("100+ shipments/month", "15% discount"),
          _buildDiscountItem("Corporate accounts", "Custom pricing available"),
        ],
      ),
    );
  }
  
  Widget _buildDiscountItem(String condition, String discount) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: successColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            condition,
            style: TextStyle(
              fontSize: 14,
              color: successColor,
            ),
          ),
        ),
        Text(
          discount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: successColor,
          ),
        ),
      ],
    );
  }
}
