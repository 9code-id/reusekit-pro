import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaInsuranceView extends StatefulWidget {
  const MhaInsuranceView({super.key});

  @override
  State<MhaInsuranceView> createState() => _MhaInsuranceViewState();
}

class _MhaInsuranceViewState extends State<MhaInsuranceView> {
  String selectedPlan = "";
  int currentTab = 0;
  
  List<Map<String, dynamic>> insurancePlans = [
    {
      "id": 1,
      "planName": "Basic Health Plan",
      "monthlyPremium": 89.99,
      "deductible": 2500,
      "maxCoverage": 50000,
      "networkSize": "15,000+ providers",
      "coverage": {
        "doctorVisits": "80%",
        "emergencyRoom": "70%",
        "prescription": "75%",
        "hospitalStay": "80%",
        "preventiveCare": "100%",
        "mentalHealth": "70%",
      },
      "benefits": [
        "24/7 Telehealth",
        "Wellness Programs",
        "Annual Physical",
        "Prescription Discounts"
      ],
      "popular": false,
    },
    {
      "id": 2,
      "planName": "Premium Health Plan",
      "monthlyPremium": 159.99,
      "deductible": 1500,
      "maxCoverage": 100000,
      "networkSize": "25,000+ providers",
      "coverage": {
        "doctorVisits": "90%",
        "emergencyRoom": "85%",
        "prescription": "85%",
        "hospitalStay": "90%",
        "preventiveCare": "100%",
        "mentalHealth": "85%",
      },
      "benefits": [
        "24/7 Telehealth",
        "Wellness Programs",
        "Annual Physical",
        "Prescription Discounts",
        "Dental & Vision",
        "Specialist Access",
        "Health Coaching"
      ],
      "popular": true,
    },
    {
      "id": 3,
      "planName": "Family Health Plan",
      "monthlyPremium": 299.99,
      "deductible": 1000,
      "maxCoverage": 250000,
      "networkSize": "30,000+ providers",
      "coverage": {
        "doctorVisits": "95%",
        "emergencyRoom": "90%",
        "prescription": "90%",
        "hospitalStay": "95%",
        "preventiveCare": "100%",
        "mentalHealth": "90%",
      },
      "benefits": [
        "24/7 Telehealth",
        "Wellness Programs",
        "Annual Physical",
        "Prescription Discounts",
        "Dental & Vision",
        "Specialist Access",
        "Health Coaching",
        "Maternity Care",
        "Pediatric Services",
        "Family Counseling"
      ],
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> myPolicies = [
    {
      "policyNumber": "MHA-2024-001",
      "planName": "Premium Health Plan",
      "status": "Active",
      "nextPayment": "2024-07-15",
      "coverageAmount": 100000,
      "monthlyPremium": 159.99,
    },
  ];

  List<Map<String, dynamic>> recentClaims = [
    {
      "claimId": "CLM-2024-0123",
      "date": "2024-06-20",
      "provider": "City General Hospital",
      "service": "Emergency Room Visit",
      "amount": 1250.00,
      "covered": 1062.50,
      "status": "Paid",
    },
    {
      "claimId": "CLM-2024-0089",
      "date": "2024-06-10",
      "provider": "Dr. Sarah Johnson",
      "service": "Routine Checkup",
      "amount": 150.00,
      "covered": 150.00,
      "status": "Paid",
    },
    {
      "claimId": "CLM-2024-0067",
      "date": "2024-05-28",
      "provider": "HealthMart Pharmacy",
      "service": "Prescription Medication",
      "amount": 89.50,
      "covered": 76.08,
      "status": "Processing",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Health Insurance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Coverage", icon: Icon(Icons.security)),
        Tab(text: "Available Plans", icon: Icon(Icons.list_alt)),
        Tab(text: "Claims", icon: Icon(Icons.receipt_long)),
      ],
      tabChildren: [
        // My Coverage Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Current Policy Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Active Coverage",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "${myPolicies[0]["planName"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Policy Number",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${myPolicies[0]["policyNumber"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
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
                                "Coverage Amount",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$${((myPolicies[0]["coverageAmount"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
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
              
              // Quick Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "File Claim",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Find Provider",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.card_membership,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "ID Card",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // Coverage Details
              Text(
                "Coverage Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Premium",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$${(myPolicies[0]["monthlyPremium"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                                "Next Payment",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${myPolicies[0]["nextPayment"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Full Benefits",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to benefits details
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Available Plans Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Choose Your Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              ...insurancePlans.map((plan) {
                bool isSelected = selectedPlan == "${plan["id"]}";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: plan["popular"] 
                        ? Border.all(color: primaryColor, width: 2)
                        : isSelected 
                            ? Border.all(color: successColor, width: 2)
                            : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${plan["planName"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (plan["popular"])
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "POPULAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      Text(
                        "\$${(plan["monthlyPremium"] as double).toStringAsFixed(2)}/month",
                        style: TextStyle(
                          fontSize: 24,
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
                                  "Deductible",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${((plan["deductible"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
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
                                  "Max Coverage",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${((plan["maxCoverage"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
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
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${plan["networkSize"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Coverage percentages
                      Text(
                        "Coverage Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: (plan["coverage"] as Map).entries.map((entry) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${entry.key}: ${entry.value}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Select Plan",
                          size: bs.sm,
                          onPressed: () {
                            selectedPlan = "${plan["id"]}";
                            setState(() {});
                            ss("Selected ${plan["planName"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        
        // Claims Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
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
                      ),
                    ),
                  ),
                  QButton(
                    label: "New Claim",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to file claim
                    },
                  ),
                ],
              ),
              
              ...recentClaims.map((claim) {
                Color statusColor = claim["status"] == "Paid" 
                    ? successColor 
                    : claim["status"] == "Processing"
                        ? warningColor
                        : dangerColor;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${claim["service"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${claim["provider"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${claim["status"]}".toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Claim ID",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${claim["claimId"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
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
                                  "Date",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${claim["date"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
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
                                  "Amount",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(claim["amount"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "Covered: \$${(claim["covered"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Your Cost: \$${((claim["amount"] as double) - (claim["covered"] as double)).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional initialization
      },
    );
  }
}
