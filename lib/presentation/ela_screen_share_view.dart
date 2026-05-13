import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaScreenShareView extends StatefulWidget {
  const ElaScreenShareView({super.key});

  @override
  State<ElaScreenShareView> createState() => _ElaScreenShareViewState();
}

class _ElaScreenShareViewState extends State<ElaScreenShareView> {
  bool isSharing = false;
  String selectedSource = "entire_screen";
  bool audioEnabled = true;
  bool annotationsEnabled = true;
  
  List<Map<String, dynamic>> shareOptions = [
    {
      "id": "entire_screen",
      "title": "Entire Screen",
      "description": "Share your complete desktop",
      "icon": Icons.desktop_windows,
    },
    {
      "id": "application_window",
      "title": "Application Window",
      "description": "Share a specific application",
      "icon": Icons.app_shortcut,
    },
    {
      "id": "browser_tab",
      "title": "Browser Tab",
      "description": "Share a specific browser tab",
      "icon": Icons.tab,
    },
    {
      "id": "presentation",
      "title": "Presentation",
      "description": "Share presentation files",
      "icon": Icons.slideshow,
    },
  ];

  List<Map<String, dynamic>> availableApplications = [
    {
      "name": "PowerPoint - Math Presentation",
      "icon": Icons.slideshow,
      "type": "presentation",
    },
    {
      "name": "Chrome - Physics Tutorial",
      "icon": Icons.web,
      "type": "browser",
    },
    {
      "name": "Calculator",
      "icon": Icons.calculate,
      "type": "application",
    },
    {
      "name": "Notepad - Class Notes",
      "icon": Icons.note,
      "type": "application",
    },
    {
      "name": "GeoGebra - Math Visualizer",
      "icon": Icons.functions,
      "type": "application",
    },
  ];

  List<Map<String, dynamic>> participants = [
    {
      "name": "Alice Johnson",
      "role": "Student",
      "canAnnotate": true,
      "isAnnotating": false,
      "avatarUrl": "https://picsum.photos/100/100?random=1",
    },
    {
      "name": "Bob Smith",
      "role": "Student",
      "canAnnotate": false,
      "isAnnotating": false,
      "avatarUrl": "https://picsum.photos/100/100?random=2",
    },
    {
      "name": "Carol Davis",
      "role": "Student",
      "canAnnotate": true,
      "isAnnotating": true,
      "avatarUrl": "https://picsum.photos/100/100?random=3",
    },
    {
      "name": "David Wilson",
      "role": "Student",
      "canAnnotate": false,
      "isAnnotating": false,
      "avatarUrl": "https://picsum.photos/100/100?random=4",
    },
  ];

  Widget _buildShareOptionsGrid() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select what to share",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: shareOptions.map((option) => _buildShareOptionCard(option)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOptionCard(Map<String, dynamic> option) {
    final isSelected = selectedSource == option["id"];
    
    return GestureDetector(
      onTap: () {
        selectedSource = option["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              option["icon"] as IconData,
              size: 48,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
            SizedBox(height: spSm),
            Text(
              "${option["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              "${option["description"]}",
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
  }

  Widget _buildApplicationList() {
    if (selectedSource != "application_window") return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Applications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...availableApplications.map((app) => _buildApplicationCard(app)),
        ],
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> app) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor),
      ),
      child: Row(
        children: [
          Icon(
            app["icon"] as IconData,
            size: 32,
            color: primaryColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${app["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${app["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Select",
            size: bs.sm,
            onPressed: () {
              ss("Selected ${app["name"]} for sharing");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShareControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                audioEnabled ? Icons.volume_up : Icons.volume_off,
                color: audioEnabled ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Share Audio",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch(
                value: audioEnabled,
                onChanged: (value) {
                  audioEnabled = value;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                annotationsEnabled ? Icons.edit : Icons.edit_off,
                color: annotationsEnabled ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Allow Annotations",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch(
                value: annotationsEnabled,
                onChanged: (value) {
                  annotationsEnabled = value;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: isSharing ? "Stop Sharing" : "Start Sharing",
              onPressed: () {
                isSharing = !isSharing;
                setState(() {});
                if (isSharing) {
                  ss("Screen sharing started");
                } else {
                  sw("Screen sharing stopped");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveShareView() {
    if (!isSharing) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Currently Sharing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Stop",
                size: bs.sm,
                onPressed: () {
                  isSharing = false;
                  setState(() {});
                  sw("Screen sharing stopped");
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor, width: 2),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400/300?random=10&keyword=presentation"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(102),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.screen_share,
                        color: Colors.white,
                        size: 48,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Sharing: ${_getShareSourceTitle()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Pause",
                  onPressed: () {
                    sw("Screen sharing paused");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {
                  ss("Entered fullscreen sharing mode");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {
                  ss("Opened sharing settings");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantAnnotations() {
    if (!isSharing || !annotationsEnabled) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Annotation Permissions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...participants.map((participant) => _buildParticipantAnnotationCard(participant)),
        ],
      ),
    );
  }

  Widget _buildParticipantAnnotationCard(Map<String, dynamic> participant) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${participant["avatarUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${participant["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${participant["role"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (participant["isAnnotating"] as bool)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Annotating",
                style: TextStyle(
                  fontSize: 10,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SizedBox(width: spSm),
          Switch(
            value: participant["canAnnotate"] as bool,
            onChanged: (value) {
              participant["canAnnotate"] = value;
              if (!value) participant["isAnnotating"] = false;
              setState(() {});
              ss("Annotation permission ${value ? "granted" : "revoked"} for ${participant["name"]}");
            },
          ),
        ],
      ),
    );
  }

  String _getShareSourceTitle() {
    final option = shareOptions.firstWhere((opt) => opt["id"] == selectedSource);
    return option["title"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen Share"),
        actions: [
          if (isSharing)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    "SHARING",
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
            if (!isSharing) ...[
              _buildShareOptionsGrid(),
              _buildApplicationList(),
            ],
            _buildShareControls(),
            _buildActiveShareView(),
            _buildParticipantAnnotations(),
          ],
        ),
      ),
    );
  }
}
