import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile4View extends StatefulWidget {
  @override
  State<GrlFile4View> createState() => _GrlFile4ViewState();
}

class _GrlFile4ViewState extends State<GrlFile4View> {
  String fileName = "";
  String fileType = "document";
  String description = "";
  String tags = "";
  bool isPublic = true;
  String selectedCategory = "Documents";
  DateTime uploadDate = DateTime.now();
  TimeOfDay uploadTime = TimeOfDay.now();

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Audio", "value": "Audio"},
    {"label": "Archives", "value": "Archives"},
    {"label": "Presentations", "value": "Presentations"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "Document", "value": "document"},
    {"label": "Spreadsheet", "value": "spreadsheet"},
    {"label": "Presentation", "value": "presentation"},
    {"label": "PDF", "value": "pdf"},
    {"label": "Text File", "value": "text"},
  ];

  List<String> recentFiles = [
    "project_proposal.pdf",
    "financial_report.xlsx",
    "meeting_notes.docx",
    "brand_guidelines.pdf",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Upload Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
          spacing: spMd,
          children: [
            // File Upload Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Drop files here to upload",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "or click to browse files",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Browse Files",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // File Information Form
            Text(
              "File Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            QTextField(
              label: "File Name",
              value: fileName,
              hint: "Enter file name",
              onChanged: (value) {
                fileName = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "File Type",
                    items: typeItems,
                    value: fileType,
                    onChanged: (value, label) {
                      fileType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QMemoField(
              label: "Description",
              value: description,
              hint: "Add file description...",
              onChanged: (value) {
                description = value;
                setState(() {});
              },
            ),

            QTextField(
              label: "Tags",
              value: tags,
              hint: "Add tags separated by commas",
              onChanged: (value) {
                tags = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Upload Date",
                    value: uploadDate,
                    onChanged: (value) {
                      uploadDate = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "Upload Time",
                    value: uploadTime,
                    onChanged: (value) {
                      uploadTime = value!;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              items: [
                {
                  "label": "Make file public",
                  "value": true,
                  "checked": isPublic,
                }
              ],
              value: [if (isPublic) {"label": "Make file public", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  isPublic = values.isNotEmpty;
                });
              },
            ),

            // Recent Files Section
            Text(
              "Recent Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentFiles.map((file) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.description,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Uploaded ${DateTime.now().subtract(Duration(days: recentFiles.indexOf(file) + 1)).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: disabledBoldColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Upload File",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
