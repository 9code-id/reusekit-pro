import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmQuoteManagementView extends StatefulWidget {
  const CrmQuoteManagementView({super.key});

  @override
  State<CrmQuoteManagementView> createState() => _CrmQuoteManagementViewState();
}

class _CrmQuoteManagementViewState extends State<CrmQuoteManagementView> {
  String selectedStatus = "All";
  String selectedTemplate = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> quotes = [
    {
      "id": "QUO001",
      "number": "Q-2024-001",
      "title": "Enterprise Software License Quote",
      "client": "TechCorp Solutions",
      "contact": "John Smith",
      "amount": 85000.0,
      "status": "Sent",
      "validUntil": "2024-02-15",
      "createdDate": "2024-01-05",
      "template": "Standard",
      "items": 5,
      "discount": 10.0,
      "tax": 8.5,
      "avatar": "https://picsum.photos/50/50?random=1",
      "lastViewed": "2024-01-08 14:30",
      "viewCount": 3,
      "approved": true,
    },
    {
      "id": "QUO002",
      "number": "Q-2024-002",
      "title": "Cloud Migration Services",
      "client": "StartupHub Inc",
      "contact": "Emily Davis",
      "amount": 45000.0,
      "status": "Draft",
      "validUntil": "2024-02-20",
      "createdDate": "2024-01-07",
      "template": "Service",
      "items": 8,
      "discount": 5.0,
      "tax": 4.5,
      "avatar": "https://picsum.photos/50/50?random=2",
      "lastViewed": null,
      "viewCount": 0,
      "approved": false,
    },
    {
      "id": "QUO003",
      "number": "Q-2024-003",
      "title": "Security Audit Package",
      "client": "Financial Corp",
      "contact": "Robert Johnson",
      "amount": 32000.0,
      "status": "Accepted",
      "validUntil": "2024-02-10",
      "createdDate": "2024-01-03",
      "template": "Audit",
      "items": 4,
      "discount": 0.0,
      "tax": 3.2,
      "avatar": "https://picsum.photos/50/50?random=3",
      "lastViewed": "2024-01-09 10:15",
      "viewCount": 7,
      "approved": true,
    },
    {
      "id": "QUO004",
      "number": "Q-2024-004",
      "title": "Mobile App Development",
      "client": "Retail Masters",
      "contact": "Sarah Wilson",
      "amount": 68000.0,
      "status": "Expired",
      "validUntil": "2024-01-05",
      "createdDate": "2023-12-20",
      "template": "Development",
      "items": 12,
      "discount": 15.0,
      "tax": 6.8,
      "avatar": "https://picsum.photos/50/50?random=4",
      "lastViewed": "2024-01-02 16:45",
      "viewCount": 2,
      "approved": true,
    },
    {
      "id": "QUO005",
      "number": "Q-2024-005",
      "title": "Data Analytics Solution",
      "client": "Healthcare Innovations",
      "contact": "Dr. Michael Chen",
      "amount": 95000.0,
      "status": "Under Review",
      "validUntil": "2024-02-25",
      "createdDate": "2024-01-08",
      "template": "Analytics",
      "items": 7,
      "discount": 8.0,
      "tax": 9.5,
      "avatar": "https://picsum.photos/50/50?random=5",
      "lastViewed": "2024-01-09 09:30",
      "viewCount": 5,
      "approved": false,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Accepted", "value": "Accepted"},
    {"label": "Declined", "value": "Declined"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "All Templates", "value": "All"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Service", "value": "Service"},
    {"label": "Development", "value": "Development"},
    {"label": "Audit", "value": "Audit"},
    {"label": "Analytics", "value": "Analytics"},
  ];

  List<Map<String, dynamic>> get filteredQuotes {
    return quotes.where((quote) {
      bool matchesSearch = quote["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          quote["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          quote["number"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || quote["status"] == selectedStatus;
      bool matchesTemplate = selectedTemplate == "All" || quote["template"] == selectedTemplate;
      return matchesSearch && matchesStatus && matchesTemplate;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledBoldColor;
      case "Sent":
        return primaryColor;
      case "Under Review":
        return warningColor;
      case "Accepted":
        return successColor;
      case "Declined":
        return dangerColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Draft":
        return Icons.edit;
      case "Sent":
        return Icons.send;
      case "Under Review":
        return Icons.hourglass_empty;
      case "Accepted":
        return Icons.check_circle;
      case "Declined":
        return Icons.cancel;
      case "Expired":
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo create quote view
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreActions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                          "${filteredQuotes.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Quotes",
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
                          "\$${((filteredQuotes.fold(0.0, (sum, quote) => sum + (quote["amount"] as double))) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                          "${quotes.where((q) => q["status"] == "Accepted").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Accepted",
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

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search quotes...",
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

            // Filter Options
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
                    label: "Template",
                    items: templateOptions,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              width: double.infinity,
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "New Quote",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo create quote view
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Templates",
                          icon: Icons.library_books,
                          size: bs.sm,
                          onPressed: () {
                            _showTemplatesDialog();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export",
                          icon: Icons.file_download,
                          size: bs.sm,
                          onPressed: () {
                            ss("Quotes exported successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quote Status Overview
            Container(
              width: double.infinity,
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
                  Text(
                    "Status Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...statusOptions.where((s) => s["value"] != "All").map((status) => 
                    _buildStatusOverviewRow(status["value"], status["label"])
                  ),
                ],
              ),
            ),

            // Quotes List
            ...filteredQuotes.map((quote) => _buildQuoteCard(quote)),

            // Expiring Soon Section
            Container(
              width: double.infinity,
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
                  Text(
                    "Expiring Soon",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  ...quotes
                      .where((quote) => quote["status"] == "Sent" || quote["status"] == "Under Review")
                      .map((quote) => _buildExpiringQuoteCard(quote)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> quote) {
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
          // Header Row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${quote["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${quote["number"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${quote["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon("${quote["status"]}"),
                                size: 12,
                                color: _getStatusColor("${quote["status"]}"),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${quote["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor("${quote["status"]}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${quote["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${quote["client"]} • ${quote["contact"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(quote["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${quote["items"]} items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Quote Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Created",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${quote["createdDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                      "Valid Until",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${quote["validUntil"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: warningColor,
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
                      "Template",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${quote["template"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Financial Summary
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount: ${(quote["discount"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Tax: ${(quote["tax"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Views: ${quote["viewCount"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Last Viewed Info
          if (quote["lastViewed"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 14,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Last viewed: ${quote["lastViewed"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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
                  label: "View",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo quote detail view
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo edit quote view
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.content_copy,
                size: bs.sm,
                onPressed: () {
                  ss("Quote duplicated successfully");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  _showShareOptions(quote);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showQuoteActions(quote);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOverviewRow(String status, String label) {
    int count = quotes.where((quote) => quote["status"] == status).length;
    double total = quotes.length.toDouble();
    double percentage = count / total;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 60,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation(_getStatusColor(status)),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${(percentage * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(status),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiringQuoteCard(Map<String, dynamic> quote) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: dangerColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            size: 18,
            color: dangerColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${quote["number"]} - ${quote["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Expires: ${quote["validUntil"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Extend",
            size: bs.sm,
            onPressed: () {
              _showExtendQuoteDialog(quote);
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Filter Quotes"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setDialogState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Template",
                    items: templateOptions,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    selectedStatus = "All";
                    selectedTemplate = "All";
                    setDialogState(() {});
                  },
                  child: Text("Clear"),
                ),
                QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTemplatesDialog() {
    List<String> templates = ["Standard", "Service", "Development", "Audit", "Analytics"];
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quote Templates"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: templates.map((template) {
                return ListTile(
                  leading: Icon(Icons.description),
                  title: Text(template),
                  subtitle: Text("${template} quote template"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pop(context);
                    ss("Creating quote from $template template");
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showShareOptions(Map<String, dynamic> quote) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Share Quote"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Send via Email"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote sent via email");
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text("Copy Link"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote link copied to clipboard");
                },
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text("Download PDF"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote PDF downloaded");
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showQuoteActions(Map<String, dynamic> quote) {
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
                "${quote["number"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Quote"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo edit quote view
                },
              ),
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text("Duplicate Quote"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote duplicated successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.send),
                title: Text("Send to Client"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote sent to client");
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle),
                title: Text("Mark as Accepted"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote marked as accepted");
                },
              ),
              ListTile(
                leading: Icon(Icons.archive),
                title: Text("Archive Quote"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Quote archived successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Quote", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  Navigator.pop(context);
                  bool isConfirmed = await confirm("Are you sure you want to delete this quote?");
                  if (isConfirmed) {
                    ss("Quote deleted successfully");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExtendQuoteDialog(Map<String, dynamic> quote) {
    String newValidDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Extend Quote Validity"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Quote: ${quote["number"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              QDatePicker(
                label: "New Valid Until Date",
                value: DateTime.parse(newValidDate),
                onChanged: (value) {
                  newValidDate = value.toString().split(' ')[0];
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            QButton(
              label: "Extend",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Quote validity extended to $newValidDate");
              },
            ),
          ],
        );
      },
    );
  }

  void _showMoreActions() {
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
                "More Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text("Export All Quotes"),
                onTap: () {
                  Navigator.pop(context);
                  ss("All quotes exported successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Bulk Email Quotes"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo bulk email view
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Quote Settings"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo quote settings
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text("Quote Analytics"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo quote analytics
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
