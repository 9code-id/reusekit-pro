import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaContractView extends StatefulWidget {
  const ReaContractView({super.key});

  @override
  State<ReaContractView> createState() => _ReaContractViewState();
}

class _ReaContractViewState extends State<ReaContractView> {
  String selectedTab = "Active";
  
  List<Map<String, dynamic>> contracts = [
    {
      "id": "CON001",
      "property_title": "Luxury 3BHK Apartment",
      "property_location": "Downtown Paradise, Mumbai",
      "property_image": "https://picsum.photos/120/120?random=501&keyword=apartment",
      "contract_type": "Purchase Agreement",
      "final_price": 2300000.0,
      "contract_date": "2024-01-25",
      "closing_date": "2024-03-15",
      "status": "Active",
      "progress_percentage": 65,
      "seller_name": "Rajesh Kumar",
      "buyer_name": "John Doe",
      "lawyer_name": "Advocate Sharma",
      "last_updated": "2 hours ago",
      "key_terms": {
        "earnest_money": 230000.0,
        "down_payment": 575000.0,
        "loan_amount": 1725000.0,
        "contingencies": ["Inspection", "Financing", "Appraisal"],
        "closing_costs_split": "50-50",
      },
      "milestones": [
        {
          "title": "Contract Signed",
          "date": "2024-01-25",
          "status": "Completed",
          "description": "Purchase agreement signed by both parties",
        },
        {
          "title": "Earnest Money Deposit",
          "date": "2024-01-26",
          "status": "Completed",
          "description": "₹2.3L earnest money deposited in escrow",
        },
        {
          "title": "Property Inspection",
          "date": "2024-02-01",
          "status": "Completed",
          "description": "Professional inspection completed",
        },
        {
          "title": "Loan Approval",
          "date": "2024-02-15",
          "status": "In Progress",
          "description": "Waiting for final loan approval",
        },
        {
          "title": "Final Walkthrough",
          "date": "2024-03-10",
          "status": "Pending",
          "description": "Final property inspection before closing",
        },
        {
          "title": "Closing & Transfer",
          "date": "2024-03-15",
          "status": "Pending",
          "description": "Property ownership transfer",
        },
      ],
    },
    {
      "id": "CON002",
      "property_title": "Modern 2BHK Villa",
      "property_location": "Green Valley, Pune",
      "property_image": "https://picsum.photos/120/120?random=502&keyword=villa",
      "contract_type": "Lease Agreement",
      "final_price": 25000.0,
      "contract_date": "2024-01-20",
      "closing_date": "2024-01-25",
      "status": "Completed",
      "progress_percentage": 100,
      "seller_name": "Priya Sharma",
      "buyer_name": "Sarah Wilson",
      "lawyer_name": "Advocate Patel",
      "last_updated": "3 days ago",
      "key_terms": {
        "security_deposit": 50000.0,
        "monthly_rent": 25000.0,
        "lease_duration": "24 months",
        "maintenance_included": true,
        "renewal_option": true,
      },
      "milestones": [
        {
          "title": "Lease Signed",
          "date": "2024-01-20",
          "status": "Completed",
          "description": "Lease agreement signed by both parties",
        },
        {
          "title": "Security Deposit",
          "date": "2024-01-21",
          "status": "Completed",
          "description": "₹50K security deposit paid",
        },
        {
          "title": "Key Handover",
          "date": "2024-01-25",
          "status": "Completed",
          "description": "Property keys handed over to tenant",
        },
      ],
    },
    {
      "id": "CON003",
      "property_title": "Commercial Office Space",
      "property_location": "Business District, Bangalore",
      "property_image": "https://picsum.photos/120/120?random=503&keyword=office",
      "contract_type": "Purchase Agreement",
      "final_price": 5300000.0,
      "contract_date": "2024-01-22",
      "closing_date": "2024-04-10",
      "status": "Under Review",
      "progress_percentage": 30,
      "seller_name": "Amit Patel",
      "buyer_name": "TechCorp Ltd",
      "lawyer_name": "Law Firm Associates",
      "last_updated": "1 day ago",
      "key_terms": {
        "earnest_money": 530000.0,
        "down_payment": 1060000.0,
        "loan_amount": 4240000.0,
        "contingencies": ["Zoning Approval", "Environmental Check"],
        "closing_costs_split": "Buyer pays all",
      },
      "milestones": [
        {
          "title": "Initial Agreement",
          "date": "2024-01-22",
          "status": "Completed",
          "description": "Initial purchase agreement drafted",
        },
        {
          "title": "Legal Review",
          "date": "2024-01-28",
          "status": "In Progress",
          "description": "Lawyers reviewing contract terms",
        },
        {
          "title": "Due Diligence",
          "date": "2024-02-05",
          "status": "Pending",
          "description": "Property due diligence period",
        },
        {
          "title": "Final Contract",
          "date": "2024-02-20",
          "status": "Pending",
          "description": "Final contract signing",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Purchase Agreement",
      "type": "PDF",
      "size": "2.3 MB",
      "uploaded": "2024-01-25",
      "status": "Signed",
      "icon": Icons.description,
    },
    {
      "name": "Property Disclosure",
      "type": "PDF",
      "size": "1.8 MB",
      "uploaded": "2024-01-25",
      "status": "Reviewed",
      "icon": Icons.info,
    },
    {
      "name": "Inspection Report",
      "type": "PDF",
      "size": "5.2 MB",
      "uploaded": "2024-02-01",
      "status": "Completed",
      "icon": Icons.home_repair_service,
    },
    {
      "name": "Loan Pre-approval",
      "type": "PDF",
      "size": "1.1 MB",
      "uploaded": "2024-01-20",
      "status": "Approved",
      "icon": Icons.account_balance,
    },
    {
      "name": "Property Appraisal",
      "type": "PDF",
      "size": "3.4 MB",
      "uploaded": "2024-02-05",
      "status": "Pending",
      "icon": Icons.assessment,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredContracts = selectedTab == "All" 
        ? contracts 
        : contracts.where((contract) => contract["status"] == selectedTab).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contracts"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _showDownloadOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showContractHelp();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Active", "value": "Active"},
                {"label": "Under Review", "value": "Under Review"},
                {"label": "Completed", "value": "Completed"},
                {"label": "Cancelled", "value": "Cancelled"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          // Summary Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${contracts.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Contracts",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${contracts.where((c) => c["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${contracts.where((c) => c["status"] == "Completed").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Contracts List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredContracts.length,
              itemBuilder: (context, index) {
                final contract = filteredContracts[index];
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
                      // Contract Header
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${contract["property_image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${contract["property_title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${contract["contract_type"]} • ${contract["id"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Closing: ${contract["closing_date"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(contract["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${contract["status"]}",
                              style: TextStyle(
                                color: _getStatusColor(contract["status"]),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contract Progress",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${contract["progress_percentage"]}%",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (contract["progress_percentage"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(contract["status"])),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Key Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Contract Value:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  contract["contract_type"] == "Lease Agreement"
                                      ? "₹${((contract["final_price"] as double) / 1000).toStringAsFixed(1)}K/month"
                                      : "₹${((contract["final_price"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Parties:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${contract["seller_name"]} & ${contract["buyer_name"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Legal Counsel:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${contract["lawyer_name"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () {
                                _showContractDetails(contract);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Documents",
                              icon: Icons.folder,
                              size: bs.sm,
                              onPressed: () {
                                _showDocuments(contract);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (contract["status"] == "Active") ...[
                            Expanded(
                              child: QButton(
                                label: "Timeline",
                                icon: Icons.timeline,
                                size: bs.sm,
                                onPressed: () {
                                  _showContractTimeline(contract);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return primaryColor;
      case "Under Review":
        return warningColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showContractDetails(Map<String, dynamic> contract) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Contract Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Property Information
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Property Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text("Title: ${contract["property_title"]}"),
                            Text("Location: ${contract["property_location"]}"),
                            Text("Contract Type: ${contract["contract_type"]}"),
                            Text("Contract ID: ${contract["id"]}"),
                          ],
                        ),
                      ),

                      // Financial Terms
                      Text(
                        "Financial Terms",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      if (contract["key_terms"]["earnest_money"] != null) ...[
                        _buildTermRow("Earnest Money", "₹${((contract["key_terms"]["earnest_money"] as double) / 100000).toStringAsFixed(1)}L"),
                      ],
                      if (contract["key_terms"]["down_payment"] != null) ...[
                        _buildTermRow("Down Payment", "₹${((contract["key_terms"]["down_payment"] as double) / 100000).toStringAsFixed(1)}L"),
                      ],
                      if (contract["key_terms"]["loan_amount"] != null) ...[
                        _buildTermRow("Loan Amount", "₹${((contract["key_terms"]["loan_amount"] as double) / 100000).toStringAsFixed(1)}L"),
                      ],
                      if (contract["key_terms"]["monthly_rent"] != null) ...[
                        _buildTermRow("Monthly Rent", "₹${((contract["key_terms"]["monthly_rent"] as double) / 1000).toStringAsFixed(1)}K"),
                      ],
                      if (contract["key_terms"]["security_deposit"] != null) ...[
                        _buildTermRow("Security Deposit", "₹${((contract["key_terms"]["security_deposit"] as double) / 1000).toStringAsFixed(1)}K"),
                      ],

                      // Important Dates
                      Text(
                        "Important Dates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      _buildTermRow("Contract Date", "${contract["contract_date"]}"),
                      _buildTermRow("Closing Date", "${contract["closing_date"]}"),
                      
                      // Contingencies
                      if (contract["key_terms"]["contingencies"] != null) ...[
                        Text(
                          "Contingencies",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...(contract["key_terms"]["contingencies"] as List).map((contingency) => 
                          Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: infoColor, size: 16),
                                SizedBox(width: spXs),
                                Text("$contingency", style: TextStyle(color: infoColor, fontSize: 12)),
                              ],
                            ),
                          ),
                        ).toList(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDocuments(Map<String, dynamic> contract) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Contract Documents",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              document["icon"] as IconData,
                              color: primaryColor,
                              size: 24,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${document["type"]} • ${document["size"]} • ${document["uploaded"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getDocumentStatusColor(document["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${document["status"]}",
                              style: TextStyle(
                                color: _getDocumentStatusColor(document["status"]),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          IconButton(
                            icon: Icon(Icons.download, color: primaryColor),
                            onPressed: () {
                              si("Downloading ${document["name"]}...");
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDocumentStatusColor(String status) {
    switch (status) {
      case "Signed":
        return successColor;
      case "Approved":
        return successColor;
      case "Completed":
        return successColor;
      case "Reviewed":
        return infoColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showContractTimeline(Map<String, dynamic> contract) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Contract Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  itemCount: (contract["milestones"] as List).length,
                  itemBuilder: (context, index) {
                    final milestone = (contract["milestones"] as List)[index];
                    final isCompleted = milestone["status"] == "Completed";
                    final isInProgress = milestone["status"] == "In Progress";
                    final isLast = index == (contract["milestones"] as List).length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted 
                                    ? successColor 
                                    : isInProgress 
                                      ? warningColor 
                                      : disabledColor,
                              ),
                              child: Icon(
                                isCompleted 
                                    ? Icons.check 
                                    : isInProgress 
                                      ? Icons.timelapse 
                                      : Icons.schedule,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (!isLast) ...[
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${milestone["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted 
                                      ? primaryColor 
                                      : isInProgress 
                                        ? warningColor 
                                        : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${milestone["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${milestone["date"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              if (!isLast) SizedBox(height: spMd),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDownloadOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Download Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose what you'd like to download:"),
            SizedBox(height: spMd),
            QButton(
              label: "All Contract Documents",
              icon: Icons.download,
              size: bs.sm,
              onPressed: () {
                back();
                si("Downloading all documents...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Contract Summary Report",
              icon: Icons.summarize,
              size: bs.sm,
              onPressed: () {
                back();
                si("Generating summary report...");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showContractHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contract Help"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Understanding Contract Status:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("• Active: Contract is in progress"),
              Text("• Under Review: Being reviewed by legal team"),
              Text("• Completed: All terms fulfilled"),
              Text("• Cancelled: Contract terminated"),
              SizedBox(height: spMd),
              Text("Important Notes:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("• Keep all documents safe"),
              Text("• Review timelines regularly"),
              Text("• Contact legal counsel for questions"),
              Text("• Monitor milestone progress"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
