import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPolicyDetailsView extends StatefulWidget {
  const BfaPolicyDetailsView({super.key});

  @override
  State<BfaPolicyDetailsView> createState() => _BfaPolicyDetailsViewState();
}

class _BfaPolicyDetailsViewState extends State<BfaPolicyDetailsView> {
  int currentTab = 0;
  String selectedPolicy = "auto";
  
  List<Map<String, dynamic>> policies = [
    {
      "id": "auto",
      "type": "Auto Insurance",
      "policyNumber": "AUTO-2024-789123",
      "status": "active",
      "effectiveDate": "2024-01-01",
      "expirationDate": "2024-12-31",
      "premium": 185.50,
      "deductible": 500.0,
      "coverageLimit": 250000.0,
      "icon": Icons.directions_car,
      "color": Colors.blue,
      "vehicle": {
        "year": 2020,
        "make": "Toyota",
        "model": "Camry",
        "vin": "1HGCM82633A123456"
      },
      "coverages": [
        {"name": "Liability", "limit": "100k/300k/100k", "premium": 85.50},
        {"name": "Collision", "limit": "Actual Cash Value", "premium": 45.00},
        {"name": "Comprehensive", "limit": "Actual Cash Value", "premium": 35.00},
        {"name": "Uninsured Motorist", "limit": "100k/300k", "premium": 20.00}
      ],
      "documents": [
        {"name": "Policy Certificate", "date": "2024-01-01", "type": "PDF"},
        {"name": "Insurance Card", "date": "2024-01-01", "type": "PDF"},
        {"name": "Coverage Summary", "date": "2024-01-01", "type": "PDF"}
      ]
    },
    {
      "id": "health",
      "type": "Health Insurance",
      "policyNumber": "HEALTH-2024-456789",
      "status": "active",
      "effectiveDate": "2024-01-01",
      "expirationDate": "2024-12-31",
      "premium": 425.00,
      "deductible": 2500.0,
      "coverageLimit": 500000.0,
      "icon": Icons.local_hospital,
      "color": Colors.red,
      "plan": {
        "name": "Gold Plan",
        "network": "PPO",
        "coinsurance": 20
      },
      "coverages": [
        {"name": "Emergency Care", "limit": "100% after deductible", "premium": 125.00},
        {"name": "Preventive Care", "limit": "100% no deductible", "premium": 75.00},
        {"name": "Prescription Drugs", "limit": "Generic \$10, Brand \$30", "premium": 95.00},
        {"name": "Specialist Visits", "limit": "80% after deductible", "premium": 85.00},
        {"name": "Mental Health", "limit": "80% after deductible", "premium": 45.00}
      ],
      "documents": [
        {"name": "Policy Booklet", "date": "2024-01-01", "type": "PDF"},
        {"name": "Insurance Card", "date": "2024-01-01", "type": "PDF"},
        {"name": "Provider Directory", "date": "2024-01-01", "type": "PDF"},
        {"name": "Formulary", "date": "2024-01-01", "type": "PDF"}
      ]
    },
    {
      "id": "home",
      "type": "Homeowner's Insurance",
      "policyNumber": "HOME-2024-321654",
      "status": "active",
      "effectiveDate": "2024-01-01",
      "expirationDate": "2024-12-31",
      "premium": 1250.00,
      "deductible": 1000.0,
      "coverageLimit": 450000.0,
      "icon": Icons.home,
      "color": Colors.green,
      "property": {
        "address": "123 Main Street, Anytown, ST 12345",
        "type": "Single Family Home",
        "squareFeet": 2400,
        "yearBuilt": 1995
      },
      "coverages": [
        {"name": "Dwelling", "limit": "\$450,000", "premium": 450.00},
        {"name": "Personal Property", "limit": "\$315,000 (70%)", "premium": 225.00},
        {"name": "Liability", "limit": "\$300,000", "premium": 185.00},
        {"name": "Medical Payments", "limit": "\$5,000", "premium": 45.00},
        {"name": "Loss of Use", "limit": "\$90,000 (20%)", "premium": 125.00},
        {"name": "Other Structures", "limit": "\$45,000 (10%)", "premium": 65.00}
      ],
      "documents": [
        {"name": "Policy Declaration", "date": "2024-01-01", "type": "PDF"},
        {"name": "Coverage Details", "date": "2024-01-01", "type": "PDF"},
        {"name": "Home Inspection", "date": "2023-12-15", "type": "PDF"}
      ]
    },
    {
      "id": "life",
      "type": "Life Insurance",
      "policyNumber": "LIFE-2024-987654",
      "status": "active",
      "effectiveDate": "2023-06-01",
      "expirationDate": "2043-06-01",
      "premium": 125.00,
      "deductible": 0.0,
      "coverageLimit": 500000.0,
      "icon": Icons.favorite,
      "color": Colors.purple,
      "policy": {
        "type": "Term Life",
        "term": "20 years",
        "beneficiary": "Jane Doe (Spouse)"
      },
      "coverages": [
        {"name": "Death Benefit", "limit": "\$500,000", "premium": 100.00},
        {"name": "Accidental Death", "limit": "\$500,000", "premium": 15.00},
        {"name": "Waiver of Premium", "limit": "Included", "premium": 10.00}
      ],
      "documents": [
        {"name": "Policy Contract", "date": "2023-06-01", "type": "PDF"},
        {"name": "Beneficiary Form", "date": "2023-06-01", "type": "PDF"},
        {"name": "Medical Exam Results", "date": "2023-05-15", "type": "PDF"}
      ]
    }
  ];

  Map<String, dynamic> get selectedPolicyData {
    return policies.firstWhere((policy) => policy["id"] == selectedPolicy);
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "expired":
        return dangerColor;
      case "suspended":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String formatPolicyNumber(String policyNumber) {
    if (policyNumber.length > 8) {
      return "${policyNumber.substring(0, 4)}-${policyNumber.substring(4, 8)}-${policyNumber.substring(8)}";
    }
    return policyNumber;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Policy Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Coverage", icon: Icon(Icons.shield)),
        Tab(text: "Documents", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Policy Selector
              Text(
                "Select Policy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QHorizontalScroll(
                children: policies.map((policy) {
                  final isSelected = selectedPolicy == policy["id"];
                  return GestureDetector(
                    onTap: () {
                      selectedPolicy = policy["id"] as String;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (policy["color"] as Color).withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? policy["color"] as Color : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: policy["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  policy["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor(policy["status"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${policy["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${policy["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            formatPolicyNumber(policy["policyNumber"] as String),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "\$${((policy["premium"] as double).toDouble()).currency}/month",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: policy["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spLg),

              // Policy Details Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [selectedPolicyData["color"] as Color, (selectedPolicyData["color"] as Color).withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          selectedPolicyData["icon"] as IconData,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${selectedPolicyData["type"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Policy #${formatPolicyNumber(selectedPolicyData["policyNumber"] as String)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${selectedPolicyData["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Premium",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                              Text(
                                "\$${((selectedPolicyData["premium"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coverage Limit",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                              Text(
                                "\$${((selectedPolicyData["coverageLimit"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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

              SizedBox(height: spLg),

              // Policy Information
              Text(
                "Policy Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Effective Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(selectedPolicyData["effectiveDate"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expiration Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(selectedPolicyData["expirationDate"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deductible",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                selectedPolicyData["deductible"] == 0.0 
                                  ? "N/A" 
                                  : "\$${((selectedPolicyData["deductible"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Annual Premium",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(((selectedPolicyData["premium"] as double) * 12).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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

              SizedBox(height: spLg),

              // Specific Details based on policy type
              if (selectedPolicy == "auto") ...[
                Text(
                  "Vehicle Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedPolicyData["vehicle"]["year"]} ${selectedPolicyData["vehicle"]["make"]} ${selectedPolicyData["vehicle"]["model"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "VIN: ${selectedPolicyData["vehicle"]["vin"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (selectedPolicy == "health") ...[
                Text(
                  "Plan Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Plan Name",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["plan"]["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Network",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["plan"]["network"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Coinsurance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["plan"]["coinsurance"]}% after deductible",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
              ],

              if (selectedPolicy == "home") ...[
                Text(
                  "Property Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedPolicyData["property"]["address"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                                  "Property Type",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["property"]["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Square Feet",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["property"]["squareFeet"]} sq ft",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Year Built",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["property"]["yearBuilt"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
              ],

              if (selectedPolicy == "life") ...[
                Text(
                  "Policy Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Policy Type",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["policy"]["type"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Term",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["policy"]["term"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Primary Beneficiary",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPolicyData["policy"]["beneficiary"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
              ],

              SizedBox(height: spLg),

              // Quick Actions
              Text(
                "Quick Actions",
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
                    child: QButton(
                      label: "Make Payment",
                      icon: Icons.payment,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.file_download,
                          color: primaryColor,
                          size: 18,
                        ),
                        label: Text(
                          "Download",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Coverage Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coverage Breakdown",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Detailed coverage information for ${selectedPolicyData["type"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Coverage List
              ...(selectedPolicyData["coverages"] as List).map((coverage) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (selectedPolicyData["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.shield,
                              color: selectedPolicyData["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${coverage["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${coverage["limit"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((coverage["premium"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedPolicyData["color"] as Color,
                                ),
                              ),
                              Text(
                                "per month",
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
                );
              }).toList(),

              SizedBox(height: spLg),

              // Premium Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [selectedPolicyData["color"] as Color, (selectedPolicyData["color"] as Color).withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Premium Breakdown",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly Premium",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                        Text(
                          "\$${((selectedPolicyData["premium"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annual Premium",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                        Text(
                          "\$${(((selectedPolicyData["premium"] as double) * 12).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Documents Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Policy Documents",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Access and download your policy documents",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Documents List
              ...(selectedPolicyData["documents"] as List).map((document) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.description,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${document["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Updated: ${DateTime.parse(document["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${document["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.download,
                                color: primaryColor,
                                size: 18,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(spXs),
                              constraints: BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: primaryColor,
                                size: 18,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(spXs),
                              constraints: BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Request Document
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Need a Different Document?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Request additional policy documents or certificates",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Request Document",
                      icon: Icons.email,
                      size: bs.sm,
                      onPressed: () {},
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
}
