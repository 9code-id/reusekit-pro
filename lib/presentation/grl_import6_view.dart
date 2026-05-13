import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport6View extends StatefulWidget {
  @override
  State<GrlImport6View> createState() => _GrlImport6ViewState();
}

class _GrlImport6ViewState extends State<GrlImport6View> {
  bool loading = false;
  String selectedImportType = "Bulk Data";
  
  List<Map<String, dynamic>> importHistory = [
    {
      "id": "IMP001",
      "type": "CSV Import",
      "filename": "customers_2024.csv",
      "status": "Completed",
      "records": 15420,
      "created_at": DateTime.now().subtract(Duration(hours: 2)),
      "duration": "2m 34s",
      "user": "admin@company.com",
      "errors": 0,
    },
    {
      "id": "IMP002", 
      "type": "Database Sync",
      "filename": "user_sync.sql",
      "status": "Failed",
      "records": 8900,
      "created_at": DateTime.now().subtract(Duration(hours: 5)),
      "duration": "1m 12s",
      "user": "john.doe@company.com",
      "errors": 23,
    },
    {
      "id": "IMP003",
      "type": "API Import",
      "filename": "products_api.json",
      "status": "Processing",
      "records": 3200,
      "created_at": DateTime.now().subtract(Duration(minutes: 15)),
      "duration": "ongoing",
      "user": "sarah.wilson@company.com",
      "errors": 0,
    },
    {
      "id": "IMP004",
      "type": "Excel Import",
      "filename": "inventory_update.xlsx",
      "status": "Completed",
      "records": 5670,
      "created_at": DateTime.now().subtract(Duration(days: 1)),
      "duration": "45s",
      "user": "mike.johnson@company.com",
      "errors": 2,
    },
    {
      "id": "IMP005",
      "type": "XML Import",
      "filename": "orders_export.xml",
      "status": "Cancelled",
      "records": 0,
      "created_at": DateTime.now().subtract(Duration(days: 2)),
      "duration": "N/A", 
      "user": "lisa.brown@company.com",
      "errors": 0,
    }
  ];

  List<Map<String, dynamic>> quickImportOptions = [
    {
      "title": "Bulk Data Import",
      "subtitle": "Import large datasets from CSV, Excel files",
      "icon": Icons.upload_file,
      "color": primaryColor,
      "type": "Bulk Data",
    },
    {
      "title": "Database Sync",
      "subtitle": "Synchronize data from external databases",
      "icon": Icons.sync,
      "color": successColor,
      "type": "Database",
    },
    {
      "title": "API Integration",
      "subtitle": "Import data from REST APIs and web services", 
      "icon": Icons.api,
      "color": infoColor,
      "type": "API",
    },
    {
      "title": "Real-time Stream",
      "subtitle": "Continuous data import from live sources",
      "icon": Icons.stream,
      "color": warningColor,
      "type": "Stream",
    }
  ];

  List<Map<String, dynamic>> recentTemplates = [
    {
      "name": "Customer Data Template",
      "fields": 12,
      "lastUsed": DateTime.now().subtract(Duration(days: 1)),
      "usage": 45,
    },
    {
      "name": "Product Inventory Template", 
      "fields": 8,
      "lastUsed": DateTime.now().subtract(Duration(days: 3)),
      "usage": 23,
    },
    {
      "name": "Sales Transaction Template",
      "fields": 15,
      "lastUsed": DateTime.now().subtract(Duration(days: 7)),
      "usage": 67,
    }
  ];

  void _retryImport(String importId) async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    // Update status
    final importIndex = importHistory.indexWhere((imp) => imp["id"] == importId);
    if (importIndex != -1) {
      importHistory[importIndex]["status"] = "Processing";
      importHistory[importIndex]["created_at"] = DateTime.now();
    }
    
    loading = false;
    setState(() {});
    
    si("Import $importId has been restarted");
  }

  void _cancelImport(String importId) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this import?");
    if (!isConfirmed) return;
    
    final importIndex = importHistory.indexWhere((imp) => imp["id"] == importId);
    if (importIndex != -1) {
      importHistory[importIndex]["status"] = "Cancelled";
    }
    setState(() {});
    
    sw("Import $importId has been cancelled");
  }

  void _viewImportDetails(Map<String, dynamic> importData) {
    si("Viewing details for ${importData["id"]}");
  }

  void _downloadImportLog(String importId) {
    ss("Import log for $importId downloaded successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Center"),
        actions: [
          Icon(
            Icons.cloud_download,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuickImportSection(),
                _buildActiveImportsSection(),
                _buildImportHistorySection(),
                _buildTemplatesSection(),
              ],
            ),
          ),
    );
  }

  Widget _buildQuickImportSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rocket_launch,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Quick Import",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickImportOptions.map((option) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (option["color"] as Color).withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (option["color"] as Color).withAlpha(100),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: option["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: option["color"] as Color,
                          size: 16,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${option["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: option["color"] as Color,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${option["subtitle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Import",
                        size: bs.sm,
                        onPressed: () {
                          selectedImportType = option["type"];
                          si("Starting ${option["title"]} import");
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveImportsSection() {
    final activeImports = importHistory.where((imp) => 
        imp["status"] == "Processing" || imp["status"] == "Queued").toList();
    
    if (activeImports.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 48,
            ),
            SizedBox(height: spSm),
            Text(
              "No Active Imports",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "All import operations have been completed",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pending_actions,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Active Imports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${activeImports.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ...activeImports.map((import) => _buildActiveImportCard(import)),
        ],
      ),
    );
  }

  Widget _buildActiveImportCard(Map<String, dynamic> import) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${import["filename"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${import["type"]} • ${import["records"]} records",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.cancel,
                size: bs.sm,
                onPressed: () => _cancelImport(import["id"]),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: 0.65,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(warningColor),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "65% Complete",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "ETA: 2m 15s",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImportHistorySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Import History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  si("Viewing all import history");
                },
              ),
            ],
          ),
          ...importHistory.take(5).map((import) => _buildImportHistoryCard(import)),
        ],
      ),
    );
  }

  Widget _buildImportHistoryCard(Map<String, dynamic> import) {
    Color statusColor = _getStatusColor(import["status"]);
    IconData statusIcon = _getStatusIcon(import["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${import["filename"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(import["created_at"] as DateTime).dMMMy}",
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
                    Text(
                      "${import["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(import["records"] as int).toString()} records",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ((import["errors"] as int) > 0) ...[
                      Text(
                        " • ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${import["errors"]} errors",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
              size: 16,
            ),
            onSelected: (value) {
              switch (value) {
                case 'details':
                  _viewImportDetails(import);
                  break;
                case 'retry':
                  _retryImport(import["id"]);
                  break;
                case 'log':
                  _downloadImportLog(import["id"]);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'details',
                child: Row(
                  children: [
                    Icon(Icons.info, size: 16),
                    SizedBox(width: spXs),
                    Text("View Details"),
                  ],
                ),
              ),
              if (import["status"] == "Failed")
                PopupMenuItem(
                  value: 'retry',
                  child: Row(
                    children: [
                      Icon(Icons.refresh, size: 16),
                      SizedBox(width: spXs),
                      Text("Retry Import"),
                    ],
                  ),
                ),
              PopupMenuItem(
                value: 'log',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 16),
                    SizedBox(width: spXs),
                    Text("Download Log"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Import Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Create New",
                size: bs.sm,
                onPressed: () {
                  si("Creating new import template");
                },
              ),
            ],
          ),
          ...recentTemplates.map((template) => _buildTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: secondaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: secondaryColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.description,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${template["fields"]} fields",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Used ${template["usage"]} times",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Use Template",
            size: bs.sm,
            onPressed: () {
              si("Using template: ${template["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed": return successColor;
      case "Failed": return dangerColor;
      case "Processing": return warningColor;
      case "Cancelled": return disabledBoldColor;
      default: return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Completed": return Icons.check_circle;
      case "Failed": return Icons.error;
      case "Processing": return Icons.hourglass_empty;
      case "Cancelled": return Icons.cancel;
      default: return Icons.upload;
    }
  }
}
