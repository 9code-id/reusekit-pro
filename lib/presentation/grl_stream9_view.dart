import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream9View extends StatefulWidget {
  @override
  State<GrlStream9View> createState() => _GrlStream9ViewState();
}

class _GrlStream9ViewState extends State<GrlStream9View> {
  String streamTitle = "";
  String streamDescription = "";
  String selectedCategory = "Gaming";
  String selectedPrivacy = "Public";
  String selectedQuality = "720p";
  bool enableChat = true;
  bool enableSuperChat = true;
  bool enableNotifications = true;
  bool recordStream = false;
  bool enableModerator = true;
  List<String> selectedTags = [];
  String thumbnailImage = "";
  String streamKey = "live_sk_abc123def456ghi789";
  String rtmpUrl = "rtmp://stream.platform.com/live/";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Gaming", "value": "Gaming"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Education", "value": "Education"},
    {"label": "Music", "value": "Music"},
    {"label": "Art & Design", "value": "Art & Design"},
    {"label": "Cooking", "value": "Cooking"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Unlisted", "value": "Unlisted"},
    {"label": "Private", "value": "Private"},
    {"label": "Members Only", "value": "Members Only"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "1080p (HD)", "value": "1080p"},
    {"label": "720p (HD)", "value": "720p"},
    {"label": "480p", "value": "480p"},
    {"label": "360p", "value": "360p"},
  ];

  List<Map<String, dynamic>> availableTags = [
    {"label": "Tutorial", "value": "tutorial"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Advanced", "value": "advanced"},
    {"label": "Live Coding", "value": "live-coding"},
    {"label": "Q&A", "value": "qa"},
    {"label": "Review", "value": "review"},
    {"label": "Tips", "value": "tips"},
    {"label": "Demo", "value": "demo"},
  ];

  List<Map<String, dynamic>> chatSettings = [
    {
      "title": "Enable Chat",
      "subtitle": "Allow viewers to chat during stream",
      "value": "enableChat",
    },
    {
      "title": "Super Chat",
      "subtitle": "Allow paid messages and donations",
      "value": "enableSuperChat",
    },
    {
      "title": "Chat Moderation",
      "subtitle": "Enable automatic moderation tools",
      "value": "enableModerator",
    },
  ];

  List<Map<String, dynamic>> streamSettings = [
    {
      "title": "Push Notifications",
      "subtitle": "Notify followers when you go live",
      "value": "enableNotifications",
    },
    {
      "title": "Record Stream",
      "subtitle": "Save stream for later viewing",
      "value": "recordStream",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Configuration"),
        actions: [
          GestureDetector(
            onTap: () => _saveSettings(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.save, size: 24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information
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
              hint: "Enter an engaging title for your stream",
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

            // Thumbnail Upload
            QImagePicker(
              label: "Stream Thumbnail",
              value: thumbnailImage,
              hint: "Upload a custom thumbnail (optional)",
              onChanged: (value) {
                thumbnailImage = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Category and Privacy
            Text(
              "Stream Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
            SizedBox(height: spSm),

            QDropdownField(
              label: "Stream Quality",
              items: qualityOptions,
              value: selectedQuality,
              onChanged: (value, label) {
                selectedQuality = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Tags Selection
            Text(
              "Tags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Text(
              "Add tags to help viewers find your stream",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),

            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: availableTags.map((tag) {
                bool isSelected = selectedTags.contains(tag["value"]);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedTags.remove(tag["value"]);
                    } else {
                      if (selectedTags.length < 5) {
                        selectedTags.add(tag["value"]);
                      } else {
                        sw("Maximum 5 tags allowed");
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      "${tag["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Chat Settings
            Text(
              "Chat Settings",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    title: "Enable Chat",
                    subtitle: "Allow viewers to chat during stream",
                    value: enableChat,
                    onChanged: (value) {
                      enableChat = value;
                      setState(() {});
                    },
                  ),
                  Divider(),
                  _buildSettingItem(
                    title: "Super Chat",
                    subtitle: "Allow paid messages and donations",
                    value: enableSuperChat,
                    onChanged: (value) {
                      enableSuperChat = value;
                      setState(() {});
                    },
                  ),
                  Divider(),
                  _buildSettingItem(
                    title: "Chat Moderation",
                    subtitle: "Enable automatic moderation tools",
                    value: enableModerator,
                    onChanged: (value) {
                      enableModerator = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Advanced Settings
            Text(
              "Advanced Settings",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    title: "Push Notifications",
                    subtitle: "Notify followers when you go live",
                    value: enableNotifications,
                    onChanged: (value) {
                      enableNotifications = value;
                      setState(() {});
                    },
                  ),
                  Divider(),
                  _buildSettingItem(
                    title: "Record Stream",
                    subtitle: "Save stream for later viewing",
                    value: recordStream,
                    onChanged: (value) {
                      recordStream = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // RTMP Settings
            Text(
              "RTMP Configuration",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RTMP URL",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          rtmpUrl,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("RTMP URL copied to clipboard");
                        },
                        child: Icon(
                          Icons.copy,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "Stream Key",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          streamKey,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Stream key copied to clipboard");
                        },
                        child: Icon(
                          Icons.copy,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          _regenerateStreamKey();
                        },
                        child: Icon(
                          Icons.refresh,
                          size: 16,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: warningColor, width: 1),
                    ),
                    child: Text(
                      "⚠️ Keep your stream key private. Don't share it publicly.",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Test Configuration",
                    size: bs.md,
                    onPressed: () {
                      _testConfiguration();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Save & Start Stream",
                    color: successColor,
                    size: bs.md,
                    onPressed: () {
                      _saveAndStartStream();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _saveSettings() {
    if (streamTitle.isEmpty) {
      se("Please enter a stream title");
      return;
    }
    
    ss("Stream settings saved successfully");
  }

  void _testConfiguration() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Configuration test completed successfully");
    });
  }

  void _saveAndStartStream() {
    if (streamTitle.isEmpty) {
      se("Please enter a stream title");
      return;
    }
    
    if (streamDescription.isEmpty) {
      se("Please enter a stream description");
      return;
    }
    
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Stream configuration saved! Ready to go live.");
      back();
    });
  }

  void _regenerateStreamKey() async {
    bool isConfirmed = await confirm("Regenerate stream key? This will invalidate your current key.");
    
    if (isConfirmed) {
      streamKey = "live_sk_${DateTime.now().millisecondsSinceEpoch}";
      setState(() {});
      ss("New stream key generated");
    }
  }
}
