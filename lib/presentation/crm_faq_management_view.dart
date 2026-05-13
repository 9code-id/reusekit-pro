import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmFaqManagementView extends StatefulWidget {
  const CrmFaqManagementView({super.key});

  @override
  State<CrmFaqManagementView> createState() => _CrmFaqManagementViewState();
}

class _CrmFaqManagementViewState extends State<CrmFaqManagementView> {
  String searchQuery = "";
  String selectedCategory = "all";
  bool showAddFaqForm = false;
  
  String faqQuestion = "";
  String faqAnswer = "";
  String faqCategory = "";
  String faqTags = "";
  bool faqPublished = true;
  int faqOrder = 1;

  List<Map<String, dynamic>> faqs = [
    {
      "id": 1,
      "question": "How do I reset my password?",
      "answer": "To reset your password, go to the login page and click 'Forgot Password'. Enter your email address and we'll send you a reset link.",
      "category": "Account",
      "tags": ["password", "login", "account"],
      "published": true,
      "order": 1,
      "views": 1245,
      "helpful": 89,
      "notHelpful": 12,
      "createdAt": "2024-12-15 10:30:00",
      "updatedAt": "2024-12-18 14:20:00",
    },
    {
      "id": 2,
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit cards (Visa, MasterCard, American Express), PayPal, and bank transfers for enterprise accounts.",
      "category": "Billing",
      "tags": ["payment", "billing", "credit card"],
      "published": true,
      "order": 2,
      "views": 892,
      "helpful": 76,
      "notHelpful": 8,
      "createdAt": "2024-12-14 09:15:00",
      "updatedAt": "2024-12-19 11:45:00",
    },
    {
      "id": 3,
      "question": "How can I upgrade my subscription plan?",
      "answer": "To upgrade your plan, go to Account Settings > Subscription and select the plan you want. Changes take effect immediately.",
      "category": "Billing",
      "tags": ["upgrade", "subscription", "plan"],
      "published": true,
      "order": 3,
      "views": 567,
      "helpful": 45,
      "notHelpful": 5,
      "createdAt": "2024-12-13 16:00:00",
      "updatedAt": "2024-12-19 09:30:00",
    },
    {
      "id": 4,
      "question": "Is there a mobile app available?",
      "answer": "Yes, we have mobile apps for both iOS and Android. You can download them from the App Store or Google Play Store.",
      "category": "Mobile",
      "tags": ["mobile", "app", "ios", "android"],
      "published": true,
      "order": 4,
      "views": 734,
      "helpful": 62,
      "notHelpful": 3,
      "createdAt": "2024-12-12 13:20:00",
      "updatedAt": "2024-12-17 15:10:00",
    },
    {
      "id": 5,
      "question": "How do I contact customer support?",
      "answer": "You can reach our support team through live chat, email at support@company.com, or by creating a support ticket in your dashboard.",
      "category": "Support",
      "tags": ["support", "contact", "help"],
      "published": false,
      "order": 5,
      "views": 456,
      "helpful": 34,
      "notHelpful": 2,
      "createdAt": "2024-12-11 11:00:00",
      "updatedAt": "2024-12-16 16:30:00",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Account", "count": 8, "icon": Icons.account_circle},
    {"name": "Billing", "count": 12, "icon": Icons.payment},
    {"name": "Technical", "count": 15, "icon": Icons.settings},
    {"name": "Mobile", "count": 6, "icon": Icons.smartphone},
    {"name": "Support", "count": 9, "icon": Icons.help},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showAddFaqForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showAddFaqForm ? _buildAddFaqForm() : _buildFaqManagement(),
    );
  }

  Widget _buildFaqManagement() {
    final filteredFaqs = faqs.where((faq) {
      final matchesSearch = (faq["question"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (faq["answer"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "all" ||
          faq["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFaqHeader(),
          _buildFaqFilters(),
          _buildFaqStats(),
          _buildCategoriesOverview(),
          _buildFaqsList(filteredFaqs),
        ],
      ),
    );
  }

  Widget _buildFaqHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FAQ Management",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Manage frequently asked questions and answers",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.quiz,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search FAQs",
          value: searchQuery,
          hint: "Search by question or answer",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Category",
          items: [
            {"label": "All Categories", "value": "all"},
            ...categories.map((cat) => {
                  "label": cat["name"],
                  "value": cat["name"],
                }),
          ],
          value: selectedCategory,
          onChanged: (value, label) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildFaqStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "FAQ Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total FAQs",
                  "${faqs.length}",
                  Icons.quiz,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Published",
                  "${faqs.where((f) => f["published"] == true).length}",
                  Icons.public,
                  successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Views",
                  "${faqs.fold(0, (sum, f) => sum + (f["views"] as int))}",
                  Icons.visibility,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Helpful Votes",
                  "${faqs.fold(0, (sum, f) => sum + (f["helpful"] as int))}",
                  Icons.thumb_up,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: categories.map((category) {
              return Container(
                width: 120,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: selectedCategory == category["name"]
                      ? primaryColor.withAlpha(20)
                      : disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: selectedCategory == category["name"]
                      ? Border.all(color: primaryColor)
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      category["icon"],
                      color: selectedCategory == category["name"]
                          ? primaryColor
                          : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selectedCategory == category["name"]
                            ? primaryColor
                            : disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${category["count"]} FAQs",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqsList(List<Map<String, dynamic>> filteredFaqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "FAQs (${filteredFaqs.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Reorder FAQs",
              size: bs.sm,
              onPressed: () {
                _showReorderDialog();
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: filteredFaqs.map((faq) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: faq["published"] == true ? successColor : warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            "${faq["order"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${faq["question"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: faq["published"] == true
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          faq["published"] == true ? "Published" : "Draft",
                          style: TextStyle(
                            fontSize: 12,
                            color: faq["published"] == true
                                ? successColor
                                : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${faq["answer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${faq["category"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${faq["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up, size: 16, color: successColor),
                              SizedBox(width: spXs),
                              Text(
                                "${faq["helpful"]} helpful",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.thumb_down, size: 16, color: dangerColor),
                              SizedBox(width: spXs),
                              Text(
                                "${faq["notHelpful"]} not helpful",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (faq["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit FAQ",
                          size: bs.sm,
                          onPressed: () {
                            _editFaq(faq);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: faq["published"] == true ? Icons.visibility_off : Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          _toggleFaqStatus(faq);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm(
                              "Are you sure you want to delete this FAQ?");
                          if (isConfirmed) {
                            _deleteFaq(faq["id"] as int);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAddFaqForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showAddFaqForm = false;
                  _resetFaqForm();
                  setState(() {});
                },
              ),
              Text(
                "Add New FAQ",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Column(
            spacing: spMd,
            children: [
              QTextField(
                label: "Question",
                value: faqQuestion,
                hint: "Enter the frequently asked question",
                onChanged: (value) {
                  faqQuestion = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Answer",
                value: faqAnswer,
                hint: "Provide a clear and helpful answer",
                onChanged: (value) {
                  faqAnswer = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories.map((cat) => {
                            "label": cat["name"],
                            "value": cat["name"],
                          }).toList(),
                      value: faqCategory,
                      onChanged: (value, label) {
                        faqCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Display Order",
                      value: faqOrder.toString(),
                      onChanged: (value) {
                        faqOrder = int.tryParse(value) ?? 1;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Tags",
                value: faqTags,
                hint: "Enter tags separated by commas",
                onChanged: (value) {
                  faqTags = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Publish FAQ",
                    "value": true,
                    "checked": faqPublished,
                  }
                ],
                value: [
                  if (faqPublished)
                    {
                      "label": "Publish FAQ",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  faqPublished = values.isNotEmpty;
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save FAQ",
                  size: bs.md,
                  onPressed: () {
                    _saveFaq();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
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
        ],
      ),
    );
  }

  void _saveFaq() {
    if (faqQuestion.isNotEmpty && faqAnswer.isNotEmpty && faqCategory.isNotEmpty) {
      faqs.add({
        "id": faqs.length + 1,
        "question": faqQuestion,
        "answer": faqAnswer,
        "category": faqCategory,
        "tags": faqTags.split(',').map((tag) => tag.trim()).toList(),
        "published": faqPublished,
        "order": faqOrder,
        "views": 0,
        "helpful": 0,
        "notHelpful": 0,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
      });
      
      ss("FAQ saved successfully");
      showAddFaqForm = false;
      _resetFaqForm();
      setState(() {});
    } else {
      se("Please fill in all required fields");
    }
  }

  void _editFaq(Map<String, dynamic> faq) {
    faqQuestion = faq["question"];
    faqAnswer = faq["answer"];
    faqCategory = faq["category"];
    faqTags = (faq["tags"] as List).join(', ');
    faqPublished = faq["published"];
    faqOrder = faq["order"];
    showAddFaqForm = true;
    setState(() {});
  }

  void _toggleFaqStatus(Map<String, dynamic> faq) {
    faq["published"] = !faq["published"];
    ss("FAQ ${faq["published"] ? "published" : "unpublished"} successfully");
    setState(() {});
  }

  void _deleteFaq(int id) {
    faqs.removeWhere((faq) => faq["id"] == id);
    ss("FAQ deleted successfully");
    setState(() {});
  }

  void _showReorderDialog() {
    // Placeholder for reorder functionality
    si("Drag and drop functionality would be implemented here");
  }

  void _resetFaqForm() {
    faqQuestion = "";
    faqAnswer = "";
    faqCategory = "";
    faqTags = "";
    faqPublished = true;
    faqOrder = faqs.length + 1;
  }
}
