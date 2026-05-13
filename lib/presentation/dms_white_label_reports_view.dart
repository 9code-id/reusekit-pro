import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsWhiteLabelReportsView extends StatefulWidget {
  const DmsWhiteLabelReportsView({super.key});

  @override
  State<DmsWhiteLabelReportsView> createState() => _DmsWhiteLabelReportsViewState();
}

class _DmsWhiteLabelReportsViewState extends State<DmsWhiteLabelReportsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedTemplate = "All";
  String selectedFormat = "PDF";
  String selectedDateRange = "Last 30 Days";
  
  List<String> templates = ["All", "Sales Report", "Marketing Report", "Financial Report", "Custom Report"];
  List<String> formats = ["PDF", "Excel", "PowerPoint", "HTML"];
  List<String> dateRanges = ["Last 7 Days", "Last 30 Days", "Last 90 Days", "This Year", "Custom"];
  
  List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      "name": "Q4 Sales Performance Report",
      "template": "Sales Report",
      "client": "ABC Corporation",
      "status": "Generated",
      "format": "PDF",
      "dateRange": "Q4 2023",
      "generatedDate": "2024-01-15",
      "size": "2.4 MB",
      "downloads": 12,
      "customization": {
        "logo": "abc_corp_logo.png",
        "primaryColor": "#1565C0",
        "companyName": "ABC Corporation"
      }
    },
    {
      "id": 2,
      "name": "Marketing Campaign Analysis",
      "template": "Marketing Report",
      "client": "XYZ Marketing",
      "status": "Processing",
      "format": "Excel",
      "dateRange": "Last 30 Days",
      "generatedDate": "2024-01-14",
      "size": "1.8 MB",
      "downloads": 8,
      "customization": {
        "logo": "xyz_logo.png",
        "primaryColor": "#2E7D32",
        "companyName": "XYZ Marketing Solutions"
      }
    },
    {
      "id": 3,
      "name": "Financial Overview Dashboard",
      "template": "Financial Report",
      "client": "Finance Corp",
      "status": "Failed",
      "format": "PowerPoint",
      "dateRange": "Last 90 Days",
      "generatedDate": "2024-01-13",
      "size": "3.2 MB",
      "downloads": 3,
      "customization": {
        "logo": "finance_corp_logo.png",
        "primaryColor": "#D32F2F",
        "companyName": "Finance Corp Ltd"
      }
    }
  ];
  
  List<Map<String, dynamic>> reportTemplates = [
    {
      "id": 1,
      "name": "Executive Summary",
      "category": "Sales Report",
      "description": "High-level overview with key metrics",
      "preview": "https://picsum.photos/300/400?random=1&keyword=report",
      "sections": ["Overview", "Key Metrics", "Trends", "Recommendations"]
    },
    {
      "id": 2,
      "name": "Campaign Performance",
      "category": "Marketing Report",
      "description": "Detailed marketing campaign analysis",
      "preview": "https://picsum.photos/300/400?random=2&keyword=marketing",
      "sections": ["Campaign Overview", "ROI Analysis", "Audience Insights", "Recommendations"]
    },
    {
      "id": 3,
      "name": "Financial Statement",
      "category": "Financial Report",
      "description": "Comprehensive financial analysis",
      "preview": "https://picsum.photos/300/400?random=3&keyword=finance",
      "sections": ["Revenue", "Expenses", "Profit/Loss", "Forecasts"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("White Label Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateReportDialog();
            },
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: spLg),
                _buildFilters(),
                SizedBox(height: spLg),
                _buildReportsList(),
                SizedBox(height: spLg),
                _buildTemplatesLibrary(),
              ],
            ),
          ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "White Label Reports",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Generate branded reports with custom styling and client branding",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.description,
            size: 48,
            color: Colors.white.withAlpha(150),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: QTextField(
                label: "Search reports",
                value: searchQuery,
                hint: "Search by name or client",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Template",
                items: templates.map((template) => {
                  "label": template,
                  "value": template,
                }).toList(),
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Format",
                items: formats.map((format) => {
                  "label": format,
                  "value": format,
                }).toList(),
                value: selectedFormat,
                onChanged: (value, label) {
                  selectedFormat = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Date Range",
                items: dateRanges.map((range) => {
                  "label": range,
                  "value": range,
                }).toList(),
                value: selectedDateRange,
                onChanged: (value, label) {
                  selectedDateRange = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Generate Report",
              icon: Icons.auto_awesome,
              size: bs.md,
              onPressed: () {
                _showCreateReportDialog();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportsList() {
    var filteredReports = reports.where((report) {
      bool matchesSearch = report["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          report["client"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesTemplate = selectedTemplate == "All" || report["template"] == selectedTemplate;
      return matchesSearch && matchesTemplate;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Generated Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${filteredReports.length}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: filteredReports.map((report) {
            return _buildReportCard(report);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "Generated" 
        ? successColor 
        : report["status"] == "Processing" 
            ? warningColor 
            : dangerColor;

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
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.description,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${report["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${report["client"]} • ${report["template"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${report["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildInfoChip(Icons.calendar_today, "${report["dateRange"]}", disabledBoldColor),
              SizedBox(width: spSm),
              _buildInfoChip(Icons.insert_drive_file, "${report["format"]}", disabledBoldColor),
              SizedBox(width: spSm),
              _buildInfoChip(Icons.folder, "${report["size"]}", disabledBoldColor),
              SizedBox(width: spSm),
              _buildInfoChip(Icons.download, "${report["downloads"]}", disabledBoldColor),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(int.parse(report["customization"]["primaryColor"].substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${report["customization"]["companyName"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              if (report["status"] == "Generated") ...[
                Expanded(
                  child: QButton(
                    label: "Download",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      _downloadReport(report);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Preview",
                  size: bs.sm,
                  onPressed: () {
                    _previewReport(report);
                  },
                ),
                SizedBox(width: spSm),
              ] else if (report["status"] == "Processing") ...[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Processing...",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Regenerate",
                    icon: Icons.refresh,
                    size: bs.sm,
                    onPressed: () {
                      _regenerateReport(report);
                    },
                  ),
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showReportActions(report);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesLibrary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Report Templates",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: reportTemplates.map((template) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    child: Image.network(
                      "${template["preview"]}",
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Use Template",
                            size: bs.sm,
                            onPressed: () {
                              _useTemplate(template);
                            },
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
      ],
    );
  }

  void _showCreateReportDialog() {
    String reportName = "";
    String clientName = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Generate New Report"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Report Name",
              value: reportName,
              onChanged: (value) {
                reportName = value;
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Client Name",
              value: clientName,
              onChanged: (value) {
                clientName = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Generate",
            size: bs.sm,
            onPressed: () {
              if (reportName.isNotEmpty && clientName.isNotEmpty) {
                _generateReport(reportName, clientName);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _generateReport(String name, String client) {
    Map<String, dynamic> newReport = {
      "id": reports.length + 1,
      "name": name,
      "template": "Custom Report",
      "client": client,
      "status": "Processing",
      "format": selectedFormat,
      "dateRange": selectedDateRange,
      "generatedDate": DateTime.now().toString().substring(0, 10),
      "size": "0 MB",
      "downloads": 0,
      "customization": {
        "logo": "default_logo.png",
        "primaryColor": "#1976D2",
        "companyName": client
      }
    };
    
    reports.insert(0, newReport);
    setState(() {});
    ss("Report generation started for $client");
    
    Future.delayed(Duration(seconds: 3), () {
      newReport["status"] = "Generated";
      newReport["size"] = "${(2.0 + (reports.length * 0.3)).toStringAsFixed(1)} MB";
      setState(() {});
      ss("Report generated successfully");
    });
  }

  void _downloadReport(Map<String, dynamic> report) {
    report["downloads"] = (report["downloads"] as int) + 1;
    setState(() {});
    ss("Downloading ${report["name"]}");
  }

  void _previewReport(Map<String, dynamic> report) {
    ss("Opening preview for ${report["name"]}");
  }

  void _regenerateReport(Map<String, dynamic> report) {
    report["status"] = "Processing";
    setState(() {});
    ss("Regenerating ${report["name"]}");
    
    Future.delayed(Duration(seconds: 3), () {
      report["status"] = "Generated";
      setState(() {});
      ss("Report regenerated successfully");
    });
  }

  void _showReportActions(Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${report["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _customizeBranding(report);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.palette),
                    SizedBox(width: spSm),
                    Text("Customize Branding"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _shareReport(report);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: spSm),
                    Text("Share Report"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _deleteReport(report);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete Report", style: TextStyle(color: dangerColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _customizeBranding(Map<String, dynamic> report) {
    ss("Opening branding customization for ${report["name"]}");
  }

  void _shareReport(Map<String, dynamic> report) {
    ss("Sharing report: ${report["name"]}");
  }

  void _deleteReport(Map<String, dynamic> report) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this report?");
    if (isConfirmed) {
      reports.removeWhere((r) => r["id"] == report["id"]);
      setState(() {});
      ss("Report deleted successfully");
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    ss("Using template: ${template["name"]}");
    _showCreateReportDialog();
  }
}
