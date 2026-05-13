import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleDocumentsView extends StatefulWidget {
  const CmaVehicleDocumentsView({super.key});

  @override
  State<CmaVehicleDocumentsView> createState() => _CmaVehicleDocumentsViewState();
}

class _CmaVehicleDocumentsViewState extends State<CmaVehicleDocumentsView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  
  // Sample vehicle data - in real app this would come from arguments
  Map<String, dynamic> vehicle = {
    "id": "veh_001",
    "name": "Honda Civic 2024",
    "licensePlate": "ABC-1234"
  };
  
  List<Map<String, dynamic>> documents = [
    {
      "id": "doc_001",
      "name": "Vehicle Registration Certificate",
      "category": "Registration",
      "description": "Official vehicle registration document",
      "uploadDate": "2024-01-15",
      "expiryDate": "2025-11-30",
      "fileSize": "2.3 MB",
      "fileType": "PDF",
      "status": "Valid",
      "uploadedBy": "John Doe",
      "reminder": true,
      "reminderDays": 30
    },
    {
      "id": "doc_002",
      "name": "Comprehensive Insurance Policy",
      "category": "Insurance",
      "description": "Full coverage insurance policy document",
      "uploadDate": "2024-01-15",
      "expiryDate": "2025-12-31",
      "fileSize": "1.8 MB",
      "fileType": "PDF",
      "status": "Valid",
      "uploadedBy": "Jane Smith",
      "reminder": true,
      "reminderDays": 45
    },
    {
      "id": "doc_003",
      "name": "Vehicle Purchase Invoice",
      "category": "Purchase",
      "description": "Original purchase invoice from dealer",
      "uploadDate": "2024-01-15",
      "expiryDate": null,
      "fileSize": "854 KB",
      "fileType": "PDF",
      "status": "Archived",
      "uploadedBy": "Bob Johnson",
      "reminder": false,
      "reminderDays": 0
    },
    {
      "id": "doc_004",
      "name": "Annual Safety Inspection",
      "category": "Inspection",
      "description": "Annual vehicle safety inspection certificate",
      "uploadDate": "2025-03-15",
      "expiryDate": "2026-03-15",
      "fileSize": "1.2 MB",
      "fileType": "PDF",
      "status": "Valid",
      "uploadedBy": "Alice Brown",
      "reminder": true,
      "reminderDays": 60
    },
    {
      "id": "doc_005",
      "name": "Emissions Test Certificate",
      "category": "Inspection",
      "description": "Vehicle emissions test compliance certificate",
      "uploadDate": "2025-02-10",
      "expiryDate": "2025-08-10",
      "fileSize": "687 KB",
      "fileType": "PDF",
      "status": "Expiring Soon",
      "uploadedBy": "Charlie Wilson",
      "reminder": true,
      "reminderDays": 15
    },
    {
      "id": "doc_006",
      "name": "Warranty Documentation",
      "category": "Warranty",
      "description": "Manufacturer warranty terms and conditions",
      "uploadDate": "2024-01-15",
      "expiryDate": "2027-01-15",
      "fileSize": "3.1 MB",
      "fileType": "PDF",
      "status": "Valid",
      "uploadedBy": "John Doe",
      "reminder": true,
      "reminderDays": 90
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Registration", "value": "Registration"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Purchase", "value": "Purchase"},
    {"label": "Inspection", "value": "Inspection"},
    {"label": "Warranty", "value": "Warranty"},
    {"label": "Maintenance", "value": "Maintenance"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Valid", "value": "Valid"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Archived", "value": "Archived"}
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    return documents.where((document) {
      bool matchesCategory = selectedCategory == "all" || document["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || document["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (document["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (document["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showUploadDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showDocumentActions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Info Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: primaryColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${vehicle["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "License Plate: ${vehicle["licensePlate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "${documents.length} Documents",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Document Statistics
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Valid",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${documents.where((d) => d["status"] == "Valid").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: warningColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Expiring",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${documents.where((d) => d["status"] == "Expiring Soon").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: dangerColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Expired",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${documents.where((d) => d["status"] == "Expired").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Search Documents",
                    value: searchQuery,
                    hint: "Search by document name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
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
                    ],
                  ),
                ],
              ),
            ),

            // Documents List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Documents (${filteredDocuments.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Upload New",
                        size: bs.sm,
                        onPressed: () {
                          _showUploadDialog();
                        },
                      ),
                    ],
                  ),
                  ...filteredDocuments.map((document) {
                    Color statusColor;
                    switch (document["status"]) {
                      case "Valid":
                        statusColor = successColor;
                        break;
                      case "Expiring Soon":
                        statusColor = warningColor;
                        break;
                      case "Expired":
                        statusColor = dangerColor;
                        break;
                      default:
                        statusColor = disabledBoldColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.description,
                              color: statusColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${document["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${document["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${document["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${document["fileType"]} • ${document["fileSize"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${document["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Uploaded: ${DateTime.parse(document["uploadDate"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    if (document["expiryDate"] != null) ...[
                                      SizedBox(width: spSm),
                                      Text(
                                        "Expires: ${DateTime.parse(document["expiryDate"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: statusColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                if (document["reminder"] as bool) 
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Reminder set ${document["reminderDays"]} days before expiry",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: warningColor,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            children: [
                              QButton(
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Downloading ${document["name"]}");
                                },
                              ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showDocumentItemActions(document);
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
          ],
        ),
      ),
    );
  }

  void _showUploadDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Upload New Document",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Registration Documents",
                  onPressed: () {
                    back();
                    ss("Registration document upload started");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Insurance Documents",
                  onPressed: () {
                    back();
                    ss("Insurance document upload started");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Inspection Certificates",
                  onPressed: () {
                    back();
                    ss("Inspection certificate upload started");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Maintenance Records",
                  onPressed: () {
                    back();
                    ss("Maintenance record upload started");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Other Documents",
                  onPressed: () {
                    back();
                    ss("Document upload started");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDocumentActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Document Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Bulk Download",
                  onPressed: () {
                    back();
                    ss("Bulk download started for all documents");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Generate Document Report",
                  onPressed: () {
                    back();
                    ss("Document report generated");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Setup Reminders",
                  onPressed: () {
                    back();
                    ss("Reminder settings updated");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Export Document List",
                  onPressed: () {
                    back();
                    ss("Document list exported");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDocumentItemActions(Map<String, dynamic> document) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Actions - ${document["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Download",
                  onPressed: () {
                    back();
                    ss("Downloading ${document["name"]}");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Details",
                  onPressed: () {
                    back();
                    ss("Viewing document details");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Replace Document",
                  onPressed: () {
                    back();
                    ss("Document replacement started");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Set Reminder",
                  onPressed: () {
                    back();
                    ss("Reminder set for document expiry");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Delete Document",
                  onPressed: () async {
                    back();
                    bool isConfirmed = await confirm("Are you sure you want to delete this document? This action cannot be undone.");
                    if (isConfirmed) {
                      ss("Document ${document["name"]} has been deleted");
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
