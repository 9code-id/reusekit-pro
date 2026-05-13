import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaProfileView extends StatefulWidget {
  const ReaProfileView({super.key});

  @override
  State<ReaProfileView> createState() => _ReaProfileViewState();
}

class _ReaProfileViewState extends State<ReaProfileView> {
  String name = "John Smith";
  String email = "john.smith@email.com";
  String phone = "+1 234 567 8900";
  String profileImage = "";
  String occupation = "Software Engineer";
  String company = "Tech Solutions Inc.";
  String location = "Miami, Florida";
  String bio = "Looking for investment properties and family homes";
  
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = true;
  
  String currency = "USD";
  String language = "English";
  String units = "Imperial";
  
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
  ];

  List<Map<String, dynamic>> unitOptions = [
    {"label": "Imperial (ft, mi)", "value": "Imperial"},
    {"label": "Metric (m, km)", "value": "Metric"},
  ];

  Map<String, dynamic> userStats = {
    "properties_viewed": 45,
    "properties_saved": 12,
    "visits_scheduled": 8,
    "offers_made": 3,
    "member_since": "2023-01-15",
    "last_active": "2025-06-14",
  };

  List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.favorite,
      "title": "Saved Properties",
      "subtitle": "12 properties",
      "action": "saved_properties",
      "color": dangerColor,
    },
    {
      "icon": Icons.history,
      "title": "Search History",
      "subtitle": "Recent searches",
      "action": "search_history",
      "color": infoColor,
    },
    {
      "icon": Icons.calendar_today,
      "title": "Scheduled Visits",
      "subtitle": "3 upcoming",
      "action": "scheduled_visits",
      "color": warningColor,
    },
    {
      "icon": Icons.request_quote,
      "title": "My Offers",
      "subtitle": "Track your offers",
      "action": "my_offers",
      "color": successColor,
    },
    {
      "icon": Icons.account_balance_wallet,
      "title": "Financial Profile",
      "subtitle": "Loan pre-approval",
      "action": "financial_profile",
      "color": primaryColor,
    },
    {
      "icon": Icons.support_agent,
      "title": "My Agent",
      "subtitle": "Sarah Johnson",
      "action": "my_agent",
      "color": secondaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editProfile(),
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                _buildProfileHeader(),
                _buildStats(),
                _buildQuickActions(),
                _buildPersonalInfo(),
                _buildNotificationSettings(),
                _buildAppSettings(),
                _buildAccountActions(),
              ],
            ),
          ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: profileImage.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        profileImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 50,
                      color: primaryColor,
                    ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            name,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            occupation,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.white.withAlpha(200)),
              SizedBox(width: spXs),
              Text(
                location,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
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
            "Activity Statistics",
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
                child: _buildStatItem(
                  "Viewed",
                  "${userStats["properties_viewed"]}",
                  Icons.visibility,
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "Saved",
                  "${userStats["properties_saved"]}",
                  Icons.favorite,
                  dangerColor,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "Visits",
                  "${userStats["visits_scheduled"]}",
                  Icons.calendar_today,
                  warningColor,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "Offers",
                  "${userStats["offers_made"]}",
                  Icons.request_quote,
                  successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Member since ${DateTime.parse("${userStats["member_since"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...menuItems.map((item) => _buildMenuItem(item)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () => _handleMenuAction("${item["action"]}"),
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["subtitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: disabledBoldColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
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
            "Personal Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Name", name),
          _buildInfoRow("Email", email),
          _buildInfoRow("Phone", phone),
          _buildInfoRow("Company", company),
          _buildInfoRow("Bio", bio),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSwitchItem("Email Notifications", emailNotifications, (value) {
            emailNotifications = value;
            setState(() {});
          }),
          _buildSwitchItem("Push Notifications", pushNotifications, (value) {
            pushNotifications = value;
            setState(() {});
          }),
          _buildSwitchItem("SMS Notifications", smsNotifications, (value) {
            smsNotifications = value;
            setState(() {});
          }),
          _buildSwitchItem("Marketing Emails", marketingEmails, (value) {
            marketingEmails = value;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
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

  Widget _buildAppSettings() {
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
            "App Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Currency",
            items: currencyOptions,
            value: currency,
            onChanged: (value, label) {
              currency = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Language",
            items: languageOptions,
            value: language,
            onChanged: (value, label) {
              language = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Units",
            items: unitOptions,
            value: units,
            onChanged: (value, label) {
              units = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions() {
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
            "Account Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildActionButton("Privacy Policy", Icons.privacy_tip, () {}),
          _buildActionButton("Terms of Service", Icons.description, () {}),
          _buildActionButton("Help & Support", Icons.help, () {}),
          _buildActionButton("Rate App", Icons.star, () {}),
          _buildActionButton("Change Password", Icons.lock, () {}),
          _buildActionButton("Delete Account", Icons.delete, () {}, isDanger: true),
          _buildActionButton("Sign Out", Icons.logout, _signOut, isDanger: true),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap, {bool isDanger = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: isDanger ? dangerColor.withAlpha(10) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDanger ? dangerColor : primaryColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDanger ? dangerColor : primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDanger ? dangerColor : disabledBoldColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    ss("Redirecting to edit profile page...");
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "saved_properties":
        ss("Opening saved properties...");
        break;
      case "search_history":
        ss("Opening search history...");
        break;
      case "scheduled_visits":
        ss("Opening scheduled visits...");
        break;
      case "my_offers":
        ss("Opening my offers...");
        break;
      case "financial_profile":
        ss("Opening financial profile...");
        break;
      case "my_agent":
        ss("Opening agent profile...");
        break;
    }
  }

  void _signOut() async {
    bool isConfirmed = await confirm("Are you sure you want to sign out?");
    if (isConfirmed) {
      ss("Signing out...");
    }
  }
}
