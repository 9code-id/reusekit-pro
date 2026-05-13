import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery8View extends StatefulWidget {
  @override
  State<GrlGallery8View> createState() => _GrlGallery8ViewState();
}

class _GrlGallery8ViewState extends State<GrlGallery8View> {
  String selectedEffect = "Original";
  double brightness = 0.0;
  double contrast = 0.0;
  double saturation = 0.0;
  double exposure = 0.0;
  bool loading = false;

  final String originalImageUrl = "https://picsum.photos/800/600?random=100&keyword=landscape";

  final List<Map<String, dynamic>> effects = [
    {"label": "Original", "value": "Original"},
    {"label": "Vintage", "value": "Vintage"},
    {"label": "Black & White", "value": "BlackWhite"},
    {"label": "Sepia", "value": "Sepia"},
    {"label": "Cool", "value": "Cool"},
    {"label": "Warm", "value": "Warm"},
    {"label": "Dramatic", "value": "Dramatic"},
    {"label": "Soft", "value": "Soft"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Editor"),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              _resetAdjustments();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveImage();
            },
          ),
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
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Photo Editor",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Enhance your photos with professional tools",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.photo_filter,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  // Image Preview
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Stack(
                        children: [
                          Image.network(
                            originalImageUrl,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          
                          // Effect Overlay (simulated)
                          if (selectedEffect != "Original")
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _getEffectColor(selectedEffect),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                            ),

                          // Current Settings Indicator
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                selectedEffect,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          // Zoom Controls
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Column(
                              spacing: spXs,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    si("Zoom in feature coming soon!");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.zoom_in,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    si("Zoom out feature coming soon!");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.zoom_out,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Effects Section
                  Text(
                    "Photo Effects",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Effects Grid
                  QHorizontalScroll(
                    children: effects.map((effect) {
                      final isSelected = selectedEffect == effect["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedEffect = effect["value"];
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: isSelected ? [shadowSm] : [],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        "https://picsum.photos/70/70?random=${100 + effects.indexOf(effect)}&keyword=preview",
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      if (effect["value"] != "Original")
                                        Positioned.fill(
                                          child: Container(
                                            color: _getEffectColor(effect["value"]),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "${effect["label"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Adjustments Section
                  Text(
                    "Adjustments",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Adjustment Controls
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spMd,
                      children: [
                        // Brightness
                        _buildSliderControl(
                          "Brightness",
                          brightness,
                          Icons.brightness_6,
                          (value) {
                            brightness = value;
                            setState(() {});
                          },
                        ),

                        // Contrast
                        _buildSliderControl(
                          "Contrast",
                          contrast,
                          Icons.contrast,
                          (value) {
                            contrast = value;
                            setState(() {});
                          },
                        ),

                        // Saturation
                        _buildSliderControl(
                          "Saturation",
                          saturation,
                          Icons.color_lens,
                          (value) {
                            saturation = value;
                            setState(() {});
                          },
                        ),

                        // Exposure
                        _buildSliderControl(
                          "Exposure",
                          exposure,
                          Icons.wb_sunny,
                          (value) {
                            exposure = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Quick Actions
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Auto Enhance",
                          icon: Icons.auto_fix_high,
                          size: bs.md,
                          onPressed: () {
                            _autoEnhance();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reset All",
                          icon: Icons.restore,
                          size: bs.md,
                          onPressed: () {
                            _resetAdjustments();
                          },
                        ),
                      ),
                    ],
                  ),

                  // Settings Info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: infoColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Current Settings",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Effect: $selectedEffect\nBrightness: ${brightness.toStringAsFixed(1)}\nContrast: ${contrast.toStringAsFixed(1)}\nSaturation: ${saturation.toStringAsFixed(1)}\nExposure: ${exposure.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export",
                          icon: Icons.file_download,
                          size: bs.md,
                          onPressed: () {
                            _exportImage();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share",
                          icon: Icons.share,
                          size: bs.md,
                          onPressed: () {
                            _shareImage();
                          },
                        ),
                      ),
                    ],
                  ),

                  // Pro Features Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: warningColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Unlock Pro Features",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Upgrade",
                              size: bs.sm,
                              onPressed: () {
                                si("Pro upgrade feature coming soon!");
                              },
                            ),
                          ],
                        ),
                        Text(
                          "• Advanced filters and effects\n• Batch processing\n• RAW image support\n• High-resolution export",
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
    );
  }

  Widget _buildSliderControl(String label, double value, IconData icon, Function(double) onChanged) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: primaryColor,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: -1.0,
          max: 1.0,
          divisions: 20,
          activeColor: primaryColor,
          inactiveColor: disabledColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Color? _getEffectColor(String effect) {
    switch (effect) {
      case "Vintage":
        return Colors.yellow.withAlpha(30);
      case "BlackWhite":
        return Colors.grey.withAlpha(50);
      case "Sepia":
        return Colors.brown.withAlpha(40);
      case "Cool":
        return Colors.blue.withAlpha(20);
      case "Warm":
        return Colors.orange.withAlpha(25);
      case "Dramatic":
        return Colors.black.withAlpha(30);
      case "Soft":
        return Colors.white.withAlpha(20);
      default:
        return null;
    }
  }

  void _autoEnhance() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    // Simulate auto enhancement
    brightness = 0.2;
    contrast = 0.1;
    saturation = 0.15;
    exposure = 0.05;
    
    loading = false;
    setState(() {});
    
    ss("Auto enhancement applied!");
  }

  void _resetAdjustments() {
    selectedEffect = "Original";
    brightness = 0.0;
    contrast = 0.0;
    saturation = 0.0;
    exposure = 0.0;
    setState(() {});
    si("All adjustments reset");
  }

  void _saveImage() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Image saved successfully!");
  }

  void _exportImage() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Image exported to gallery!");
  }

  void _shareImage() {
    si("Share feature coming soon!");
  }
}
