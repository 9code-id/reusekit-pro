import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPanoramaView extends StatefulWidget {
  const PpaPanoramaView({super.key});

  @override
  State<PpaPanoramaView> createState() => _PpaPanoramaViewState();
}

class _PpaPanoramaViewState extends State<PpaPanoramaView> {
  bool isCapturing = false;
  bool isPanoramaEnabled = false;
  int captureProgress = 0;
  String selectedPanoramaMode = "horizontal";
  
  List<Map<String, dynamic>> panoramaModes = [
    {
      "id": "horizontal",
      "label": "Horizontal Panorama",
      "description": "Capture wide landscape views",
      "icon": Icons.panorama_horizontal,
      "angle": "180°"
    },
    {
      "id": "vertical",
      "label": "Vertical Panorama",
      "description": "Capture tall buildings or waterfalls",
      "icon": Icons.panorama_vertical,
      "angle": "180°"
    },
    {
      "id": "wide",
      "label": "Wide Angle",
      "description": "Ultra-wide panoramic capture",
      "icon": Icons.panorama_wide_angle,
      "angle": "360°"
    },
    {
      "id": "photosphere",
      "label": "Photo Sphere",
      "description": "Complete 360° spherical capture",
      "icon": Icons.panorama_photosphere,
      "angle": "360°"
    }
  ];

  List<Map<String, dynamic>> panoramaGallery = [
    {
      "url": "https://picsum.photos/400/150?random=1&keyword=landscape",
      "title": "Mountain Range Panorama",
      "mode": "Horizontal",
      "date": "Today",
      "angle": "180°",
      "size": "4.2 MB"
    },
    {
      "url": "https://picsum.photos/400/150?random=2&keyword=cityscape",
      "title": "City Skyline Panorama",
      "mode": "Wide Angle",
      "date": "Yesterday",
      "angle": "270°",
      "size": "5.8 MB"
    },
    {
      "url": "https://picsum.photos/400/150?random=3&keyword=ocean",
      "title": "Ocean View Panorama",
      "mode": "Horizontal",
      "date": "2 days ago",
      "angle": "180°",
      "size": "3.7 MB"
    },
    {
      "url": "https://picsum.photos/150/400?random=4&keyword=building",
      "title": "Skyscraper Vertical",
      "mode": "Vertical",
      "date": "3 days ago",
      "angle": "180°",
      "size": "2.9 MB"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panorama Mode"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Panorama Mode Selection
            Text(
              "Panorama Modes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              spacing: spSm,
              children: panoramaModes.map((mode) {
                final isSelected = selectedPanoramaMode == mode["id"];
                return GestureDetector(
                  onTap: () {
                    selectedPanoramaMode = mode["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            mode["icon"],
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${mode["label"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryColor : Colors.black87,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${mode["angle"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${mode["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Camera Preview
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.withAlpha(100),
                            Colors.teal.withAlpha(100),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              panoramaModes.firstWhere((m) => m["id"] == selectedPanoramaMode)["icon"],
                              color: Colors.white,
                              size: 48,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Panorama Preview",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${panoramaModes.firstWhere((m) => m["id"] == selectedPanoramaMode)["label"]}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Panorama Indicator
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.panorama,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "PANORAMA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Progress Indicator
                  if (isCapturing)
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      right: spSm,
                      child: Column(
                        children: [
                          Text(
                            "Capturing Panorama... ${captureProgress}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: captureProgress / 100,
                            backgroundColor: Colors.white.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Capture Instructions
            if (!isCapturing)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Panorama Tips",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• Move your device slowly and steadily",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• Keep the device level and at the same height",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• Avoid moving subjects in the scene",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• Follow the on-screen guide for best results",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Capture Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isCapturing ? "Capturing..." : "Start Panorama Capture",
                icon: isCapturing ? Icons.hourglass_empty : Icons.panorama,
                size: bs.md,
                onPressed: () {
                  if (!isCapturing) {
                    isCapturing = true;
                    captureProgress = 0;
                    setState(() {});
                    
                    // Simulate panorama capture process
                    _simulatePanoramaCapture();
                  }
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Panorama Gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Panorama Gallery",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Column(
              spacing: spSm,
              children: panoramaGallery.map((panorama) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${panorama["url"]}",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${panorama["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${panorama["angle"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${panorama["mode"]} • ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${panorama["date"]} • ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${panorama["size"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _simulatePanoramaCapture() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (captureProgress >= 100) {
        timer.cancel();
        isCapturing = false;
        setState(() {});
        ss("Panorama captured successfully!");
      } else {
        captureProgress += 2;
        setState(() {});
      }
    });
  }
}
