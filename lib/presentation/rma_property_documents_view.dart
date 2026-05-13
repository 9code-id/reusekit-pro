import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPropertyDocumentsView extends StatefulWidget {
  const RmaPropertyDocumentsView({super.key});

  @override
  State<RmaPropertyDocumentsView> createState() => _RmaPropertyDocumentsViewState();
}

class _RmaPropertyDocumentsViewState extends State<RmaPropertyDocumentsView> {
  String selectedProperty = "sunset_villa";
  String selectedCategory = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> propertyOptions = [
    {"label": "Sunset Villa", "value": "sunset_villa"},
    {"label": "Ocean View Condo", "value": "ocean_view"},
    {"label": "Downtown Loft", "value": "downtown_loft"},
    {"label": "Garden House", "value": "garden_house"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Legal Documents", "value": "legal"},
    {"label": "Property Records", "value": "records"},
    {"label": "Marketing Materials", "value": "marketing"},
    {"label": "Financial Documents", "value": "financial"},
    {"label": "Maintenance Records", "value": "maintenance"},
    {"label": "Insurance Documents", "value": "insurance"},
  ];

  Map<String, dynamic> propertyDetails = {
    "sunset_villa": {
      "name": "Sunset Villa",
      "address": "123 Sunset Blvd, Beverly Hills, CA 90210",
      "type": "Single Family Home",
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2850,
      "yearBuilt": 1995,
      "lotSize": "0.5 acres",
      "listingPrice": 1250000,
      "status": "Active",
      "agent": "Michael Johnson",
      "documents": [
        {
          "id": "1",
          "name": "Property Deed",
          "category": "legal",
          "type": "PDF",
          "size": "1.2 MB",
          "dateAdded": "2024-01-05",
          "lastModified": "2024-01-05",
          "uploadedBy": "Title Company",
          "isRequired": true,
          "isPublic": false,
          "tags": ["deed", "ownership", "legal"],
          "description": "Official property deed showing ownership transfer",
        },
        {
          "id": "2",
          "name": "Property Survey",
          "category": "records",
          "type": "PDF",
          "size": "3.8 MB",
          "dateAdded": "2024-01-06",
          "lastModified": "2024-01-06",
          "uploadedBy": "Surveyor Inc.",
          "isRequired": true,
          "isPublic": false,
          "tags": ["survey", "boundaries", "measurements"],
          "description": "Professional land survey with boundary markers",
        },
        {
          "id": "3",
          "name": "Property Disclosure Statement",
          "category": "legal",
          "type": "PDF",
          "size": "2.1 MB",
          "dateAdded": "2024-01-03",
          "lastModified": "2024-01-10",
          "uploadedBy": "Property Owner",
          "isRequired": true,
          "isPublic": true,
          "tags": ["disclosure", "condition", "seller"],
          "description": "Seller's disclosure of property condition and known issues",
        },
        {
          "id": "4",
          "name": "Professional Photography",
          "category": "marketing",
          "type": "ZIP",
          "size": "45.2 MB",
          "dateAdded": "2024-01-08",
          "lastModified": "2024-01-08",
          "uploadedBy": "Pro Photos LLC",
          "isRequired": false,
          "isPublic": true,
          "tags": ["photos", "marketing", "listing"],
          "description": "High-resolution interior and exterior photos",
        },
        {
          "id": "5",
          "name": "Property Tax Records",
          "category": "financial",
          "type": "PDF",
          "size": "0.8 MB",
          "dateAdded": "2024-01-07",
          "lastModified": "2024-01-07",
          "uploadedBy": "County Assessor",
          "isRequired": true,
          "isPublic": true,
          "tags": ["taxes", "assessment", "financial"],
          "description": "Current and historical property tax information",
        },
        {
          "id": "6",
          "name": "HOA Documents",
          "category": "legal",
          "type": "PDF",
          "size": "1.5 MB",
          "dateAdded": "2024-01-09",
          "lastModified": "2024-01-09",
          "uploadedBy": "HOA Management",
          "isRequired": true,
          "isPublic": false,
          "tags": ["hoa", "bylaws", "covenants"],
          "description": "Homeowners association rules and financial statements",
        },
        {
          "id": "7",
          "name": "HVAC Maintenance Records",
          "category": "maintenance",
          "type": "PDF",
          "size": "1.1 MB",
          "dateAdded": "2024-01-12",
          "lastModified": "2024-01-12",
          "uploadedBy": "HVAC Pro Services",
          "isRequired": false,
          "isPublic": false,
          "tags": ["hvac", "maintenance", "service"],
          "description": "Complete HVAC system maintenance and repair history",
        },
        {
          "id": "8",
          "name": "Home Insurance Policy",
          "category": "insurance",
          "type": "PDF",
          "size": "0.9 MB",
          "dateAdded": "2024-01-15",
          "lastModified": "2024-01-15",
          "uploadedBy": "Insurance Agent",
          "isRequired": true,
          "isPublic": false,
          "tags": ["insurance", "coverage", "policy"],
          "description": "Current homeowner's insurance policy details",
        },
        {
          "id": "9",
          "name": "Virtual Tour Files",
          "category": "marketing",
          "type": "ZIP",
          "size": "125.7 MB",
          "dateAdded": "2024-01-20",
          "lastModified": "2024-01-20",
          "uploadedBy": "Virtual Tour Co.",
          "isRequired": false,
          "isPublic": true,
          "tags": ["virtual_tour", "3d", "marketing"],
          "description": "Interactive 3D virtual tour of the property",
        },
        {
          "id": "10",
          "name": "Utility Bills History",
          "category": "financial",
          "type": "PDF",
          "size": "0.6 MB",
          "dateAdded": "2024-01-18",
          "lastModified": "2024-01-18",
          "uploadedBy": "Property Owner",
          "isRequired": false,
          "isPublic": false,
          "tags": ["utilities", "costs", "history"],
          "description": "12 months of utility bills showing average costs",
        },
        {
          "id": "11",
          "name": "Roof Inspection Report",
          "category": "maintenance",
          "type": "PDF",
          "size": "2.3 MB",
          "dateAdded": "2024-01-22",
          "lastModified": "2024-01-22",
          "uploadedBy": "Roof Experts Inc.",
          "isRequired": false,
          "isPublic": false,
          "tags": ["roof", "inspection", "condition"],
          "description": "Professional roof condition assessment and recommendations",
        },
        {
          "id": "12",
          "name": "Property Marketing Flyer",
          "category": "marketing",
          "type": "PDF",
          "size": "1.4 MB",
          "dateAdded": "2024-01-25",
          "lastModified": "2024-01-28",
          "uploadedBy": "Michael Johnson",
          "isRequired": false,
          "isPublic": true,
          "tags": ["flyer", "marketing", "listing"],
          "description": "Professional property marketing flyer with key features",
        },
      ],
    },
  };

  List<Map<String, dynamic>> get currentPropertyDocuments {
    if (!propertyDetails.containsKey(selectedProperty)) return [];
    
    List<Map<String, dynamic>> docs = List<Map<String, dynamic>>.from(
      propertyDetails[selectedProperty]["documents"] ?? []
    );
    
    return docs.where((doc) {
      bool matchesCategory = selectedCategory == "all" || doc["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          "${doc["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${doc["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doc["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Map<String, dynamic> get currentProperty {
    return propertyDetails[selectedProperty] ?? {};
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "legal":
        return dangerColor;
      case "records":
        return infoColor;
      case "marketing":
        return successColor;
      case "financial":
        return warningColor;
      case "maintenance":
        return primaryColor;
      case "insurance":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "legal":
        return "Legal";
      case "records":
        return "Records";
      case "marketing":
        return "Marketing";
      case "financial":
        return "Financial";
      case "maintenance":
        return "Maintenance";
      case "insurance":
        return "Insurance";
      default:
        return "Other";
    }
  }

  IconData _getDocumentIcon(String type) {
    switch (type.toLowerCase()) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "doc":
      case "docx":
        return Icons.description;
      case "xls":
      case "xlsx":
        return Icons.table_chart;
      case "zip":
        return Icons.archive;
      case "img":
      case "jpg":
      case "png":
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedDocuments = currentPropertyDocuments;
    Map<String, dynamic> property = currentProperty;

    return Scaffold(
      appBar: AppBar(
        title: Text("Property Documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Selection
            QDropdownField(
              label: "Select Property",
              items: propertyOptions,
              value: selectedProperty,
              onChanged: (value, label) {
                selectedProperty = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Property Overview
            if (property.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${property["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Property Stats
                    QHorizontalScroll(
                      children: [
                        _buildPropertyStat("Type", "${property["type"]}"),
                        _buildPropertyStat("Bedrooms", "${property["bedrooms"]}"),
                        _buildPropertyStat("Bathrooms", "${property["bathrooms"]}"),
                        _buildPropertyStat("Sq Ft", "${property["sqft"]}"),
                        _buildPropertyStat("Year Built", "${property["yearBuilt"]}"),
                        _buildPropertyStat("Lot Size", "${property["lotSize"]}"),
                      ],
                    ),

                    SizedBox(height: spMd),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Listing Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((property["listingPrice"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${property["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),
            ],

            // Document Statistics
            QHorizontalScroll(
              children: [
                _buildDocumentStat(
                  "Total Documents",
                  "${displayedDocuments.length}",
                  Icons.folder,
                  primaryColor,
                ),
                _buildDocumentStat(
                  "Required",
                  "${displayedDocuments.where((d) => d["isRequired"] == true).length}",
                  Icons.star,
                  dangerColor,
                ),
                _buildDocumentStat(
                  "Public",
                  "${displayedDocuments.where((d) => d["isPublic"] == true).length}",
                  Icons.public,
                  successColor,
                ),
                _buildDocumentStat(
                  "Private",
                  "${displayedDocuments.where((d) => d["isPublic"] == false).length}",
                  Icons.lock,
                  warningColor,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Search and Filter
            Text(
              "Document Search & Filter",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QTextField(
              label: "Search documents...",
              value: searchQuery,
              hint: "Name, description, or tags",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            QDropdownField(
              label: "Document Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Documents List
            Text(
              "Property Documents (${displayedDocuments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...displayedDocuments.map((document) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getCategoryColor("${document["category"]}"),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Icon(
                          _getDocumentIcon("${document["type"]}"),
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${document["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (document["isRequired"] == true)
                                    Container(
                                      margin: EdgeInsets.only(left: spXs),
                                      child: Icon(
                                        Icons.star,
                                        color: dangerColor,
                                        size: 16,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${document["size"]} • ${document["type"]} • Added ${document["dateAdded"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor("${document["category"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                _getCategoryLabel("${document["category"]}"),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getCategoryColor("${document["category"]}"),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: document["isPublic"] == true 
                                    ? successColor.withAlpha(20)
                                    : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                document["isPublic"] == true ? "PUBLIC" : "PRIVATE",
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: document["isPublic"] == true 
                                      ? successColor
                                      : warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Description
                    Text(
                      "${document["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Document Info
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Uploaded by ${document["uploadedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "Modified: ${document["lastModified"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Tags
                    if ((document["tags"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (document["tags"] as List).map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Document",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.edit,
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
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyStat(String label, String value) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentStat(String title, String value, IconData icon, Color color) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
