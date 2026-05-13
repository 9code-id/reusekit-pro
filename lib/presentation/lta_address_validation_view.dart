import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaAddressValidationView extends StatefulWidget {
  const LtaAddressValidationView({super.key});

  @override
  State<LtaAddressValidationView> createState() => _LtaAddressValidationViewState();
}

class _LtaAddressValidationViewState extends State<LtaAddressValidationView> {
  bool isValidating = false;
  String validationStatus = "pending"; // pending, success, error, warning
  
  Map<String, dynamic> originalAddress = {
    "street": "123 Main Street",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001",
    "country": "United States",
  };

  Map<String, dynamic> suggestedAddress = {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001-1234",
    "country": "United States",
  };

  List<Map<String, dynamic>> validationResults = [
    {
      "field": "Street Address",
      "status": "corrected",
      "original": "123 Main Street",
      "suggested": "123 Main St",
      "message": "Street name standardized",
      "icon": Icons.check_circle,
      "color": "warning",
    },
    {
      "field": "ZIP Code",
      "status": "enhanced",
      "original": "10001",
      "suggested": "10001-1234",
      "message": "Added ZIP+4 extension",
      "icon": Icons.info,
      "color": "info",
    },
    {
      "field": "City",
      "status": "verified",
      "original": "New York",
      "suggested": "New York",
      "message": "City name verified",
      "icon": Icons.verified,
      "color": "success",
    },
    {
      "field": "State",
      "status": "verified",
      "original": "NY",
      "suggested": "NY",
      "message": "State code verified",
      "icon": Icons.verified,
      "color": "success",
    },
  ];

  Map<String, dynamic> deliveryInfo = {
    "deliverable": true,
    "residential": true,
    "poBox": false,
    "businessAddress": false,
    "deliveryDays": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    "restrictions": [],
    "accessNotes": "Standard residential delivery",
  };

  List<Map<String, dynamic>> alternativeAddresses = [
    {
      "id": 1,
      "street": "123 Main Street, Apt 2A",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001-1234",
      "confidence": 95,
      "type": "Apartment variation",
    },
    {
      "id": 2,
      "street": "125 Main Street",
      "city": "New York", 
      "state": "NY",
      "zipCode": "10001-1234",
      "confidence": 85,
      "type": "Similar address",
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "error":
        return dangerColor;
      case "info":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "verified":
        return Icons.verified;
      case "corrected":
        return Icons.check_circle;
      case "enhanced":
        return Icons.info;
      case "error":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  void startValidation() {
    isValidating = true;
    setState(() {});
    
    // Simulate validation process
    Future.delayed(Duration(seconds: 2), () {
      isValidating = false;
      validationStatus = "success";
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    startValidation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Validation"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              startValidation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Validation Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isValidating 
                    ? infoColor.withAlpha(20)
                    : validationStatus == "success" 
                        ? successColor.withAlpha(20)
                        : dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isValidating 
                      ? infoColor.withAlpha(50)
                      : validationStatus == "success" 
                          ? successColor.withAlpha(50)
                          : dangerColor.withAlpha(50),
                ),
              ),
              child: Row(
                children: [
                  if (isValidating) ...[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                      ),
                    ),
                  ] else ...[
                    Icon(
                      validationStatus == "success" ? Icons.check_circle : Icons.error,
                      color: validationStatus == "success" ? successColor : dangerColor,
                      size: 24,
                    ),
                  ],
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isValidating 
                              ? "Validating Address..."
                              : validationStatus == "success" 
                                  ? "Address Validated Successfully"
                                  : "Address Validation Failed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isValidating 
                                ? infoColor
                                : validationStatus == "success" 
                                    ? successColor
                                    : dangerColor,
                          ),
                        ),
                        if (!isValidating) ...[
                          Text(
                            validationStatus == "success" 
                                ? "Address is deliverable with suggested corrections"
                                : "Please review and correct the address",
                            style: TextStyle(
                              fontSize: 12,
                              color: validationStatus == "success" 
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (!isValidating && validationStatus == "success") ...[
              // Original vs Suggested Address
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
                    Text(
                      "Address Comparison",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Original Address",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${originalAddress["street"]}"),
                                    Text("${originalAddress["city"]}, ${originalAddress["state"]} ${originalAddress["zipCode"]}"),
                                    Text("${originalAddress["country"]}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Suggested Address",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: successColor.withAlpha(50)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${suggestedAddress["street"]}"),
                                    Text("${suggestedAddress["city"]}, ${suggestedAddress["state"]} ${suggestedAddress["zipCode"]}"),
                                    Text("${suggestedAddress["country"]}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Validation Results
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
                    Text(
                      "Validation Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...validationResults.map((result) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: getStatusColor(result["color"] as String).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: getStatusColor(result["color"] as String).withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              result["icon"] as IconData,
                              color: getStatusColor(result["color"] as String),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${result["field"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (result["original"] != result["suggested"]) ...[
                                    Text(
                                      "${result["original"]} → ${result["suggested"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  Text(
                                    "${result["message"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: getStatusColor(result["color"] as String),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Delivery Information
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
                    Text(
                      "Delivery Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: deliveryInfo["deliverable"] as bool 
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  deliveryInfo["deliverable"] as bool 
                                      ? Icons.local_shipping 
                                      : Icons.block,
                                  color: deliveryInfo["deliverable"] as bool 
                                      ? successColor 
                                      : dangerColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  deliveryInfo["deliverable"] as bool 
                                      ? "Deliverable" 
                                      : "Not Deliverable",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: deliveryInfo["deliverable"] as bool 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  deliveryInfo["residential"] as bool 
                                      ? Icons.home 
                                      : Icons.business,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  deliveryInfo["residential"] as bool 
                                      ? "Residential" 
                                      : "Commercial",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Delivery Schedule",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            children: (deliveryInfo["deliveryDays"] as List<String>).map((day) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Text(
                            "${deliveryInfo["accessNotes"]}",
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

              // Alternative Addresses
              if (alternativeAddresses.isNotEmpty) ...[
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
                      Text(
                        "Alternative Addresses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Found similar addresses that might be correct",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      ...alternativeAddresses.map((address) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${address["confidence"]}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${address["street"]}, ${address["city"]}, ${address["state"]} ${address["zipCode"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${address["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Select this alternative address
                                },
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ],

            // Action Buttons
            if (!isValidating) ...[
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Use Original",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('LtaRoutePlanningView')
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: validationStatus == "success" ? "Use Suggested" : "Retry",
                      size: bs.md,
                      onPressed: () {
                        if (validationStatus == "success") {
                          //navigateTo('LtaRoutePlanningView')
                        } else {
                          startValidation();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
