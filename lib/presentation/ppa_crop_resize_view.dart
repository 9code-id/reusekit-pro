import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCropResizeView extends StatefulWidget {
  const PpaCropResizeView({super.key});

  @override
  State<PpaCropResizeView> createState() => _PpaCropResizeViewState();
}

class _PpaCropResizeViewState extends State<PpaCropResizeView> {
  String selectedAspectRatio = "Free";
  String selectedCropType = "Crop";
  double cropTop = 0.0;
  double cropLeft = 0.0;
  double cropRight = 1.0;
  double cropBottom = 1.0;
  int customWidth = 1920;
  int customHeight = 1080;
  
  List<Map<String, dynamic>> aspectRatios = [
    {
      "label": "Free",
      "value": "Free",
      "ratio": null,
    },
    {
      "label": "1:1",
      "value": "1:1",
      "ratio": 1.0,
    },
    {
      "label": "4:3",
      "value": "4:3",
      "ratio": 4.0 / 3.0,
    },
    {
      "label": "16:9",
      "value": "16:9",
      "ratio": 16.0 / 9.0,
    },
    {
      "label": "3:4",
      "value": "3:4",
      "ratio": 3.0 / 4.0,
    },
    {
      "label": "9:16",
      "value": "9:16",
      "ratio": 9.0 / 16.0,
    },
  ];

  List<Map<String, dynamic>> cropTypes = [
    {
      "label": "Crop",
      "value": "Crop",
      "icon": Icons.crop,
    },
    {
      "label": "Resize",
      "value": "Resize",
      "icon": Icons.photo_size_select_large,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop & Resize"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _resetCrop();
            },
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              _applyCrop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tool Selection
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: cropTypes,
              value: selectedCropType,
              onChanged: (index, label, value, item) {
                selectedCropType = value;
                setState(() {});
              },
            ),
          ),
          
          // Photo Preview with Crop Overlay
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/400/300?random=9&keyword=nature"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  if (selectedCropType == "Crop")
                    _buildCropOverlay(),
                  
                  // Grid Toggle
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: GestureDetector(
                      onTap: () {
                        ss("Grid overlay toggled");
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.grid_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  
                  // Image Info
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        selectedCropType == "Crop" 
                          ? "Original: 4000×3000" 
                          : "Current: ${customWidth}×${customHeight}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Controls Section
          Expanded(
            flex: 2,
            child: selectedCropType == "Crop" 
              ? _buildCropControls() 
              : _buildResizeControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildCropOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          // Darkened areas
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
          ),
          
          // Crop area (transparent)
          Positioned(
            left: cropLeft * 300,
            top: cropTop * 200,
            width: (cropRight - cropLeft) * 300,
            height: (cropBottom - cropTop) * 200,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  // Corner handles
                  _buildCornerHandle(Alignment.topLeft),
                  _buildCornerHandle(Alignment.topRight),
                  _buildCornerHandle(Alignment.bottomLeft),
                  _buildCornerHandle(Alignment.bottomRight),
                  
                  // Rule of thirds grid
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerHandle(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
      ),
    );
  }

  Widget _buildCropControls() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aspect Ratio",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          QCategoryPicker(
            items: aspectRatios,
            value: selectedAspectRatio,
            onChanged: (index, label, value, item) {
              selectedAspectRatio = value;
              _applyAspectRatio(item["ratio"]);
            },
          ),
          
          SizedBox(height: spLg),
          
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Center Crop",
                  icon: Icons.center_focus_strong,
                  size: bs.sm,
                  onPressed: () {
                    _centerCrop();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Fill Frame",
                  icon: Icons.fullscreen,
                  size: bs.sm,
                  onPressed: () {
                    _fillFrame();
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Smart Crop",
                  icon: Icons.auto_awesome,
                  size: bs.sm,
                  onPressed: () {
                    _smartCrop();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Original",
                  icon: Icons.restore,
                  size: bs.sm,
                  onPressed: () {
                    _resetCrop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResizeControls() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Custom Size",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Width",
                  value: customWidth.toString(),
                  onChanged: (value) {
                    customWidth = int.tryParse(value) ?? customWidth;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {
                  int temp = customWidth;
                  customWidth = customHeight;
                  customHeight = temp;
                  setState(() {});
                  ss("Dimensions swapped");
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.swap_horiz,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QNumberField(
                  label: "Height",
                  value: customHeight.toString(),
                  onChanged: (value) {
                    customHeight = int.tryParse(value) ?? customHeight;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Aspect ratio: ${(customWidth / customHeight).toStringAsFixed(2)}:1",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          Text(
            "Preset Sizes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          _buildPresetButton("HD (1920×1080)", 1920, 1080),
          SizedBox(height: spSm),
          _buildPresetButton("4K (3840×2160)", 3840, 2160),
          SizedBox(height: spSm),
          _buildPresetButton("Instagram Square (1080×1080)", 1080, 1080),
          SizedBox(height: spSm),
          _buildPresetButton("Instagram Story (1080×1920)", 1080, 1920),
        ],
      ),
    );
  }

  Widget _buildPresetButton(String label, int width, int height) {
    return GestureDetector(
      onTap: () {
        customWidth = width;
        customHeight = height;
        setState(() {});
        ss("Preset size applied: $label");
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Icon(
              Icons.photo_size_select_large,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: disabledBoldColor,
            ),
          ],
        ),
      ),
    );
  }

  void _applyAspectRatio(double? ratio) {
    if (ratio != null) {
      double currentWidth = cropRight - cropLeft;
      double currentHeight = cropBottom - cropTop;
      double centerX = (cropLeft + cropRight) / 2;
      double centerY = (cropTop + cropBottom) / 2;
      
      if (currentWidth / currentHeight > ratio) {
        // Adjust width
        double newWidth = currentHeight * ratio;
        cropLeft = centerX - newWidth / 2;
        cropRight = centerX + newWidth / 2;
      } else {
        // Adjust height
        double newHeight = currentWidth / ratio;
        cropTop = centerY - newHeight / 2;
        cropBottom = centerY + newHeight / 2;
      }
      
      // Ensure bounds
      if (cropLeft < 0) {
        cropRight -= cropLeft;
        cropLeft = 0;
      }
      if (cropRight > 1) {
        cropLeft -= (cropRight - 1);
        cropRight = 1;
      }
      if (cropTop < 0) {
        cropBottom -= cropTop;
        cropTop = 0;
      }
      if (cropBottom > 1) {
        cropTop -= (cropBottom - 1);
        cropBottom = 1;
      }
      
      setState(() {});
    }
  }

  void _centerCrop() {
    cropLeft = 0.2;
    cropTop = 0.2;
    cropRight = 0.8;
    cropBottom = 0.8;
    setState(() {});
    ss("Centered crop applied");
  }

  void _fillFrame() {
    cropLeft = 0.0;
    cropTop = 0.0;
    cropRight = 1.0;
    cropBottom = 1.0;
    setState(() {});
    ss("Full frame selected");
  }

  void _smartCrop() {
    cropLeft = 0.1;
    cropTop = 0.15;
    cropRight = 0.9;
    cropBottom = 0.85;
    setState(() {});
    ss("Smart crop applied");
  }

  void _resetCrop() {
    cropLeft = 0.0;
    cropTop = 0.0;
    cropRight = 1.0;
    cropBottom = 1.0;
    selectedAspectRatio = "Free";
    customWidth = 1920;
    customHeight = 1080;
    setState(() {});
    ss("Crop reset to original");
  }

  void _applyCrop() {
    if (selectedCropType == "Crop") {
      ss("Photo cropped successfully");
    } else {
      ss("Photo resized to ${customWidth}×${customHeight}");
    }
  }
}
