import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorContractsView extends StatefulWidget {
  const AbaVendorContractsView({super.key});

  @override
  State<AbaVendorContractsView> createState() => _AbaVendorContractsViewState();
}

class _AbaVendorContractsViewState extends State<AbaVendorContractsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  bool loading = false;

  List<Map<String, dynamic>> contracts = [
    {
      "id": "CON-001",
      "contractNumber": "CNT-2024-001",
      "vendorName": "Tech Solutions Ltd",
      "vendorId": "VEN-001",
      "title": "Software License Agreement",
      "type": "Service Agreement",
      "status": "Active",
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "renewalDate": "2024-11-01",
      "contractValue": 150000.00,
      "currency": "USD",
      "paymentTerms": "Monthly",
      "autoRenewal": true,
      "nextPayment": "2024-02-01",
      "category": "Technology",
      "manager": "John Manager",
      "description": "Annual software license with support and maintenance",
      "terms": [
        "24/7 technical support",
        "Quarterly software updates",
        "Data backup services",
        "SLA: 99.9% uptime"
      ],
      "attachments": 3,
      "lastModified": "2024-01-15"
    },
    {
      "id": "CON-002",
      "contractNumber": "CNT-2024-002",
      "vendorName": "Global Supplies Inc",
      "vendorId": "VEN-002",
      "title": "Office Supplies Framework Agreement",
      "type": "Purchase Agreement",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2025-01-14",
      "renewalDate": "2024-12-15",
      "contractValue": 85000.00,
      "currency": "USD",
      "paymentTerms": "Net 30",
      "autoRenewal": false,
      "nextPayment": null,
      "category": "Supplies",
      "manager": "Sarah Finance",
      "description": "Framework agreement for office supplies and stationery",
      "terms": [
        "Volume discounts applicable",
        "Monthly delivery schedule",
        "Quality assurance guarantee",
        "30-day payment terms"
      ],
      "attachments": 5,
      "lastModified": "2024-01-20"
    },
    {
      "id": "CON-003",
      "contractNumber": "CNT-2024-003",
      "vendorName": "Manufacturing Corp",
      "vendorId": "VEN-003",
      "title": "Equipment Lease Agreement",
      "type": "Lease Agreement",
      "status": "Pending",
      "startDate": "2024-02-01",
      "endDate": "2027-01-31",
      "renewalDate": "2026-11-01",
      "contractValue": 450000.00,
      "currency": "USD",
      "paymentTerms": "Quarterly",
      "autoRenewal": true,
      "nextPayment": "2024-02-01",
      "category": "Manufacturing",
      "manager": "Mike Director",
      "description": "3-year lease agreement for manufacturing equipment",
      "terms": [
        "Maintenance included",
        "Quarterly payments",
        "Option to purchase",
        "Insurance coverage required"
      ],
      "attachments": 8,
      "lastModified": "2024-01-25"
    },
    {
      "id": "CON-004",
      "contractNumber": "CNT-2023-045",
      "vendorName": "Logistics Partners",
      "vendorId": "VEN-004",
      "title": "Transportation Services Contract",
      "type": "Service Agreement",
      "status": "Expiring",
      "startDate": "2023-03-01",
      "endDate": "2024-02-29",
      "renewalDate": "2024-01-29",
      "contractValue": 95000.00,
      "currency": "USD",
      "paymentTerms": "Monthly",
      "autoRenewal": false,
      "nextPayment": "2024-02-01",
      "category": "Logistics",
      "manager": "Emily Operations",
      "description": "Comprehensive transportation and logistics services",
      "terms": [
        "Nationwide coverage",
        "Real-time tracking",
        "Insurance included",
        "Monthly reporting"
      ],
      "attachments": 4,
      "lastModified": "2024-01-10"
    },
    {
      "id": "CON-005",
      "contractNumber": "CNT-2023-032",
      "vendorName": "Service Providers LLC",
      "vendorId": "VEN-005",
      "title": "Consulting Services Agreement",
      "type": "Consulting Agreement",
      "status": "Expired",
      "startDate": "2023-06-01",
      "endDate": "2023-12-31",
      "renewalDate": null,
      "contractValue": 60000.00,
      "currency": "USD",
      "paymentTerms": "Net 15",
      "autoRenewal": false,
      "nextPayment": null,
      "category": "Services",
      "manager": "David Success",
      "description": "Business process consulting and optimization",
      "terms": [
        "Weekly progress reports",
        "Deliverable milestones",
        "Confidentiality agreement",
        "Knowledge transfer included"
      ],
      "attachments": 6,
      "lastModified": "2023-12-15"
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Expiring", "value": "Expiring"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Terminated", "value": "Terminated"}
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All", "value": "All"},
    {"label": "Service Agreement", "value": "Service Agreement"},
    {"label": "Purchase Agreement", "value": "Purchase Agreement"},
    {"label": "Lease Agreement", "value": "Lease Agreement"},
    {"label": "Consulting Agreement", "value": "Consulting Agreement"}
  ];

  List<Map<String, dynamic>> get filteredContracts {
    return contracts.where((contract) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${contract["contractNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["vendorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["title"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || contract["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || contract["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Expiring":
        return infoColor;
      case "Expired":
        return dangerColor;
      case "Terminated":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalValue {
    return filteredContracts.fold(0.0, (sum, contract) => sum + (contract["contractValue"] as double));
  }

  int get activeContracts {
    return filteredContracts.where((c) => c["status"] == "Active").length;
  }

  int get expiringContracts {
    return filteredContracts.where((c) => c["status"] == "Expiring").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Contracts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo AddContractView
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // navigateTo ContractCalendarView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search contracts...",
                          value: searchQuery,
                          hint: "Contract number, vendor, or title",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters,
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
                          label: "Type",
                          items: typeFilters,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalValue.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Value",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$activeContracts",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$expiringContracts",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Expiring",
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

            // Expiring Contracts Alert
            if (expiringContracts > 0)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: infoColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contracts Expiring Soon",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "$expiringContracts contracts require renewal attention",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Review",
                      size: bs.sm,
                      onPressed: () {
                        // Filter to show expiring contracts
                        selectedStatus = "Expiring";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            // Contracts List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredContracts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.description,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No contracts found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredContracts.map((contract) {
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
                    spacing: spSm,
                    children: [
                      // Contract Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${contract["contractNumber"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${contract["vendorName"]}",
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
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${contract["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${contract["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${contract["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Contract Title and Type
                      Text(
                        "${contract["title"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${contract["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),

                      // Contract Value
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contract Value",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "\$${(contract["contractValue"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Contract Details
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Start: ${DateTime.parse("${contract["startDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "End: ${DateTime.parse("${contract["endDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: contract["status"] == "Expiring" ? infoColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Payment: ${contract["paymentTerms"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (contract["autoRenewal"] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Auto Renewal",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: infoColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Manager: ${contract["manager"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_file,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${contract["attachments"]} files",
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
                      ),

                      // Description
                      Text(
                        "${contract["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Key Terms
                      if (contract["terms"] != null && (contract["terms"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Key Terms",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(contract["terms"] as List).take(3).map((term) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "$term",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              if ((contract["terms"] as List).length > 3)
                                Text(
                                  "... and ${(contract["terms"] as List).length - 3} more terms",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Contract",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo ContractDetailView
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          if (contract["status"] == "Expiring")
                            Expanded(
                              child: QButton(
                                label: "Renew",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo RenewContractView
                                },
                              ),
                            ),
                          if (contract["status"] == "Active")
                            Expanded(
                              child: QButton(
                                label: "Modify",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo ModifyContractView
                                },
                              ),
                            ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
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
    );
  }
}
