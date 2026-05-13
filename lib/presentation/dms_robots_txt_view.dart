import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsRobotsTxtView extends StatefulWidget {
  const DmsRobotsTxtView({super.key});

  @override
  State<DmsRobotsTxtView> createState() => _DmsRobotsTxtViewState();
}

class _DmsRobotsTxtViewState extends State<DmsRobotsTxtView> {
  String robotsContent = "";
  String selectedTemplate = "ecommerce";
  String domain = "";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> templates = [
    {"label": "E-commerce Website", "value": "ecommerce"},
    {"label": "Blog/News Site", "value": "blog"},
    {"label": "Corporate Website", "value": "corporate"},
    {"label": "SaaS Product", "value": "saas"},
    {"label": "Custom Template", "value": "custom"},
  ];

  List<Map<String, dynamic>> validationResults = [
    {
      "rule": "User-agent: *",
      "status": "valid",
      "line": 1,
      "description": "Applies to all web crawlers"
    },
    {
      "rule": "Disallow: /admin/",
      "status": "valid",
      "line": 2,
      "description": "Blocks access to admin directory"
    },
    {
      "rule": "Allow: /wp-admin/admin-ajax.php",
      "status": "valid",
      "line": 3,
      "description": "Allows access to WordPress AJAX"
    },
    {
      "rule": "Sitemap: https://example.com/sitemap.xml",
      "status": "warning",
      "line": 15,
      "description": "Sitemap URL should be absolute"
    }
  ];

  List<Map<String, dynamic>> commonDirectives = [
    {
      "directive": "User-agent",
      "description": "Specifies which robots the rule applies to",
      "example": "User-agent: *",
      "category": "Basic"
    },
    {
      "directive": "Disallow",
      "description": "Tells robots not to access specific paths",
      "example": "Disallow: /private/",
      "category": "Basic"
    },
    {
      "directive": "Allow",
      "description": "Overrides a disallow directive for specific paths",
      "example": "Allow: /public/",
      "category": "Basic"
    },
    {
      "directive": "Sitemap",
      "description": "Provides the location of your XML sitemap",
      "example": "Sitemap: https://example.com/sitemap.xml",
      "category": "Advanced"
    },
    {
      "directive": "Crawl-delay",
      "description": "Sets delay between crawler requests",
      "example": "Crawl-delay: 10",
      "category": "Advanced"
    }
  ];

  String ecommerceTemplate = """User-agent: *
Disallow: /admin/
Disallow: /cart/
Disallow: /checkout/
Disallow: /account/
Disallow: /search?
Disallow: /wp-admin/
Allow: /wp-admin/admin-ajax.php
Disallow: /wp-includes/
Disallow: /wp-content/plugins/
Disallow: /wp-content/themes/
Allow: /wp-content/uploads/

# Search engine specific rules
User-agent: Googlebot
Allow: /

User-agent: Bingbot
Allow: /

# Social media crawlers
User-agent: facebookexternalhit
Allow: /

# Sitemap location
Sitemap: https://example.com/sitemap.xml
Sitemap: https://example.com/sitemap-products.xml""";

  String blogTemplate = """User-agent: *
Disallow: /wp-admin/
Allow: /wp-admin/admin-ajax.php
Disallow: /wp-includes/
Disallow: /wp-content/plugins/
Disallow: /wp-content/themes/
Allow: /wp-content/uploads/
Disallow: /search
Disallow: /author/
Disallow: /date/
Disallow: /?s=
Disallow: /*?

# Allow important pages
Allow: /

# Search engines
User-agent: Googlebot
Allow: /

User-agent: Bingbot
Allow: /

# Sitemap
Sitemap: https://example.com/sitemap.xml""";

  @override
  void initState() {
    super.initState();
    robotsContent = ecommerceTemplate;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Robots.txt Generator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Generator", icon: Icon(Icons.build)),
        Tab(text: "Validator", icon: Icon(Icons.check_circle)),
        Tab(text: "Guide", icon: Icon(Icons.help)),
      ],
      tabChildren: [
        _buildGeneratorTab(),
        _buildValidatorTab(),
        _buildGuideTab(),
      ],
    );
  }

  Widget _buildGeneratorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGeneratorForm(),
          _buildRobotsPreview(),
        ],
      ),
    );
  }

  Widget _buildGeneratorForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Robots.txt Generator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Domain",
            value: domain,
            hint: "https://example.com",
            onChanged: (value) {
              domain = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Template Type",
            items: templates,
            value: selectedTemplate,
            onChanged: (value, label) {
              selectedTemplate = value;
              _updateTemplate();
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Robots.txt",
                  size: bs.md,
                  onPressed: () => _generateRobots(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Download",
                size: bs.md,
                icon: Icons.download,
                onPressed: () => _downloadRobots(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRobotsPreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Robots.txt Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Copy",
                size: bs.sm,
                icon: Icons.copy,
                onPressed: () => _copyToClipboard(),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 300,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: SingleChildScrollView(
              child: Text(
                robotsContent,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
            ),
          ),
          QMemoField(
            label: "Custom Rules",
            value: "",
            hint: "Add custom robots.txt rules here",
            onChanged: (value) {
              // Handle custom rules
            },
          ),
        ],
      ),
    );
  }

  Widget _buildValidatorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildValidatorForm(),
          _buildValidationResults(),
        ],
      ),
    );
  }

  Widget _buildValidatorForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Robots.txt Validator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Robots.txt URL",
            value: "",
            hint: "https://example.com/robots.txt",
            onChanged: (value) {
              // Handle URL input
            },
          ),
          Text(
            "Or paste your robots.txt content:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Robots.txt Content",
            value: "",
            hint: "Paste your robots.txt content here",
            onChanged: (value) {
              // Handle content input
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Validate",
              size: bs.md,
              onPressed: () => _validateRobots(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationResults() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Validation Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildValidationStat("Valid Rules", "12", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildValidationStat("Warnings", "1", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildValidationStat("Errors", "0", dangerColor),
              ),
            ],
          ),
          ...validationResults.map((result) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: _getStatusColor("${result["status"]}").withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: _getStatusColor("${result["status"]}").withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon("${result["status"]}"),
                    color: _getStatusColor("${result["status"]}"),
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${result["rule"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${result["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Line ${result["line"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildValidationStat(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGuideHeader(),
          _buildDirectivesGuide(),
          _buildBestPractices(),
        ],
      ),
    );
  }

  Widget _buildGuideHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Robots.txt Guide",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "The robots.txt file tells search engine crawlers which URLs the crawler can access on your site. This is used mainly to avoid overloading your site with requests.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Place your robots.txt file in the root directory of your website (e.g., https://example.com/robots.txt)",
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

  Widget _buildDirectivesGuide() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Common Directives",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...commonDirectives.map((directive) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "${directive["directive"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getCategoryColor("${directive["category"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${directive["category"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: _getCategoryColor("${directive["category"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${directive["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${directive["example"]}",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBestPractices() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Best Practices",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildPracticeItem(
            "Always include sitemap location",
            "Add your XML sitemap URL to help search engines discover your content",
            Icons.account_tree,
            successColor,
          ),
          _buildPracticeItem(
            "Use specific paths",
            "Be specific with your disallow rules to avoid blocking important content",
            Icons.folder,
            warningColor,
          ),
          _buildPracticeItem(
            "Test your robots.txt",
            "Use Google Search Console to test your robots.txt file",
            Icons.bug_report,
            infoColor,
          ),
          _buildPracticeItem(
            "Keep it simple",
            "Robots.txt is not a security measure - don't rely on it to hide sensitive content",
            Icons.security,
            dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "valid":
        return successColor;
      case "warning":
        return warningColor;
      case "error":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "valid":
        return Icons.check_circle;
      case "warning":
        return Icons.warning;
      case "error":
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Basic":
        return successColor;
      case "Advanced":
        return warningColor;
      default:
        return infoColor;
    }
  }

  void _updateTemplate() {
    switch (selectedTemplate) {
      case "ecommerce":
        robotsContent = ecommerceTemplate;
        break;
      case "blog":
        robotsContent = blogTemplate;
        break;
      case "corporate":
        robotsContent = ecommerceTemplate.replaceAll("/cart/", "/contact/");
        break;
      case "saas":
        robotsContent = ecommerceTemplate.replaceAll("/cart/", "/dashboard/");
        break;
      default:
        robotsContent = "";
    }
  }

  void _generateRobots() {
    if (domain.isEmpty) {
      se("Please enter your domain");
      return;
    }
    
    // Update sitemap URLs with actual domain
    robotsContent = robotsContent.replaceAll("https://example.com", domain);
    setState(() {});
    ss("Robots.txt generated successfully");
  }

  void _downloadRobots() {
    ss("Robots.txt file downloaded");
  }

  void _copyToClipboard() {
    ss("Robots.txt content copied to clipboard");
  }

  void _validateRobots() {
    loading = true;
    setState(() {});
    
    // Simulate validation
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Robots.txt validation completed");
    });
  }
}
