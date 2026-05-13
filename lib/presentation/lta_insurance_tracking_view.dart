import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaInsuranceTrackingView extends StatefulWidget {
  const LtaInsuranceTrackingView({super.key});

  @override
  State<LtaInsuranceTrackingView> createState() => _LtaInsuranceTrackingViewState();
}

class _LtaInsuranceTrackingViewState extends State<LtaInsuranceTrackingView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedInsuranceType = "All";
  String selectedProvider = "All";
  
  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": "POL-2024-001",
      "vehicleId": "TXI-001",
      "vehiclePlate": "ABC-1234",
      "vehicleModel": "Toyota Camry 2023",
      "policyNumber": "INS-TC-2024-001",
      "insuranceType": "Comprehensive",
      "provider": "SafeGuard Insurance",
      "providerLogo": "https://picsum.photos/60/30?random=1&keyword=insurance+logo",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2025-01-15",
      "premiumAmount": 2400,
      "deductible": 500,
      "coverageLimit": 100000,
      "ownerName": "Premium Transport Co.",
      "driverName": "Michael Johnson",
      "lastClaim": "2024-03-20",
      "claimsCount": 1,
      "renewalNoticed": false,
      "documents": [
        "Policy Certificate",
        "Payment Receipt",
        "Coverage Details"
      ],
      "coverageTypes": [
        "Vehicle Damage",
        "Third Party Liability",
        "Personal Injury",
        "Theft Protection"
      ],
    },
    {
      "id": "POL-2024-002",
      "vehicleId": "TXI-002",
      "vehiclePlate": "XYZ-5678",
      "vehicleModel": "Honda Pilot 2024",
      "policyNumber": "INS-HP-2024-002",
      "insuranceType": "Third Party",
      "provider": "AutoProtect Plus",
      "providerLogo": "https://picsum.photos/60/30?random=2&keyword=insurance+company",
      "status": "Expiring Soon",
      "startDate": "2024-02-01",
      "endDate": "2024-12-31",
      "premiumAmount": 1800,
      "deductible": 750,
      "coverageLimit": 50000,
      "ownerName": "City Cab Services",
      "driverName": "Robert Wilson",
      "lastClaim": "Never",
      "claimsCount": 0,
      "renewalNoticed": true,
      "documents": [
        "Policy Certificate",
        "Payment Receipt"
      ],
      "coverageTypes": [
        "Third Party Liability",
        "Property Damage"
      ],
    },
    {
      "id": "POL-2024-003",
      "vehicleId": "TXI-003",
      "vehiclePlate": "DEF-9012",
      "vehicleModel": "Ford Transit 2022",
      "policyNumber": "INS-FT-2024-003",
      "insuranceType": "Commercial",
      "provider": "FleetCare Insurance",
      "providerLogo": "https://picsum.photos/60/30?random=3&keyword=fleet+insurance",
      "status": "Active",
      "startDate": "2024-03-10",
      "endDate": "2025-03-10",
      "premiumAmount": 3200,
      "deductible": 1000,
      "coverageLimit": 200000,
      "ownerName": "Express Logistics",
      "driverName": "Jennifer Martinez",
      "lastClaim": "2024-08-15",
      "claimsCount": 2,
      "renewalNoticed": false,
      "documents": [
        "Policy Certificate",
        "Payment Receipt",
        "Coverage Details",
        "Claim History"
      ],
      "coverageTypes": [
        "Vehicle Damage",
        "Third Party Liability",
        "Cargo Protection",
        "Business Interruption"
      ],
    },
    {
      "id": "POL-2024-004",
      "vehicleId": "TXI-004",
      "vehiclePlate": "GHI-3456",
      "vehicleModel": "Nissan Versa 2023",
      "policyNumber": "INS-NV-2024-004",
      "insuranceType": "Basic",
      "provider": "Budget Insurance Co.",
      "providerLogo": "https://picsum.photos/60/30?random=4&keyword=budget+insurance",
      "status": "Expired",
      "startDate": "2023-11-20",
      "endDate": "2024-11-20",
      "premiumAmount": 1200,
      "deductible": 300,
      "coverageLimit": 25000,
      "ownerName": "Budget Rides",
      "driverName": "Amanda Thompson",
      "lastClaim": "Never",
      "claimsCount": 0,
      "renewalNoticed": true,
      "documents": [
        "Expired Policy Certificate"
      ],
      "coverageTypes": [
        "Third Party Liability"
      ],
    },
    {
      "id": "POL-2024-005",
      "vehicleId": "TXI-005",
      "vehiclePlate": "JKL-7890",
      "vehicleModel": "BMW 5 Series 2024",
      "policyNumber": "INS-BMW-2024-005",
      "insuranceType": "Luxury",
      "provider": "Premium Insurance Group",
      "providerLogo": "https://picsum.photos/60/30?random=5&keyword=premium+insurance",
      "status": "Active",
      "startDate": "2024-05-01",
      "endDate": "2025-05-01",
      "premiumAmount": 4800,
      "deductible": 2000,
      "coverageLimit": 500000,
      "ownerName": "Elite Transport Services",
      "driverName": "Christopher Davis",
      "lastClaim": "Never",
      "claimsCount": 0,
      "renewalNoticed": false,
      "documents": [
        "Policy Certificate",
        "Payment Receipt",
        "Coverage Details",
        "Premium Coverage Terms"
      ],
      "coverageTypes": [
        "Vehicle Damage",
        "Third Party Liability",
        "Personal Injury",
        "Theft Protection",
        "Gap Coverage",
        "Roadside Assistance"
      ],
    },
  ];

  List<Map<String, dynamic>> recentClaims = [
    {
      "id": "CLM-2024-001",
      "policyId": "POL-2024-001",
      "vehiclePlate": "ABC-1234",
      "claimDate": "2024-03-20",
      "incidentType": "Minor Accident",
      "claimAmount": 1200,
      "status": "Settled",
      "description": "Rear-end collision at traffic light",
    },
    {
      "id": "CLM-2024-002",
      "policyId": "POL-2024-003",
      "vehiclePlate": "DEF-9012",
      "claimDate": "2024-08-15",
      "incidentType": "Vandalism",
      "claimAmount": 800,
      "status": "Processing",
      "description": "Windows broken in parking lot",
    },
  ];

  List<String> statusOptions = ["All", "Active", "Expiring Soon", "Expired", "Pending"];
  List<String> insuranceTypeOptions = ["All", "Comprehensive", "Third Party", "Commercial", "Basic", "Luxury"];
  List<String> providerOptions = ["All", "SafeGuard Insurance", "AutoProtect Plus", "FleetCare Insurance", "Budget Insurance Co.", "Premium Insurance Group"];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Insurance Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Policies", icon: Icon(Icons.description)),
        Tab(text: "Claims", icon: Icon(Icons.report_problem)),
        Tab(text: "Renewals", icon: Icon(Icons.refresh)),
      ],
      tabChildren: [
        // Policies Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Status Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [successColor.withAlpha(25), successColor.withAlpha(50)],
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
                                Icons.verified_user,
                                color: successColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${insurancePolicies.where((policy) => policy["status"] == "Active").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Active Policies",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Currently Covered",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
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
                                Icons.schedule,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${insurancePolicies.where((policy) => policy["status"] == "Expiring Soon").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Expiring Soon",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Needs Renewal",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
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
                                Icons.error,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${insurancePolicies.where((policy) => policy["status"] == "Expired").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Expired",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Immediate Action",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor.withAlpha(25), primaryColor.withAlpha(50)],
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
                                Icons.attach_money,
                                color: primaryColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "\$${((insurancePolicies.fold(0.0, (sum, policy) => sum + (policy["premiumAmount"] as int).toDouble())) / 12).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Monthly Premium",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Average Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.map((status) => {
                        "label": status,
                        "value": status,
                      }).toList(),
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Insurance Type",
                      items: insuranceTypeOptions.map((type) => {
                        "label": type,
                        "value": type,
                      }).toList(),
                      value: selectedInsuranceType,
                      onChanged: (value, label) {
                        selectedInsuranceType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QDropdownField(
                label: "Provider",
                items: providerOptions.map((provider) => {
                  "label": provider,
                  "value": provider,
                }).toList(),
                value: selectedProvider,
                onChanged: (value, label) {
                  selectedProvider = value;
                  setState(() {});
                },
              ),

              // Insurance Policies List
              Column(
                children: insurancePolicies
                    .where((policy) {
                      if (selectedStatus != "All" && policy["status"] != selectedStatus) return false;
                      if (selectedInsuranceType != "All" && policy["insuranceType"] != selectedInsuranceType) return false;
                      if (selectedProvider != "All" && policy["provider"] != selectedProvider) return false;
                      return true;
                    })
                    .map((policy) {
                  Color statusColor = policy["status"] == "Active" ? successColor :
                                     policy["status"] == "Expiring Soon" ? warningColor :
                                     policy["status"] == "Expired" ? dangerColor : infoColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
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
                                    "${policy["policyNumber"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${policy["vehiclePlate"]} - ${policy["vehicleModel"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                color: statusColor.withAlpha(25),
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

                        // Provider Info
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                "${policy["providerLogo"]}",
                                width: 50,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${policy["provider"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${policy["insuranceType"]} Coverage",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Policy Details
                        Row(
                          children: [
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
                                    "\$${((policy["premiumAmount"] as int).toDouble()).currency}",
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
                                    "Coverage Limit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((policy["coverageLimit"] as int).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
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
                                    "Valid Until",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${policy["endDate"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
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
                                    "Claims Count",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${policy["claimsCount"]} claims",
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

                        // Owner Info
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${policy["ownerName"]} • ${policy["driverName"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Coverage Types
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coverage Types:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (policy["coverageTypes"] as List).map((coverage) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$coverage",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            if (policy["status"] == "Expiring Soon" || policy["status"] == "Expired")
                              QButton(
                                label: "Renew Policy",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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
              // Claims Statistics
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [infoColor.withAlpha(25), infoColor.withAlpha(50)],
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
                                Icons.assignment,
                                color: infoColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${recentClaims.length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total Claims",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "This Year",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
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
                                Icons.attach_money,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "\$${((recentClaims.fold(0.0, (sum, claim) => sum + (claim["claimAmount"] as int).toDouble())).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Claims Amount",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Total Paid",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                "Recent Claims",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              if (recentClaims.isNotEmpty)
                Column(
                  children: recentClaims.map((claim) {
                    Color statusColor = claim["status"] == "Settled" ? successColor :
                                       claim["status"] == "Processing" ? warningColor : infoColor;

                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            color: statusColor,
                            width: 4,
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
                                      "${claim["id"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${claim["vehiclePlate"]} • ${claim["incidentType"]}",
                                      style: TextStyle(
                                        fontSize: 14,
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
                                  color: statusColor.withAlpha(25),
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

                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${claim["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),

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
                                      "\$${((claim["claimAmount"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
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
                                      "Claim Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${claim["claimDate"]}",
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

                          Row(
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spSm),
                              if (claim["status"] == "Processing")
                                QButton(
                                  label: "Follow Up",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

              if (recentClaims.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied,
                          size: 48,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No Claims Filed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Great driving record! No insurance claims on file",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "File New Claim",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Renewals Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Renewal Reminders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: insurancePolicies
                    .where((policy) => policy["status"] == "Expiring Soon" || policy["status"] == "Expired")
                    .map((policy) {
                  Color statusColor = policy["status"] == "Expiring Soon" ? warningColor : dangerColor;
                  bool isExpired = policy["status"] == "Expired";

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isExpired ? Icons.error : Icons.warning,
                              color: statusColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${policy["vehiclePlate"]} - ${policy["vehicleModel"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${policy["provider"]} • ${policy["policyNumber"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                isExpired ? "EXPIRED" : "EXPIRES SOON",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: statusColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                isExpired ? "Expired on ${policy["endDate"]}" : "Expires on ${policy["endDate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Premium",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((policy["premiumAmount"] as int).toDouble()).currency}",
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
                                    "Owner",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${policy["ownerName"]}",
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

                        Row(
                          children: [
                            QButton(
                              label: "Renew Now",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Get Quotes",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            if (policy["renewalNoticed"] == false)
                              SizedBox(width: spSm),
                            if (policy["renewalNoticed"] == false)
                              QButton(
                                label: "Send Reminder",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              if (insurancePolicies.where((policy) => policy["status"] == "Expiring Soon" || policy["status"] == "Expired").isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 48,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "All Policies Current",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "No immediate renewals required",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
