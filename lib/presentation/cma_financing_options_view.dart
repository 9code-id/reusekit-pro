import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFinancingOptionsView extends StatefulWidget {
  const CmaFinancingOptionsView({super.key});

  @override
  State<CmaFinancingOptionsView> createState() => _CmaFinancingOptionsViewState();
}

class _CmaFinancingOptionsViewState extends State<CmaFinancingOptionsView> {
  String selectedOption = "loan";
  String creditScore = "excellent";
  double vehiclePrice = 35000;
  double downPayment = 7000;
  int loanTerm = 60;
  double interestRate = 4.5;

  List<Map<String, dynamic>> financingOptions = [
    {
      "type": "loan",
      "title": "Auto Loan",
      "description": "Traditional financing with ownership after payments",
      "icon": Icons.account_balance,
      "color": 0xFF4CAF50,
      "pros": ["Own the vehicle", "Build equity", "No mileage restrictions", "Can modify vehicle"],
      "cons": ["Higher monthly payments", "Depreciation", "Maintenance costs"],
      "best_for": "Long-term ownership, high mileage drivers"
    },
    {
      "type": "lease",
      "title": "Vehicle Lease",
      "description": "Lower payments, return vehicle at end of term",
      "icon": Icons.time_to_leave,
      "color": 0xFF2196F3,
      "pros": ["Lower monthly payments", "Warranty coverage", "Latest features", "No resale hassle"],
      "cons": ["No ownership", "Mileage restrictions", "Wear charges", "Continuous payments"],
      "best_for": "Low mileage, want newest features"
    },
    {
      "type": "cash",
      "title": "Cash Purchase",
      "description": "Pay full amount upfront, no financing needed",
      "icon": Icons.attach_money,
      "color": 0xFFFF9800,
      "pros": ["No interest payments", "Full ownership", "No credit requirements", "Lower insurance"],
      "cons": ["Large upfront cost", "Opportunity cost", "Depreciation risk"],
      "best_for": "Excellent financial position, avoid debt"
    },
    {
      "type": "certified",
      "title": "Certified Pre-Owned",
      "description": "Manufacturer certified used vehicles with warranties",
      "icon": Icons.verified,
      "color": 0xFF9C27B0,
      "pros": ["Lower price", "Warranty included", "Inspection certified", "Lower depreciation"],
      "cons": ["Limited selection", "Higher than regular used", "Older technology"],
      "best_for": "Value seekers, want warranty protection"
    }
  ];

  List<Map<String, dynamic>> lenders = [
    {
      "name": "Chase Auto Finance",
      "type": "Bank",
      "rate": 4.2,
      "term": 72,
      "rating": 4.5,
      "features": ["Online application", "Pre-approval", "No prepayment penalty"],
      "logo": "https://picsum.photos/60/60?random=1&keyword=bank"
    },
    {
      "name": "Capital One Auto",
      "type": "Bank",
      "rate": 4.8,
      "term": 60,
      "rating": 4.3,
      "features": ["Auto Navigator", "Blank check", "Rate lock"],
      "logo": "https://picsum.photos/60/60?random=2&keyword=finance"
    },
    {
      "name": "Toyota Financial",
      "type": "Manufacturer",
      "rate": 3.9,
      "term": 60,
      "rating": 4.6,
      "features": ["Special rates", "Loyalty programs", "Extended warranty"],
      "logo": "https://picsum.photos/60/60?random=3&keyword=car"
    },
    {
      "name": "Local Credit Union",
      "type": "Credit Union",
      "rate": 3.5,
      "term": 72,
      "rating": 4.8,
      "features": ["Member benefits", "Lowest rates", "Personal service"],
      "logo": "https://picsum.photos/60/60?random=4&keyword=credit"
    }
  ];

  double get monthlyPayment {
    if (selectedOption == "cash") return 0;
    
    final principal = vehiclePrice - downPayment;
    final monthlyRate = interestRate / 100 / 12;
    final numPayments = loanTerm.toDouble();
    
    if (monthlyRate == 0) return principal / numPayments;
    
    return principal * (monthlyRate * Math.pow(1 + monthlyRate, numPayments)) / 
           (Math.pow(1 + monthlyRate, numPayments) - 1);
  }

  double get totalCost {
    if (selectedOption == "cash") return vehiclePrice;
    return (monthlyPayment * loanTerm) + downPayment;
  }

  double get totalInterest {
    if (selectedOption == "cash") return 0;
    return totalCost - vehiclePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financing Options"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calculate),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Calculator
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Calculator",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "\$${vehiclePrice.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Down Payment",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "\$${downPayment.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Payment Summary
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${monthlyPayment.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Monthly Payment",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: primaryColor.withAlpha(100),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${totalInterest.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total Interest",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Financing Options
            Text(
              "Financing Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: financingOptions.map((option) {
                final isSelected = selectedOption == option["type"];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () {
                      selectedOption = option["type"];
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Color(option["color"] as int).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  option["icon"] as IconData,
                                  color: Color(option["color"] as int),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${option["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${option["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Radio<String>(
                                value: option["type"],
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  selectedOption = value!;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),

                          if (isSelected) ...[
                            SizedBox(height: spSm),
                            
                            // Pros & Cons
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 16, color: successColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Pros",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      ...(option["pros"] as List).map((pro) => Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          "• $pro",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      )).toList(),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.cancel, size: 16, color: dangerColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Cons",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      ...(option["cons"] as List).map((con) => Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          "• $con",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      )).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Best For
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.lightbulb, size: 16, color: infoColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "Best for: ${option["best_for"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Recommended Lenders
            Text(
              "Recommended Lenders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: lenders.map((lender) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      // Logo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${lender["logo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${lender["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${lender["rate"]}% APR",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Text(
                                  "${lender["type"]} • ${lender["term"]} months",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 12, color: warningColor),
                                    Text(
                                      " ${lender["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Wrap(
                              spacing: spXs,
                              children: (lender["features"] as List).take(3).map((feature) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
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
                      
                      SizedBox(width: spSm),
                      
                      QButton(
                        label: "Apply",
                        size: bs.sm,
                        onPressed: () {
                          ss("Application started for ${lender["name"]}");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Calculate Detailed Payment",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo(CmaLoanCalculatorView());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
