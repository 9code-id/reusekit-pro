import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaInsuranceView extends StatefulWidget {
  const TtaInsuranceView({super.key});

  @override
  State<TtaInsuranceView> createState() => _TtaInsuranceViewState();
}

class _TtaInsuranceViewState extends State<TtaInsuranceView> {
  int currentTab = 0;

  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": 1,
      "type": "Travel Insurance",
      "provider": "Global Travel Insurance",
      "policyNumber": "GTI-2024-123456",
      "status": "Active",
      "premium": 89.99,
      "coverage": 100000,
      "startDate": "2024-03-01",
      "endDate": "2024-12-31",
      "beneficiary": "John Smith",
      "emergencyContact": "+1-800-EMERGENCY",
      "color": primaryColor,
      "icon": Icons.flight,
      "benefits": [
        "Medical expenses up to \$100,000",
        "Emergency evacuation",
        "Trip cancellation/interruption",
        "Lost luggage compensation",
        "24/7 assistance hotline",
      ],
    },
    {
      "id": 2,
      "type": "Health Insurance",
      "provider": "International Health Coverage",
      "policyNumber": "IHC-2024-789012",
      "status": "Active",
      "premium": 150.00,
      "coverage": 500000,
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "beneficiary": "John Smith",
      "emergencyContact": "+1-800-HEALTH",
      "color": successColor,
      "icon": Icons.local_hospital,
      "benefits": [
        "Worldwide medical coverage",
        "Prescription medication",
        "Dental and vision care",
        "Mental health support",
        "Preventive care",
      ],
    },
    {
      "id": 3,
      "type": "Car Rental Insurance",
      "provider": "Auto Protect Plus",
      "policyNumber": "APP-2024-345678",
      "status": "Pending Renewal",
      "premium": 45.00,
      "coverage": 50000,
      "startDate": "2024-02-15",
      "endDate": "2024-08-15",
      "beneficiary": "John Smith",
      "emergencyContact": "+1-800-AUTOHELP",
      "color": warningColor,
      "icon": Icons.directions_car,
      "benefits": [
        "Collision damage waiver",
        "Theft protection",
        "Third-party liability",
        "Roadside assistance",
        "Replacement vehicle",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Insurance"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddInsuranceDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            height: 120,
            padding: EdgeInsets.all(spMd),
            child: QHorizontalScroll(
              children: [
                _buildSummaryCard(
                  "Active Policies",
                  "${insurancePolicies.where((p) => p["status"] == "Active").length}",
                  Icons.security,
                  successColor,
                ),
                _buildSummaryCard(
                  "Total Coverage",
                  "\$${((insurancePolicies.fold(0.0, (sum, policy) => sum + (policy["coverage"] as num))) / 1000).toInt()}K",
                  Icons.attach_money,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Annual Premium",
                  "\$${(insurancePolicies.fold(0.0, (sum, policy) => sum + (policy["premium"] as num)) * 12).toInt()}",
                  Icons.payment,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Expiring Soon",
                  "${_getExpiringSoonCount()}",
                  Icons.warning,
                  dangerColor,
                ),
              ],
            ),
          ),

          // Tab Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "My Policies",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentTab == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Buy Insurance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentTab == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          Expanded(
            child: currentTab == 0 ? _buildPoliciesTab() : _buildBuyInsuranceTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: insurancePolicies.map((policy) {
          return _buildPolicyCard(policy);
        }).toList(),
      ),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy) {
    bool isExpiringSoon = _isPolicyExpiringSoon(policy["endDate"]);
    bool isActive = policy["status"] == "Active";

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: isExpiringSoon ? warningColor : disabledOutlineBorderColor,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: policy["color"].withAlpha(30),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: policy["color"],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    policy["icon"],
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${policy["type"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: policy["color"],
                        ),
                      ),
                      Text(
                        "${policy["provider"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isActive ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${policy["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildPolicyDetail("Policy Number", "${policy["policyNumber"]}"),
                    ),
                    Expanded(
                      child: _buildPolicyDetail("Coverage", "\$${((policy["coverage"] as num) / 1000).toInt()}K"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildPolicyDetail("Valid From", "${DateTime.parse(policy["startDate"]).dMMMy}"),
                    ),
                    Expanded(
                      child: _buildPolicyDetail("Valid Until", "${DateTime.parse(policy["endDate"]).dMMMy}"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildPolicyDetail("Premium", "\$${policy["premium"]}/month"),
                    ),
                    Expanded(
                      child: _buildPolicyDetail("Emergency", "${policy["emergencyContact"]}"),
                    ),
                  ],
                ),
                if (isExpiringSoon) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Policy expires soon! Consider renewal.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showPolicyDetails(policy);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "File Claim",
                        icon: Icons.assignment,
                        size: bs.sm,
                        onPressed: () {
                          _fileClaim(policy);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBuyInsuranceTab() {
    List<Map<String, dynamic>> insuranceTypes = [
      {
        "type": "Comprehensive Travel Insurance",
        "description": "Complete coverage for all travel needs",
        "price": "From \$50",
        "features": ["Medical Coverage", "Trip Cancellation", "Baggage Protection", "Emergency Evacuation"],
        "color": primaryColor,
        "icon": Icons.shield,
      },
      {
        "type": "Medical Travel Insurance",
        "description": "Focus on health and medical emergencies",
        "price": "From \$30",
        "features": ["Emergency Medical", "Hospitalization", "Prescription Drugs", "Dental Emergency"],
        "color": successColor,
        "icon": Icons.local_hospital,
      },
      {
        "type": "Adventure Sports Insurance",
        "description": "Coverage for high-risk activities",
        "price": "From \$80",
        "features": ["Extreme Sports", "Equipment Coverage", "Search & Rescue", "Activity-specific"],
        "color": warningColor,
        "icon": Icons.snowboarding,
      },
      {
        "type": "Business Travel Insurance",
        "description": "Corporate travel protection",
        "price": "From \$60",
        "features": ["Business Equipment", "Meeting Cancellation", "Executive Protection", "24/7 Support"],
        "color": secondaryColor,
        "icon": Icons.business_center,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Your Coverage",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Select the insurance type that best fits your travel needs",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: insuranceTypes.map((insurance) {
              return _buildInsuranceTypeCard(insurance);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceTypeCard(Map<String, dynamic> insurance) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: insurance["color"].withAlpha(30),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: insurance["color"],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    insurance["icon"],
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
                        "${insurance["type"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: insurance["color"],
                        ),
                      ),
                      Text(
                        "${insurance["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${insurance["price"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: insurance["color"],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Features:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: (insurance["features"] as List).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: insurance["color"].withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: insurance["color"],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Get Quote",
                        size: bs.sm,
                        onPressed: () {
                          _getQuote(insurance);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {
                          _showInsuranceDetails(insurance);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isPolicyExpiringSoon(String endDate) {
    DateTime expiry = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    int daysUntilExpiry = expiry.difference(now).inDays;
    return daysUntilExpiry <= 30;
  }

  int _getExpiringSoonCount() {
    return insurancePolicies.where((policy) => _isPolicyExpiringSoon(policy["endDate"])).length;
  }

  void _showPolicyDetails(Map<String, dynamic> policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${policy["type"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Policy Number: ${policy["policyNumber"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: spSm),
              Text("Beneficiary: ${policy["beneficiary"]}"),
              Text("Provider: ${policy["provider"]}"),
              Text("Coverage: \$${(policy["coverage"] as num).toStringAsFixed(0)}"),
              Text("Premium: \$${policy["premium"]}/month"),
              SizedBox(height: spSm),
              Text(
                "Benefits Included:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: spXs),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (policy["benefits"] as List).map((benefit) {
                  return Text("• $benefit", style: TextStyle(fontSize: 12));
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Download",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Policy document downloaded");
            },
          ),
        ],
      ),
    );
  }

  void _fileClaim(Map<String, dynamic> policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("File Insurance Claim"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("File a claim for your ${policy["type"]} policy"),
            SizedBox(height: spMd),
            Text(
              "You will be redirected to the insurance provider's claim portal.",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Continue",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Redirecting to claim portal");
            },
          ),
        ],
      ),
    );
  }

  void _getQuote(Map<String, dynamic> insurance) {
    ss("Getting quote for ${insurance["type"]}");
  }

  void _showInsuranceDetails(Map<String, dynamic> insurance) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${insurance["type"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${insurance["description"]}"),
            SizedBox(height: spMd),
            Text(
              "Features:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: spXs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (insurance["features"] as List).map((feature) {
                return Text("• $feature", style: TextStyle(fontSize: 12));
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showAddInsuranceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Insurance Policy"),
        content: Text("Add a new insurance policy to your portfolio"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Policy",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Add policy functionality coming soon");
            },
          ),
        ],
      ),
    );
  }
}
