import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCamera3View extends StatefulWidget {
  @override
  State<GrlCamera3View> createState() => _GrlCamera3ViewState();
}

class _GrlCamera3ViewState extends State<GrlCamera3View> {
  String resolution = "4K";
  String frameRate = "30fps";
  String quality = "High";
  String format = "MP4";
  bool stabilization = true;
  bool autoFocus = true;
  bool touchToFocus = true;
  double audioGain = 0.5;
  String micSource = "Device";
  bool windNoiseReduction = true;
  
  // Storage settings
  String storageLocation = "Internal";
  bool autoBackup = false;
  bool compressVideos = false;
  
  // Advanced settings
  String colorProfile = "Standard";
  double bitrate = 100.0;
  bool hdr = false;
  String whiteBalance = "Auto";
  double iso = 100.0;
  double shutterSpeed = 60.0;

  List<String> resolutionOptions = ["4K", "1080p", "720p", "480p"];
  List<String> frameRateOptions = ["60fps", "30fps", "24fps"];
  List<String> qualityOptions = ["High", "Medium", "Low"];
  List<String> formatOptions = ["MP4", "MOV", "AVI"];
  List<String> micOptions = ["Device", "External", "Bluetooth"];
  List<String> storageOptions = ["Internal", "SD Card", "Cloud"];
  List<String> colorProfileOptions = ["Standard", "Vivid", "Natural", "Cinema"];
  List<String> whiteBalanceOptions = ["Auto", "Daylight", "Cloudy", "Tungsten", "Fluorescent"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Reset to defaults
              setState(() {
                resolution = "4K";
                frameRate = "30fps";
                quality = "High";
                format = "MP4";
                stabilization = true;
                autoFocus = true;
                touchToFocus = true;
                audioGain = 0.5;
                micSource = "Device";
                windNoiseReduction = true;
                storageLocation = "Internal";
                autoBackup = false;
                compressVideos = false;
                colorProfile = "Standard";
                bitrate = 100.0;
                hdr = false;
                whiteBalance = "Auto";
                iso = 100.0;
                shutterSpeed = 60.0;
              });
              ss("Settings reset to defaults");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.videocam,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Video Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Resolution",
                    items: resolutionOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: resolution,
                    onChanged: (value, label) {
                      resolution = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Frame Rate",
                    items: frameRateOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: frameRate,
                    onChanged: (value, label) {
                      frameRate = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Quality",
                    items: qualityOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: quality,
                    onChanged: (value, label) {
                      quality = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Video Format",
                    items: formatOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: format,
                    onChanged: (value, label) {
                      format = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Camera Features
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Camera Features",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    label: "Image Stabilization",
                    items: [
                      {
                        "label": "Enable optical image stabilization",
                        "value": true,
                        "checked": stabilization,
                      }
                    ],
                    value: [
                      if (stabilization)
                        {
                          "label": "Enable optical image stabilization",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        stabilization = values.isNotEmpty;
                      });
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "Auto Focus",
                    items: [
                      {
                        "label": "Enable continuous auto focus",
                        "value": true,
                        "checked": autoFocus,
                      }
                    ],
                    value: [
                      if (autoFocus)
                        {
                          "label": "Enable continuous auto focus",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        autoFocus = values.isNotEmpty;
                      });
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "Touch to Focus",
                    items: [
                      {
                        "label": "Tap to focus on specific areas",
                        "value": true,
                        "checked": touchToFocus,
                      }
                    ],
                    value: [
                      if (touchToFocus)
                        {
                          "label": "Tap to focus on specific areas",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        touchToFocus = values.isNotEmpty;
                      });
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "HDR Mode",
                    items: [
                      {
                        "label": "Enable High Dynamic Range",
                        "value": true,
                        "checked": hdr,
                      }
                    ],
                    value: [
                      if (hdr)
                        {
                          "label": "Enable High Dynamic Range",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        hdr = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Audio Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.mic,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Audio Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Microphone Source",
                    items: micOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: micSource,
                    onChanged: (value, label) {
                      micSource = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Audio Gain Slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Audio Gain",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(audioGain * 100).round()}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Slider(
                        value: audioGain,
                        min: 0.0,
                        max: 1.0,
                        divisions: 20,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            audioGain = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "Wind Noise Reduction",
                    items: [
                      {
                        "label": "Reduce wind noise in recordings",
                        "value": true,
                        "checked": windNoiseReduction,
                      }
                    ],
                    value: [
                      if (windNoiseReduction)
                        {
                          "label": "Reduce wind noise in recordings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        windNoiseReduction = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Storage Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage & Backup",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Storage Location",
                    items: storageOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: storageLocation,
                    onChanged: (value, label) {
                      storageLocation = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "Auto Backup",
                    items: [
                      {
                        "label": "Automatically backup photos and videos",
                        "value": true,
                        "checked": autoBackup,
                      }
                    ],
                    value: [
                      if (autoBackup)
                        {
                          "label": "Automatically backup photos and videos",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        autoBackup = values.isNotEmpty;
                      });
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    label: "Compress Videos",
                    items: [
                      {
                        "label": "Compress videos to save storage space",
                        "value": true,
                        "checked": compressVideos,
                      }
                    ],
                    value: [
                      if (compressVideos)
                        {
                          "label": "Compress videos to save storage space",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        compressVideos = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Advanced Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings_applications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Advanced Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Color Profile",
                    items: colorProfileOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: colorProfile,
                    onChanged: (value, label) {
                      colorProfile = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "White Balance",
                    items: whiteBalanceOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: whiteBalance,
                    onChanged: (value, label) {
                      whiteBalance = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Bitrate Slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Video Bitrate",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${bitrate.round()} Mbps",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Slider(
                        value: bitrate,
                        min: 10.0,
                        max: 200.0,
                        divisions: 38,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            bitrate = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // ISO Slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "ISO Sensitivity",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${iso.round()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Slider(
                        value: iso,
                        min: 50.0,
                        max: 3200.0,
                        divisions: 32,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            iso = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Settings",
                size: bs.md,
                onPressed: () {
                  ss("Camera settings saved successfully");
                  back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
