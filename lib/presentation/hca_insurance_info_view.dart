import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaInsuranceInfoView extends StatefulWidget {
  const HcaInsuranceInfoView({super.key});

  @override
  State<HcaInsuranceInfoView> createState() => _HcaInsuranceInfoViewState();
}

class _HcaInsuranceInfoViewState extends State<HcaInsuranceInfoView> {
  String selectedPlan = "primary";

  Map<String, dynamic> primaryInsurance = {
    "provider": "Blue Cross Blue Shield",
    "planName": "PPO Gold Plus",
    "memberId": "BC123456789",
    "groupNumber": "G789456",
    "policyHolder": "John Smith",
    "relationship": "Self",
    "effectiveDate": "2025-01-01",
    "expirationDate": "2025-12-31",
    "status": "active",
    "copayGeneral": 25.00,
    "copaySpecialist": 50.00,
    "deductible": 1500.00,
    "deductibleMet": 450.00,
    "outOfPocketMax": 8000.00,
    "outOfPocketUsed": 1250.00,
    "coveragePercentage": 80,
    "customerService": "1-800-BCBS-123",
    "website": "www.bluecross.com",
    "networkType": "PPO",
  };

  Map<String, dynamic> secondaryInsurance = {
    "provider": "Aetna",
    "planName": "HMO Standard",
    "memberId": "AET987654321",
    "groupNumber": "G456789",
    "policyHolder": "Jane Smith",
    "relationship": "Spouse",
    "effectiveDate": "2025-01-01",
    "expirationDate": "2025-12-31",
    "status": "active",
    "copayGeneral": 20.00,
    "copaySpecialist": 40.00,
    "deductible": 1000.00,
    "deductibleMet": 200.00,
    "outOfPocketMax": 6500.00,
    "outOfPocketUsed": 800.00,
    "coveragePercentage": 70,
    "customerService": "1-800-AETNA-123",
    "website": "www.aetna.com",
    "networkType": "HMO",
  };

  List<Map<String, dynamic>> recentClaims = [
    {
      "claimId": "CLM001234",
      "date": "2025-06-15",
      "provider": "City Medical Center",
      "service": "Annual Physical Exam",
      "amount": 320.00,
      "covered": 256.00,
      "patientPay": 64.00,
      "status": "paid",
    },
    {
      "claimId": "CLM001235",
      "date": "2025-06-10",
      "provider": "Dr. Johnson Cardiology",
      "service": "Cardiology Consultation",
      "amount": 450.00,
      "covered": 360.00,
      "patientPay": 90.00,
      "status": "processing",
    },
    {
      "claimId": "CLM001236",
      "date": "2025-06-05",
      "provider": "Lab Corp",
      "service": "Blood Work Panel",
      "amount": 180.00,
      "covered": 144.00,
      "patientPay": 36.00,
      "status": "paid",
    },
    {
      "claimId": "CLM001237",
      "date": "2025-05-28",
      "provider": "Pharmacy Plus",
      "service": "Prescription Medication",
      "amount": 85.00,
      "covered": 68.00,
      "patientPay": 17.00,
      "status": "denied",
    },
  ];

  Map<String, dynamic> get currentInsurance {
    return selectedPlan == "primary" ? primaryInsurance : secondaryInsurance;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "expired":
        return dangerColor;
      case "paid":
        return successColor;
      case "processing":
        return warningColor;
      case "denied":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Information"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit insurance info
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Plan Selector
            QCategoryPicker(
              label: "Select Insurance Plan",
              items: [
                {"label": "Primary Insurance", "value": "primary"},
                {"label": "Secondary Insurance", "value": "secondary"},
              ],
              value: selectedPlan,
              onChanged: (index, label, value, item) {
                selectedPlan = value;
                setState(() {});
              },
            ),

            // Insurance Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${currentInsurance["provider"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${currentInsurance["networkType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${currentInsurance["planName"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
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
                              "Member ID",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            Text(
                              "${currentInsurance["memberId"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Group #",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(180),
                            ),
                          ),
                          Text(
                            "${currentInsurance["groupNumber"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${currentInsurance["policyHolder"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Valid: ${currentInsurance["expirationDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Coverage Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Coverage Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCoverageItem(
                          "General Visit",
                          "\$${(currentInsurance["copayGeneral"] as double).toStringAsFixed(0)}",
                          "Copay",
                          Icons.local_hospital,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildCoverageItem(
                          "Specialist",
                          "\$${(currentInsurance["copaySpecialist"] as double).toStringAsFixed(0)}",
                          "Copay",
                          Icons.person,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCoverageItem(
                          "Coverage",
                          "${currentInsurance["coveragePercentage"]}%",
                          "After deductible",
                          Icons.security,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildCoverageItem(
                          "Network",
                          "${currentInsurance["networkType"]}",
                          "Plan type",
                          Icons.network_check,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Deductible Progress
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Deductible Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildProgressBar(
                    "Annual Deductible",
                    currentInsurance["deductibleMet"] as double,
                    currentInsurance["deductible"] as double,
                    successColor,
                  ),
                  _buildProgressBar(
                    "Out-of-Pocket Maximum",
                    currentInsurance["outOfPocketUsed"] as double,
                    currentInsurance["outOfPocketMax"] as double,
                    warningColor,
                  ),
                ],
              ),
            ),

            // Recent Claims
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Recent Claims",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // View all claims
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentClaims.take(3).map((claim) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getStatusColor(claim["status"]),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${claim["service"]}",
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
                                  color: _getStatusColor(claim["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${claim["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(claim["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${claim["provider"]} • ${claim["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Total: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(claim["amount"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "You pay: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(claim["patientPay"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Contact Information",
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Customer Service",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${currentInsurance["customerService"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.call,
                        size: bs.sm,
                        onPressed: () {
                          // Call customer service
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Open website
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.web,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Website",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${currentInsurance["website"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: infoColor,
                            size: 16,
                          ),
                        ],
                      ),
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

  Widget _buildCoverageItem(String title, String value, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String title, double current, double total, Color color) {
    double percentage = current / total;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              "\$${current.toStringAsFixed(0)} / \$${total.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage > 1.0 ? 1.0 : percentage,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
        Text(
          "${(percentage * 100).toStringAsFixed(1)}% used",
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
