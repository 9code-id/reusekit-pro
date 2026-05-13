import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow8View extends StatefulWidget {
  @override
  State<GrlFollow8View> createState() => _GrlFollow8ViewState();
}

class _GrlFollow8ViewState extends State<GrlFollow8View> {
  bool allowFollowRequests = true;
  bool showMutualConnections = true;
  bool allowTagging = true;
  bool showOnlineStatus = false;
  bool allowDirectMessages = true;
  bool showFollowerActivity = true;
  String accountPrivacy = "public";
  String whoCanFollowMe = "everyone";
  String whoCanSeeMyFollowers = "followers";
  String whoCanSeeMyFollowing = "public";
  
  List<Map<String, dynamic>> privacyOptions = [
    {
      "label": "Public Account",
      "value": "public",
      "description": "Anyone can see your posts and profile"
    },
    {
      "label": "Private Account", 
      "value": "private",
      "description": "Only followers can see your posts"
    },
    {
      "label": "Friends Only",
      "value": "friends",
      "description": "Only approved friends can see everything"
    }
  ];

  List<Map<String, dynamic>> followOptions = [
    {
      "label": "Everyone",
      "value": "everyone",
      "description": "Anyone can follow you"
    },
    {
      "label": "People I Know",
      "value": "mutual",
      "description": "Only people with mutual connections"
    },
    {
      "label": "Approved Only",
      "value": "approved",
      "description": "Manually approve each follower"
    }
  ];

  List<Map<String, dynamic>> visibilityOptions = [
    {
      "label": "Public",
      "value": "public",
      "description": "Everyone can see"
    },
    {
      "label": "Followers Only",
      "value": "followers", 
      "description": "Only your followers can see"
    },
    {
      "label": "Nobody",
      "value": "nobody",
      "description": "Hide from everyone"
    }
  ];

  void _savePrivacySettings() {
    ss("Privacy settings updated successfully");
  }

  void _resetToDefault() async {
    bool isConfirmed = await confirm("Reset all privacy settings to default?");
    if (isConfirmed) {
      setState(() {
        allowFollowRequests = true;
        showMutualConnections = true;
        allowTagging = true;
        showOnlineStatus = false;
        allowDirectMessages = true;
        showFollowerActivity = true;
        accountPrivacy = "public";
        whoCanFollowMe = "everyone";
        whoCanSeeMyFollowers = "followers";
        whoCanSeeMyFollowing = "public";
      });
      ss("Privacy settings reset to default");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Safety"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _savePrivacySettings,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Privacy Section
            _buildSectionHeader(
              "Account Privacy",
              "Control who can see your content and profile",
              Icons.security,
            ),
            
            QDropdownField(
              label: "Account Type",
              items: privacyOptions,
              value: accountPrivacy,
              onChanged: (value, label) {
                accountPrivacy = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Follow Settings Section
            _buildSectionHeader(
              "Follow Settings",
              "Manage who can follow you and how",
              Icons.people,
            ),
            
            QDropdownField(
              label: "Who Can Follow Me",
              items: followOptions,
              value: whoCanFollowMe,
              onChanged: (value, label) {
                whoCanFollowMe = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            _buildToggleItem(
              "Allow Follow Requests",
              "Let people send you follow requests",
              allowFollowRequests,
              (value) {
                allowFollowRequests = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Visibility Settings Section
            _buildSectionHeader(
              "Visibility Settings", 
              "Control what others can see about you",
              Icons.visibility,
            ),
            
            QDropdownField(
              label: "Who Can See My Followers",
              items: visibilityOptions,
              value: whoCanSeeMyFollowers,
              onChanged: (value, label) {
                whoCanSeeMyFollowers = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Who Can See My Following List",
              items: visibilityOptions,
              value: whoCanSeeMyFollowing,
              onChanged: (value, label) {
                whoCanSeeMyFollowing = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            _buildToggleItem(
              "Show Mutual Connections",
              "Display mutual followers to others",
              showMutualConnections,
              (value) {
                showMutualConnections = value;
                setState(() {});
              },
            ),
            
            _buildToggleItem(
              "Show Online Status",
              "Let others see when you're online",
              showOnlineStatus,
              (value) {
                showOnlineStatus = value;
                setState(() {});
              },
            ),
            
            _buildToggleItem(
              "Show Follower Activity",
              "Display your likes and comments to followers",
              showFollowerActivity,
              (value) {
                showFollowerActivity = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Interaction Settings Section
            _buildSectionHeader(
              "Interaction Settings",
              "Control how others can interact with you",
              Icons.chat,
            ),
            
            _buildToggleItem(
              "Allow Direct Messages",
              "Let people send you private messages",
              allowDirectMessages,
              (value) {
                allowDirectMessages = value;
                setState(() {});
              },
            ),
            
            _buildToggleItem(
              "Allow Tagging",
              "Let others tag you in their posts",
              allowTagging,
              (value) {
                allowTagging = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Privacy Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildSummaryItem("Account Type", _getAccountTypeLabel()),
                  _buildSummaryItem("Follow Permissions", _getFollowPermissionLabel()),
                  _buildSummaryItem("Profile Visibility", _getVisibilityLabel()),
                  _buildSummaryItem("Direct Messages", allowDirectMessages ? "Enabled" : "Disabled"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: _resetToDefault,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: disabledOutlineBorderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      child: Text(
                        "Reset to Default",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Save Changes",
                    size: bs.md,
                    onPressed: _savePrivacySettings,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Help Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Learn more about privacy settings and how they protect your account.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ss("Privacy guide coming soon");
                        },
                        child: Text(
                          "Privacy Guide",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        " • ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ss("Support coming soon");
                        },
                        child: Text(
                          "Contact Support",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
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
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: infoColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getAccountTypeLabel() {
    switch (accountPrivacy) {
      case 'public':
        return 'Public';
      case 'private':
        return 'Private';
      case 'friends':
        return 'Friends Only';
      default:
        return 'Public';
    }
  }

  String _getFollowPermissionLabel() {
    switch (whoCanFollowMe) {
      case 'everyone':
        return 'Everyone';
      case 'mutual':
        return 'People I Know';
      case 'approved':
        return 'Approved Only';
      default:
        return 'Everyone';
    }
  }

  String _getVisibilityLabel() {
    if (whoCanSeeMyFollowers == 'public' && whoCanSeeMyFollowing == 'public') {
      return 'High Visibility';
    } else if (whoCanSeeMyFollowers == 'followers' || whoCanSeeMyFollowing == 'followers') {
      return 'Medium Visibility';
    } else {
      return 'Low Visibility';
    }
  }
}
