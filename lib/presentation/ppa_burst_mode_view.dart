import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBurstModeView extends StatefulWidget {
  const PpaBurstModeView({super.key});

  @override
  State<PpaBurstModeView> createState() => _PpaBurstModeViewState();
}

class _PpaBurstModeViewState extends State<PpaBurstModeView> {
  bool isBurstEnabled = false;
  bool isBurstActive = false;
  int burstCount = 10;
  String burstSpeed = "fast";
  bool autoSelectBest = true;
  bool keepAllPhotos = false;
  int capturedPhotos = 0;
  int totalBurstPhotos = 0;

  List<Map<String, dynamic>> burstCountOptions = [
    {"label": "5 photos", "value": 5},
    {"label": "10 photos", "value": 10},
    {"label": "15 photos", "value": 15},
    {"label": "20 photos", "value": 20},
    {"label": "Unlimited", "value": -1},
  ];

  List<Map<String, dynamic>> speedOptions = [
    {"label": "Slow (2/sec)", "value": "slow"},
    {"label": "Normal (5/sec)", "value": "normal"},
    {"label": "Fast (10/sec)", "value": "fast"},
    {"label": "Ultra Fast (15/sec)", "value": "ultra"},
  ];

  List<Map<String, dynamic>> recentBursts = [
    {
      "id": 1,
      "thumbnail": "https://picsum.photos/120/120?random=1&keyword=portrait",
      "count": 12,
      "timestamp": "2 hours ago",
      "bestSelected": true,
    },
    {
      "id": 2,
      "thumbnail": "https://picsum.photos/120/120?random=2&keyword=action",
      "count": 8,
      "timestamp": "Yesterday",
      "bestSelected": false,
    },
    {
      "id": 3,
      "thumbnail": "https://picsum.photos/120/120?random=3&keyword=sports",
      "count": 15,
      "timestamp": "3 days ago",
      "bestSelected": true,
    },
  ];

  void _startBurst() {
    isBurstActive = true;
    capturedPhotos = 0;
    setState(() {});
    
    // Simulate burst capture (in real app would use camera API)
    // This is just for UI demonstration
  }

  void _stopBurst() {
    isBurstActive = false;
    totalBurstPhotos = capturedPhotos;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Burst Mode"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("Burst mode captures multiple photos rapidly for action shots");
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
            // Burst Mode Toggle
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isBurstEnabled ? primaryColor.withAlpha(25) : disabledColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: isBurstEnabled ? primaryColor : disabledBoldColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Burst Mode",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Capture multiple photos rapidly",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isBurstEnabled,
                    onChanged: (value) {
                      isBurstEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Burst Preview/Status
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Camera preview simulation
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isBurstActive ? successColor : (isBurstEnabled ? primaryColor : disabledBoldColor),
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            isBurstActive ? Icons.camera : Icons.camera_alt,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                        if (isBurstActive) ...[
                          SizedBox(height: spSm),
                          Text(
                            "Capturing... ${capturedPhotos}/${burstCount == -1 ? '∞' : burstCount}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Burst indicator
                  if (isBurstEnabled && !isBurstActive)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.burst_mode, size: 16, color: Colors.white),
                            SizedBox(width: spXs),
                            Text(
                              "BURST",
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

            if (isBurstEnabled) ...[
              // Burst Settings
              Text(
                "Burst Settings",
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
                    // Burst Count
                    QDropdownField(
                      label: "Number of Photos",
                      items: burstCountOptions,
                      value: burstCount,
                      onChanged: (value, label) {
                        burstCount = value;
                        setState(() {});
                      },
                    ),
                    
                    // Burst Speed
                    QDropdownField(
                      label: "Capture Speed",
                      items: speedOptions,
                      value: burstSpeed,
                      onChanged: (value, label) {
                        burstSpeed = value;
                        setState(() {});
                      },
                    ),
                    
                    // Auto Select Best
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto-select Best Photo",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "AI picks the sharpest photo",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoSelectBest,
                          onChanged: (value) {
                            autoSelectBest = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    
                    // Keep All Photos
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Keep All Photos",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Save all burst photos to gallery",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: keepAllPhotos,
                          onChanged: (value) {
                            keepAllPhotos = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Control Button
              Container(
                width: double.infinity,
                child: !isBurstActive
                    ? QButton(
                        label: "Start Burst Capture",
                        icon: Icons.burst_mode,
                        onPressed: _startBurst,
                      )
                    : QButton(
                        label: "Stop Burst",
                        icon: Icons.stop,
                        color: dangerColor,
                        onPressed: _stopBurst,
                      ),
              ),
            ],

            // Recent Bursts
            if (recentBursts.isNotEmpty) ...[
              Text(
                "Recent Burst Photos",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: recentBursts.map((burst) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${burst["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(179),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${burst["count"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Burst of ${burst["count"]} photos",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${burst["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (burst["bestSelected"] == true)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Best photo selected",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening burst photo gallery");
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Usage Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(51)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Burst Mode Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Perfect for action shots and sports\n• Use fast speed for moving subjects\n• Auto-select helps find the best shot\n• Keep device steady during burst",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
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
}
