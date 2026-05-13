import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPrintView extends StatefulWidget {
  const RmaPrintView({super.key});

  @override
  State<RmaPrintView> createState() => _RmaPrintViewState();
}

class _RmaPrintViewState extends State<RmaPrintView> {
  String selectedDocument = "Property Listing";
  String paperSize = "A4";
  String orientation = "Portrait";
  String quality = "High";
  bool includeImages = true;
  bool includeWatermark = false;
  bool includeFooter = true;
  bool colorPrint = true;
  int copies = 1;
  String printerName = "Default Printer";
  
  List<String> documentTypes = [
    "Property Listing",
    "Market Report",
    "Investment Analysis",
    "Contract Document",
    "Property Brochure",
    "Floor Plans",
    "Price History",
    "Neighborhood Guide",
    "Mortgage Calculator Results",
    "Property Comparison"
  ];
  
  List<String> paperSizes = ["A4", "A3", "Letter", "Legal", "Tabloid"];
  List<String> orientations = ["Portrait", "Landscape"];
  List<String> qualities = ["Draft", "Normal", "High", "Best"];
  List<String> printers = ["Default Printer", "HP LaserJet Pro", "Canon Pixma", "Epson EcoTank"];

  List<Map<String, dynamic>> printHistory = [
    {
      "id": 1,
      "document": "Luxury Villa Brochure",
      "type": "Property Brochure",
      "pages": 8,
      "copies": 5,
      "date": "2024-03-15 10:30 AM",
      "status": "Completed",
      "printer": "HP LaserJet Pro",
      "cost": 2.40
    },
    {
      "id": 2,
      "document": "Q1 Market Analysis Report",
      "type": "Market Report",
      "pages": 15,
      "copies": 3,
      "date": "2024-03-12 02:15 PM",
      "status": "Completed",
      "printer": "Canon Pixma",
      "cost": 4.50
    },
    {
      "id": 3,
      "document": "Investment Property ROI",
      "type": "Investment Analysis",
      "pages": 6,
      "copies": 2,
      "date": "2024-03-10 09:45 AM",
      "status": "Failed",
      "printer": "Default Printer",
      "cost": 0.00
    },
    {
      "id": 4,
      "document": "Downtown Condo Listing",
      "type": "Property Listing",
      "pages": 4,
      "copies": 10,
      "date": "2024-03-08 04:20 PM",
      "status": "Completed",
      "printer": "Epson EcoTank",
      "cost": 3.20
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Print Documents"),
        actions: [
          GestureDetector(
            onTap: () {
              _viewPrintQueue();
            },
            child: Icon(Icons.print_outlined),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildHeaderSection(),
            _buildPrintSettings(),
            _buildPreviewSection(),
            _buildPrintHistory(),
            _buildPrinterStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.print,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Print Center",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Print professional real estate documents with customizable options",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
          Row(
            children: [
              _buildStatCard("${printHistory.length}", "Printed"),
              SizedBox(width: spMd),
              _buildStatCard("${printHistory.fold(0, (sum, item) => sum + (item["pages"] as int))}", "Pages"),
              SizedBox(width: spMd),
              _buildStatCard("\$${printHistory.fold(0.0, (sum, item) => sum + (item["cost"] as double)).toStringAsFixed(2)}", "Cost"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrintSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Print Settings",
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
                child: QDropdownField(
                  label: "Document Type",
                  items: documentTypes.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: selectedDocument,
                  onChanged: (value, label) {
                    selectedDocument = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Printer",
                  items: printers.map((printer) => {
                    "label": printer,
                    "value": printer,
                  }).toList(),
                  value: printerName,
                  onChanged: (value, label) {
                    printerName = value;
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
                  label: "Paper Size",
                  items: paperSizes.map((size) => {
                    "label": size,
                    "value": size,
                  }).toList(),
                  value: paperSize,
                  onChanged: (value, label) {
                    paperSize = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Orientation",
                  items: orientations.map((orientation) => {
                    "label": orientation,
                    "value": orientation,
                  }).toList(),
                  value: orientation,
                  onChanged: (value, label) {
                    orientation = value;
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
                  label: "Quality",
                  items: qualities.map((quality) => {
                    "label": quality,
                    "value": quality,
                  }).toList(),
                  value: quality,
                  onChanged: (value, label) {
                    quality = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Copies",
                  value: copies.toString(),
                  onChanged: (value) {
                    copies = int.tryParse(value) ?? 1;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: [
              _buildPrintOption(
                "Include Images",
                "Print high-quality property images",
                includeImages,
                Icons.image,
                (value) {
                  includeImages = value;
                  setState(() {});
                },
              ),
              _buildPrintOption(
                "Color Printing",
                "Print in full color (additional cost)",
                colorPrint,
                Icons.palette,
                (value) {
                  colorPrint = value;
                  setState(() {});
                },
              ),
              _buildPrintOption(
                "Include Watermark",
                "Add company watermark to pages",
                includeWatermark,
                Icons.water_drop,
                (value) {
                  includeWatermark = value;
                  setState(() {});
                },
              ),
              _buildPrintOption(
                "Include Footer",
                "Add page numbers and contact info",
                includeFooter,
                Icons.text_fields,
                (value) {
                  includeFooter = value;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Preview",
                  size: bs.md,
                  icon: Icons.preview,
                  onPressed: () {
                    _previewDocument();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Print Now",
                  size: bs.md,
                  icon: Icons.print,
                  onPressed: () {
                    _printDocument();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrintOption(
    String title,
    String description,
    bool value,
    IconData icon,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: value ? primaryColor.withAlpha(15) : Colors.grey.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: value ? primaryColor.withAlpha(80) : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: value ? primaryColor.withAlpha(25) : disabledColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                icon,
                color: value ? primaryColor : disabledBoldColor,
                size: 16,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: value ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.preview,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Print Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description,
                  color: disabledBoldColor,
                  size: 48,
                ),
                SizedBox(height: spSm),
                Text(
                  "$selectedDocument Preview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "$paperSize • $orientation • $quality Quality",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Estimated cost: \$${_calculatePrintCost().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildPreviewInfo(Icons.pages, "Estimated Pages", "8"),
              SizedBox(width: spMd),
              _buildPreviewInfo(Icons.print, "Copies", "$copies"),
              SizedBox(width: spMd),
              _buildPreviewInfo(Icons.schedule, "Print Time", "~2 min"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewInfo(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: infoColor.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: infoColor,
              size: 20,
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: infoColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: infoColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrintHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Print History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _viewAllPrintJobs();
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: List.generate(printHistory.length, (index) {
              final job = printHistory[index];
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(job["status"]).withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(job["status"]).withAlpha(80),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(job["status"]).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        _getStatusIcon(job["status"]),
                        color: _getStatusColor(job["status"]),
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                            "${job["document"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              _buildJobInfo(Icons.pages, "${job["pages"]} pages"),
                              SizedBox(width: spSm),
                              _buildJobInfo(Icons.content_copy, "${job["copies"]} copies"),
                              SizedBox(width: spSm),
                              _buildJobInfo(Icons.attach_money, "\$${(job["cost"] as double).toStringAsFixed(2)}"),
                            ],
                          ),
                          Text(
                            "${job["printer"]} • ${job["date"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(job["status"]),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildJobInfo(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: disabledBoldColor,
            size: 10,
          ),
          SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = _getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPrinterStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.print_outlined,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Printer Status",
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
                child: _buildStatusCard("Ready", "Printer is online and ready", successColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusCard("85%", "Ink/Toner level", warningColor, Icons.opacity),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard("50", "Sheets remaining", infoColor, Icons.description),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusCard("0", "Jobs in queue", primaryColor, Icons.queue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Printing":
        return warningColor;
      case "Queued":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "Failed":
        return Icons.error;
      case "Printing":
        return Icons.print;
      case "Queued":
        return Icons.queue;
      default:
        return Icons.help;
    }
  }

  double _calculatePrintCost() {
    double baseCost = 0.30; // Base cost per page
    if (colorPrint) baseCost += 0.20;
    if (quality == "High") baseCost += 0.10;
    if (quality == "Best") baseCost += 0.20;
    
    int estimatedPages = 8; // Estimate based on document type
    return baseCost * estimatedPages * copies;
  }

  void _previewDocument() {
    ss("Generating print preview");
  }

  void _printDocument() {
    if (selectedDocument.isEmpty) {
      se("Please select a document to print");
      return;
    }
    
    ss("Print job submitted successfully");
  }

  void _viewPrintQueue() {
    ss("Opening print queue");
  }

  void _viewAllPrintJobs() {
    ss("Opening all print jobs");
  }
}
