import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPhotoCaptureView extends StatefulWidget {
  const DlaPhotoCaptureView({super.key});

  @override
  State<DlaPhotoCaptureView> createState() => _DlaPhotoCaptureViewState();
}

class _DlaPhotoCaptureViewState extends State<DlaPhotoCaptureView> {
  String photoType = "delivery";
  bool flashEnabled = false;
  bool frontCamera = false;
  String captureNotes = "";
  List<String> capturedPhotos = [];
  int maxPhotos = 5;
  
  final List<Map<String, dynamic>> photoTypeOptions = [
    {"label": "Delivery Proof", "value": "delivery"},
    {"label": "Package Condition", "value": "package"},
    {"label": "Recipient", "value": "recipient"},
    {"label": "Address Verification", "value": "address"},
    {"label": "Damage Report", "value": "damage"},
    {"label": "Return Item", "value": "return"},
  ];

  final List<String> photoTemplates = [
    "https://picsum.photos/300/400?random=1",
    "https://picsum.photos/300/400?random=2",
    "https://picsum.photos/300/400?random=3",
  ];

  Widget _buildCameraInterface() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 280,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Camera Preview",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Position the ${photoType.replaceAll('_', ' ')} in frame",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: spSm,
            left: spSm,
            child: QButton(
              icon: flashEnabled ? Icons.flash_on : Icons.flash_off,
              color: flashEnabled ? warningColor : disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                flashEnabled = !flashEnabled;
                setState(() {});
                si(flashEnabled ? "Flash enabled" : "Flash disabled");
              },
            ),
          ),
          Positioned(
            top: spSm,
            right: spSm,
            child: QButton(
              icon: frontCamera ? Icons.camera_front : Icons.camera_rear,
              color: primaryColor,
              size: bs.sm,
              onPressed: () {
                frontCamera = !frontCamera;
                setState(() {});
                si(frontCamera ? "Front camera" : "Rear camera");
              },
            ),
          ),
          Positioned(
            bottom: spSm,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QButton(
                  icon: Icons.photo_library,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Open gallery");
                  },
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera, color: Colors.white, size: 30),
                    onPressed: () {
                      if (capturedPhotos.length < maxPhotos) {
                        capturedPhotos.add("https://picsum.photos/300/400?random=${capturedPhotos.length + 10}");
                        setState(() {});
                        ss("Photo captured successfully");
                      } else {
                        sw("Maximum $maxPhotos photos allowed");
                      }
                    },
                  ),
                ),
                QButton(
                  icon: Icons.grid_view,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View captured photos");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoTypeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.category, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Photo Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Photo Type",
            items: photoTypeOptions,
            value: photoType,
            onChanged: (value, label) {
              photoType = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    _getPhotoTypeDescription(),
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPhotoTypeDescription() {
    switch (photoType) {
      case "delivery":
        return "Take a photo of the delivered package at the destination";
      case "package":
        return "Document the condition of the package before/after delivery";
      case "recipient":
        return "Photo of the person receiving the package (with consent)";
      case "address":
        return "Verify the delivery address with house number/signage";
      case "damage":
        return "Document any damage to the package or contents";
      case "return":
        return "Photo of item being returned by customer";
      default:
        return "Select photo type for specific instructions";
    }
  }

  Widget _buildCapturedPhotos() {
    if (capturedPhotos.isEmpty) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.photo_library, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Captured Photos (${capturedPhotos.length}/$maxPhotos)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.delete_sweep,
                color: dangerColor,
                size: bs.sm,
                onPressed: () {
                  capturedPhotos.clear();
                  setState(() {});
                  si("All photos cleared");
                },
              ),
            ],
          ),
          Container(
            height: 120,
            child: QHorizontalScroll(
              children: capturedPhotos.asMap().entries.map((entry) {
                int index = entry.key;
                String photo = entry.value;
                return Container(
                  width: 90,
                  margin: EdgeInsets.only(right: spSm),
                  child: Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage(photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: spXs,
                        right: spXs,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: dangerColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.close, color: Colors.white, size: 16),
                            onPressed: () {
                              capturedPhotos.removeAt(index);
                              setState(() {});
                              si("Photo removed");
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spXs,
                        left: spXs,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoNotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Photo Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Additional Notes",
            value: captureNotes,
            hint: "Add notes about the photos taken...",
            onChanged: (value) {
              captureNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGuidelines() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Photo Guidelines",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "• Ensure good lighting and clear visibility\n• Include relevant context in the frame\n• Avoid blurry or unclear photos\n• Respect privacy when photographing people\n• Check photo quality before proceeding",
            style: TextStyle(
              fontSize: 13,
              color: warningColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Capture"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Camera settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPhotoTypeSelection(),
            _buildCameraInterface(),
            _buildCapturedPhotos(),
            _buildPhotoNotes(),
            _buildPhotoGuidelines(),
            if (capturedPhotos.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Photos (${capturedPhotos.length})",
                  color: successColor,
                  size: bs.md,
                  onPressed: () {
                    ss("${capturedPhotos.length} photos saved successfully!");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
