import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaExportDataView extends StatefulWidget {
  const CmaExportDataView({super.key});

  @override
  State<CmaExportDataView> createState() => _CmaExportDataViewState();
}

class _CmaExportDataViewState extends State<CmaExportDataView> {
  String selectedFormat = "Excel (.xlsx)";
  String selectedDataset = "All Data";
  String selectedDateRange = "Last 30 Days";
  String selectedCompression = "None";
  bool includeHeaders = true;
  bool includeMetadata = true;
  bool includeCharts = false;
  bool scheduleExport = false;
  String scheduledFrequency = "Weekly";
  String recipientEmail = "";
  bool loading = false;

  List<Map<String, dynamic>> exportFormats = [
    {
      "name": "Excel (.xlsx)",
      "description": "Microsoft Excel format with multiple sheets",
      "icon": Icons.table_chart,
      "size": "Medium",
      "compatibility": "High"
    },
    {
      "name": "CSV (.csv)",
      "description": "Comma-separated values, universal format",
      "icon": Icons.description,
      "size": "Small",
      "compatibility": "Very High"
    },
    {
      "name": "JSON (.json)",
      "description": "JavaScript Object Notation for APIs",
      "icon": Icons.code,
      "size": "Medium",
      "compatibility": "Medium"
    },
    {
      "name": "PDF (.pdf)",
      "description": "Portable Document Format with charts",
      "icon": Icons.picture_as_pdf,
      "size": "Large",
      "compatibility": "High"
    },
    {
      "name": "XML (.xml)",
      "description": "Extensible Markup Language structured data",
      "icon": Icons.code_off,
      "size": "Large",
      "compatibility": "Medium"
    }
  ];

  List<Map<String, dynamic>> datasets = [
    {
      "name": "All Data",
      "description": "Complete dataset with all available information",
      "records": 45230,
      "tables": 12,
      "size": "156 MB"
    },
    {
      "name": "Sales Data",
      "description": "Sales transactions, revenue, and customer information",
      "records": 18750,
      "tables": 5,
      "size": "62 MB"
    },
    {
      "name": "Financial Data",
      "description": "Financial metrics, budgets, and accounting records",
      "records": 8920,
      "tables": 4,
      "size": "28 MB"
    },
    {
      "name": "Customer Data",
      "description": "Customer profiles, preferences, and interaction history",
      "records": 12500,
      "tables": 3,
      "size": "41 MB"
    },
    {
      "name": "Operational Data",
      "description": "Operations metrics, performance, and system logs",
      "records": 5060,
      "tables": 2,
      "size": "25 MB"
    }
  ];

  List<Map<String, dynamic>> recentExports = [
    {
      "filename": "sales_data_2024_Q4.xlsx",
      "format": "Excel",
      "size": "2.4 MB",
      "date": "2024-01-15 14:30",
      "status": "Completed",
      "downloads": 3
    },
    {
      "filename": "customer_analysis.pdf",
      "format": "PDF",
      "size": "5.7 MB",
      "date": "2024-01-14 09:15",
      "status": "Completed",
      "downloads": 1
    },
    {
      "filename": "financial_report.csv",
      "format": "CSV",
      "size": "892 KB",
      "date": "2024-01-13 16:45",
      "status": "Completed",
      "downloads": 7
    },
    {
      "filename": "operational_metrics.json",
      "format": "JSON",
      "size": "1.2 MB",
      "date": "2024-01-12 11:20",
      "status": "Processing",
      "downloads": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showExportHistory,
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showExportGuide,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildExportSummary(),
                  _buildFormatSelection(),
                  _buildDatasetSelection(),
                  _buildExportOptions(),
                  _buildScheduleOptions(),
                  _buildExportButton(),
                  _buildRecentExports(),
                ],
              ),
            ),
    );
  }

  Widget _buildExportSummary() {
    Map<String, dynamic> selectedDatasetInfo = datasets.firstWhere((d) => d["name"] == selectedDataset);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.download, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Export Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Format", selectedFormat, Icons.file_copy),
              ),
              Expanded(
                child: _buildSummaryItem("Dataset", selectedDataset, Icons.storage),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Records", "${selectedDatasetInfo["records"]}", Icons.list),
              ),
              Expanded(
                child: _buildSummaryItem("Est. Size", "${selectedDatasetInfo["size"]}", Icons.folder),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormatSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.file_download, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Export Format",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...exportFormats.map((format) => _buildFormatOption(format)),
        ],
      ),
    );
  }

  Widget _buildFormatOption(Map<String, dynamic> format) {
    bool isSelected = format["name"] == selectedFormat;

    return GestureDetector(
      onTap: () {
        selectedFormat = format["name"] as String;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                format["icon"] as IconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${format["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${format["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isSelected ? primaryColor : disabledBoldColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${format["size"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  "${format["compatibility"]} Compatibility",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatasetSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.dataset, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Select Dataset",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Dataset",
            items: datasets.map((d) => {"label": d["name"], "value": d["name"]}).toList(),
            value: selectedDataset,
            onChanged: (value, label) {
              selectedDataset = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Date Range",
            items: [
              {"label": "Last 7 Days", "value": "Last 7 Days"},
              {"label": "Last 30 Days", "value": "Last 30 Days"},
              {"label": "Last 3 Months", "value": "Last 3 Months"},
              {"label": "Last 6 Months", "value": "Last 6 Months"},
              {"label": "Last Year", "value": "Last Year"},
              {"label": "All Time", "value": "All Time"},
              {"label": "Custom Range", "value": "Custom Range"}
            ],
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),
          _buildDatasetPreview(),
        ],
      ),
    );
  }

  Widget _buildDatasetPreview() {
    Map<String, dynamic> selectedDatasetInfo = datasets.firstWhere((d) => d["name"] == selectedDataset);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Dataset Information",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "${selectedDatasetInfo["description"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Records: ${selectedDatasetInfo["records"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Tables: ${selectedDatasetInfo["tables"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Size: ${selectedDatasetInfo["size"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Export Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Include Column Headers",
                "value": "headers",
                "checked": includeHeaders,
              }
            ],
            value: includeHeaders ? [{"label": "Include Column Headers", "value": "headers", "checked": true}] : [],
            onChanged: (values, ids) {
              includeHeaders = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Metadata",
                "value": "metadata",
                "checked": includeMetadata,
              }
            ],
            value: includeMetadata ? [{"label": "Include Metadata", "value": "metadata", "checked": true}] : [],
            onChanged: (values, ids) {
              includeMetadata = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Charts & Visualizations",
                "value": "charts",
                "checked": includeCharts,
              }
            ],
            value: includeCharts ? [{"label": "Include Charts & Visualizations", "value": "charts", "checked": true}] : [],
            onChanged: (values, ids) {
              includeCharts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Compression",
            items: [
              {"label": "None", "value": "None"},
              {"label": "ZIP Compression", "value": "ZIP"},
              {"label": "GZIP Compression", "value": "GZIP"},
              {"label": "RAR Compression", "value": "RAR"}
            ],
            value: selectedCompression,
            onChanged: (value, label) {
              selectedCompression = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Schedule Export",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Scheduled Export",
                "value": "schedule",
                "checked": scheduleExport,
              }
            ],
            value: scheduleExport ? [{"label": "Enable Scheduled Export", "value": "schedule", "checked": true}] : [],
            onChanged: (values, ids) {
              scheduleExport = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (scheduleExport) ...[
            QDropdownField(
              label: "Frequency",
              items: [
                {"label": "Daily", "value": "Daily"},
                {"label": "Weekly", "value": "Weekly"},
                {"label": "Monthly", "value": "Monthly"},
                {"label": "Quarterly", "value": "Quarterly"}
              ],
              value: scheduledFrequency,
              onChanged: (value, label) {
                scheduledFrequency = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Email Recipient",
              value: recipientEmail,
              hint: "Enter email address for scheduled exports",
              onChanged: (value) {
                recipientEmail = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: scheduleExport ? "Schedule Export" : "Export Now",
        icon: scheduleExport ? Icons.schedule_send : Icons.download,
        size: bs.md,
        onPressed: _startExport,
      ),
    );
  }

  Widget _buildRecentExports() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Recent Exports",
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
                onPressed: _showExportHistory,
              ),
            ],
          ),
          ...recentExports.take(3).map((export) => _buildExportItem(export)),
        ],
      ),
    );
  }

  Widget _buildExportItem(Map<String, dynamic> export) {
    Color statusColor = export["status"] == "Completed" ? successColor :
                       export["status"] == "Processing" ? warningColor : dangerColor;
    IconData statusIcon = export["status"] == "Completed" ? Icons.check_circle :
                         export["status"] == "Processing" ? Icons.schedule : Icons.error;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${export["filename"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${export["format"]} • ${export["size"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${export["date"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (export["status"] == "Completed") ...[
            SizedBox(width: spSm),
            Row(
              children: [
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () => _downloadExport(export["filename"] as String),
                ),
                SizedBox(width: spXs),
                Text(
                  "${export["downloads"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _startExport() async {
    loading = true;
    setState(() {});

    // Simulate export process
    await Future.delayed(Duration(seconds: 3));

    loading = false;
    setState(() {});

    if (scheduleExport) {
      ss("Export scheduled successfully! You will receive notifications at $recipientEmail");
    } else {
      ss("Export completed! Download will start automatically");
      // Simulate download
      await Future.delayed(Duration(seconds: 1));
      si("File downloaded: ${selectedDataset.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.${selectedFormat.split('.').last.replaceAll(')', '')}");
    }
  }

  void _downloadExport(String filename) {
    si("Downloading $filename...");
  }

  void _showExportHistory() {
    si("Opening export history...");
  }

  void _showExportGuide() {
    si("Opening export guide...");
  }
}
