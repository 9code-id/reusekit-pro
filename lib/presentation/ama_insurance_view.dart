import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaInsuranceView extends StatefulWidget {
  const AmaInsuranceView({super.key});

  @override
  State<AmaInsuranceView> createState() => _AmaInsuranceViewState();
}

class _AmaInsuranceViewState extends State<AmaInsuranceView> {
  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": "CROP001",
      "type": "Crop Insurance",
      "provider": "National Insurance",
      "premium": 25000.0,
      "coverage": 500000.0,
      "status": "Active",
      "expiryDate": "2024-12-31",
      "crops": ["Wheat", "Rice", "Corn"],
      "riskLevel": "Medium",
      "claimsCount": 2
    },
    {
      "id": "EQUIP002",
      "type": "Equipment Insurance",
      "provider": "Farm Shield Insurance",
      "premium": 45000.0,
      "coverage": 1200000.0,
      "status": "Active",
      "expiryDate": "2024-11-15",
      "crops": ["Tractor", "Harvester", "Irrigation System"],
      "riskLevel": "Low",
      "claimsCount": 0
    },
    {
      "id": "LIVE003",
      "type": "Livestock Insurance",
      "provider": "Agricultural Mutual",
      "premium": 18000.0,
      "coverage": 300000.0,
      "status": "Pending Renewal",
      "expiryDate": "2024-08-20",
      "crops": ["Cattle", "Poultry", "Goats"],
      "riskLevel": "High",
      "claimsCount": 1
    },
    {
      "id": "PROP004",
      "type": "Property Insurance",
      "provider": "Rural Insurance Co.",
      "premium": 32000.0,
      "coverage": 800000.0,
      "status": "Active",
      "expiryDate": "2025-01-10",
      "crops": ["Barn", "Storage", "Farmhouse"],
      "riskLevel": "Medium",
      "claimsCount": 0
    },
  ];

  List<Map<String, dynamic>> recentClaims = [
    {
      "claimId": "CLM2024001",
      "policyId": "CROP001",
      "type": "Weather Damage",
      "amount": 75000.0,
      "status": "Approved",
      "dateSubmitted": "2024-06-10",
      "dateProcessed": "2024-06-25"
    },
    {
      "claimId": "CLM2024002",
      "policyId": "LIVE003",
      "type": "Disease Outbreak",
      "amount": 45000.0,
      "status": "Under Review",
      "dateSubmitted": "2024-07-15",
      "dateProcessed": null
    },
  ];

  String selectedFilter = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredPolicies = insurancePolicies.where((policy) {
      final matchesSearch = "${policy["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${policy["provider"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == "All" || "${policy["status"]}" == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new insurance policy
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search policies...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),

            // Insurance Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Total Coverage",
                  "\$${((insurancePolicies.fold(0.0, (sum, policy) => sum + (policy["coverage"] as double))) / 1000).toStringAsFixed(0)}K",
                  Icons.security,
                  successColor,
                ),
                _buildOverviewCard(
                  "Annual Premium",
                  "\$${((insurancePolicies.fold(0.0, (sum, policy) => sum + (policy["premium"] as double))) / 1000).toStringAsFixed(0)}K",
                  Icons.payment,
                  warningColor,
                ),
                _buildOverviewCard(
                  "Active Policies",
                  "${insurancePolicies.where((p) => p["status"] == "Active").length}",
                  Icons.policy,
                  primaryColor,
                ),
                _buildOverviewCard(
                  "Claims This Year",
                  "${recentClaims.length}",
                  Icons.description,
                  infoColor,
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Insurance Policies Section
            Text(
              "Insurance Policies",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredPolicies.map((policy) => _buildPolicyCard(policy)),

            SizedBox(height: spMd),

            // Recent Claims Section
            Text(
              "Recent Claims",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),

            ...recentClaims.map((claim) => _buildClaimCard(claim)),

            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildQuickActionCard(
                  "New Policy Application",
                  "Apply for new insurance coverage",
                  Icons.add_task,
                  primaryColor,
                ),
                _buildQuickActionCard(
                  "File a Claim",
                  "Submit new insurance claim",
                  Icons.report_problem,
                  dangerColor,
                ),
                _buildQuickActionCard(
                  "Policy Renewal",
                  "Renew expiring policies",
                  Icons.refresh,
                  warningColor,
                ),
                _buildQuickActionCard(
                  "Risk Assessment",
                  "Evaluate farm risks",
                  Icons.assessment,
                  infoColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy) {
    Color statusColor = _getStatusColor("${policy["status"]}");
    Color riskColor = _getRiskColor("${policy["riskLevel"]}");

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${policy["type"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${policy["provider"]} • ${policy["id"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${policy["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
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
                      "Coverage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((policy["coverage"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Premium",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((policy["premium"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 16,
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
                      "Expires",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${policy["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: riskColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${policy["riskLevel"]} Risk",
                  style: TextStyle(
                    fontSize: 12,
                    color: riskColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${policy["claimsCount"]} Claims",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  // Navigate to policy details
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimCard(Map<String, dynamic> claim) {
    Color statusColor = _getClaimStatusColor("${claim["status"]}");

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Claim ${claim["claimId"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${claim["type"]} • Policy ${claim["policyId"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${claim["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
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
                      "Claim Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((claim["amount"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      "Submitted",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${claim["dateSubmitted"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Track",
                size: bs.sm,
                onPressed: () {
                  // Navigate to claim tracking
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle quick action
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending Renewal":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getClaimStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Policies"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            "All",
            "Active",
            "Pending Renewal",
            "Expired"
          ].map((filter) => RadioListTile<String>(
            title: Text(filter),
            value: filter,
            groupValue: selectedFilter,
            onChanged: (value) {
              selectedFilter = value!;
              setState(() {});
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }
}
