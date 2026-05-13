import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaContractsView extends StatefulWidget {
  const LcaContractsView({super.key});

  @override
  State<LcaContractsView> createState() => _LcaContractsViewState();
}

class _LcaContractsViewState extends State<LcaContractsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  bool showExpiringSoon = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Signed", "value": "signed"},
    {"label": "Expired", "value": "expired"},
    {"label": "Terminated", "value": "terminated"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Service Agreement", "value": "service"},
    {"label": "Employment", "value": "employment"},
    {"label": "NDA", "value": "nda"},
    {"label": "Purchase", "value": "purchase"},
    {"label": "Lease", "value": "lease"},
    {"label": "Partnership", "value": "partnership"},
  ];

  List<Map<String, dynamic>> contracts = [
    {
      "id": 1,
      "title": "Software Development Service Agreement",
      "contractNumber": "SA-2024-001",
      "client": "TechCorp Inc.",
      "type": "service",
      "status": "active",
      "value": 125000.0,
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "signedDate": "2023-12-15",
      "lastModified": "2024-01-15",
      "attorney": "Sarah Mitchell",
      "nextReview": "2024-06-01",
      "autoRenewal": true,
      "confidential": true,
      "description": "Comprehensive software development services including design, coding, testing, and maintenance",
      "parties": ["TechCorp Inc.", "DevSolutions LLC"],
      "keyTerms": [
        "12-month term with auto-renewal",
        "Monthly payment of \$10,416.67",
        "IP ownership transfers to client",
        "90-day termination notice required"
      ],
    },
    {
      "id": 2,
      "title": "Non-Disclosure Agreement - Market Research",
      "contractNumber": "NDA-2024-002",
      "client": "MarketInsights Group",
      "type": "nda",
      "status": "signed",
      "value": null,
      "startDate": "2024-01-10",
      "endDate": "2026-01-10",
      "signedDate": "2024-01-10",
      "lastModified": "2024-01-10",
      "attorney": "Michael Chen",
      "nextReview": "2025-01-10",
      "autoRenewal": false,
      "confidential": true,
      "description": "Mutual non-disclosure agreement for sharing proprietary market research data",
      "parties": ["MarketInsights Group", "Strategic Analytics Co."],
      "keyTerms": [
        "2-year confidentiality period",
        "Mutual disclosure permitted",
        "Return of materials required",
        "Liquidated damages clause"
      ],
    },
    {
      "id": 3,
      "title": "Employment Agreement - Senior Developer",
      "contractNumber": "EA-2024-003",
      "client": "Jennifer Rodriguez",
      "type": "employment",
      "status": "draft",
      "value": 95000.0,
      "startDate": "2024-02-01",
      "endDate": null,
      "signedDate": null,
      "lastModified": "2024-01-14",
      "attorney": "David Park",
      "nextReview": null,
      "autoRenewal": false,
      "confidential": false,
      "description": "Full-time employment agreement for senior software developer position",
      "parties": ["InnovateTech LLC", "Jennifer Rodriguez"],
      "keyTerms": [
        "Annual salary of \$95,000",
        "Standard benefits package",
        "6-month probationary period",
        "Flexible remote work options"
      ],
    },
    {
      "id": 4,
      "title": "Commercial Lease Agreement",
      "contractNumber": "LA-2024-004",
      "client": "Downtown Properties LLC",
      "type": "lease",
      "status": "under_review",
      "value": 240000.0,
      "startDate": "2024-03-01",
      "endDate": "2029-02-28",
      "signedDate": null,
      "lastModified": "2024-01-13",
      "attorney": "Lisa Thompson",
      "nextReview": "2024-01-20",
      "autoRenewal": true,
      "confidential": false,
      "description": "5-year commercial lease for retail space in downtown business district",
      "parties": ["Downtown Properties LLC", "Retail Innovations Inc."],
      "keyTerms": [
        "5-year term with renewal option",
        "Monthly rent of \$4,000",
        "3% annual rent increase",
        "Tenant improvements allowed"
      ],
    },
    {
      "id": 5,
      "title": "Partnership Agreement - Law Practice",
      "contractNumber": "PA-2023-005",
      "client": "Rodriguez & Associates",
      "type": "partnership",
      "status": "expired",
      "value": null,
      "startDate": "2023-01-01",
      "endDate": "2023-12-31",
      "signedDate": "2022-12-20",
      "lastModified": "2023-12-31",
      "attorney": "Mark Johnson",
      "nextReview": null,
      "autoRenewal": false,
      "confidential": true,
      "description": "Partnership agreement for collaborative law practice specializing in corporate law",
      "parties": ["Rodriguez & Associates", "Corporate Legal Solutions"],
      "keyTerms": [
        "50/50 profit sharing",
        "Joint case management",
        "Shared office expenses",
        "Non-compete clause"
      ],
    },
    {
      "id": 6,
      "title": "Purchase Agreement - Legal Software",
      "contractNumber": "PU-2024-006",
      "client": "LegalTech Solutions",
      "type": "purchase",
      "status": "signed",
      "value": 45000.0,
      "startDate": "2024-01-12",
      "endDate": null,
      "signedDate": "2024-01-12",
      "lastModified": "2024-01-12",
      "attorney": "Anna Wilson",
      "nextReview": "2024-07-12",
      "autoRenewal": false,
      "confidential": false,
      "description": "Software purchase agreement including licensing, implementation, and support services",
      "parties": ["Law Firm Partners LLC", "LegalTech Solutions"],
      "keyTerms": [
        "One-time purchase price",
        "3-year support included",
        "Unlimited user licenses",
        "Data migration services"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredContracts {
    var filtered = contracts.where((contract) {
      bool matchesSearch = contract["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contract["contractNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contract["client"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || contract["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || contract["type"] == selectedType;
      
      if (showExpiringSoon && contract["endDate"] != null) {
        DateTime endDate = DateTime.parse(contract["endDate"]);
        DateTime now = DateTime.now();
        DateTime threeMonthsFromNow = now.add(Duration(days: 90));
        bool isExpiringSoon = endDate.isBefore(threeMonthsFromNow) && endDate.isAfter(now);
        return matchesSearch && matchesStatus && matchesType && isExpiringSoon;
      }
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    filtered.sort((a, b) => b["lastModified"].compareTo(a["lastModified"]));
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "signed":
        return primaryColor;
      case "draft":
        return warningColor;
      case "under_review":
        return infoColor;
      case "expired":
        return dangerColor;
      case "terminated":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _isExpiringSoon(String? endDate) {
    if (endDate == null) return false;
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    DateTime threeMonthsFromNow = now.add(Duration(days: 90));
    return end.isBefore(threeMonthsFromNow) && end.isAfter(now);
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "service":
        return "Service Agreement";
      case "employment":
        return "Employment";
      case "nda":
        return "NDA";
      case "purchase":
        return "Purchase";
      case "lease":
        return "Lease";
      case "partnership":
        return "Partnership";
      default:
        return type.toUpperCase();
    }
  }

  Widget _buildContractCard(Map<String, dynamic> contract) {
    bool isExpiring = _isExpiringSoon(contract["endDate"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isExpiring
            ? Border.all(color: warningColor, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${contract["contractNumber"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getTypeLabel("${contract["type"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${contract["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${contract["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${contract["status"]}"),
                  ),
                ),
              ),
              if (contract["confidential"] == true) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CONFIDENTIAL",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (isExpiring) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Expires soon: ${contract["endDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Text(
            "${contract["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${contract["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.business, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Client: ${contract["client"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${contract["attorney"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Start: ${contract["startDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (contract["endDate"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.event, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "End: ${contract["endDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          if (contract["value"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.attach_money, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Value: \$${((contract["value"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                if (contract["autoRenewal"] == true) ...[
                  Spacer(),
                  Icon(Icons.refresh, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Text(
                    "Auto-Renewal",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
          SizedBox(height: spSm),
          ExpansionTile(
            title: Text(
              "Key Terms & Parties",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Parties:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(contract["parties"] as List).map(
                      (party) => Padding(
                        padding: EdgeInsets.only(left: spSm, bottom: 2),
                        child: Text(
                          "• $party",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Key Terms:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(contract["keyTerms"] as List).map(
                      (term) => Padding(
                        padding: EdgeInsets.only(left: spSm, bottom: 2),
                        child: Text(
                          "• $term",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
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
                child: QButton(
                  label: "View Contract",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int expiringSoonCount = contracts.where((c) => _isExpiringSoon(c["endDate"])).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Contracts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create contract
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert for expiring contracts
            if (expiringSoonCount > 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$expiringSoonCount contract${expiringSoonCount > 1 ? 's' : ''} expiring within 90 days",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showExpiringSoon = true;
                        setState(() {});
                      },
                      child: Text(
                        "View",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search contracts",
                    value: searchQuery,
                    hint: "Search by title, number, or client",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: showExpiringSoon ? Icons.schedule : Icons.schedule_outlined,
                  size: bs.sm,
                  onPressed: () {
                    showExpiringSoon = !showExpiringSoon;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
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
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Stats Cards
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
                        Icon(Icons.description, color: primaryColor, size: 28),
                        SizedBox(height: spXs),
                        Text(
                          "${contracts.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Contracts",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
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
                        Icon(Icons.check_circle, color: successColor, size: 28),
                        SizedBox(height: spXs),
                        Text(
                          "${contracts.where((c) => c["status"] == "active" || c["status"] == "signed").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active/Signed",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
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
                        Icon(Icons.warning, color: warningColor, size: 28),
                        SizedBox(height: spXs),
                        Text(
                          "$expiringSoonCount",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Expiring Soon",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
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
                        Icon(Icons.attach_money, color: infoColor, size: 28),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((contracts.where((c) => c["value"] != null).fold(0.0, (sum, c) => sum + (c["value"] as double))) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Contracts List
            Row(
              children: [
                Text(
                  "Contracts (${filteredContracts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (showExpiringSoon)
                  Container(
                    margin: EdgeInsets.only(left: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "EXPIRING SOON",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spSm),

            if (filteredContracts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.description_outlined, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No contracts found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredContracts.map((contract) => _buildContractCard(contract)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
