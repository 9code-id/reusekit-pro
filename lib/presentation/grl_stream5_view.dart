import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream5View extends StatefulWidget {
  @override
  State<GrlStream5View> createState() => _GrlStream5ViewState();
}

class _GrlStream5ViewState extends State<GrlStream5View> {
  bool isRecording = false;
  bool isMicEnabled = true;
  bool isCameraEnabled = true;
  bool isScreenSharing = false;
  String streamTitle = "";
  String streamDescription = "";
  String selectedCategory = "Gaming";
  String selectedPrivacy = "Public";
  int estimatedViewers = 0;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Gaming", "value": "Gaming"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Education", "value": "Education"},
    {"label": "Music", "value": "Music"},
    {"label": "Art", "value": "Art"},
    {"label": "Cooking", "value": "Cooking"},
  ];

  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Unlisted", "value": "Unlisted"},
    {"label": "Private", "value": "Private"},
  ];

  List<Map<String, dynamic>> streamStats = [
    {"label": "Duration", "value": "01:23:45", "icon": Icons.access_time},
    {"label": "Viewers", "value": "234", "icon": Icons.visibility},
    {"label": "Likes", "value": "89", "icon": Icons.favorite},
    {"label": "Comments", "value": "156", "icon": Icons.chat},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Stream Setup"),
        actions: [
          if (isRecording)
            Container(
              margin: EdgeInsets.only(right: spMd),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "LIVE",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stream Preview
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Camera Preview
                  if (isCameraEnabled)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/400/200?random=402&keyword=camera'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            color: disabledBoldColor,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Camera Off",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Screen Share Overlay
                  if (isScreenSharing)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.screen_share,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Screen Sharing",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Control Buttons
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isMicEnabled = !isMicEnabled;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isMicEnabled 
                                  ? Colors.black.withAlpha(178) 
                                  : dangerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isMicEnabled ? Icons.mic : Icons.mic_off,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            isCameraEnabled = !isCameraEnabled;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isCameraEnabled 
                                  ? Colors.black.withAlpha(178) 
                                  : dangerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCameraEnabled ? Icons.videocam : Icons.videocam_off,
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
            SizedBox(height: spMd),

            // Stream Information
            Text(
              "Stream Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QTextField(
              label: "Stream Title",
              value: streamTitle,
              hint: "Enter your stream title",
              onChanged: (value) {
                streamTitle = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QMemoField(
              label: "Description",
              value: streamDescription,
              hint: "Describe what you'll be streaming about",
              onChanged: (value) {
                streamDescription = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Privacy",
                    items: privacyOptions,
                    value: selectedPrivacy,
                    onChanged: (value, label) {
                      selectedPrivacy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Stream Settings
            Text(
              "Stream Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.screen_share,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Screen Sharing",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: isScreenSharing,
                        onChanged: (value) {
                          isScreenSharing = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  if (isScreenSharing) ...[
                    Divider(),
                    Text(
                      "Screen sharing will capture your entire screen. Make sure to close any private information.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Stream Stats (when live)
            if (isRecording) ...[
              Text(
                "Live Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: streamStats.map((stat) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              stat["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${stat["label"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
            ],

            // Start/Stop Stream Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isRecording ? "Stop Stream" : "Start Stream",
                color: isRecording ? dangerColor : successColor,
                size: bs.md,
                onPressed: () {
                  isRecording = !isRecording;
                  if (isRecording) {
                    estimatedViewers = 0;
                    ss("Stream started successfully!");
                  } else {
                    se("Stream ended");
                  }
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: spSm),

            // Preview Button
            if (!isRecording)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Test Preview",
                  size: bs.md,
                  onPressed: () {
                    si("Preview mode activated");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
