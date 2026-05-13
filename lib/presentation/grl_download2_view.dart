import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload2View extends StatefulWidget {
  @override
  State<GrlDownload2View> createState() => _GrlDownload2ViewState();
}

class _GrlDownload2ViewState extends State<GrlDownload2View> {
  int currentTab = 0;
  String url = "";
  String fileName = "";
  String selectedQuality = "1080p";
  String selectedFormat = "MP4";
  String savePath = "/Downloads/Videos/";
  bool autoRetry = true;
  bool notifyOnComplete = true;

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "4K (2160p)", "value": "4K"},
    {"label": "1080p HD", "value": "1080p"},
    {"label": "720p HD", "value": "720p"},
    {"label": "480p", "value": "480p"},
    {"label": "360p", "value": "360p"},
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "MP4", "value": "MP4"},
    {"label": "AVI", "value": "AVI"},
    {"label": "MOV", "value": "MOV"},
    {"label": "MKV", "value": "MKV"},
    {"label": "MP3 (Audio Only)", "value": "MP3"},
  ];

  List<Map<String, dynamic>> recentDownloads = [
    {
      "title": "Machine Learning Tutorial Series",
      "url": "https://youtube.com/watch?v=example1",
      "duration": "02:45:30",
      "size": "1.2 GB",
      "quality": "1080p",
      "format": "MP4",
      "downloadDate": "2024-12-21",
    },
    {
      "title": "Python Programming Fundamentals",
      "url": "https://vimeo.com/example2",
      "duration": "01:30:15",
      "size": "850 MB",
      "quality": "720p",
      "format": "MP4",
      "downloadDate": "2024-12-20",
    },
    {
      "title": "Data Science Workshop Recording",
      "url": "https://youtube.com/watch?v=example3",
      "duration": "03:20:45",
      "size": "2.1 GB",
      "quality": "1080p",
      "format": "MP4",
      "downloadDate": "2024-12-19",
    },
  ];

  List<Map<String, dynamic>> supportedSites = [
    {
      "name": "YouTube",
      "icon": Icons.video_library,
      "color": dangerColor,
      "supported": true,
      "description": "Download videos and playlists in various qualities",
    },
    {
      "name": "Vimeo",
      "icon": Icons.videocam,
      "color": infoColor,
      "supported": true,
      "description": "High-quality video downloads with original quality",
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": primaryColor,
      "supported": true,
      "description": "Download public videos and live streams",
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": warningColor,
      "supported": true,
      "description": "Download photos, videos, and stories",
    },
    {
      "name": "Twitter",
      "icon": Icons.chat,
      "color": infoColor,
      "supported": true,
      "description": "Download videos and GIFs from tweets",
    },
    {
      "name": "TikTok",
      "icon": Icons.music_video,
      "color": secondaryColor,
      "supported": false,
      "description": "Coming soon - TikTok video downloads",
    },
  ];

  Widget _buildDownloadTab() {
    return Column(
      spacing: spMd,
      children: [
        // URL Input
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.download,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Video Downloader",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Paste the video URL below to start downloading",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // URL Input Field
        QTextField(
          label: "Video URL",
          value: url,
          hint: "https://youtube.com/watch?v=example",
          onChanged: (value) {
            url = value;
            setState(() {});
          },
        ),

        // Quick Action Buttons
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Paste URL",
                size: bs.sm,
                icon: Icons.paste,
                onPressed: () {},
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Analyze URL",
                size: bs.sm,
                icon: Icons.search,
                onPressed: url.isNotEmpty ? () {} : null,
              ),
            ),
          ],
        ),

        // Download Settings
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Download Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Custom File Name (Optional)",
                value: fileName,
                hint: "Leave empty to use original name",
                onChanged: (value) {
                  fileName = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Quality",
                      items: qualityOptions,
                      value: selectedQuality,
                      onChanged: (value, label) {
                        selectedQuality = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Format",
                      items: formatOptions,
                      value: selectedFormat,
                      onChanged: (value, label) {
                        selectedFormat = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QTextField(
                label: "Save Location",
                value: savePath,
                hint: "/Downloads/Videos/",
                onChanged: (value) {
                  savePath = value;
                  setState(() {});
                },
              ),

              // Advanced Options
              QSwitch(
                items: [
                  {
                    "label": "Auto-retry on failure",
                    "value": "retry",
                    "checked": autoRetry,
                  }
                ],
                value: autoRetry ? [{"label": "Auto-retry on failure", "value": "retry", "checked": true}] : [],
                onChanged: (values, ids) {
                  autoRetry = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Notify when download completes",
                    "value": "notify",
                    "checked": notifyOnComplete,
                  }
                ],
                value: notifyOnComplete ? [{"label": "Notify when download completes", "value": "notify", "checked": true}] : [],
                onChanged: (values, ids) {
                  notifyOnComplete = values.isNotEmpty;
                  setState(() {});
                },
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Download Video",
                  size: bs.md,
                  icon: Icons.download,
                  onPressed: url.isNotEmpty ? () {} : null,
                ),
              ),
            ],
          ),
        ),

        // Supported Sites
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Supported Platforms",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: supportedSites.map((site) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: site["supported"] == true 
                          ? (site["color"] as Color).withAlpha(20)
                          : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: site["supported"] == true 
                            ? (site["color"] as Color).withAlpha(50)
                            : disabledColor.withAlpha(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          site["icon"] as IconData,
                          color: site["supported"] == true 
                              ? site["color"] as Color
                              : disabledColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${site["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: site["supported"] == true 
                                      ? site["color"] as Color
                                      : disabledColor,
                                ),
                              ),
                              Text(
                                "${site["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (site["supported"] == true)
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          )
                        else
                          Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 20,
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      spacing: spMd,
      children: [
        // History Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: infoColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Download History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Your recent video downloads and settings",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Clear All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Recent Downloads
        ...recentDownloads.map((download) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.video_library,
                        color: successColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${download["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${download["url"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Video Details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Duration: ${download["duration"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.file_download,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Size: ${download["size"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.high_quality,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Quality: ${download["quality"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.video_file,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Format: ${download["format"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Downloaded: ${DateTime.parse(download["downloadDate"] as String).dMMMy}",
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

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download Again",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.copy,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.delete_outline,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        }),

        // Load More
        Container(
          width: double.infinity,
          child: QButton(
            label: "Load More History",
            size: bs.md,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Download Preferences
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Default Download Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Default Quality",
                items: qualityOptions,
                value: selectedQuality,
                onChanged: (value, label) {
                  selectedQuality = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Default Format",
                items: formatOptions,
                value: selectedFormat,
                onChanged: (value, label) {
                  selectedFormat = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Default Save Location",
                value: savePath,
                onChanged: (value) {
                  savePath = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Advanced Settings
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Advanced Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label": "Auto-retry failed downloads",
                    "value": "retry",
                    "checked": autoRetry,
                  }
                ],
                value: autoRetry ? [{"label": "Auto-retry failed downloads", "value": "retry", "checked": true}] : [],
                onChanged: (values, ids) {
                  autoRetry = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Show completion notifications",
                    "value": "notify",
                    "checked": notifyOnComplete,
                  }
                ],
                value: notifyOnComplete ? [{"label": "Show completion notifications", "value": "notify", "checked": true}] : [],
                onChanged: (values, ids) {
                  notifyOnComplete = values.isNotEmpty;
                  setState(() {});
                },
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Settings",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Storage Management
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: warningColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.storage,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Storage Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Used Space",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "8.4 GB",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Space",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "15.6 GB",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Clear Cache",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Manage Files",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Video Downloader",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Download", icon: Icon(Icons.download)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildDownloadTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildHistoryTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSettingsTab(),
        ),
      ],
    );
  }
}
