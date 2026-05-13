import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaShutterSpeedView extends StatefulWidget {
  const PpaShutterSpeedView({super.key});

  @override
  State<PpaShutterSpeedView> createState() => _PpaShutterSpeedViewState();
}

class _PpaShutterSpeedViewState extends State<PpaShutterSpeedView> {
  String shutterMode = "Auto";
  double shutterSpeed = 60.0;
  bool bulbMode = false;
  double bulbDuration = 5.0;
  bool mirrorLockup = false;
  bool electronicalShutter = false;
  String driveMode = "Single";
  double continuousSpeed = 5.0;
  bool antiShock = true;
  bool shutterSound = true;
  String shutterType = "Mechanical";
  bool exposureDelay = false;
  double delayTime = 2.0;
  
  List<Map<String, dynamic>> shutterModes = [
    {"label": "Auto Shutter", "value": "Auto"},
    {"label": "Manual Shutter", "value": "Manual"},
    {"label": "Shutter Priority", "value": "Priority"},
    {"label": "Bulb Mode", "value": "Bulb"},
  ];

  List<Map<String, dynamic>> driveModes = [
    {"label": "Single Shot", "value": "Single"},
    {"label": "Continuous Low", "value": "CL"},
    {"label": "Continuous High", "value": "CH"},
    {"label": "Self-Timer", "value": "Timer"},
  ];

  List<Map<String, dynamic>> shutterTypes = [
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Electronic", "value": "Electronic"},
    {"label": "Electronic Front Curtain", "value": "EFC"},
  ];

  List<String> standardSpeeds = [
    "1/4000", "1/2000", "1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8", "1/4", "1/2", "1", "2", "4", "8", "15", "30"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shutter Speed"),
        actions: [
          Icon(Icons.shutter_speed, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Shutter Speed Preview
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
                  // Mock motion blur effect based on shutter speed
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Stack(
                      children: [
                        Image.network(
                          "https://picsum.photos/400/200?random=7&keyword=motion",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        // Motion blur overlay effect
                        if (shutterSpeed < 30)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withAlpha(26),
                                  Colors.transparent,
                                ],
                                stops: [0.0, 0.5, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Shutter speed indicator
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(179),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        bulbMode ? "BULB" : shutterMode == "Auto" ? "AUTO" : "1/${shutterSpeed.toInt()}",
                        style: TextStyle(
                          color: bulbMode ? Colors.orange : 
                                 shutterMode == "Auto" ? Colors.green : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Shutter type indicator
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(179),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        shutterType == "Mechanical" ? "MECH" :
                        shutterType == "Electronic" ? "ELEC" : "EFC",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Drive mode indicator
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(179),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        driveMode == "Single" ? "S" :
                        driveMode == "CL" ? "CL" :
                        driveMode == "CH" ? "CH" : "T",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Anti-shock indicator
                  if (antiShock)
                    Positioned(
                      bottom: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(179),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 2,
                          children: [
                            Icon(Icons.vibration, color: Colors.blue, size: 10),
                            Text(
                              "AS",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Shutter Mode Settings
            Container(
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
                    "Shutter Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Mode",
                    items: shutterModes,
                    value: shutterMode,
                    onChanged: (value, label) {
                      shutterMode = value;
                      bulbMode = value == "Bulb";
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Shutter Type",
                    items: shutterTypes,
                    value: shutterType,
                    onChanged: (value, label) {
                      shutterType = value;
                      electronicalShutter = value == "Electronic";
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Shutter Speed Control
            if (!bulbMode)
              Container(
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
                      "Shutter Speed Control",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (shutterMode != "Auto") ...[
                      Text(
                        "Speed: 1/${shutterSpeed.toInt()} sec",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.speed, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Slider(
                              value: shutterSpeed,
                              min: 1.0,
                              max: 4000.0,
                              divisions: 100,
                              onChanged: (value) {
                                shutterSpeed = value;
                                setState(() {});
                              },
                              activeColor: primaryColor,
                              inactiveColor: disabledColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Icon(Icons.speed, color: primaryColor, size: 16),
                        ],
                      ),
                      Text(
                        "Quick Selection",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: standardSpeeds.take(8).map((speed) {
                          return QButton(
                            label: speed,
                            size: bs.sm,
                            onPressed: () {
                              String speedStr = speed.replaceAll("1/", "");
                              shutterSpeed = double.tryParse(speedStr) ?? 60;
                              setState(() {});
                            },
                          );
                        }).toList(),
                      ),
                    ] else ...[
                      Text(
                        "Auto shutter speed enabled",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Camera will automatically select optimal shutter speed based on lighting conditions and subject movement",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            // Bulb Mode Settings
            if (bulbMode)
              Container(
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
                      "Bulb Mode Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Duration: ${bulbDuration.toInt()} seconds",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: bulbDuration,
                      min: 1.0,
                      max: 300.0,
                      divisions: 299,
                      onChanged: (value) {
                        bulbDuration = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                      inactiveColor: disabledColor,
                    ),
                    Text(
                      "Perfect for long exposure photography like star trails, light painting, and night scenes",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Drive Mode Settings
            Container(
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
                    "Drive Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Drive Mode",
                    items: driveModes,
                    value: driveMode,
                    onChanged: (value, label) {
                      driveMode = value;
                      setState(() {});
                    },
                  ),
                  if (driveMode == "CH" || driveMode == "CL") ...[
                    Text(
                      "Continuous Speed: ${continuousSpeed.toStringAsFixed(1)} fps",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: continuousSpeed,
                      min: 1.0,
                      max: 20.0,
                      divisions: 19,
                      onChanged: (value) {
                        continuousSpeed = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                      inactiveColor: disabledColor,
                    ),
                  ],
                  if (driveMode == "Timer") ...[
                    Text(
                      "Timer Delay: ${delayTime.toInt()} seconds",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: delayTime,
                      min: 2.0,
                      max: 30.0,
                      divisions: 28,
                      onChanged: (value) {
                        delayTime = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                      inactiveColor: disabledColor,
                    ),
                  ],
                ],
              ),
            ),

            // Advanced Shutter Settings
            Container(
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
                    "Advanced Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Mirror Lock-up",
                              "value": true,
                              "checked": mirrorLockup,
                            }
                          ],
                          value: [
                            if (mirrorLockup)
                              {
                                "label": "Mirror Lock-up",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            if (shutterType == "Mechanical") {
                              mirrorLockup = values.isNotEmpty;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Anti-Shock",
                              "value": true,
                              "checked": antiShock,
                            }
                          ],
                          value: [
                            if (antiShock)
                              {
                                "label": "Anti-Shock",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            antiShock = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Exposure Delay",
                              "value": true,
                              "checked": exposureDelay,
                            }
                          ],
                          value: [
                            if (exposureDelay)
                              {
                                "label": "Exposure Delay",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            exposureDelay = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Shutter Sound",
                              "value": true,
                              "checked": shutterSound,
                            }
                          ],
                          value: [
                            if (shutterSound)
                              {
                                "label": "Shutter Sound",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            shutterSound = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: bulbMode ? "Start Bulb" : "Take Photo",
                    icon: Icons.camera,
                    size: bs.md,
                    onPressed: () {
                      if (bulbMode) {
                        ss("Bulb exposure started for ${bulbDuration.toInt()} seconds");
                      } else {
                        ss("Photo captured at 1/${shutterSpeed.toInt()} sec");
                      }
                    },
                  ),
                ),
                QButton(
                  icon: Icons.refresh,
                  size: bs.md,
                  onPressed: () {
                    shutterMode = "Auto";
                    shutterSpeed = 60.0;
                    bulbMode = false;
                    driveMode = "Single";
                    mirrorLockup = false;
                    antiShock = true;
                    setState(() {});
                    si("Shutter settings reset");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
