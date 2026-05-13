import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEmailTemplatesView extends StatefulWidget {
  const CrmEmailTemplatesView({super.key});

  @override
  State<CrmEmailTemplatesView> createState() => _CrmEmailTemplatesViewState();
}

class _CrmEmailTemplatesViewState extends State<CrmEmailTemplatesView> {
  String searchQuery = "";
  String selectedCategory = "all";
  bool loading = false;

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Welcome Email",
      "description": "Welcome message for new customers with onboarding information",
      "category": "onboarding",
      "subject": "Welcome to {{company_name}}! Let's get you started",
      "content": "Hi {{first_name}},\n\nWelcome to {{company_name}}! We're thrilled to have you on board.\n\nTo get started, here are a few things you can do:\n• Complete your profile\n• Explore our features\n• Contact support if you need help\n\nBest regards,\nThe {{company_name}} Team",
      "variables": ["company_name", "first_name"],
      "usage_count": 1245,
      "success_rate": 89.5,
      "created_at": "2024-01-15T10:00:00",
      "last_used": "2024-06-19T09:30:00",
      "created_by": "Marketing Team",
      "tags": ["welcome", "onboarding", "automated"],
      "status": "active"
    },
    {
      "id": "2",
      "name": "Abandoned Cart Recovery",
      "description": "Remind customers about items left in their shopping cart",
      "category": "e-commerce",
      "subject": "You left something behind! Complete your purchase",
      "content": "Hi {{first_name}},\n\nWe noticed you left some great items in your cart. Don't miss out!\n\n{{cart_items}}\n\nTotal: {{cart_total}}\n\nComplete your purchase now and get FREE shipping!\n\n[Complete Purchase Button]\n\nHurry, items in your cart are in high demand!",
      "variables": ["first_name", "cart_items", "cart_total"],
      "usage_count": 892,
      "success_rate": 65.3,
      "created_at": "2024-02-10T14:30:00",
      "last_used": "2024-06-18T16:45:00",
      "created_by": "E-commerce Team",
      "tags": ["cart", "recovery", "automated", "sales"],
      "status": "active"
    },
    {
      "id": "3",
      "name": "Newsletter Template",
      "description": "Monthly newsletter template with company updates and features",
      "category": "newsletter",
      "subject": "{{month}} Newsletter - What's New at {{company_name}}",
      "content": "Hello {{first_name}},\n\nHere's what's been happening at {{company_name}} this month:\n\n📈 COMPANY UPDATES\n{{company_updates}}\n\n🚀 NEW FEATURES\n{{new_features}}\n\n📊 INDUSTRY INSIGHTS\n{{industry_insights}}\n\n💡 TIPS & TRICKS\n{{tips_section}}\n\nThank you for being part of our community!\n\nBest regards,\n{{sender_name}}",
      "variables": ["month", "company_name", "first_name", "company_updates", "new_features", "industry_insights", "tips_section", "sender_name"],
      "usage_count": 567,
      "success_rate": 72.8,
      "created_at": "2024-01-05T11:00:00",
      "last_used": "2024-06-15T08:00:00",
      "created_by": "Content Team",
      "tags": ["newsletter", "monthly", "updates"],
      "status": "active"
    },
    {
      "id": "4",
      "name": "Follow-up Email",
      "description": "Professional follow-up email for prospects and leads",
      "category": "sales",
      "subject": "Following up on our conversation - {{company_name}}",
      "content": "Hi {{first_name}},\n\nI hope this email finds you well. I wanted to follow up on our conversation about {{discussion_topic}}.\n\nAs discussed, here are the key points:\n{{key_points}}\n\nNext steps:\n{{next_steps}}\n\nI'd love to schedule a time to discuss this further. Are you available for a brief call this week?\n\nBest regards,\n{{sender_name}}\n{{sender_title}}\n{{company_name}}",
      "variables": ["first_name", "discussion_topic", "key_points", "next_steps", "sender_name", "sender_title", "company_name"],
      "usage_count": 423,
      "success_rate": 58.7,
      "created_at": "2024-03-20T09:15:00",
      "last_used": "2024-06-19T11:20:00",
      "created_by": "Sales Team",
      "tags": ["follow-up", "sales", "prospects"],
      "status": "active"
    },
    {
      "id": "5",
      "name": "Event Invitation",
      "description": "Invitation template for webinars, conferences, and events",
      "category": "events",
      "subject": "You're Invited: {{event_name}} on {{event_date}}",
      "content": "Dear {{first_name}},\n\nYou're cordially invited to join us for {{event_name}}!\n\n📅 Date: {{event_date}}\n🕐 Time: {{event_time}}\n📍 Location: {{event_location}}\n\nEvent Details:\n{{event_description}}\n\nWhat you'll learn:\n{{event_agenda}}\n\nWho should attend:\n{{target_audience}}\n\n[Register Now Button]\n\nSpaces are limited, so register today!\n\nLooking forward to seeing you there!\n\nBest regards,\n{{organizer_name}}",
      "variables": ["first_name", "event_name", "event_date", "event_time", "event_location", "event_description", "event_agenda", "target_audience", "organizer_name"],
      "usage_count": 234,
      "success_rate": 81.2,
      "created_at": "2024-04-05T13:45:00",
      "last_used": "2024-06-10T14:30:00",
      "created_by": "Events Team",
      "tags": ["events", "invitation", "webinar"],
      "status": "active"
    },
    {
      "id": "6",
      "name": "Password Reset",
      "description": "Security template for password reset requests",
      "category": "security",
      "subject": "Reset your {{company_name}} password",
      "content": "Hi {{first_name}},\n\nWe received a request to reset your password for your {{company_name}} account.\n\nIf you requested this, click the button below to reset your password:\n\n[Reset Password Button]\n\nThis link will expire in 24 hours for security purposes.\n\nIf you didn't request this password reset, please ignore this email or contact our support team if you have concerns.\n\nFor security reasons, never share this email with anyone.\n\nBest regards,\n{{company_name}} Security Team",
      "variables": ["first_name", "company_name", "reset_link"],
      "usage_count": 156,
      "success_rate": 95.8,
      "created_at": "2024-01-20T16:00:00",
      "last_used": "2024-06-19T07:15:00",
      "created_by": "Security Team",
      "tags": ["security", "password", "automated"],
      "status": "active"
    },
    {
      "id": "7",
      "name": "Customer Feedback Request",
      "description": "Template to request feedback and reviews from customers",
      "category": "feedback",
      "subject": "How was your experience with {{company_name}}?",
      "content": "Hi {{first_name}},\n\nThank you for choosing {{company_name}} for {{service_type}}!\n\nWe'd love to hear about your experience. Your feedback helps us improve our services and assist other customers.\n\nHow would you rate your experience?\n[5-Star Rating]\n\nWould you mind sharing a few words about your experience?\n[Feedback Form Button]\n\nAs a thank you, here's a special offer for your next purchase:\n{{special_offer}}\n\nThank you for your time and for being a valued customer!\n\nBest regards,\n{{sender_name}}\nCustomer Success Team",
      "variables": ["first_name", "company_name", "service_type", "special_offer", "sender_name"],
      "usage_count": 345,
      "success_rate": 43.6,
      "created_at": "2024-02-28T12:30:00",
      "last_used": "2024-06-17T10:45:00",
      "created_by": "Customer Success",
      "tags": ["feedback", "review", "customer"],
      "status": "active"
    },
    {
      "id": "8",
      "name": "Seasonal Promotion",
      "description": "Template for seasonal sales and promotional campaigns",
      "category": "promotional",
      "subject": "🎉 {{season}} Sale - Save {{discount}}% on Everything!",
      "content": "Hello {{first_name}},\n\nThe {{season}} season is here, and we're celebrating with our biggest sale of the year!\n\n🎯 Save {{discount}}% on ALL products\n⏰ Limited time offer - ends {{sale_end_date}}\n🚚 FREE shipping on orders over {{free_shipping_minimum}}\n\nFeatured Products:\n{{featured_products}}\n\nDon't miss out on these amazing deals:\n{{special_offers}}\n\n[Shop Now Button]\n\nUse code: {{promo_code}} at checkout\n\nHappy shopping!\n\nThe {{company_name}} Team",
      "variables": ["first_name", "season", "discount", "sale_end_date", "free_shipping_minimum", "featured_products", "special_offers", "promo_code", "company_name"],
      "usage_count": 789,
      "success_rate": 67.4,
      "created_at": "2024-03-15T08:00:00",
      "last_used": "2024-06-16T12:00:00",
      "created_by": "Marketing Team",
      "tags": ["promotional", "sale", "seasonal"],
      "status": "active"
    }
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return templates.where((template) {
      final matchesSearch = "${template["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           "${template["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           (template["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      final matchesCategory = selectedCategory == "all" || "${template["category"]}" == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList()..sort((a, b) => (b["usage_count"] as int).compareTo(a["usage_count"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateTemplateDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search templates...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            // Category Filter Chips
            QHorizontalScroll(
              children: [
                _buildCategoryChip("All", "all"),
                _buildCategoryChip("Onboarding", "onboarding"),
                _buildCategoryChip("Sales", "sales"),
                _buildCategoryChip("E-commerce", "e-commerce"),
                _buildCategoryChip("Newsletter", "newsletter"),
                _buildCategoryChip("Events", "events"),
                _buildCategoryChip("Security", "security"),
                _buildCategoryChip("Feedback", "feedback"),
                _buildCategoryChip("Promotional", "promotional"),
              ],
            ),

            // Template Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: [
                _buildStatCard("Total Templates", "${templates.length}", primaryColor, Icons.description),
                _buildStatCard("Most Used", "${templates.fold(0, (sum, t) => sum + (t["usage_count"] as int))}", successColor, Icons.trending_up),
                _buildStatCard("Avg. Success Rate", "${_calculateAverageSuccessRate().toStringAsFixed(1)}%", infoColor, Icons.check_circle),
                _buildStatCard("Active", "${templates.where((t) => t["status"] == "active").length}", warningColor, Icons.flash_on),
              ],
            ),

            // Templates List
            if (loading)
              Center(child: CircularProgressIndicator())
            else if (filteredTemplates.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.description, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No templates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredTemplates.map((template) => _buildTemplateCard(template)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateTemplateDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value) {
    final isSelected = selectedCategory == value;
    return GestureDetector(
      onTap: () {
        selectedCategory = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getCategoryColor("${template["category"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getCategoryIcon("${template["category"]}"),
                color: _getCategoryColor("${template["category"]}"),
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor("${template["category"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${template["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor("${template["category"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Subject line preview
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subject:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${template["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Template metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildMetric("Usage Count", "${template["usage_count"]}", Icons.trending_up),
              _buildMetric("Success Rate", "${template["success_rate"]}%", Icons.check_circle),
              _buildMetric("Variables", "${(template["variables"] as List).length}", Icons.code),
              _buildMetric("Last Used", _formatTimestamp("${template["last_used"]}"), Icons.schedule),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Tags
          if ((template["tags"] as List).isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (template["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: spSm),
          ],
          
          // Created by info
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Created by ${template["created_by"]} • ${_formatTimestamp("${template["created_at"]}")}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {
                    _useTemplate(template);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.preview,
                size: bs.sm,
                onPressed: () {
                  _previewTemplate(template);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _editTemplate(template);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showTemplateOptions(template);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "onboarding":
        return Icons.waving_hand;
      case "sales":
        return Icons.trending_up;
      case "e-commerce":
        return Icons.shopping_cart;
      case "newsletter":
        return Icons.newspaper;
      case "events":
        return Icons.event;
      case "security":
        return Icons.security;
      case "feedback":
        return Icons.feedback;
      case "promotional":
        return Icons.local_offer;
      default:
        return Icons.description;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "onboarding":
        return successColor;
      case "sales":
        return primaryColor;
      case "e-commerce":
        return warningColor;
      case "newsletter":
        return infoColor;
      case "events":
        return Colors.purple;
      case "security":
        return dangerColor;
      case "feedback":
        return Colors.orange;
      case "promotional":
        return Colors.pink;
      default:
        return disabledBoldColor;
    }
  }

  double _calculateAverageSuccessRate() {
    if (templates.isEmpty) return 0.0;
    
    final totalSuccessRate = templates.fold(0.0, (sum, t) => sum + (t["success_rate"] as double));
    return totalSuccessRate / templates.length;
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays}d ago";
      } else {
        return "${(difference.inDays / 7).round()}w ago";
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Templates"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text("High success rate only"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Frequently used"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Recently created"),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCreateTemplateDialog() {
    String templateName = "";
    String templateDescription = "";
    String templateCategory = "onboarding";
    String templateSubject = "";
    String templateContent = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Email Template"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Template Name",
                value: templateName,
                onChanged: (value) => templateName = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: templateDescription,
                onChanged: (value) => templateDescription = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Category",
                items: [
                  {"label": "Onboarding", "value": "onboarding"},
                  {"label": "Sales", "value": "sales"},
                  {"label": "E-commerce", "value": "e-commerce"},
                  {"label": "Newsletter", "value": "newsletter"},
                  {"label": "Events", "value": "events"},
                  {"label": "Security", "value": "security"},
                  {"label": "Feedback", "value": "feedback"},
                  {"label": "Promotional", "value": "promotional"},
                ],
                value: templateCategory,
                onChanged: (value, label) => templateCategory = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Subject Line",
                value: templateSubject,
                hint: "Use {{variable}} for dynamic content",
                onChanged: (value) => templateSubject = value,
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Email Content",
                value: templateContent,
                hint: "Write your email content here. Use {{variable}} for dynamic content.",
                onChanged: (value) => templateContent = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (templateName.isNotEmpty && templateSubject.isNotEmpty && templateContent.isNotEmpty) {
                Navigator.pop(context);
                _createTemplate(templateName, templateDescription, templateCategory, templateSubject, templateContent);
              } else {
                se("Please fill in all required fields");
              }
            },
          ),
        ],
      ),
    );
  }

  void _previewTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Template Preview"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Template: ${template["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("Subject:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${template["subject"]}", style: TextStyle(fontStyle: FontStyle.italic)),
              SizedBox(height: spSm),
              Text("Content:", style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text("${template["content"]}"),
              ),
              SizedBox(height: spSm),
              Text("Variables:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${(template["variables"] as List).join(", ")}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _useTemplate(Map<String, dynamic> template) {
    // Update usage count
    template["usage_count"] = (template["usage_count"] as int) + 1;
    template["last_used"] = DateTime.now().toString();
    setState(() {});
    
    ss("Template '${template["name"]}' ready to use");
    //navigateTo('CrmEmailComposeView', arguments: template);
  }

  void _editTemplate(Map<String, dynamic> template) {
    String templateName = "${template["name"]}";
    String templateDescription = "${template["description"]}";
    String templateCategory = "${template["category"]}";
    String templateSubject = "${template["subject"]}";
    String templateContent = "${template["content"]}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Template"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Template Name",
                value: templateName,
                onChanged: (value) => templateName = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: templateDescription,
                onChanged: (value) => templateDescription = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Subject Line",
                value: templateSubject,
                onChanged: (value) => templateSubject = value,
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Email Content",
                value: templateContent,
                onChanged: (value) => templateContent = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _updateTemplate(template, templateName, templateDescription, templateSubject, templateContent);
            },
          ),
        ],
      ),
    );
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text("Duplicate Template"),
              onTap: () {
                Navigator.pop(context);
                _duplicateTemplate(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Export Template"),
              onTap: () {
                Navigator.pop(context);
                _exportTemplate(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Template"),
              onTap: () {
                Navigator.pop(context);
                _shareTemplate(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Analytics"),
              onTap: () {
                Navigator.pop(context);
                _viewTemplateAnalytics(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Template", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this template?");
                if (isConfirmed) {
                  _deleteTemplate(template);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createTemplate(String name, String description, String category, String subject, String content) {
    // Extract variables from content and subject
    final variables = <String>[];
    final regex = RegExp(r'\{\{([^}]+)\}\}');
    final matches = regex.allMatches(subject + content);
    for (final match in matches) {
      final variable = match.group(1);
      if (variable != null && !variables.contains(variable)) {
        variables.add(variable);
      }
    }

    final newTemplate = {
      "id": "${templates.length + 1}",
      "name": name,
      "description": description,
      "category": category,
      "subject": subject,
      "content": content,
      "variables": variables,
      "usage_count": 0,
      "success_rate": 0.0,
      "created_at": DateTime.now().toString(),
      "last_used": DateTime.now().toString(),
      "created_by": "Current User",
      "tags": [category],
      "status": "active"
    };
    
    templates.insert(0, newTemplate);
    setState(() {});
    ss("Template created successfully");
  }

  void _updateTemplate(Map<String, dynamic> template, String name, String description, String subject, String content) {
    // Extract variables from updated content and subject
    final variables = <String>[];
    final regex = RegExp(r'\{\{([^}]+)\}\}');
    final matches = regex.allMatches(subject + content);
    for (final match in matches) {
      final variable = match.group(1);
      if (variable != null && !variables.contains(variable)) {
        variables.add(variable);
      }
    }

    template["name"] = name;
    template["description"] = description;
    template["subject"] = subject;
    template["content"] = content;
    template["variables"] = variables;
    setState(() {});
    ss("Template updated successfully");
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    final duplicatedTemplate = Map<String, dynamic>.from(template);
    duplicatedTemplate["id"] = "${templates.length + 1}";
    duplicatedTemplate["name"] = "${template["name"]} (Copy)";
    duplicatedTemplate["usage_count"] = 0;
    duplicatedTemplate["created_at"] = DateTime.now().toString();
    
    templates.insert(0, duplicatedTemplate);
    setState(() {});
    ss("Template duplicated successfully");
  }

  void _exportTemplate(Map<String, dynamic> template) {
    ss("Template export functionality would be implemented here");
  }

  void _shareTemplate(Map<String, dynamic> template) {
    ss("Template sharing functionality would be implemented here");
  }

  void _viewTemplateAnalytics(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Template Analytics"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Template: ${template["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("Performance Metrics:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("• Usage Count: ${template["usage_count"]}"),
              Text("• Success Rate: ${template["success_rate"]}%"),
              Text("• Category: ${template["category"]}"),
              Text("• Variables: ${(template["variables"] as List).length}"),
              SizedBox(height: spSm),
              Text("Usage History:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("• Created: ${_formatTimestamp("${template["created_at"]}")}"),
              Text("• Last Used: ${_formatTimestamp("${template["last_used"]}")}"),
              Text("• Created By: ${template["created_by"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _deleteTemplate(Map<String, dynamic> template) {
    templates.removeWhere((t) => t["id"] == template["id"]);
    setState(() {});
    ss("Template deleted successfully");
  }
}
