import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPhotoCaptureView extends StatefulWidget {
  const PpaPhotoCaptureView({super.key});

  @override
  State<PpaPhotoCaptureView> createState() => _PpaPhotoCaptureViewState();
}

class _PpaPhotoCaptureViewState extends State<PpaPhotoCaptureView> {
  int currentTab = 0;
  List<String> capturedPhotos = [];
  bool isCapturing = false;
  String selectedMode = "single";
  int burstCount = 5;
  String selectedFilter = "none";
  bool isFlashOn = false;
  double exposureValue = 0.0;
  double contrastValue = 0.0;
  double brightnessValue = 0.0;
  double saturationValue = 0.0;
  
  List<Map<String, dynamic>> captureHistory = [
    {
      "id": "1",
      "timestamp": "2024-01-15 14:30:00",
      "photos": [
        {
          "url": "https://picsum.photos/300/400?random=1&keyword=portrait",
          "filter": "Vivid",
          "settings": {"exposure": 0.2, "contrast": 0.1, "brightness": 0.0}
        },
        {
          "url": "https://picsum.photos/400/300?random=2&keyword=landscape", 
          "filter": "Natural",
          "settings": {"exposure": -0.1, "contrast": 0.2, "brightness": 0.1}
        },
      ],
      "mode": "single",
      "location": "Central Park, NY"
    },
    {
      "id": "2",
      "timestamp": "2024-01-15 12:15:00",
      "photos": [
        {
          "url": "https://picsum.photos/300/300?random=3&keyword=nature",
          "filter": "Vintage",
          "settings": {"exposure": 0.0, "contrast": 0.3, "brightness": -0.1}
        },
        {
          "url": "https://picsum.photos/400/400?random=4&keyword=architecture",
          "filter": "Black & White", 
          "settings": {"exposure": 0.1, "contrast": 0.4, "brightness": 0.2}
        },
      ],
      "mode": "burst",
      "location": "Brooklyn Bridge"
    },
    {
      "id": "3", 
      "timestamp": "2024-01-14 18:20:00",
      "photos": [
        {
          "url": "https://picsum.photos/400/300?random=5&keyword=city",
          "filter": "Cool",
          "settings": {"exposure": -0.2, "contrast": 0.0, "brightness": 0.3}
        },
      ],
      "mode": "single",
      "location": "Times Square"
    },
  ];

  List<Map<String, dynamic>> filters = [
    {"name": "None", "value": "none", "preview": "https://picsum.photos/100/100?random=101&keyword=filter"},
    {"name": "Vivid", "value": "vivid", "preview": "https://picsum.photos/100/100?random=102&keyword=filter"},
    {"name": "Natural", "value": "natural", "preview": "https://picsum.photos/100/100?random=103&keyword=filter"},
    {"name": "Vintage", "value": "vintage", "preview": "https://picsum.photos/100/100?random=104&keyword=filter"},
    {"name": "Black & White", "value": "bw", "preview": "https://picsum.photos/100/100?random=105&keyword=filter"},
    {"name": "Cool", "value": "cool", "preview": "https://picsum.photos/100/100?random=106&keyword=filter"},
    {"name": "Warm", "value": "warm", "preview": "https://picsum.photos/100/100?random=107&keyword=filter"},
    {"name": "Sepia", "value": "sepia", "preview": "https://picsum.photos/100/100?random=108&keyword=filter"},
  ];

  List<Map<String, dynamic>> captureModes = [
    {
      "name": "Single Shot",
      "value": "single",
      "icon": Icons.camera_alt,
      "description": "Take one photo at a time"
    },
    {
      "name": "Burst Mode",
      "value": "burst", 
      "icon": Icons.burst_mode,
      "description": "Take multiple photos quickly"
    },
    {
      "name": "Timer Mode",
      "value": "timer",
      "icon": Icons.timer,
      "description": "Delayed capture with countdown"
    },
    {
      "name": "HDR Mode",
      "value": "hdr",
      "icon": Icons.hdr_on,
      "description": "High dynamic range photography"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Photo Capture",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Capture", icon: Icon(Icons.camera)),
        Tab(text: "Settings", icon: Icon(Icons.tune)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildCaptureTab(),
        _buildSettingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildCaptureTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Camera Preview
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Stack(
              children: [
                // Preview Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400/350?random=200&keyword=preview"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Controls Overlay
                Positioned(
                  top: spMd,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flash Toggle
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFlashOn = !isFlashOn;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: isFlashOn ? warningColor : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      // Mode Indicator
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedMode.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Settings Access
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentTab = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Center Focus Point
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withAlpha(200),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.center_focus_strong,
                      color: Colors.white.withAlpha(200),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Quick Filter Selection
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Filters",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                QHorizontalScroll(
                  children: filters.map((filter) {
                    bool isSelected = selectedFilter == filter["value"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter["value"];
                        });
                      },
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage("${filter["preview"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${filter["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
              ],
            ),
          ),
          
          // Capture Mode Selection
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capture Mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: captureModes.map((mode) {
                    bool isSelected = selectedMode == mode["value"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMode = mode["value"];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Icon(
                              mode["icon"],
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 32,
                            ),
                            Text(
                              "${mode["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${mode["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Additional Settings for Burst Mode
          if (selectedMode == "burst")
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Burst Settings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Number of Photos",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${burstCount}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [3, 5, 7, 10].map((count) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              burstCount = count;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: burstCount == count ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: burstCount == count ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "$count",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: burstCount == count ? Colors.white : disabledBoldColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          
          // Capture Button
          Container(
            height: 80,
            width: 80,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isCapturing = true;
                });
                
                // Simulate capture delay
                await Future.delayed(Duration(milliseconds: 800));
                
                setState(() {
                  isCapturing = false;
                  capturedPhotos.add("https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}&keyword=captured");
                });
                
                String message = selectedMode == "burst" ? 
                  "Captured $burstCount photos in burst mode!" : 
                  "Photo captured successfully!";
                ss(message);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isCapturing ? dangerColor : primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [shadowMd],
                ),
                child: isCapturing 
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Icon(
                      selectedMode == "burst" ? Icons.burst_mode :
                      selectedMode == "timer" ? Icons.timer : Icons.camera_alt,
                      color: Colors.white,
                      size: 32,
                    ),
              ),
            ),
          ),
          
          // Recent Captures Preview
          if (capturedPhotos.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Captures",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            capturedPhotos.clear();
                          });
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: capturedPhotos.map((photo) {
                      return Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage(photo),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [shadowXs],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Exposure Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exposure Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                // Exposure
                Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exposure",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${exposureValue.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: exposureValue,
                      min: -2.0,
                      max: 2.0,
                      divisions: 40,
                      onChanged: (value) {
                        setState(() {
                          exposureValue = value;
                        });
                      },
                    ),
                  ],
                ),
                
                // Contrast
                Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contrast",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${contrastValue.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: contrastValue,
                      min: -1.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: (value) {
                        setState(() {
                          contrastValue = value;
                        });
                      },
                    ),
                  ],
                ),
                
                // Brightness
                Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brightness",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${brightnessValue.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: brightnessValue,
                      min: -1.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: (value) {
                        setState(() {
                          brightnessValue = value;
                        });
                      },
                    ),
                  ],
                ),
                
                // Saturation
                Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saturation",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${saturationValue.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: saturationValue,
                      min: -1.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: (value) {
                        setState(() {
                          saturationValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Advanced Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Advanced Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  minItemWidth: 100,
                  children: filters.map((filter) {
                    bool isSelected = selectedFilter == filter["value"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter["value"];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${filter["preview"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${filter["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
              ],
            ),
          ),
          
          // Reset Settings
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Reset All",
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      exposureValue = 0.0;
                      contrastValue = 0.0;
                      brightnessValue = 0.0;
                      saturationValue = 0.0;
                      selectedFilter = "none";
                    });
                    ss("Settings reset to default");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Apply Preset",
                  icon: Icons.auto_fix_high,
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      exposureValue = 0.2;
                      contrastValue = 0.1;
                      brightnessValue = 0.1;
                      saturationValue = 0.2;
                      selectedFilter = "vivid";
                    });
                    ss("Vivid preset applied");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capture Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: [
                    _buildStatCard("Total Photos", "127", Icons.camera_alt, primaryColor),
                    _buildStatCard("This Week", "23", Icons.date_range, successColor),
                    _buildStatCard("Favorites", "45", Icons.favorite, dangerColor),
                    _buildStatCard("Shared", "12", Icons.share, infoColor),
                  ],
                ),
              ],
            ),
          ),
          
          // Capture Sessions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Sessions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...captureHistory.map((session) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTime.parse(session["timestamp"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${session["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${session["mode"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Photos Grid
                        QHorizontalScroll(
                          children: (session["photos"] as List).map((photo) {
                            return Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${photo["url"]}"),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [shadowXs],
                              ),
                              child: Stack(
                                children: [
                                  // Filter Badge
                                  Positioned(
                                    top: 4,
                                    left: 4,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: BorderRadius.circular(radiusXxs),
                                      ),
                                      child: Text(
                                        "${photo["filter"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Clear History
          Container(
            width: double.infinity,
            child: QButton(
              label: "Clear History",
              icon: Icons.delete_outline,
              size: bs.md,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to clear all capture history?");
                if (isConfirmed) {
                  setState(() {
                    captureHistory.clear();
                    capturedPhotos.clear();
                  });
                  ss("Capture history cleared");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
