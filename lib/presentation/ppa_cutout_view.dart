import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCutoutView extends StatefulWidget {
  const PpaCutoutView({super.key});

  @override
  State<PpaCutoutView> createState() => _PpaCutoutViewState();
}

class _PpaCutoutViewState extends State<PpaCutoutView> {
  String selectedTool = "Auto";
  double brushSize = 0.3;
  double tolerance = 0.2;
  bool showPreview = true;
  String cutoutMode = "Subject";
  
  List<Map<String, dynamic>> tools = [
    {"label": "Auto", "value": "Auto", "icon": Icons.auto_fix_high},
    {"label": "Magic Wand", "value": "Magic", "icon": Icons.colorize},
    {"label": "Brush", "value": "Brush", "icon": Icons.brush},
    {"label": "Eraser", "value": "Eraser", "icon": Icons.cleaning_services},
    {"label": "Lasso", "value": "Lasso", "icon": Icons.gesture},
  ];
  
  List<Map<String, dynamic>> cutoutModes = [
    {"label": "Subject", "value": "Subject"},
    {"label": "Background", "value": "Background"},
    {"label": "Manual Selection", "value": "Manual"},
  ];
  
  List<Map<String, dynamic>> recentCutouts = [
    {
      "id": "1",
      "name": "Portrait Cutout 1",
      "thumbnail": "https://picsum.photos/100/100?random=1&keyword=portrait",
      "date": "2 hours ago",
    },
    {
      "id": "2", 
      "name": "Product Photo",
      "thumbnail": "https://picsum.photos/100/100?random=2&keyword=product",
      "date": "1 day ago",
    },
    {
      "id": "3",
      "name": "Fashion Shot",
      "thumbnail": "https://picsum.photos/100/100?random=3&keyword=fashion",
      "date": "3 days ago",
    },
    {
      "id": "4",
      "name": "Nature Cutout",
      "thumbnail": "https://picsum.photos/100/100?random=4&keyword=nature",
      "date": "1 week ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cutout Tool"),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              si("Undo last stroke");
            },
          ),
          IconButton(
            icon: Icon(Icons.redo),
            onPressed: () {
              si("Redo last stroke");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Reset cutout");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "https://picsum.photos/400/350?random=101&keyword=person",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  if (showPreview)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: primaryColor.withAlpha(100),
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.content_cut,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "$selectedTool Tool",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.touch_app,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Tap and drag to create selection",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Text(
              "Cutout Tools",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: tools.map((tool) {
                final isSelected = selectedTool == tool["value"];
                
                return GestureDetector(
                  onTap: () {
                    selectedTool = tool["value"];
                    setState(() {});
                    si("${tool["label"]} tool selected");
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          tool["icon"] as IconData,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tool["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            Text(
              "Cutout Mode",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QDropdownField(
              label: "Selection Mode",
              items: cutoutModes,
              value: cutoutMode,
              onChanged: (value, label) {
                cutoutMode = value;
                setState(() {});
              },
            ),
            
            QSwitch(
              label: "Preview Mode",
              items: [
                {
                  "label": "Show cutout preview overlay",
                  "value": true,
                  "checked": showPreview,
                }
              ],
              value: [
                if (showPreview)
                  {
                    "label": "Show cutout preview overlay",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showPreview = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            Text(
              "Tool Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            if (selectedTool == "Brush" || selectedTool == "Eraser") ...[
              Text(
                "Brush Size: ${(brushSize * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Slider(
                value: brushSize,
                onChanged: (value) {
                  brushSize = value;
                  setState(() {});
                },
                activeColor: primaryColor,
                inactiveColor: disabledColor,
              ),
            ],
            
            if (selectedTool == "Magic") ...[
              Text(
                "Tolerance: ${(tolerance * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Slider(
                value: tolerance,
                onChanged: (value) {
                  tolerance = value;
                  setState(() {});
                },
                activeColor: primaryColor,
                inactiveColor: disabledColor,
              ),
            ],
            
            Text(
              "Recent Cutouts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: recentCutouts.map((cutout) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      si("Loading ${cutout["name"]}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Image.network(
                              "${cutout["thumbnail"]}",
                              height: 80,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spXs),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cutout["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${cutout["date"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Selection",
                    size: bs.md,
                    onPressed: () {
                      si("Selection cleared");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Cutout",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Cutout applied successfully!");
                      });
                    },
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
