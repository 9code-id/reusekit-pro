import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLegalDocumentsView extends StatefulWidget {
  const ReaLegalDocumentsView({super.key});

  @override
  State<ReaLegalDocumentsView> createState() => _ReaLegalDocumentsViewState();
}

class _ReaLegalDocumentsViewState extends State<ReaLegalDocumentsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> documentCategories = [
    {"label": "All", "value": "All"},
    {"label": "Purchase Agreement", "value": "Purchase Agreement"},
    {"label": "Property Documents", "value": "Property Documents"},
    {"label": "Financial", "value": "Financial"},
    {"label": "Legal Clearance", "value": "Legal Clearance"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Tax Documents", "value": "Tax Documents"},
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": "DOC001",
      "title": "Sale Deed",
      "category": "Purchase Agreement",
      "property": "Luxury 3BHK Apartment",
      "description": "Legal document transferring property ownership from seller to buyer",
      "file_type": "PDF",
      "file_size": "2.3 MB",
      "upload_date": "2024-01-25",
      "expiry_date": null,
      "status": "Signed",
      "priority": "High",
      "required_for_closing": true,
      "signed_by": ["Buyer", "Seller", "Witness"],
      "notarized": true,
      "icon": Icons.gavel,
      "color": primaryColor,
    },
    {
      "id": "DOC002",
      "title": "Property Title Document",
      "category": "Property Documents",
      "property": "Luxury 3BHK Apartment",
      "description": "Official document proving ownership and clear title of the property",
      "file_type": "PDF",
      "file_size": "1.8 MB",
      "upload_date": "2024-01-20",
      "expiry_date": null,
      "status": "Verified",
      "priority": "High",
      "required_for_closing": true,
      "signed_by": ["Property Owner"],
      "notarized": true,
      "icon": Icons.home,
      "color": successColor,
    },
    {
      "id": "DOC003",
      "title": "Property Survey Report",
      "category": "Property Documents",
      "property": "Luxury 3BHK Apartment",
      "description": "Professional survey report detailing property boundaries and measurements",
      "file_type": "PDF",
      "file_size": "5.2 MB",
      "upload_date": "2024-01-22",
      "expiry_date": "2025-01-22",
      "status": "Valid",
      "priority": "Medium",
      "required_for_closing": true,
      "signed_by": ["Licensed Surveyor"],
      "notarized": false,
      "icon": Icons.map,
      "color": infoColor,
    },
    {
      "id": "DOC004",
      "title": "Home Loan Pre-approval",
      "category": "Financial",
      "property": "Luxury 3BHK Apartment",
      "description": "Bank pre-approval letter for home loan financing",
      "file_type": "PDF",
      "file_size": "1.1 MB",
      "upload_date": "2024-01-18",
      "expiry_date": "2024-04-18",
      "status": "Approved",
      "priority": "High",
      "required_for_closing": true,
      "signed_by": ["Bank Manager"],
      "notarized": false,
      "icon": Icons.account_balance,
      "color": successColor,
    },
    {
      "id": "DOC005",
      "title": "Property Inspection Report",
      "category": "Property Documents",
      "property": "Luxury 3BHK Apartment",
      "description": "Comprehensive inspection report covering structural and safety aspects",
      "file_type": "PDF",
      "file_size": "3.4 MB",
      "upload_date": "2024-02-01",
      "expiry_date": "2024-08-01",
      "status": "Completed",
      "priority": "Medium",
      "required_for_closing": false,
      "signed_by": ["Certified Inspector"],
      "notarized": false,
      "icon": Icons.home_repair_service,
      "color": warningColor,
    },
    {
      "id": "DOC006",
      "title": "Property Appraisal Report",
      "category": "Financial",
      "property": "Luxury 3BHK Apartment",
      "description": "Professional property valuation report for loan purposes",
      "file_type": "PDF",
      "file_size": "2.1 MB",
      "upload_date": "2024-02-05",
      "expiry_date": "2024-08-05",
      "status": "Approved",
      "priority": "High",
      "required_for_closing": true,
      "signed_by": ["Licensed Appraiser"],
      "notarized": true,
      "icon": Icons.assessment,
      "color": primaryColor,
    },
    {
      "id": "DOC007",
      "title": "No Objection Certificate (NOC)",
      "category": "Legal Clearance",
      "property": "Luxury 3BHK Apartment",
      "description": "NOC from local authorities for property construction and occupation",
      "file_type": "PDF",
      "file_size": "0.8 MB",
      "upload_date": "2024-01-15",
      "expiry_date": null,
      "status": "Valid",
      "priority": "High",
      "required_for_closing": true,
      "signed_by": ["Municipal Authority"],
      "notarized": true,
      "icon": Icons.verified,
      "color": successColor,
    },
    {
      "id": "DOC008",
      "title": "Property Insurance Policy",
      "category": "Insurance",
      "property": "Luxury 3BHK Apartment",
      "description": "Comprehensive property insurance coverage document",
      "file_type": "PDF",
      "file_size": "1.5 MB",
      "upload_date": "2024-02-10",
      "expiry_date": "2025-02-10",
      "status": "Active",
      "priority": "Medium",
      "required_for_closing": false,
      "signed_by": ["Insurance Company"],
      "notarized": false,
      "icon": Icons.shield,
      "color": infoColor,
    },
    {
      "id": "DOC009",
      "title": "Property Tax Receipt",
      "category": "Tax Documents",
      "property": "Luxury 3BHK Apartment",
      "description": "Latest property tax payment receipt and clearance certificate",
      "file_type": "PDF",
      "file_size": "0.5 MB",
      "upload_date": "2024-01-30",
      "expiry_date": "2025-03-31",
      "status": "Paid",
      "priority": "Medium",
      "required_for_closing": true,
      "signed_by": ["Tax Authority"],
      "notarized": false,
      "icon": Icons.receipt,
      "color": warningColor,
    },
    {
      "id": "DOC010",
      "title": "Environmental Clearance",
      "category": "Legal Clearance",
      "property": "Luxury 3BHK Apartment",
      "description": "Environmental impact assessment and clearance certificate",
      "file_type": "PDF",
      "file_size": "2.8 MB",
      "upload_date": "2024-01-12",
      "expiry_date": "2029-01-12",
      "status": "Valid",
      "priority": "Low",
      "required_for_closing": false,
      "signed_by": ["Environmental Board"],
      "notarized": true,
      "icon": Icons.eco,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDocuments = documents.where((doc) {
      final categoryMatch = selectedCategory == "All" || doc["category"] == selectedCategory;
      final searchMatch = searchQuery.isEmpty || 
          doc["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          doc["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              _showUploadDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showDocumentGuide();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search documents...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: documentCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spMd),

          // Document Stats
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
                        "${documents.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Documents",
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
                        "${documents.where((d) => d["required_for_closing"] == true).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Required",
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
                        "${documents.where((d) => d["status"] == "Signed" || d["status"] == "Verified" || d["status"] == "Approved").length}",
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
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${documents.where((d) => d["expiry_date"] != null && DateTime.parse(d["expiry_date"]).isBefore(DateTime.now().add(Duration(days: 30)))).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Expiring Soon",
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

          // Documents List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredDocuments.length,
              itemBuilder: (context, index) {
                final document = filteredDocuments[index];
                final isExpiringSoon = document["expiry_date"] != null && 
                    DateTime.parse(document["expiry_date"]).isBefore(DateTime.now().add(Duration(days: 30)));
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isExpiringSoon ? dangerColor : Colors.transparent,
                      width: isExpiringSoon ? 1 : 0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (document["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              document["icon"] as IconData,
                              color: document["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${document["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${document["category"]} • ${document["id"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(document["priority"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${document["priority"]}",
                                  style: TextStyle(
                                    color: _getPriorityColor(document["priority"]),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(document["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${document["status"]}",
                                  style: TextStyle(
                                    color: _getStatusColor(document["status"]),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Document Description
                      Text(
                        "${document["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Document Details
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
                                  "File Type:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${document["file_type"]} • ${document["file_size"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Upload Date:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${document["upload_date"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            if (document["expiry_date"] != null) ...[
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Expiry Date:",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${document["expiry_date"]}",
                                    style: TextStyle(
                                      color: isExpiringSoon ? dangerColor : disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: isExpiringSoon ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Document Attributes
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: [
                          if (document["required_for_closing"] == true) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Required for Closing",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (document["notarized"] == true) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified, color: successColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Notarized",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (isExpiringSoon) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.warning, color: dangerColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Expiring Soon",
                                    style: TextStyle(
                                      color: dangerColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View",
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () {
                                _showDocumentPreview(document);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Download",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                si("Downloading ${document["title"]}...");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Share",
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                _showShareOptions(document);
                              },
                            ),
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUploadDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Signed":
      case "Verified":
      case "Approved":
      case "Valid":
      case "Active":
      case "Paid":
        return successColor;
      case "Completed":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showDocumentPreview(Map<String, dynamic> document) {
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
                        "${document["title"]}",
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
                      // Document details preview would go here
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              document["icon"] as IconData,
                              size: 64,
                              color: disabledBoldColor,
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "Document Preview",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${document["file_type"]} • ${document["file_size"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Text(
                        "Document Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      _buildInfoRow("Category", "${document["category"]}"),
                      _buildInfoRow("Property", "${document["property"]}"),
                      _buildInfoRow("Status", "${document["status"]}"),
                      _buildInfoRow("Priority", "${document["priority"]}"),
                      _buildInfoRow("Upload Date", "${document["upload_date"]}"),
                      if (document["expiry_date"] != null) ...[
                        _buildInfoRow("Expiry Date", "${document["expiry_date"]}"),
                      ],
                      
                      Text(
                        "Signatories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      ...(document["signed_by"] as List).map((signer) => 
                        Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 16),
                              SizedBox(width: spSm),
                              Text(
                                "$signer",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
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

  Widget _buildInfoRow(String label, String value) {
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

  void _showShareOptions(Map<String, dynamic> document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Share Document"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose how to share ${document["title"]}:"),
            SizedBox(height: spMd),
            QButton(
              label: "Email",
              icon: Icons.email,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening email to share document...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Generate Link",
              icon: Icons.link,
              size: bs.sm,
              onPressed: () {
                back();
                si("Generating shareable link...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Send to Lawyer",
              icon: Icons.gavel,
              size: bs.sm,
              onPressed: () {
                back();
                si("Sending document to legal counsel...");
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

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Upload Document"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose upload method:"),
            SizedBox(height: spMd),
            QButton(
              label: "Choose File",
              icon: Icons.upload_file,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening file picker...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Take Photo",
              icon: Icons.camera_alt,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening camera...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Scan Document",
              icon: Icons.scanner,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening document scanner...");
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

  void _showDocumentGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Document Guide"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Essential Documents for Property Purchase:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("• Sale Deed - Property ownership transfer"),
              Text("• Title Documents - Proof of clear title"),
              Text("• Survey Report - Property boundaries"),
              Text("• Loan Documents - Financing papers"),
              Text("• NOC - Regulatory clearances"),
              Text("• Insurance - Property protection"),
              Text("• Tax Receipts - Payment records"),
              SizedBox(height: spMd),
              Text("Document Status Guide:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("• Signed - Document executed by parties"),
              Text("• Verified - Authenticity confirmed"),
              Text("• Approved - Officially sanctioned"),
              Text("• Valid - Currently in effect"),
              Text("• Pending - Awaiting action"),
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
