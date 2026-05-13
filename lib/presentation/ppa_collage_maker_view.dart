import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCollageMakerView extends StatefulWidget {
  const PpaCollageMakerView({super.key});

  @override
  State<PpaCollageMakerView> createState() => _PpaCollageMakerViewState();
}

class _PpaCollageMakerViewState extends State<PpaCollageMakerView> {
  String selectedTemplate = "Grid 2x2";
  double spacing = 0.1;
  double cornerRadius = 0.2;
  bool enableShadow = true;
  String backgroundColor = "White";
  
  List<String> selectedImages = [
    "https://picsum.photos/200/200?random=40&keyword=nature",
    "https://picsum.photos/200/200?random=41&keyword=city",
    "https://picsum.photos/200/200?random=42&keyword=portrait",
    "https://picsum.photos/200/200?random=43&keyword=abstract",
  ];
  
  List<Map<String, dynamic>> templates = [
    {
      "name": "Grid 2x2",
      "value": "Grid2x2",
      "layout": "grid",
      "slots": 4,
      "thumbnail": "https://picsum.photos/80/80?random=50&keyword=grid",
    },
    {
      "name": "Grid 3x3",
      "value": "Grid3x3", 
      "layout": "grid",
      "slots": 9,
      "thumbnail": "https://picsum.photos/80/80?random=51&keyword=grid",
    },
    {
      "name": "Magazine",
      "value": "Magazine",
      "layout": "magazine",
      "slots": 5,
      "thumbnail": "https://picsum.photos/80/80?random=52&keyword=magazine",
    },
    {
      "name": "Mosaic",
      "value": "Mosaic",
      "layout": "mosaic",
      "slots": 6,
      "thumbnail": "https://picsum.photos/80/80?random=53&keyword=mosaic",
    },
    {
      "name": "Film Strip",
      "value": "FilmStrip",
      "layout": "strip",
      "slots": 4,
      "thumbnail": "https://picsum.photos/80/80?random=54&keyword=film",
    },
    {
      "name": "Heart Shape",
      "value": "Heart",
      "layout": "shape",
      "slots": 8,
      "thumbnail": "https://picsum.photos/80/80?random=55&keyword=heart",
    },
  ];
  
  List<Map<String, dynamic>> backgroundColors = [
    {"label": "White", "value": "White", "color": Colors.white},
    {"label": "Black", "value": "Black", "color": Colors.black},
    {"label": "Gray", "value": "Gray", "color": Colors.grey},
    {"label": "Transparent", "value": "Transparent", "color": Colors.transparent},
  ];
  
  List<Map<String, dynamic>> aspectRatios = [
    {"label": "Square (1:1)", "value": "1:1"},
    {"label": "Portrait (4:5)", "value": "4:5"},
    {"label": "Landscape (16:9)", "value": "16:9"},
    {"label": "Story (9:16)", "value": "9:16"},
  ];

  Map<String, dynamic>? get currentTemplate {
    return templates.firstWhere(
      (template) => template["value"] == selectedTemplate,
      orElse: () => templates.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collage Maker"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveCollage();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Sharing collage");
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
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: enableShadow ? [shadowMd] : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: _buildCollagePreview(),
              ),
            ),
            
            Text(
              "Collage Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: templates.map((template) {
                final isSelected = selectedTemplate == template["value"];
                
                return GestureDetector(
                  onTap: () {
                    selectedTemplate = template["value"];
                    setState(() {});
                    si("${template["name"]} template selected");
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(right: spSm),
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
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Image.network(
                              "${template["thumbnail"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spXs),
                          child: Column(
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${template["slots"]} photos",
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
                );
              }).toList(),
            ),
            
            Text(
              "Selected Images",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              height: 100,
              child: Row(
                children: [
                  ...selectedImages.take(6).map((imageUrl) {
                    final index = selectedImages.indexOf(imageUrl);
                    return Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                selectedImages.removeAt(index);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  if (selectedImages.length < 10)
                    GestureDetector(
                      onTap: () {
                        _addNewImage();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            Text(
              "Collage Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QDropdownField(
              label: "Background Color",
              items: backgroundColors.map((color) => {
                "label": color["label"],
                "value": color["value"],
              }).toList(),
              value: backgroundColor,
              onChanged: (value, label) {
                backgroundColor = value;
                setState(() {});
              },
            ),
            
            Text(
              "Spacing: ${(spacing * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: spacing,
              onChanged: (value) {
                spacing = value;
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            Text(
              "Corner Radius: ${(cornerRadius * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: cornerRadius,
              onChanged: (value) {
                cornerRadius = value;
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            QSwitch(
              label: "Shadow Effect",
              items: [
                {
                  "label": "Add shadow to collage",
                  "value": true,
                  "checked": enableShadow,
                }
              ],
              value: [
                if (enableShadow)
                  {
                    "label": "Add shadow to collage",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                enableShadow = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Photos",
                    size: bs.md,
                    onPressed: () {
                      _addNewImage();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: () {
                      _resetCollage();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create",
                    size: bs.md,
                    onPressed: () {
                      _createCollage();
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
  
  Widget _buildCollagePreview() {
    switch (selectedTemplate) {
      case "Grid2x2":
        return _buildGridLayout(2, 2);
      case "Grid3x3":
        return _buildGridLayout(3, 3);
      case "Magazine":
        return _buildMagazineLayout();
      case "FilmStrip":
        return _buildFilmStripLayout();
      default:
        return _buildGridLayout(2, 2);
    }
  }
  
  Widget _buildGridLayout(int rows, int cols) {
    return Container(
      padding: EdgeInsets.all(spacing * 20),
      child: Column(
        children: List.generate(rows, (row) {
          return Expanded(
            child: Row(
              children: List.generate(cols, (col) {
                final index = row * cols + col;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.all(spacing * 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius * 20),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(cornerRadius * 20),
                      child: index < selectedImages.length
                          ? Image.network(
                              selectedImages[index],
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: disabledColor,
                              child: Icon(
                                Icons.add_photo_alternate,
                                color: disabledBoldColor,
                                size: 24,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
  
  Widget _buildMagazineLayout() {
    return Container(
      padding: EdgeInsets.all(spacing * 20),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(spacing * 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius * 20),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius * 20),
                child: selectedImages.isNotEmpty
                    ? Image.network(selectedImages[0], fit: BoxFit.cover)
                    : Container(color: disabledColor),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: List.generate(2, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.all(spacing * 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius * 20),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(cornerRadius * 20),
                      child: index + 1 < selectedImages.length
                          ? Image.network(selectedImages[index + 1], fit: BoxFit.cover)
                          : Container(color: disabledColor),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilmStripLayout() {
    return Container(
      padding: EdgeInsets.all(spacing * 20),
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.all(spacing * 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius * 20),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius * 20),
                child: index < selectedImages.length
                    ? Image.network(selectedImages[index], fit: BoxFit.cover)
                    : Container(color: disabledColor),
              ),
            ),
          );
        }),
      ),
    );
  }
  
  Color _getBackgroundColor() {
    switch (backgroundColor) {
      case "White":
        return Colors.white;
      case "Black":
        return Colors.black;
      case "Gray":
        return Colors.grey.shade200;
      case "Transparent":
        return Colors.transparent;
      default:
        return Colors.white;
    }
  }
  
  void _addNewImage() {
    final newImageUrl = "https://picsum.photos/200/200?random=${selectedImages.length + 60}&keyword=photo";
    selectedImages.add(newImageUrl);
    setState(() {});
    si("New image added to collage");
  }
  
  void _resetCollage() {
    selectedImages.clear();
    selectedImages.addAll([
      "https://picsum.photos/200/200?random=40&keyword=nature",
      "https://picsum.photos/200/200?random=41&keyword=city",
      "https://picsum.photos/200/200?random=42&keyword=portrait",
      "https://picsum.photos/200/200?random=43&keyword=abstract",
    ]);
    selectedTemplate = "Grid2x2";
    spacing = 0.1;
    cornerRadius = 0.2;
    enableShadow = true;
    backgroundColor = "White";
    setState(() {});
    si("Collage reset to default");
  }
  
  void _createCollage() {
    if (selectedImages.isEmpty) {
      se("Please add at least one image");
      return;
    }
    
    showLoading();
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Collage created successfully!");
    });
  }
  
  void _saveCollage() {
    if (selectedImages.isEmpty) {
      se("No images to save");
      return;
    }
    
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Collage saved to gallery!");
    });
  }
}
