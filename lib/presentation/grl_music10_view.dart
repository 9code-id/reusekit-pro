import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic10View extends StatefulWidget {
  @override
  State<GrlMusic10View> createState() => _GrlMusic10ViewState();
}

class _GrlMusic10ViewState extends State<GrlMusic10View> {
  bool notificationsEnabled = true;
  bool autoDownload = false;
  bool highQuality = true;
  bool showExplicitContent = false;
  bool crossfade = true;
  double crossfadeDuration = 5.0;
  String audioQuality = "High";
  String downloadQuality = "High";
  String language = "English";
  String theme = "System";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAccountSection(),
            SizedBox(height: spLg),
            _buildPlaybackSection(),
            SizedBox(height: spLg),
            _buildAudioSection(),
            SizedBox(height: spLg),
            _buildDownloadSection(),
            SizedBox(height: spLg),
            _buildNotificationSection(),
            SizedBox(height: spLg),
            _buildPrivacySection(),
            SizedBox(height: spLg),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 30,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Premium Member",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "john.doe@email.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.edit,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Playlists", "24"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Favorites", "156"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Following", "89"),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Manage Subscription",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Playback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.shuffle,
                color: disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Crossfade",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Fade between songs",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: crossfade,
                onChanged: (value) {
                  crossfade = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          if (crossfade) ...[
            SizedBox(height: spMd),
            Text(
              "Crossfade Duration: ${crossfadeDuration.toInt()} seconds",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: primaryColor,
                inactiveTrackColor: disabledColor,
                thumbColor: primaryColor,
                overlayColor: primaryColor.withAlpha(50),
              ),
              child: Slider(
                value: crossfadeDuration,
                min: 1,
                max: 12,
                divisions: 11,
                onChanged: (value) {
                  crossfadeDuration = value;
                  setState(() {});
                },
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.explicit,
                color: disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Show Explicit Content",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Display songs with explicit lyrics",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: showExplicitContent,
                onChanged: (value) {
                  showExplicitContent = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAudioSection() {
    List<Map<String, String>> audioQualities = [
      {"label": "Normal", "value": "Normal"},
      {"label": "High", "value": "High"},
      {"label": "Very High", "value": "Very High"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audio Quality",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Streaming Quality",
            items: audioQualities,
            value: audioQuality,
            onChanged: (value, label) {
              audioQuality = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Higher quality uses more data. Very High quality is 320kbps.",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadSection() {
    List<Map<String, String>> downloadQualities = [
      {"label": "Normal", "value": "Normal"},
      {"label": "High", "value": "High"},
      {"label": "Very High", "value": "Very High"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Downloads",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.download,
                color: disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto Download",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Download liked songs automatically",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: autoDownload,
                onChanged: (value) {
                  autoDownload = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Download Quality",
            items: downloadQualities,
            value: downloadQuality,
            onChanged: (value, label) {
              downloadQuality = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.storage,
                color: disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Storage Used: 2.4 GB",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Clear Cache",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.notifications,
                color: disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Push Notifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Get notified about new releases and updates",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  notificationsEnabled = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy & Security",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSettingItem(
            Icons.privacy_tip,
            "Privacy Policy",
            "Read our privacy policy",
            () {},
          ),
          _buildSettingItem(
            Icons.security,
            "Data & Privacy",
            "Manage your data preferences",
            () {},
          ),
          _buildSettingItem(
            Icons.block,
            "Blocked Users",
            "Manage blocked users",
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSettingItem(
            Icons.help,
            "Help & Support",
            "Get help with your account",
            () {},
          ),
          _buildSettingItem(
            Icons.feedback,
            "Send Feedback",
            "Tell us what you think",
            () {},
          ),
          _buildSettingItem(
            Icons.star_rate,
            "Rate App",
            "Rate us on the app store",
            () {},
          ),
          _buildSettingItem(
            Icons.info,
            "About",
            "Version 3.2.1",
            () {},
            showArrow: false,
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Sign Out",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        child: Row(
          children: [
            Icon(
              icon,
              color: disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
