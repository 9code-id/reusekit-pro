import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDocumentsView extends StatefulWidget {
  const TtaDocumentsView({super.key});

  @override
  State<TtaDocumentsView> createState() => _TtaDocumentsViewState();
}

class _TtaDocumentsViewState extends State<TtaDocumentsView> {
  int currentTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> documentCategories = [
    {
      "id": 1,
      "name": "All Documents",
      "icon": Icons.folder,
      "color": primaryColor,
      "count": 12,
    },
    {
      "id": 2,
      "name": "Travel Documents",
      "icon": Icons.flight,
      "color": secondaryColor,
      "count": 5,
    },
    {
      "id": 3,
      "name": "Insurance",
      "icon": Icons.security,
      "color": successColor,
      "count": 3,
    },
    {
      "id": 4,
      "name": "Health Records",
      "icon": Icons.local_hospital,
      "color": warningColor,
      "count": 2,
    },
    {
      "id": 5,
      "name": "Emergency",
      "icon": Icons.emergency,
      "color": dangerColor,
      "count": 2,
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": 1,
      "name": "Passport",
      "category": "Travel Documents",
      "type": "pdf",
      "size": "2.3 MB",
      "uploadDate": "2024-01-15",
      "expiryDate": "2030-05-20",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Primary identification document for international travel",
      "issueCountry": "United States",
      "documentNumber": "XXX-XXX-1234",
      "thumbnail": "https://picsum.photos/100/100?random=1&keyword=passport",
    },
    {
      "id": 2,
      "name": "Travel Insurance Policy",
      "category": "Insurance",
      "type": "pdf",
      "size": "1.8 MB",
      "uploadDate": "2024-02-01",
      "expiryDate": "2024-12-31",
      "status": "Active",
      "isExpiringSoon": true,
      "description": "Comprehensive travel insurance coverage",
      "policyNumber": "TI-2024-567890",
      "provider": "Global Travel Insurance",
      "thumbnail": "https://picsum.photos/100/100?random=2&keyword=insurance",
    },
    {
      "id": 3,
      "name": "Driver's License",
      "category": "Travel Documents",
      "type": "jpg",
      "size": "1.2 MB",
      "uploadDate": "2024-01-20",
      "expiryDate": "2026-03-15",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "International driving permit for vehicle rental",
      "licenseNumber": "DL-ABC-12345",
      "issueState": "California",
      "thumbnail": "https://picsum.photos/100/100?random=3&keyword=license",
    },
    {
      "id": 4,
      "name": "Flight Tickets",
      "category": "Travel Documents",
      "type": "pdf",
      "size": "856 KB",
      "uploadDate": "2024-03-01",
      "expiryDate": "2024-06-15",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Round-trip flight booking confirmation",
      "bookingReference": "ABC123XYZ",
      "airline": "International Airways",
      "thumbnail": "https://picsum.photos/100/100?random=4&keyword=flight",
    },
    {
      "id": 5,
      "name": "Hotel Reservation",
      "category": "Travel Documents",
      "type": "pdf",
      "size": "1.1 MB",
      "uploadDate": "2024-02-15",
      "expiryDate": "2024-06-20",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Hotel booking confirmation",
      "confirmationNumber": "HTL-789456",
      "hotelName": "Grand Palace Hotel",
      "thumbnail": "https://picsum.photos/100/100?random=5&keyword=hotel",
    },
    {
      "id": 6,
      "name": "Vaccination Certificate",
      "category": "Health Records",
      "type": "pdf",
      "size": "943 KB",
      "uploadDate": "2024-01-10",
      "expiryDate": "2025-01-10",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "COVID-19 and other required vaccinations",
      "certificateNumber": "VAX-2024-001",
      "issuingAuthority": "Department of Health",
      "thumbnail": "https://picsum.photos/100/100?random=6&keyword=vaccine",
    },
    {
      "id": 7,
      "name": "Medical Prescription",
      "category": "Health Records",
      "type": "jpg",
      "size": "756 KB",
      "uploadDate": "2024-02-20",
      "expiryDate": "2024-08-20",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Prescription for essential medications",
      "prescribedBy": "Dr. Smith",
      "pharmacy": "City Pharmacy",
      "thumbnail": "https://picsum.photos/100/100?random=7&keyword=prescription",
    },
    {
      "id": 8,
      "name": "Emergency Contacts",
      "category": "Emergency",
      "type": "pdf",
      "size": "234 KB",
      "uploadDate": "2024-01-05",
      "expiryDate": null,
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Important contact information for emergencies",
      "lastUpdated": "2024-03-01",
      "contactCount": 8,
      "thumbnail": "https://picsum.photos/100/100?random=8&keyword=emergency",
    },
    {
      "id": 9,
      "name": "Travel Itinerary",
      "category": "Travel Documents",
      "type": "pdf",
      "size": "1.5 MB",
      "uploadDate": "2024-02-25",
      "expiryDate": "2024-06-25",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Detailed travel schedule and bookings",
      "tripDuration": "14 days",
      "destinations": 3,
      "thumbnail": "https://picsum.photos/100/100?random=9&keyword=itinerary",
    },
    {
      "id": 10,
      "name": "Car Insurance",
      "category": "Insurance",
      "type": "pdf",
      "size": "1.3 MB",
      "uploadDate": "2024-01-30",
      "expiryDate": "2025-01-30",
      "status": "Active",
      "isExpiringSoon": false,
      "description": "International car rental insurance",
      "policyNumber": "CI-2024-112233",
      "provider": "Auto Insurance Corp",
      "thumbnail": "https://picsum.photos/100/100?random=10&keyword=car",
    },
    {
      "id": 11,
      "name": "Bank Statements",
      "category": "Travel Documents",
      "type": "pdf",
      "size": "2.1 MB",
      "uploadDate": "2024-02-10",
      "expiryDate": null,
      "status": "Active",
      "isExpiringSoon": false,
      "description": "Financial proof for visa application",
      "statementPeriod": "6 months",
      "bankName": "First National Bank",
      "thumbnail": "https://picsum.photos/100/100?random=11&keyword=bank",
    },
    {
      "id": 12,
      "name": "Emergency Evacuation Insurance",
      "category": "Insurance",
      "type": "pdf",
      "size": "987 KB",
      "uploadDate": "2024-02-05",
      "expiryDate": "2024-12-31",
      "status": "Active",
      "isExpiringSoon": true,
      "description": "Emergency medical evacuation coverage",
      "policyNumber": "EEI-2024-445566",
      "coverage": "\$1,000,000",
      "thumbnail": "https://picsum.photos/100/100?random=12&keyword=evacuation",
    },
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    List<Map<String, dynamic>> filtered = documents;
    
    // Filter by category
    if (currentTab > 0) {
      String selectedCategory = documentCategories[currentTab]["name"];
      filtered = filtered.where((doc) => doc["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((doc) {
        return (doc["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (doc["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              _showUploadOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              children: [
                QTextField(
                  label: "Search documents",
                  value: searchQuery,
                  hint: "Enter document name or description",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: List.generate(documentCategories.length, (index) {
                    var category = documentCategories[index];
                    bool isSelected = currentTab == index;
                    
                    return GestureDetector(
                      onTap: () {
                        currentTab = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? category["color"] : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? category["color"] : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"],
                              size: 16,
                              color: isSelected ? Colors.white : category["color"],
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white.withAlpha(50) : category["color"].withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${category["count"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : category["color"],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredDocuments.length} documents",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Sort",
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    _showSortOptions();
                  },
                ),
              ],
            ),
          ),
          if (_getExpiringSoonDocuments().isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Documents Expiring Soon",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "${_getExpiringSoonDocuments().length} documents need renewal",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View",
                    size: bs.sm,
                    onPressed: () {
                      _showExpiringSoonDialog();
                    },
                  ),
                ],
              ),
            ),
          SizedBox(height: spSm),
          Expanded(
            child: filteredDocuments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No documents found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Upload your travel documents to get started",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Upload Document",
                          icon: Icons.cloud_upload,
                          size: bs.md,
                          onPressed: () {
                            _showUploadOptions();
                          },
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredDocuments.length,
                    itemBuilder: (context, index) {
                      return _buildDocumentItem(filteredDocuments[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUploadOptions();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDocumentItem(Map<String, dynamic> document) {
    bool isExpiringSoon = document["isExpiringSoon"] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isExpiringSoon ? warningColor : disabledOutlineBorderColor,
        ),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXs),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusXs),
              child: Image.network(
                "${document["thumbnail"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    _getDocumentIcon(document["type"]),
                    color: primaryColor,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${document["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isExpiringSoon)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Expiring",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${document["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${document["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.file_copy,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${document["size"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (document["expiryDate"] != null)
                    Padding(
                      padding: EdgeInsets.only(top: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 12,
                            color: isExpiringSoon ? warningColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Expires: ${document["expiryDate"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: isExpiringSoon ? warningColor : disabledBoldColor,
                              fontWeight: isExpiringSoon ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
              size: 20,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'view',
                child: Row(
                  children: [
                    Icon(Icons.visibility, size: 16),
                    SizedBox(width: spSm),
                    Text("View"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 16),
                    SizedBox(width: spSm),
                    Text("Download"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 16),
                    SizedBox(width: spSm),
                    Text("Share"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 16, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete", style: TextStyle(color: dangerColor)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              _handleDocumentAction(value, document);
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
    );
  }

  IconData _getDocumentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  List<Map<String, dynamic>> _getExpiringSoonDocuments() {
    return documents.where((doc) => doc["isExpiringSoon"] == true).toList();
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Upload Document",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ss("Camera selected");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ss("Gallery selected");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            color: secondaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ss("Files selected");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.folder,
                            color: successColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Files",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort Documents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text("Name (A-Z)"),
              onTap: () {
                Navigator.pop(context);
                ss("Sorted by name");
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Upload Date"),
              onTap: () {
                Navigator.pop(context);
                ss("Sorted by upload date");
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text("Expiry Date"),
              onTap: () {
                Navigator.pop(context);
                ss("Sorted by expiry date");
              },
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("File Size"),
              onTap: () {
                Navigator.pop(context);
                ss("Sorted by file size");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showExpiringSoonDialog() {
    List<Map<String, dynamic>> expiring = _getExpiringSoonDocuments();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Documents Expiring Soon"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: expiring.map((doc) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Expires: ${doc["expiryDate"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
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

  void _handleDocumentAction(String action, Map<String, dynamic> document) {
    switch (action) {
      case 'view':
        ss("Viewing ${document["name"]}");
        break;
      case 'download':
        ss("Downloading ${document["name"]}");
        break;
      case 'share':
        ss("Sharing ${document["name"]}");
        break;
      case 'delete':
        _deleteDocument(document);
        break;
    }
  }

  void _deleteDocument(Map<String, dynamic> document) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this document?");
    if (isConfirmed) {
      documents.removeWhere((doc) => doc["id"] == document["id"]);
      setState(() {});
      ss("Document deleted successfully");
    }
  }
}
