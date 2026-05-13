import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAnalyticsIntegrationView extends StatefulWidget {
  const DmsAnalyticsIntegrationView({super.key});

  @override
  State<DmsAnalyticsIntegrationView> createState() => _DmsAnalyticsIntegrationViewState();
}

class _DmsAnalyticsIntegrationViewState extends State<DmsAnalyticsIntegrationView> {
  final formKey = GlobalKey<FormState>();
  
  // Integration Status
  bool googleAnalyticsConnected = true;
  bool googleAdsConnected = false;
  bool facebookPixelConnected = true;
  bool hotjarConnected = false;
  bool mixpanelConnected = false;
  bool gtmConnected = true;
  
  // Account Information
  String googleAnalyticsId = "GA-123456789-1";
  String googleAdsId = "";
  String facebookPixelId = "123456789012345";
  String hotjarId = "";
  String mixpanelId = "";
  String gtmId = "GTM-XXXXXXX";
  
  // Configuration
  bool enhancedEcommerce = true;
  bool crossDomainTracking = false;
  bool anonymizeIP = true;
  bool cookieConsent = true;
  String selectedDataRetention = "26 months";
  
  int currentTab = 0;
  
  List<Map<String, dynamic>> integrations = [
    {
      "name": "Google Analytics",
      "description": "Track website traffic and user behavior",
      "icon": Icons.analytics,
      "connected": true,
      "accountId": "GA-123456789-1",
      "color": 0xFF4285F4,
      "features": ["Traffic Analysis", "Conversion Tracking", "Audience Insights", "Real-time Reports"],
    },
    {
      "name": "Google Ads",
      "description": "Track advertising performance and conversions",
      "icon": Icons.ads_click,
      "connected": false,
      "accountId": "",
      "color": 0xFF34A853,
      "features": ["Conversion Tracking", "Remarketing", "Campaign Performance", "ROI Analysis"],
    },
    {
      "name": "Facebook Pixel",
      "description": "Track Facebook and Instagram ad performance",
      "icon": Icons.facebook,
      "connected": true,
      "accountId": "123456789012345",
      "color": 0xFF1877F2,
      "features": ["Ad Tracking", "Custom Audiences", "Conversion Events", "Attribution"],
    },
    {
      "name": "Hotjar",
      "description": "User behavior analytics and heatmaps",
      "icon": Icons.mouse,
      "connected": false,
      "accountId": "",
      "color": 0xFFFF3C00,
      "features": ["Heatmaps", "Session Recordings", "Surveys", "User Feedback"],
    },
    {
      "name": "Mixpanel",
      "description": "Advanced event tracking and analytics",
      "icon": Icons.timeline,
      "connected": false,
      "accountId": "",
      "color": 0xFF9333EA,
      "features": ["Event Tracking", "Funnel Analysis", "Cohort Analysis", "A/B Testing"],
    },
    {
      "name": "Google Tag Manager",
      "description": "Manage all tracking codes from one place",
      "icon": Icons.label,
      "connected": true,
      "accountId": "GTM-XXXXXXX",
      "color": 0xFF4285F4,
      "features": ["Tag Management", "Event Tracking", "Conversion Tracking", "Code Deployment"],
    },
  ];
  
  List<Map<String, dynamic>> recentEvents = [
    {"event": "Google Analytics Connected", "time": "2 hours ago", "status": "success"},
    {"event": "Facebook Pixel Setup", "time": "1 day ago", "status": "success"},
    {"event": "Google Tag Manager Updated", "time": "3 days ago", "status": "info"},
    {"event": "Hotjar Integration Failed", "time": "5 days ago", "status": "error"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics Integration",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Integrations", icon: Icon(Icons.integration_instructions)),
        Tab(text: "Configuration", icon: Icon(Icons.settings)),
        Tab(text: "Events", icon: Icon(Icons.event)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildIntegrationsTab(),
        _buildConfigurationTab(),
        _buildEventsTab(),
      ],
      onInit: (tabController) {},
    );
  }
  
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusOverviewCard(),
          _buildQuickActionsCard(),
          _buildRecentActivityCard(),
        ],
      ),
    );
  }
  
  Widget _buildStatusOverviewCard() {
    int connectedCount = integrations.where((i) => i["connected"] == true).length;
    int totalCount = integrations.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Integration Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$connectedCount of $totalCount Connected",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Analytics platforms are tracking your data",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  "Active Trackers",
                  "$connectedCount",
                  Icons.track_changes,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard(
                  "Data Points",
                  "2.4M",
                  Icons.data_usage,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard(
                  "Last Sync",
                  "5 min ago",
                  Icons.sync,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "Test Tracking",
                  Icons.bug_report,
                  primaryColor,
                  () {
                    // Test tracking
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildActionButton(
                  "Sync Data",
                  Icons.sync_alt,
                  successColor,
                  () {
                    // Sync data
                  },
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "View Reports",
                  Icons.assessment,
                  infoColor,
                  () {
                    // View reports
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildActionButton(
                  "Export Data",
                  Icons.download,
                  warningColor,
                  () {
                    // Export data
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: spXs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRecentActivityCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  // View all activities
                },
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: recentEvents.map((event) => _buildActivityRow(event)).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityRow(Map<String, dynamic> event) {
    Color statusColor;
    IconData statusIcon;
    
    switch (event["status"]) {
      case "success":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "error":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        break;
      case "info":
        statusColor = infoColor;
        statusIcon = Icons.info;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.circle;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["event"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${event["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIntegrationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: integrations.map((integration) => _buildIntegrationCard(integration)).toList(),
      ),
    );
  }
  
  Widget _buildIntegrationCard(Map<String, dynamic> integration) {
    bool isConnected = integration["connected"];
    Color integrationColor = Color(integration["color"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isConnected ? integrationColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: integrationColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  integration["icon"],
                  color: integrationColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${integration["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isConnected ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isConnected ? "Connected" : "Disconnected",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isConnected ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          
          if (isConnected && integration["accountId"].isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: integrationColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: integrationColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Account ID: ${integration["accountId"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: integrationColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (integration["features"] as List).map((feature) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
              decoration: BoxDecoration(
                color: integrationColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "$feature",
                style: TextStyle(
                  fontSize: 10,
                  color: integrationColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isConnected ? "Disconnect" : "Connect",
                  size: bs.sm,
                  onPressed: () {
                    _toggleIntegration(integration["name"]);
                  },
                ),
              ),
              if (isConnected) ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.settings,
                  size: bs.sm,
                  onPressed: () {
                    _configureIntegration(integration["name"]);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildConfigurationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralConfigCard(),
            _buildPrivacyConfigCard(),
            _buildDataRetentionCard(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGeneralConfigCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "General Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          _buildConfigOption(
            "Enhanced Ecommerce",
            "Track detailed product and purchase data",
            enhancedEcommerce,
            (value) {
              enhancedEcommerce = value;
              setState(() {});
            },
          ),
          
          _buildConfigOption(
            "Cross Domain Tracking",
            "Track users across multiple domains",
            crossDomainTracking,
            (value) {
              crossDomainTracking = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Google Analytics ID",
            value: googleAnalyticsId,
            hint: "GA-XXXXXXXXX-X",
            validator: Validator.required,
            onChanged: (value) {
              googleAnalyticsId = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Google Tag Manager ID",
            value: gtmId,
            hint: "GTM-XXXXXXX",
            onChanged: (value) {
              gtmId = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacyConfigCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Privacy Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          _buildConfigOption(
            "Anonymize IP Addresses",
            "Remove the last octet of user IP addresses",
            anonymizeIP,
            (value) {
              anonymizeIP = value;
              setState(() {});
            },
          ),
          
          _buildConfigOption(
            "Cookie Consent Required",
            "Request user consent before tracking",
            cookieConsent,
            (value) {
              cookieConsent = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDataRetentionCard() {
    List<Map<String, dynamic>> retentionOptions = [
      {"label": "14 months", "value": "14 months"},
      {"label": "26 months", "value": "26 months"},
      {"label": "38 months", "value": "38 months"},
      {"label": "50 months", "value": "50 months"},
    ];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Data Retention",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Data Retention Period",
            items: retentionOptions,
            value: selectedDataRetention,
            onChanged: (value, label) {
              selectedDataRetention = value;
              setState(() {});
            },
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "User and event data will be automatically deleted after the specified period.",
                    style: TextStyle(
                      fontSize: 12,
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
  
  Widget _buildConfigOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
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
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
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
  
  Widget _buildEventsTab() {
    List<Map<String, dynamic>> trackingEvents = [
      {"name": "Page View", "enabled": true, "description": "Track page visits"},
      {"name": "Button Click", "enabled": true, "description": "Track button interactions"},
      {"name": "Form Submit", "enabled": true, "description": "Track form submissions"},
      {"name": "File Download", "enabled": false, "description": "Track file downloads"},
      {"name": "Video Play", "enabled": false, "description": "Track video interactions"},
      {"name": "Scroll Depth", "enabled": true, "description": "Track how far users scroll"},
    ];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTrackingCard(trackingEvents),
          _buildCustomEventsCard(),
        ],
      ),
    );
  }
  
  Widget _buildEventTrackingCard(List<Map<String, dynamic>> events) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Event Tracking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: events.map((event) => _buildEventRow(event)).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEventRow(Map<String, dynamic> event) {
    bool isEnabled = event["enabled"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isEnabled ? successColor.withAlpha(10) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isEnabled ? successColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isEnabled ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isEnabled ? successColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              event["enabled"] = value;
              setState(() {});
            },
            activeColor: successColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCustomEventsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.add_circle, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Custom Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Event",
                size: bs.sm,
                onPressed: () {
                  // Add custom event
                },
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Custom Events",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Track specific user actions that are important to your business goals.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Save Configuration",
        size: bs.md,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ss("Analytics configuration saved successfully");
          }
        },
      ),
    );
  }
  
  void _toggleIntegration(String integrationName) {
    setState(() {
      for (var integration in integrations) {
        if (integration["name"] == integrationName) {
          integration["connected"] = !integration["connected"];
          
          if (integration["connected"]) {
            ss("${integration["name"]} connected successfully");
          } else {
            sw("${integration["name"]} disconnected");
          }
          break;
        }
      }
    });
  }
  
  void _configureIntegration(String integrationName) {
    si("Opening $integrationName configuration");
    // Navigate to specific integration configuration
  }
}
