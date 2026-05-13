import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaGuestModeView extends StatefulWidget {
  const PpaGuestModeView({super.key});

  @override
  State<PpaGuestModeView> createState() => _PpaGuestModeViewState();
}

class _PpaGuestModeViewState extends State<PpaGuestModeView> {
  int currentTab = 0;
  bool showLimitationBanner = true;

  Map<String, dynamic> guestLimitations = {
    "maxPhotosPerSession": 10,
    "currentPhotoCount": 3,
    "maxFilters": 5,
    "maxEditTime": 300, // seconds
    "canSaveToCloud": false,
    "canUseProFeatures": false,
    "sessionTimeLeft": 1800, // 30 minutes
  };

  List<Map<String, dynamic>> availableFeatures = [
    {
      "title": "Basic Camera",
      "description": "Take photos with standard camera features",
      "icon": Icons.camera_alt,
      "available": true,
      "limitation": "Up to 10 photos per session"
    },
    {
      "title": "Quick Filters",
      "description": "Apply basic filters to your photos",
      "icon": Icons.filter,
      "available": true,
      "limitation": "5 filters available"
    },
    {
      "title": "Basic Editing",
      "description": "Simple brightness and contrast adjustments",
      "icon": Icons.edit,
      "available": true,
      "limitation": "5 minutes editing time"
    },
    {
      "title": "Local Gallery",
      "description": "View and organize photos on device",
      "icon": Icons.photo_library,
      "available": true,
      "limitation": "Device storage only"
    },
    {
      "title": "Pro Filters",
      "description": "Advanced artistic filters and effects",
      "icon": Icons.auto_awesome,
      "available": false,
      "limitation": "Requires account"
    },
    {
      "title": "Cloud Storage",
      "description": "Save and sync photos across devices",
      "icon": Icons.cloud,
      "available": false,
      "limitation": "Account required"
    },
    {
      "title": "Advanced Editing",
      "description": "Professional editing tools and presets",
      "icon": Icons.tune,
      "available": false,
      "limitation": "Premium feature"
    },
    {
      "title": "AI Enhancement",
      "description": "Automatic photo enhancement with AI",
      "icon": Icons.psychology,
      "available": false,
      "limitation": "Premium feature"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.visibility_off, size: 20),
            SizedBox(width: spSm),
            Text("Guest Mode"),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "${_formatTime(guestLimitations["sessionTimeLeft"])} left",
              style: TextStyle(
                fontSize: 12,
                color: warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Limitation Banner
          if (showLimitationBanner)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                border: Border(bottom: BorderSide(color: warningColor.withAlpha(50))),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: warningColor, size: 20),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Limited Access Mode",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Create an account to unlock all features",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showLimitationBanner = false;
                      setState(() {});
                    },
                    child: Icon(Icons.close, color: warningColor, size: 16),
                  ),
                ],
              ),
            ),

          // Usage Statistics
          Container(
            margin: EdgeInsets.all(spMd),
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
                  "Session Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildUsageCard(
                        "Photos Taken",
                        "${guestLimitations["currentPhotoCount"]}",
                        "${guestLimitations["maxPhotosPerSession"]}",
                        (guestLimitations["currentPhotoCount"] as int) / (guestLimitations["maxPhotosPerSession"] as int),
                        Icons.camera_alt,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: _buildUsageCard(
                        "Filters Used",
                        "2",
                        "${guestLimitations["maxFilters"]}",
                        0.4,
                        Icons.filter,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildTimeUsageCard(),
              ],
            ),
          ),

          // Available Features
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Column(
                    children: availableFeatures.map((feature) {
                      return _buildFeatureCard(feature);
                    }).toList(),
                  ),

                  SizedBox(height: spMd),

                  // Upgrade Prompt
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Unlock Full Potential",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Create a free account to access unlimited photos, professional filters, cloud storage, and more!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _navigateToRegister();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(radiusMd),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign Up Free",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Container(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _navigateToLogin();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(radiusMd),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Start Camera",
                size: bs.md,
                onPressed: () {
                  _startCamera();
                },
              ),
            ),
            SizedBox(width: spMd),
            QButton(
              icon: Icons.photo_library,
              size: bs.md,
              onPressed: () {
                _openGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageCard(String title, String current, String max, double progress, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            "$current / $max",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUsageCard() {
    int editTimeUsed = 120; // 2 minutes used
    double progress = editTimeUsed / (guestLimitations["maxEditTime"] as int);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: warningColor, size: 24),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Editing Time",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                Text(
                  "${_formatTime(editTimeUsed)} / ${_formatTime(guestLimitations["maxEditTime"])} used",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    bool isAvailable = feature["available"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isAvailable ? Border.all(color: disabledColor) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isAvailable 
                    ? primaryColor.withAlpha(20) 
                    : disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                feature["icon"] as IconData,
                color: isAvailable ? primaryColor : disabledBoldColor,
                size: 24,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${feature["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isAvailable ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                      if (isAvailable)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Premium",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${feature["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${feature["limitation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isAvailable ? warningColor : dangerColor,
                      fontStyle: FontStyle.italic,
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

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return "${minutes}m ${remainingSeconds}s";
    }
    return "${seconds}s";
  }

  void _startCamera() {
    if ((guestLimitations["currentPhotoCount"] as int) >= (guestLimitations["maxPhotosPerSession"] as int)) {
      se("Photo limit reached! Create an account for unlimited photos.");
      return;
    }
    
    // navigateTo CameraView with guest limitations
    ss("Opening camera in guest mode");
  }

  void _openGallery() {
    // navigateTo GalleryView with limited features
    ss("Opening gallery in guest mode");
  }

  void _navigateToRegister() {
    // navigateTo RegisterView
    ss("Opening registration screen");
  }

  void _navigateToLogin() {
    // navigateTo LoginView
    ss("Opening login screen");
  }
}
