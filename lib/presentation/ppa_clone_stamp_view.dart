import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCloneStampView extends StatefulWidget {
  const PpaCloneStampView({super.key});

  @override
  State<PpaCloneStampView> createState() => _PpaCloneStampViewState();
}

class _PpaCloneStampViewState extends State<PpaCloneStampView> {
  double brushSize = 20.0;
  double opacity = 100.0;
  double hardness = 80.0;
  bool alignedMode = true;
  bool showSamplePoint = true;
  Offset? sourcePoint;
  Offset? targetPoint;
  String blendMode = "Normal";
  bool useAllLayers = false;

  List<String> blendModes = [
    "Normal",
    "Multiply",
    "Screen", 
    "Overlay",
    "Soft Light",
    "Hard Light",
    "Color Dodge",
    "Color Burn",
    "Darken",
    "Lighten",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clone Stamp"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showInstructions();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetTool();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Canvas
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    // Base Image
                    GestureDetector(
                      onTapDown: (details) {
                        if (sourcePoint == null) {
                          // Set source point (Alt+Click simulation)
                          sourcePoint = details.localPosition;
                          ss("Source point set");
                        } else {
                          // Apply clone stamp
                          targetPoint = details.localPosition;
                          _applyCloneStamp();
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          "https://picsum.photos/400/300?random=5&keyword=architecture", 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Source Point Indicator
                    if (sourcePoint != null && showSamplePoint)
                      Positioned(
                        left: sourcePoint!.dx - 15,
                        top: sourcePoint!.dy - 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Target Point Indicator  
                    if (targetPoint != null)
                      Positioned(
                        left: targetPoint!.dx - 10,
                        top: targetPoint!.dy - 10,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                    // Brush Size Preview
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
                          "Size: ${brushSize.toInt()}px",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Instructions Overlay
                    if (sourcePoint == null)
                      Positioned(
                        bottom: spMd,
                        left: spMd,
                        right: spMd,
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Text(
                            "Tap to set source point first (Alt+Click)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Controls Panel
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
                boxShadow: [shadowLg],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clone Stamp Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Brush Size
                    _buildSliderControl(
                      label: "Brush Size",
                      value: brushSize,
                      min: 1,
                      max: 100,
                      suffix: "px",
                      onChanged: (value) {
                        brushSize = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Opacity
                    _buildSliderControl(
                      label: "Opacity",
                      value: opacity,
                      min: 1,
                      max: 100,
                      suffix: "%",
                      onChanged: (value) {
                        opacity = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Hardness
                    _buildSliderControl(
                      label: "Hardness",
                      value: hardness,
                      min: 0,
                      max: 100,
                      suffix: "%",
                      onChanged: (value) {
                        hardness = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spLg),

                    // Mode Settings
                    Text(
                      "Clone Mode",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Aligned Mode
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: alignedMode ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: alignedMode ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            value: alignedMode,
                            onChanged: (value) {
                              alignedMode = value;
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aligned Mode",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Source point moves with brush strokes",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Show Sample Point
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Show Sample Point",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: showSamplePoint,
                          onChanged: (value) {
                            showSamplePoint = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Use All Layers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sample All Layers",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: useAllLayers,
                          onChanged: (value) {
                            useAllLayers = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Blend Mode
                    Row(
                      children: [
                        Text(
                          "Blend Mode:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: blendMode,
                                isExpanded: true,
                                items: blendModes.map((mode) {
                                  return DropdownMenuItem(
                                    value: mode,
                                    child: Text(mode),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  blendMode = value!;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spLg),

                    // Quick Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Reset Source",
                            color: warningColor,
                            size: bs.md,
                            onPressed: () {
                              sourcePoint = null;
                              targetPoint = null;
                              setState(() {});
                              si("Source point cleared");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Apply Effect",
                            size: bs.md,
                            onPressed: () {
                              if (sourcePoint != null && targetPoint != null) {
                                ss("Clone stamp effect applied");
                              } else {
                                se("Please set source and target points");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    String suffix = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              "${value.toInt()}$suffix",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primaryColor,
            inactiveTrackColor: disabledColor,
            thumbColor: primaryColor,
            overlayColor: primaryColor.withAlpha(30),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clone Stamp Instructions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionStep("1.", "Tap to set source point (red circle)"),
            SizedBox(height: spSm),
            _buildInstructionStep("2.", "Tap target areas to clone from source"),
            SizedBox(height: spSm),
            _buildInstructionStep("3.", "Adjust brush size and opacity as needed"),
            SizedBox(height: spSm),
            _buildInstructionStep("4.", "Use Aligned mode for continuous cloning"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  void _resetTool() {
    sourcePoint = null;
    targetPoint = null;
    brushSize = 20.0;
    opacity = 100.0;
    hardness = 80.0;
    alignedMode = true;
    showSamplePoint = true;
    blendMode = "Normal";
    useAllLayers = false;
    setState(() {});
    si("Clone stamp tool reset");
  }

  void _applyCloneStamp() {
    if (sourcePoint != null && targetPoint != null) {
      // Simulate cloning effect
      ss("Clone applied from source to target");
      if (!alignedMode) {
        // Reset target point if not in aligned mode
        targetPoint = null;
      }
    }
  }
}
