import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout3View extends StatefulWidget {
  @override
  State<GrlAbout3View> createState() => _GrlAbout3ViewState();
}

class _GrlAbout3ViewState extends State<GrlAbout3View> {
  String selectedSection = 'overview';
  
  List<Map<String, dynamic>> serviceStats = [
    {
      "title": "Active Users",
      "value": "2.5M",
      "icon": Icons.people,
      "color": primaryColor,
      "growth": "+23%",
    },
    {
      "title": "Daily Transactions",
      "value": "150K",
      "icon": Icons.analytics,
      "color": successColor,
      "growth": "+18%",
    },
    {
      "title": "Countries Served",
      "value": "75",
      "icon": Icons.public,
      "color": infoColor,
      "growth": "+12%",
    },
    {
      "title": "Customer Satisfaction",
      "value": "98%",
      "icon": Icons.sentiment_very_satisfied,
      "color": warningColor,
      "growth": "+5%",
    },
  ];

  List<Map<String, dynamic>> certifications = [
    {
      "name": "ISO 27001",
      "description": "Information Security Management",
      "year": "2024",
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "name": "SOC 2 Type II",
      "description": "Security, Availability & Confidentiality",
      "year": "2024",
      "icon": Icons.verified,
      "color": infoColor,
    },
    {
      "name": "GDPR Compliant",
      "description": "General Data Protection Regulation",
      "year": "2023",
      "icon": Icons.privacy_tip,
      "color": warningColor,
    },
    {
      "name": "PCI DSS",
      "description": "Payment Card Industry Data Security",
      "year": "2023",
      "icon": Icons.payment,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> awards = [
    {
      "title": "Best Fintech Innovation 2024",
      "organization": "Global Finance Awards",
      "description": "Recognized for revolutionary approach to digital banking solutions.",
      "image": "https://picsum.photos/100/100?random=1&keyword=award",
    },
    {
      "title": "Tech Company of the Year",
      "organization": "Innovation Summit 2023",
      "description": "Outstanding achievement in technology development and implementation.",
      "image": "https://picsum.photos/100/100?random=2&keyword=trophy",
    },
    {
      "title": "Customer Choice Award",
      "organization": "Consumer Trust 2023",
      "description": "Highest customer satisfaction rating in our industry segment.",
      "image": "https://picsum.photos/100/100?random=3&keyword=medal",
    },
  ];

  List<Map<String, dynamic>> partnerships = [
    {
      "name": "Microsoft Azure",
      "type": "Cloud Infrastructure",
      "description": "Strategic partnership for scalable cloud solutions",
      "logo": "https://picsum.photos/60/60?random=4&keyword=tech",
    },
    {
      "name": "Amazon Web Services",
      "type": "Cloud Services",
      "description": "Enterprise-grade hosting and data analytics",
      "logo": "https://picsum.photos/60/60?random=5&keyword=cloud",
    },
    {
      "name": "Stripe",
      "type": "Payment Processing",
      "description": "Secure and reliable payment infrastructure",
      "logo": "https://picsum.photos/60/60?random=6&keyword=payment",
    },
    {
      "name": "Salesforce",
      "type": "CRM Integration",
      "description": "Customer relationship management solutions",
      "logo": "https://picsum.photos/60/60?random=7&keyword=business",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Section Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: [
                _buildSectionTab('overview', 'Overview', Icons.dashboard),
                _buildSectionTab('certifications', 'Certifications', Icons.verified_user),
                _buildSectionTab('awards', 'Awards', Icons.emoji_events),
                _buildSectionTab('partnerships', 'Partners', Icons.handshake),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildSelectedContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTab(String value, String label, IconData icon) {
    final isSelected = selectedSection == value;
    return GestureDetector(
      onTap: () {
        selectedSection = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
            SizedBox(width: spSm),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (selectedSection) {
      case 'overview':
        return _buildOverviewContent();
      case 'certifications':
        return _buildCertificationsContent();
      case 'awards':
        return _buildAwardsContent();
      case 'partnerships':
        return _buildPartnershipsContent();
      default:
        return _buildOverviewContent();
    }
  }

  Widget _buildOverviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Stats
        Text(
          "Company Performance",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: serviceStats.map((stat) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (stat["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 24,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${stat["growth"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${stat["value"]}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: stat["color"] as Color,
                  ),
                ),
                Text(
                  "${stat["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
        
        SizedBox(height: spMd),
        
        // Mission Statement
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [infoColor, infoColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Our Mission",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "To democratize access to financial services and empower individuals and businesses worldwide through innovative technology solutions that are secure, accessible, and user-friendly.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Global Presence
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.language,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Global Presence",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Operating in 75 countries across 6 continents, we serve millions of customers with 24/7 support in 15 languages. Our global infrastructure ensures 99.99% uptime and lightning-fast performance worldwide.",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.6,
                ),
              ),
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Americas",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "25 Countries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Europe",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "30 Countries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Asia-Pacific",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "20 Countries",
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Security & Compliance",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...certifications.map((cert) => Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (cert["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  cert["icon"] as IconData,
                  color: cert["color"] as Color,
                  size: 32,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${cert["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (cert["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${cert["year"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: cert["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${cert["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildAwardsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recognition & Awards",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...awards.map((award) => Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${award["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${award["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${award["organization"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${award["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildPartnershipsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Strategic Partnerships",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...partnerships.map((partner) => Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${partner["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${partner["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${partner["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${partner["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}
