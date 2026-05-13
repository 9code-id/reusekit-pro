import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExport9View extends StatefulWidget {
  @override
  State<GrlExport9View> createState() => _GrlExport9ViewState();
}

class _GrlExport9ViewState extends State<GrlExport9View> {
  int currentTab = 0;
  String selectedFormat = "Excel";
  String selectedTemplate = "Customer Report";
  bool includeCharts = true;
  bool includeSummary = true;
  String reportTitle = "Data Export Report";
  String orientation = "Portrait";
  String pageSize = "A4";
  
  List<Map<String, dynamic>> formatOptions = [
    {"label": "Excel", "value": "Excel"},
    {"label": "PDF", "value": "PDF"},
    {"label": "Word", "value": "Word"},
    {"label": "PowerPoint", "value": "PowerPoint"},
  ];
  
  List<Map<String, dynamic>> templateOptions = [
    {"label": "Customer Report", "value": "Customer Report"},
    {"label": "Sales Analytics", "value": "Sales Analytics"},
    {"label": "Financial Summary", "value": "Financial Summary"},
    {"label": "Inventory Report", "value": "Inventory Report"},
    {"label": "Custom Template", "value": "Custom Template"},
  ];
  
  List<Map<String, dynamic>> orientationOptions = [
    {"label": "Portrait", "value": "Portrait"},
    {"label": "Landscape", "value": "Landscape"},
  ];
  
  List<Map<String, dynamic>> pageSizeOptions = [
    {"label": "A4", "value": "A4"},
    {"label": "A3", "value": "A3"},
    {"label": "Letter", "value": "Letter"},
    {"label": "Legal", "value": "Legal"},
  ];
  
  List<Map<String, dynamic>> reportData = [
    {
      "section": "Customer Overview",
      "type": "table",
      "data": [
        {"metric": "Total Customers", "value": "2,845", "change": "+12%"},
        {"metric": "Active Customers", "value": "2,156", "change": "+8%"},
        {"metric": "New Customers", "value": "189", "change": "+25%"},
        {"metric": "Retention Rate", "value": "87.5%", "change": "+3%"},
      ]
    },
    {
      "section": "Sales Performance",
      "type": "chart",
      "chartType": "line",
      "data": [
        {"month": "Jan", "sales": 85000, "target": 80000},
        {"month": "Feb", "sales": 92000, "target": 85000},
        {"month": "Mar", "sales": 88000, "target": 90000},
        {"month": "Apr", "sales": 95000, "target": 92000},
        {"month": "May", "sales": 103000, "target": 95000},
        {"month": "Jun", "sales": 110000, "target": 100000},
      ]
    },
    {
      "section": "Top Products",
      "type": "table",
      "data": [
        {"product": "Premium Package", "sales": 1250, "revenue": 125000},
        {"product": "Standard Package", "sales": 2100, "revenue": 168000},
        {"product": "Basic Package", "sales": 3200, "revenue": 96000},
        {"product": "Enterprise Plan", "sales": 450, "revenue": 225000},
      ]
    },
  ];
  
  Map<String, dynamic> previewData = {
    "isGenerating": false,
    "progress": 0.0,
    "currentSection": "",
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Report Generator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Setup", icon: Icon(Icons.settings)),
        Tab(text: "Data", icon: Icon(Icons.table_chart)),
        Tab(text: "Design", icon: Icon(Icons.palette)),
        Tab(text: "Preview", icon: Icon(Icons.preview)),
      ],
      tabChildren: [
        _buildSetupTab(),
        _buildDataTab(),
        _buildDesignTab(),
        _buildPreviewTab(),
      ],
    );
  }

  Widget _buildSetupTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFormatSelection(),
          _buildTemplateSelection(),
          _buildReportSettings(),
          _buildLayoutSettings(),
        ],
      ),
    );
  }

  Widget _buildFormatSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Output Format",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QCategoryPicker(
            label: "Select Format",
            items: formatOptions,
            value: selectedFormat,
            onChanged: (index, label, value, item) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          _buildFormatInfo(),
        ],
      ),
    );
  }

  Widget _buildFormatInfo() {
    Map<String, dynamic> formatInfo = {
      "Excel": {
        "description": "Spreadsheet format with multiple worksheets and formulas",
        "features": ["Interactive tables", "Charts", "Formulas", "Multiple sheets"],
        "icon": Icons.table_chart,
        "color": successColor
      },
      "PDF": {
        "description": "Portable document format with professional layout",
        "features": ["Fixed layout", "Print-ready", "Charts", "Professional design"],
        "icon": Icons.picture_as_pdf,
        "color": dangerColor
      },
      "Word": {
        "description": "Document format with editable content and formatting",
        "features": ["Editable text", "Tables", "Images", "Templates"],
        "icon": Icons.article,
        "color": primaryColor
      },
      "PowerPoint": {
        "description": "Presentation format with slides and visual elements",
        "features": ["Slide layouts", "Charts", "Images", "Animations"],
        "icon": Icons.slideshow,
        "color": warningColor
      },
    };
    
    var info = formatInfo[selectedFormat] ?? formatInfo["Excel"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (info["color"] as Color).withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (info["color"] as Color).withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(info["icon"], color: info["color"], size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  info["description"],
                  style: TextStyle(
                    fontSize: 12,
                    color: info["color"],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (info["features"] as List<String>).map((feature) => Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: (info["color"] as Color).withAlpha(100),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                feature,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Report Template",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Template",
            items: templateOptions,
            value: selectedTemplate,
            onChanged: (value, label) {
              selectedTemplate = value;
              setState(() {});
            },
          ),
          _buildTemplatePreview(),
        ],
      ),
    );
  }

  Widget _buildTemplatePreview() {
    Map<String, dynamic> templateInfo = {
      "Customer Report": {
        "sections": ["Customer Overview", "Demographics", "Activity Analysis"],
        "charts": 3,
        "tables": 2
      },
      "Sales Analytics": {
        "sections": ["Sales Performance", "Product Analysis", "Trends"],
        "charts": 5,
        "tables": 3
      },
      "Financial Summary": {
        "sections": ["Revenue", "Expenses", "Profit Analysis"],
        "charts": 4,
        "tables": 4
      },
      "Inventory Report": {
        "sections": ["Stock Levels", "Movement", "Forecasting"],
        "charts": 2,
        "tables": 5
      },
      "Custom Template": {
        "sections": ["Custom Sections"],
        "charts": 0,
        "tables": 0
      },
    };
    
    var info = templateInfo[selectedTemplate] ?? templateInfo["Customer Report"];
    
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "Template Preview",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${info["charts"]} charts, ${info["tables"]} tables",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (info["sections"] as List<String>).map((section) => Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                section,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Report Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Report Title",
            value: reportTitle,
            onChanged: (value) {
              reportTitle = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Charts",
                "value": "charts",
                "checked": includeCharts,
              },
              {
                "label": "Include Summary",
                "value": "summary",
                "checked": includeSummary,
              },
            ],
            value: [
              if (includeCharts)
                {
                  "label": "Include Charts",
                  "value": "charts",
                  "checked": true
                },
              if (includeSummary)
                {
                  "label": "Include Summary",
                  "value": "summary",
                  "checked": true
                },
            ],
            onChanged: (values, ids) {
              includeCharts = values.any((v) => v["value"] == "charts");
              includeSummary = values.any((v) => v["value"] == "summary");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.rotate_90_degrees_ccw, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Layout Settings",
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
                  label: "Orientation",
                  items: orientationOptions,
                  value: orientation,
                  onChanged: (value, label) {
                    orientation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Page Size",
                  items: pageSizeOptions,
                  value: pageSize,
                  onChanged: (value, label) {
                    pageSize = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDataSource(),
          ...reportData.map((section) => _buildDataSection(section)),
        ],
      ),
    );
  }

  Widget _buildDataSource() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(Icons.storage, color: primaryColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data Source",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Configure report data sources and connections",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Configure",
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _configureDataSource();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection(Map<String, dynamic> section) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                section["type"] == "chart" ? Icons.bar_chart : Icons.table_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${section["section"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: section["type"] == "chart" ? secondaryColor : infoColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${section["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (section["type"] == "table") _buildTablePreview(section["data"]),
          if (section["type"] == "chart") _buildChartPreview(section),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Edit Data",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _editSectionData(section);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _deleteSectionData(section);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTablePreview(List<dynamic> data) {
    List<Map<String, dynamic>> tableData = data.cast<Map<String, dynamic>>();
    
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "Preview (${tableData.length} rows)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...tableData.take(3).map((row) => Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: row.entries.map((entry) => Expanded(
                child: Text(
                  "${entry.value}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              )).toList(),
            ),
          )),
          if (tableData.length > 3)
            Text(
              "... and ${tableData.length - 3} more rows",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChartPreview(Map<String, dynamic> section) {
    List<Map<String, dynamic>> chartData = (section["data"] as List).cast<Map<String, dynamic>>();
    
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${section["chartType"]} Chart (${chartData.length} data points)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: chartData.map((point) {
                double height = ((point["sales"] as int) / 120000 * 80).toDouble();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: height,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${point["month"]}",
                      style: TextStyle(
                        fontSize: 8,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildThemeSettings(),
          _buildColorSettings(),
          _buildFontSettings(),
          _buildBrandingSettings(),
        ],
      ),
    );
  }

  Widget _buildThemeSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Theme & Style",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildThemeOptions(),
        ],
      ),
    );
  }

  Widget _buildThemeOptions() {
    List<Map<String, dynamic>> themes = [
      {"name": "Professional", "color": primaryColor, "selected": true},
      {"name": "Modern", "color": secondaryColor, "selected": false},
      {"name": "Minimal", "color": Colors.grey, "selected": false},
      {"name": "Vibrant", "color": warningColor, "selected": false},
    ];
    
    return Row(
      children: themes.map((theme) => Expanded(
        child: GestureDetector(
          onTap: () {
            for (var t in themes) {
              t["selected"] = false;
            }
            theme["selected"] = true;
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: theme["selected"] ? (theme["color"] as Color) : Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: theme["selected"] ? (theme["color"] as Color) : Colors.grey.withAlpha(100),
                width: theme["selected"] ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.palette,
                  color: theme["selected"] ? Colors.white : disabledBoldColor,
                  size: 16,
                ),
                SizedBox(height: 2),
                Text(
                  theme["name"],
                  style: TextStyle(
                    fontSize: 10,
                    color: theme["selected"] ? Colors.white : disabledBoldColor,
                    fontWeight: theme["selected"] ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildColorSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.color_lens, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Color Scheme",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildColorPalette(),
        ],
      ),
    );
  }

  Widget _buildColorPalette() {
    List<Color> colors = [
      primaryColor,
      secondaryColor,
      successColor,
      warningColor,
      dangerColor,
      infoColor,
    ];
    
    return Column(
      spacing: spXs,
      children: [
        Row(
          children: colors.map((color) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          )).toList(),
        ),
        Row(
          children: [
            QButton(
              label: "Primary",
              size: bs.sm,
              onPressed: () => _selectColor("Primary"),
            ),
            SizedBox(width: spXs),
            QButton(
              label: "Secondary",
              size: bs.sm,
              onPressed: () => _selectColor("Secondary"),
            ),
            SizedBox(width: spXs),
            QButton(
              label: "Accent",
              size: bs.sm,
              onPressed: () => _selectColor("Accent"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFontSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.font_download, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Typography",
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
                  label: "Header Font",
                  items: [
                    {"label": "Arial", "value": "Arial"},
                    {"label": "Helvetica", "value": "Helvetica"},
                    {"label": "Times New Roman", "value": "Times New Roman"},
                    {"label": "Roboto", "value": "Roboto"},
                  ],
                  value: "Arial",
                  onChanged: (value, label) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Body Font",
                  items: [
                    {"label": "Arial", "value": "Arial"},
                    {"label": "Helvetica", "value": "Helvetica"},
                    {"label": "Times New Roman", "value": "Times New Roman"},
                    {"label": "Roboto", "value": "Roboto"},
                  ],
                  value: "Arial",
                  onChanged: (value, label) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.business, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Branding",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QImagePicker(
            label: "Company Logo",
            value: "",
            hint: "Upload your company logo",
            onChanged: (value) {
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Company Name",
                  value: "",
                  hint: "Your Company Name",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Report Footer",
                  value: "",
                  hint: "Confidential - Internal Use Only",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPreviewHeader(),
          if (previewData["isGenerating"]) _buildGenerationProgress(),
          _buildReportPreview(),
          _buildExportControls(),
        ],
      ),
    );
  }

  Widget _buildPreviewHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.preview, color: primaryColor, size: 20),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Report Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$selectedFormat format • $selectedTemplate template",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Refresh",
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _refreshPreview();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenerationProgress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.sync, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Generating Report Preview",
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
              Text(
                "Current: ${previewData["currentSection"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(previewData["progress"] * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: previewData["progress"],
            backgroundColor: Colors.grey.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildReportPreview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          _buildPreviewTitle(),
          if (includeSummary) _buildPreviewSummary(),
          ...reportData.map((section) => _buildPreviewSection(section)),
        ],
      ),
    );
  }

  Widget _buildPreviewTitle() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reportTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Generated on ${DateTime.now().toString().split(' ')[0]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            "Executive Summary",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "This report provides a comprehensive overview of customer data, sales performance, and product analytics for the current period. Key metrics show positive growth trends across all major indicators.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection(Map<String, dynamic> section) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            "${section["section"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (section["type"] == "table" && includeCharts == false) 
            Text(
              "Table with ${(section["data"] as List).length} rows of data",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          if (section["type"] == "chart" && includeCharts) 
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Center(
                child: Text(
                  "${section["chartType"]} Chart Preview",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExportControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.play_arrow,
                  size: bs.md,
                  onPressed: () {
                    _generateReport();
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Save Template",
                icon: Icons.save,
                size: bs.md,
                onPressed: () {
                  _saveTemplate();
                },
              ),
            ],
          ),
          Row(
            children: [
              QButton(
                label: "Export to Email",
                icon: Icons.email,
                size: bs.sm,
                onPressed: () {
                  _exportToEmail();
                },
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Schedule Report",
                icon: Icons.schedule,
                size: bs.sm,
                onPressed: () {
                  _scheduleReport();
                },
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Share",
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  _shareReport();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _configureDataSource() {
    si("Data source configuration");
  }

  void _editSectionData(Map<String, dynamic> section) {
    si("Edit data for ${section["section"]}");
  }

  void _deleteSectionData(Map<String, dynamic> section) async {
    bool isConfirmed = await confirm("Remove ${section["section"]} from report?");
    if (isConfirmed) {
      reportData.remove(section);
      setState(() {});
      ss("Section removed from report");
    }
  }

  void _selectColor(String colorType) {
    si("$colorType color selection");
  }

  void _refreshPreview() {
    previewData = {
      "isGenerating": true,
      "progress": 0.0,
      "currentSection": "Initializing...",
    };
    setState(() {});
    
    List<String> sections = ["Loading data", "Generating charts", "Formatting layout", "Finalizing"];
    int currentIndex = 0;
    
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (currentIndex < sections.length) {
        previewData["currentSection"] = sections[currentIndex];
        previewData["progress"] = (currentIndex + 1) / sections.length;
        currentIndex++;
        setState(() {});
      } else {
        timer.cancel();
        previewData["isGenerating"] = false;
        setState(() {});
        ss("Preview refreshed successfully!");
      }
    });
  }

  void _generateReport() {
    previewData = {
      "isGenerating": true,
      "progress": 0.0,
      "currentSection": "Starting generation...",
    };
    setState(() {});
    
    List<String> steps = [
      "Processing data",
      "Creating charts",
      "Applying formatting",
      "Generating $selectedFormat file",
      "Finalizing report"
    ];
    int currentIndex = 0;
    
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentIndex < steps.length) {
        previewData["currentSection"] = steps[currentIndex];
        previewData["progress"] = (currentIndex + 1) / steps.length;
        currentIndex++;
        setState(() {});
      } else {
        timer.cancel();
        previewData["isGenerating"] = false;
        setState(() {});
        ss("Report generated successfully!");
      }
    });
  }

  void _saveTemplate() {
    ss("Report template saved successfully!");
  }

  void _exportToEmail() {
    si("Export to email functionality");
  }

  void _scheduleReport() {
    si("Schedule report functionality");
  }

  void _shareReport() {
    si("Share report functionality");
  }
}
