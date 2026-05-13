import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxDocumentsView extends StatefulWidget {
  const AbaTaxDocumentsView({super.key});

  @override
  State<AbaTaxDocumentsView> createState() => _AbaTaxDocumentsViewState();
}

class _AbaTaxDocumentsViewState extends State<AbaTaxDocumentsView> {
  String selectedCategory = "all";
  String selectedYear = "2024";
  String selectedStatus = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Tax Forms", "value": "tax_forms"},
    {"label": "W-2 Forms", "value": "w2_forms"},
    {"label": "1099 Forms", "value": "1099_forms"},
    {"label": "Receipts", "value": "receipts"},
    {"label": "Certificates", "value": "certificates"},
    {"label": "Correspondence", "value": "correspondence"},
  ];

  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
    {"label": "2020", "value": "2020"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Archived", "value": "archived"},
    {"label": "Pending Review", "value": "pending"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> documentStats = [
    {
      "title": "Total Documents",
      "count": 1247,
      "icon": Icons.description,
      "color": primaryColor,
    },
    {
      "title": "This Year",
      "count": 285,
      "icon": Icons.calendar_today,
      "color": successColor,
    },
    {
      "title": "Pending Review",
      "count": 23,
      "icon": Icons.pending,
      "color": warningColor,
    },
    {
      "title": "Expiring Soon",
      "count": 8,
      "icon": Icons.warning,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> taxDocuments = [
    {
      "id": "TD001",
      "title": "Form 941 - Q1 2024",
      "description": "Quarterly Federal Tax Return for Q1 2024",
      "category": "Tax Forms",
      "fileType": "PDF",
      "fileSize": "2.4 MB",
      "uploadDate": "2024-04-01",
      "year": "2024",
      "status": "active",
      "uploadedBy": "Sarah Johnson",
      "tags": ["Federal", "Quarterly", "Tax Return"],
      "downloads": 15,
      "icon": Icons.description,
    },
    {
      "id": "TD002",
      "title": "W-2 Forms 2023",
      "description": "Employee W-2 wage and tax statements for 2023",
      "category": "W-2 Forms",
      "fileType": "ZIP",
      "fileSize": "15.8 MB",
      "uploadDate": "2024-01-15",
      "year": "2023",
      "status": "active",
      "uploadedBy": "John Smith",
      "tags": ["W-2", "Employees", "Annual"],
      "downloads": 125,
      "icon": Icons.people,
    },
    {
      "id": "TD003",
      "title": "1099-MISC Forms 2023",
      "description": "Miscellaneous income forms for contractors",
      "category": "1099 Forms",
      "fileType": "PDF",
      "fileSize": "5.2 MB",
      "uploadDate": "2024-01-20",
      "year": "2023",
      "status": "active",
      "uploadedBy": "Mike Davis",
      "tags": ["1099", "Contractors", "Miscellaneous"],
      "downloads": 38,
      "icon": Icons.receipt_long,
    },
    {
      "id": "TD004",
      "title": "State Tax Certificate",
      "description": "State tax registration certificate",
      "category": "Certificates",
      "fileType": "PDF",
      "fileSize": "1.2 MB",
      "uploadDate": "2023-12-15",
      "year": "2023",
      "status": "active",
      "uploadedBy": "Emily Wilson",
      "tags": ["State", "Registration", "Certificate"],
      "downloads": 8,
      "icon": Icons.verified,
    },
    {
      "id": "TD005",
      "title": "IRS Correspondence - Notice",
      "description": "IRS notice regarding tax filing requirements",
      "category": "Correspondence",
      "fileType": "PDF",
      "fileSize": "850 KB",
      "uploadDate": "2024-03-15",
      "year": "2024",
      "status": "pending",
      "uploadedBy": "David Brown",
      "tags": ["IRS", "Notice", "Correspondence"],
      "downloads": 3,
      "icon": Icons.mail,
    },
    {
      "id": "TD006",
      "title": "Office Supplies Receipts",
      "description": "Business expense receipts for office supplies",
      "category": "Receipts",
      "fileType": "PDF",
      "fileSize": "3.7 MB",
      "uploadDate": "2024-03-28",
      "year": "2024",
      "status": "active",
      "uploadedBy": "Lisa Anderson",
      "tags": ["Receipts", "Office", "Expenses"],
      "downloads": 12,
      "icon": Icons.receipt,
    },
    {
      "id": "TD007",
      "title": "Federal Tax ID Certificate",
      "description": "Federal Employer Identification Number certificate",
      "category": "Certificates",
      "fileType": "PDF",
      "fileSize": "645 KB",
      "uploadDate": "2021-08-10",
      "year": "2021",
      "status": "expired",
      "uploadedBy": "John Smith",
      "tags": ["Federal", "EIN", "Certificate"],
      "downloads": 45,
      "icon": Icons.verified,
    },
    {
      "id": "TD008",
      "title": "Form 940 - Annual 2023",
      "description": "Annual Federal Unemployment Tax Act filing",
      "category": "Tax Forms",
      "fileType": "PDF",
      "fileSize": "1.8 MB",
      "uploadDate": "2024-01-28",
      "year": "2023",
      "status": "archived",
      "uploadedBy": "Sarah Johnson",
      "tags": ["Federal", "Annual", "Unemployment"],
      "downloads": 22,
      "icon": Icons.description,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "archived":
        return infoColor;
      case "expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "pending":
        return "Pending Review";
      case "archived":
        return "Archived";
      case "expired":
        return "Expired";
      default:
        return "Unknown";
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Tax Forms":
        return primaryColor;
      case "W-2 Forms":
        return successColor;
      case "1099 Forms":
        return infoColor;
      case "Receipts":
        return warningColor;
      case "Certificates":
        return dangerColor;
      case "Correspondence":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Upload Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: primaryColor.withAlpha(51),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upload Tax Documents",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Drag and drop files here or click to browse. Supported formats: PDF, DOC, DOCX, XLS, XLSX, ZIP",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Browse Files",
                          icon: Icons.folder_open,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Scan Document",
                          icon: Icons.scanner,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters Section
            Container(
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
                  Text(
                    "Document Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Year",
                          items: yearOptions,
                          value: selectedYear,
                          onChanged: (value, label) {
                            selectedYear = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
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
                        child: QTextField(
                          label: "Search Documents",
                          value: searchQuery,
                          hint: "Title, description, or tags",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Document Statistics
            Text(
              "Document Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: documentStats.map((stat) {
                return Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${stat["count"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Tax Documents List
            Text(
              "Tax Documents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: taxDocuments.map((document) {
                return Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(document["category"]).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              document["icon"] as IconData,
                              color: _getCategoryColor(document["category"]),
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(document["status"]).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusLabel(document["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(document["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${document["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${document["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(document["category"]).withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${document["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getCategoryColor(document["category"]),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.file_copy,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${document["fileType"]} • ${document["fileSize"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.download,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${document["downloads"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      // Tags
                      if ((document["tags"] as List).isNotEmpty) ...[
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (document["tags"] as List).map<Widget>((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${document["uploadedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Uploaded: ${document["uploadDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Download",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
