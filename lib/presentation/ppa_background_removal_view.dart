import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBackgroundRemovalView extends StatefulWidget {
  const PpaBackgroundRemovalView({super.key});

  @override
  State<PpaBackgroundRemovalView> createState() => _PpaBackgroundRemovalViewState();
}

class _PpaBackgroundRemovalViewState extends State<PpaBackgroundRemovalView> {
  String selectedMethod = "ai_auto";
  double tolerance = 50.0;
  double feather = 5.0;
  double edgeSmoothing = 10.0;
  bool previewMode = false;
  bool showEdges = false;
  String refinementMethod = "edge";
  double brushSize = 20.0;
  bool isProcessing = false;
  int processingProgress = 0;

  List<Map<String, dynamic>> removalMethods = [
    {
      "label": "AI Auto Remove",
      "value": "ai_auto",
      "icon": Icons.auto_fix_high,
      "description": "Automatic background removal using AI"
    },
    {
      "label": "Magic Wand",
      "value": "magic_wand",
      "icon": Icons.auto_awesome,
      "description": "Select similar colors to remove"
    },
    {
      "label": "Color Range",
      "value": "color_range",
      "icon": Icons.palette,
      "description": "Remove based on color selection"
    },
    {
      "label": "Manual Selection",
      "value": "manual",
      "icon": Icons.crop_free,
      "description": "Draw selection manually"
    },
  ];

  List<Map<String, dynamic>> refinementMethods = [
    {"label": "Edge Refinement", "value": "edge"},
    {"label": "Smooth", "value": "smooth"},
    {"label": "Contrast", "value": "contrast"},
    {"label": "Feather", "value": "feather"},
  ];

  List<Map<String, dynamic>> backgroundOptions = [
    {
      "label": "Transparent",
      "value": "transparent",
      "preview": "https://via.placeholder.com/100x100/FFFFFF/000000?text=PNG"
    },
    {
      "label": "White",
      "value": "white",
      "preview": "https://via.placeholder.com/100x100/FFFFFF/FFFFFF"
    },
    {
      "label": "Black",
      "value": "black",
      "preview": "https://via.placeholder.com/100x100/000000/000000"
    },
    {
      "label": "Custom Color",
      "value": "custom",
      "preview": "https://via.placeholder.com/100x100/FF5722/FF5722"
    },
    {
      "label": "Blur Original",
      "value": "blur",
      "preview": "https://picsum.photos/100/100?random=10&blur=5"
    },
    {
      "label": "New Image",
      "value": "image",
      "preview": "https://picsum.photos/100/100?random=11"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Background Removal"),
        actions: [
          IconButton(
            icon: Icon(previewMode ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              previewMode = !previewMode;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(showEdges ? Icons.border_clear : Icons.border_outer),
            onPressed: () {
              showEdges = !showEdges;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Preview Area
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    // Background pattern for transparency preview
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/400/280?random=5&keyword=portrait"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: previewMode ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 80,
                                color: primaryColor.withAlpha(150),
                              ),
                              Text(
                                "Subject Only",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) : null,
                    ),
                    
                    // Processing overlay
                    if (isProcessing)
                      Container(
                        color: Colors.black.withAlpha(150),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: spSm),
                              Text(
                                "Processing... $processingProgress%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Status indicators
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          previewMode ? "Preview Mode" : "Original",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    if (showEdges)
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.border_outer, size: 14, color: Colors.white),
                              SizedBox(width: spXs),
                              Text(
                                "Show Edges",
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
                  ],
                ),
              ),
            ),

            // Removal Method Selection
            Text(
              "Removal Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: removalMethods.map((method) {
                bool isSelected = selectedMethod == method["value"];
                return GestureDetector(
                  onTap: () {
                    selectedMethod = method["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          method["icon"] as IconData,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 28,
                        ),
                        Text(
                          "${method["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${method["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Method-specific Settings
            Text(
              "Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  if (selectedMethod == "magic_wand" || selectedMethod == "color_range") ...[
                    _buildSlider(
                      "Tolerance",
                      tolerance,
                      0.0,
                      100.0,
                      (value) {
                        tolerance = value;
                        setState(() {});
                      },
                      showPercentage: true,
                    ),
                  ],
                  
                  _buildSlider(
                    "Edge Feather",
                    feather,
                    0.0,
                    50.0,
                    (value) {
                      feather = value;
                      setState(() {});
                    },
                    unit: "px",
                  ),
                  
                  _buildSlider(
                    "Edge Smoothing",
                    edgeSmoothing,
                    0.0,
                    50.0,
                    (value) {
                      edgeSmoothing = value;
                      setState(() {});
                    },
                    unit: "px",
                  ),

                  if (selectedMethod == "manual") ...[
                    _buildSlider(
                      "Brush Size",
                      brushSize,
                      1.0,
                      100.0,
                      (value) {
                        brushSize = value;
                        setState(() {});
                      },
                      unit: "px",
                    ),
                  ],
                ],
              ),
            ),

            // Edge Refinement
            Text(
              "Edge Refinement",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Refinement Method",
                    items: refinementMethods,
                    value: refinementMethod,
                    onChanged: (value, label) {
                      refinementMethod = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Refine Edges",
                          icon: Icons.tune,
                          size: bs.sm,
                          onPressed: () {
                            _refineEdges();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Reset Selection",
                          icon: Icons.refresh,
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () {
                            _resetSelection();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Background Replacement Options
            Text(
              "Background Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: backgroundOptions.map((option) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _selectBackground(option["value"]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${option["preview"]}"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                          ),
                          Text(
                            "${option["label"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Process Controls
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: isProcessing ? "Processing..." : "Remove Background",
                    icon: isProcessing ? null : Icons.auto_fix_high,
                    size: bs.md,
                    onPressed: isProcessing ? null : () {
                      _processBackgroundRemoval();
                    },
                  ),
                ),
              ],
            ),

            if (!isProcessing) ...[
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as PNG",
                      icon: Icons.save,
                      size: bs.sm,
                      onPressed: () {
                        ss("Image saved as PNG with transparent background");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Export JPEG",
                      icon: Icons.photo,
                      size: bs.sm,
                      onPressed: () {
                        ss("Image exported as JPEG with background");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged, {
    bool showPercentage = false,
    String unit = "",
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              showPercentage 
                ? "${value.toInt()}%"
                : "${value.toInt()}$unit",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _processBackgroundRemoval() {
    isProcessing = true;
    processingProgress = 0;
    setState(() {});

    // Simulate processing
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      processingProgress += 5;
      setState(() {});
      
      if (processingProgress >= 100) {
        timer.cancel();
        isProcessing = false;
        previewMode = true;
        setState(() {});
        ss("Background removed successfully!");
      }
    });
  }

  void _selectBackground(String backgroundType) {
    switch (backgroundType) {
      case "transparent":
        si("Background set to transparent");
        break;
      case "white":
        si("Background set to white");
        break;
      case "black":
        si("Background set to black");
        break;
      case "custom":
        si("Opening color picker for custom background");
        break;
      case "blur":
        si("Background set to blurred original");
        break;
      case "image":
        si("Opening image picker for background");
        break;
    }
  }

  void _refineEdges() {
    si("Refining edges using $refinementMethod method");
  }

  void _resetSelection() {
    previewMode = false;
    showEdges = false;
    setState(() {});
    si("Selection reset to original image");
  }
}
