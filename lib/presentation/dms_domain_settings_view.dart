import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsDomainSettingsView extends StatefulWidget {
  const DmsDomainSettingsView({super.key});

  @override
  State<DmsDomainSettingsView> createState() => _DmsDomainSettingsViewState();
}

class _DmsDomainSettingsViewState extends State<DmsDomainSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // Domain Settings
  String domainName = "example.com";
  bool autoRenewal = true;
  bool privacyProtection = true;
  bool domainLock = true;
  bool emailForwarding = false;
  String selectedPlan = "Pro";
  
  // Contact Information
  String registrantName = "John Smith";
  String registrantEmail = "john@example.com";
  String registrantPhone = "+1 (555) 123-4567";
  String registrantAddress = "123 Main St, City, Country";
  
  // DNS Settings
  String primaryDNS = "ns1.example.com";
  String secondaryDNS = "ns2.example.com";
  bool customDNS = false;
  
  // Security Settings
  bool twoFactorAuth = true;
  bool loginAlerts = true;
  bool apiAccess = false;
  String selectedSSL = "Premium SSL";
  
  int currentTab = 0;
  
  List<Map<String, dynamic>> plans = [
    {
      "name": "Basic",
      "price": 12.99,
      "features": ["Domain Registration", "Basic DNS", "Email Support"],
      "duration": "per year"
    },
    {
      "name": "Pro",
      "price": 24.99,
      "features": ["Everything in Basic", "Privacy Protection", "Advanced DNS", "Priority Support"],
      "duration": "per year"
    },
    {
      "name": "Enterprise",
      "price": 49.99,
      "features": ["Everything in Pro", "Premium SSL", "API Access", "24/7 Phone Support"],
      "duration": "per year"
    },
  ];
  
  List<Map<String, dynamic>> sslOptions = [
    {"name": "Basic SSL", "price": 9.99, "level": "Domain Validation"},
    {"name": "Premium SSL", "price": 29.99, "level": "Organization Validation"},
    {"name": "Enterprise SSL", "price": 99.99, "level": "Extended Validation"},
  ];
  
  List<Map<String, dynamic>> dnsRecords = [
    {"type": "A", "name": "@", "value": "192.168.1.1", "ttl": 3600},
    {"type": "CNAME", "name": "www", "value": "example.com", "ttl": 3600},
    {"type": "MX", "name": "@", "value": "mail.example.com", "ttl": 3600},
    {"type": "TXT", "name": "@", "value": "v=spf1 include:_spf.google.com ~all", "ttl": 3600},
  ];
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Domain Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "DNS", icon: Icon(Icons.dns)),
        Tab(text: "Security", icon: Icon(Icons.security)),
        Tab(text: "Billing", icon: Icon(Icons.payment)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildDNSTab(),
        _buildSecurityTab(),
        _buildBillingTab(),
      ],
      onInit: (tabController) {},
    );
  }
  
  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDomainInfoCard(),
            _buildContactInfoCard(),
            _buildDomainOptionsCard(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDomainInfoCard() {
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
              Icon(Icons.domain, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Domain Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Domain Status: Active",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Expires: Dec 15, 2024",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          QTextField(
            label: "Domain Name",
            value: domainName,
            hint: "Enter your domain name",
            validator: Validator.required,
            onChanged: (value) {
              domainName = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Registered",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Dec 15, 2023",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expires",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Dec 15, 2024",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactInfoCard() {
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
              Icon(Icons.person, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Registrant Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Full Name",
            value: registrantName,
            validator: Validator.required,
            onChanged: (value) {
              registrantName = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Email Address",
            value: registrantEmail,
            validator: Validator.email,
            onChanged: (value) {
              registrantEmail = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Phone Number",
            value: registrantPhone,
            validator: Validator.required,
            onChanged: (value) {
              registrantPhone = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Address",
            value: registrantAddress,
            hint: "Enter complete address",
            validator: Validator.required,
            onChanged: (value) {
              registrantAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDomainOptionsCard() {
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
                "Domain Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          _buildOptionRow(
            "Auto Renewal",
            "Automatically renew domain before expiration",
            autoRenewal,
            (value) {
              autoRenewal = value;
              setState(() {});
            },
          ),
          
          _buildOptionRow(
            "Privacy Protection",
            "Hide your personal information from WHOIS",
            privacyProtection,
            (value) {
              privacyProtection = value;
              setState(() {});
            },
          ),
          
          _buildOptionRow(
            "Domain Lock",
            "Protect domain from unauthorized transfers",
            domainLock,
            (value) {
              domainLock = value;
              setState(() {});
            },
          ),
          
          _buildOptionRow(
            "Email Forwarding",
            "Forward emails to your primary email address",
            emailForwarding,
            (value) {
              emailForwarding = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptionRow(String title, String description, bool value, Function(bool) onChanged) {
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
          SizedBox(width: spSm),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDNSTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDNSServersCard(),
          _buildDNSRecordsCard(),
        ],
      ),
    );
  }
  
  Widget _buildDNSServersCard() {
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
              Icon(Icons.dns, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "DNS Servers",
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Use Custom DNS",
                      "value": true,
                      "checked": customDNS,
                    }
                  ],
                  value: customDNS ? [{"label": "Use Custom DNS", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    customDNS = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (customDNS) ...[
            QTextField(
              label: "Primary DNS Server",
              value: primaryDNS,
              hint: "ns1.example.com",
              validator: Validator.required,
              onChanged: (value) {
                primaryDNS = value;
                setState(() {});
              },
            ),
            
            QTextField(
              label: "Secondary DNS Server",
              value: secondaryDNS,
              hint: "ns2.example.com",
              validator: Validator.required,
              onChanged: (value) {
                secondaryDNS = value;
                setState(() {});
              },
            ),
          ] else ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Default DNS Servers",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text("Primary: ns1.cloudflare.com"),
                  Text("Secondary: ns2.cloudflare.com"),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildDNSRecordsCard() {
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
              Icon(Icons.list, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "DNS Records",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new DNS record
                },
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: dnsRecords.map((record) => _buildDNSRecordRow(record)).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDNSRecordRow(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${record["type"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${record["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${record["value"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "TTL: ${record["ttl"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              // Edit DNS record
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSecurityOptionsCard(),
          _buildSSLCertificateCard(),
        ],
      ),
    );
  }
  
  Widget _buildSecurityOptionsCard() {
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
              Icon(Icons.security, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Security Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          _buildSecurityOption(
            "Two-Factor Authentication",
            "Add extra security to your account",
            twoFactorAuth,
            (value) {
              twoFactorAuth = value;
              setState(() {});
            },
          ),
          
          _buildSecurityOption(
            "Login Alerts",
            "Get notified of suspicious login attempts",
            loginAlerts,
            (value) {
              loginAlerts = value;
              setState(() {});
            },
          ),
          
          _buildSecurityOption(
            "API Access",
            "Enable API access for domain management",
            apiAccess,
            (value) {
              apiAccess = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSecurityOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? successColor.withAlpha(10) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? successColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle : Icons.radio_button_unchecked,
            color: value ? successColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
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
            activeColor: successColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildSSLCertificateCard() {
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
              Icon(Icons.https, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "SSL Certificate",
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
            children: sslOptions.map((ssl) => _buildSSLOption(ssl)).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSSLOption(Map<String, dynamic> ssl) {
    bool isSelected = selectedSSL == ssl["name"];
    
    return GestureDetector(
      onTap: () {
        selectedSSL = ssl["name"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ssl["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${ssl["level"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "\$${(ssl["price"] as double).toStringAsFixed(2)}/year",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBillingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentPlanCard(),
          _buildPlanOptionsCard(),
          _buildPaymentHistoryCard(),
        ],
      ),
    );
  }
  
  Widget _buildCurrentPlanCard() {
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
              Icon(Icons.credit_card, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Current Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pro Plan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Next billing: Dec 15, 2024",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$24.99/year",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlanOptionsCard() {
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
              Icon(Icons.layers, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Available Plans",
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
            children: plans.map((plan) => _buildPlanOption(plan)).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlanOption(Map<String, dynamic> plan) {
    bool isSelected = selectedPlan == plan["name"];
    
    return GestureDetector(
      onTap: () {
        selectedPlan = plan["name"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${plan["name"]} Plan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "\$${(plan["price"] as double).toStringAsFixed(2)} ${plan["duration"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Padding(
              padding: EdgeInsets.only(left: spLg),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (plan["features"] as List).map((feature) => Row(
                  children: [
                    Icon(Icons.check, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "$feature",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPaymentHistoryCard() {
    List<Map<String, dynamic>> payments = [
      {"date": "Nov 15, 2024", "description": "Pro Plan Renewal", "amount": 24.99, "status": "Paid"},
      {"date": "Oct 10, 2024", "description": "Premium SSL Certificate", "amount": 29.99, "status": "Paid"},
      {"date": "Sep 15, 2024", "description": "Domain Privacy Protection", "amount": 9.99, "status": "Paid"},
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
              Icon(Icons.history, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Payment History",
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
            children: payments.map((payment) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.receipt, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${payment["description"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${payment["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${(payment["amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${payment["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Save Changes",
            size: bs.md,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Domain settings updated successfully");
              }
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.refresh,
          size: bs.md,
          onPressed: () {
            setState(() {
              // Reset to default values
            });
          },
        ),
      ],
    );
  }
}
