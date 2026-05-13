import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSharingView extends StatefulWidget {
  const PpaSharingView({super.key});

  @override
  State<PpaSharingView> createState() => _PpaSharingViewState();
}

class _PpaSharingViewState extends State<PpaSharingView> {
  List<Map<String, dynamic>> selectedPhotos = [];
  String shareDescription = "";
  bool shareWithOriginalQuality = true;
  bool addWatermark = false;
  String selectedAlbum = "Wedding Photos";
  
  List<Map<String, dynamic>> recentShares = [
    {
      "id": "share_001",
      "title": "Wedding Album",
      "photoCount": 25,
      "sharedWith": ["john@email.com", "sarah@email.com", "family_group"],
      "sharedDate": "2024-06-16",
      "shareMethod": "Email & Link",
      "expiryDate": "2024-07-16",
      "viewCount": 45,
      "downloadCount": 12,
    },
    {
      "id": "share_002",
      "title": "Birthday Celebration",
      "photoCount": 18,
      "sharedWith": ["friends_group", "mom@email.com"],
      "sharedDate": "2024-06-15",
      "shareMethod": "Social Media",
      "expiryDate": null,
      "viewCount": 23,
      "downloadCount": 8,
    },
    {
      "id": "share_003",
      "title": "Vacation Memories",
      "photoCount": 42,
      "sharedWith": ["family@email.com"],
      "sharedDate": "2024-06-14",
      "shareMethod": "Link Share",
      "expiryDate": "2024-07-14",
      "viewCount": 67,
      "downloadCount": 15,
    },
  ];

  List<Map<String, dynamic>> shareOptions = [
    {
      "icon": Icons.email,
      "title": "Email",
      "description": "Send photos via email",
      "color": primaryColor,
    },
    {
      "icon": Icons.link,
      "title": "Share Link",
      "description": "Generate shareable link",
      "color": successColor,
    },
    {
      "icon": Icons.share,
      "title": "Social Media",
      "description": "Share to social platforms",
      "color": infoColor,
    },
    {
      "icon": Icons.cloud_upload,
      "title": "Cloud Share",
      "description": "Share via cloud storage",
      "color": warningColor,
    },
    {
      "icon": Icons.qr_code,
      "title": "QR Code",
      "description": "Generate QR code for sharing",
      "color": primaryColor,
    },
    {
      "icon": Icons.bluetooth,
      "title": "Nearby Share",
      "description": "Share with nearby devices",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> albums = [
    {"label": "Wedding Photos", "value": "Wedding Photos"},
    {"label": "Birthday Party", "value": "Birthday Party"},
    {"label": "Vacation 2024", "value": "Vacation 2024"},
    {"label": "Family Reunion", "value": "Family Reunion"},
    {"label": "Recent Photos", "value": "Recent Photos"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Photos"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showShareHistory();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showShareSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.share,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Share Your Memories",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Share photos with friends, family, or on social media",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Select Album or Photos",
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
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Select Album",
                    items: albums,
                    value: selectedAlbum,
                    onChanged: (value, label) {
                      selectedAlbum = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Select Photos",
                          size: bs.md,
                          icon: Icons.photo_library,
                          onPressed: () {
                            _selectPhotos();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${selectedPhotos.length} selected",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (selectedPhotos.isNotEmpty) ...[
                    QMemoField(
                      label: "Share Description (Optional)",
                      value: shareDescription,
                      hint: "Add a description for your shared photos",
                      onChanged: (value) {
                        shareDescription = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            Text(
              "Share Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: shareOptions.map((option) {
                return _buildShareOptionCard(option);
              }).toList(),
            ),

            Text(
              "Share Settings",
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
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Original Quality",
                    items: [
                      {
                        "label": "Share with original quality",
                        "value": true,
                        "checked": shareWithOriginalQuality,
                      }
                    ],
                    value: [
                      if (shareWithOriginalQuality)
                        {
                          "label": "Share with original quality",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      shareWithOriginalQuality = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Add Watermark",
                    items: [
                      {
                        "label": "Add watermark to shared photos",
                        "value": true,
                        "checked": addWatermark,
                      }
                    ],
                    value: [
                      if (addWatermark)
                        {
                          "label": "Add watermark to shared photos",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      addWatermark = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Text(
              "Recent Shares",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentShares.length,
              itemBuilder: (context, index) {
                final share = recentShares[index];
                return _buildRecentShareCard(share);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOptionCard(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () {
        _shareViaMethod(option["title"]);
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (option["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                option["icon"],
                color: option["color"],
                size: 28,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${option["title"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              "${option["description"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentShareCard(Map<String, dynamic> share) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${share["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Shared on ${share["sharedDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${share["shareMethod"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.photo,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${share["photoCount"]} photos",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                Icons.visibility,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${share["viewCount"]} views",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.download,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${share["downloadCount"]} downloads",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.people,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Shared with: ${(share["sharedWith"] as List).join(", ")}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          
          if (share["expiryDate"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Expires on ${share["expiryDate"]}",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              QButton(
                label: "View",
                size: bs.sm,
                icon: Icons.visibility,
                onPressed: () {
                  _viewSharedAlbum(share["id"]);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Copy Link",
                size: bs.sm,
                icon: Icons.link,
                onPressed: () {
                  _copyShareLink(share["id"]);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Share Again",
                size: bs.sm,
                icon: Icons.share,
                onPressed: () {
                  _shareAgain(share["id"]);
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _deleteShare(share["id"]);
                },
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectPhotos() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Photos"),
          content: Text("Photo selection interface would be implemented here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Select (15)",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  selectedPhotos = List.generate(15, (index) => {"id": "photo_$index"});
                });
                Navigator.pop(context);
                ss("15 photos selected for sharing");
              },
            ),
          ],
        );
      },
    );
  }

  void _shareViaMethod(String method) {
    if (selectedPhotos.isEmpty && selectedAlbum.isEmpty) {
      se("Please select photos or an album to share");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Share via $method"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Share ${selectedPhotos.isNotEmpty ? "${selectedPhotos.length} photos" : selectedAlbum} via $method?"),
              SizedBox(height: spSm),
              if (method == "Email") ...[
                QTextField(
                  label: "Email Address",
                  value: "",
                  hint: "Enter recipient email",
                  onChanged: (value) {},
                ),
              ] else if (method == "Share Link") ...[
                QSwitch(
                  label: "Set Expiry",
                  items: [
                    {
                      "label": "Link expires after 30 days",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Link expires after 30 days",
                      "value": true,
                      "checked": true
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Share",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Photos shared via $method successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showShareHistory() {
    si("Showing complete share history");
  }

  void _showShareSettings() {
    si("Opening share settings");
  }

  void _viewSharedAlbum(String shareId) {
    si("Opening shared album");
  }

  void _copyShareLink(String shareId) {
    ss("Share link copied to clipboard");
  }

  void _shareAgain(String shareId) {
    si("Share again initiated");
  }

  void _deleteShare(String shareId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this share?");
    if (isConfirmed) {
      ss("Share deleted successfully");
    }
  }
}
