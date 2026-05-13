import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCustomerSupportView extends StatefulWidget {
  const SpaCustomerSupportView({Key? key}) : super(key: key);

  @override
  State<SpaCustomerSupportView> createState() => _SpaCustomerSupportViewState();
}

class _SpaCustomerSupportViewState extends State<SpaCustomerSupportView> {
  String selectedCategory = "general";
  String searchQuery = "";
  String selectedSupportOption = "";

  List<Map<String, dynamic>> supportCategories = [
    {"label": "General", "value": "general", "icon": Icons.help_outline},
    {"label": "Booking", "value": "booking", "icon": Icons.calendar_today},
    {"label": "Payment", "value": "payment", "icon": Icons.payment},
    {"label": "Technical", "value": "technical", "icon": Icons.bug_report},
  ];

  List<Map<String, dynamic>> supportOptions = [
    {
      "id": 1,
      "title": "Live Chat",
      "description": "Chat with our support team in real-time",
      "icon": Icons.chat,
      "availability": "Available 24/7",
      "responseTime": "Instant",
      "type": "chat",
      "isAvailable": true,
      "priority": "high",
    },
    {
      "id": 2,
      "title": "Phone Support",
      "description": "Speak directly with a support representative",
      "icon": Icons.phone,
      "availability": "Mon-Fri 8AM-8PM",
      "responseTime": "Immediate",
      "type": "phone",
      "isAvailable": true,
      "priority": "high",
      "phone": "+1 (555) 123-4567",
    },
    {
      "id": 3,
      "title": "Email Support",
      "description": "Send us a detailed message about your issue",
      "icon": Icons.email,
      "availability": "Available 24/7",
      "responseTime": "Within 2 hours",
      "type": "email",
      "isAvailable": true,
      "priority": "medium",
      "email": "support@spaluxury.com",
    },
    {
      "id": 4,
      "title": "Video Call",
      "description": "Schedule a video call for complex issues",
      "icon": Icons.video_call,
      "availability": "By appointment",
      "responseTime": "Same day",
      "type": "video",
      "isAvailable": true,
      "priority": "medium",
    },
    {
      "id": 5,
      "title": "FAQ Center",
      "description": "Browse frequently asked questions",
      "icon": Icons.quiz,
      "availability": "Available 24/7",
      "responseTime": "Instant",
      "type": "faq",
      "isAvailable": true,
      "priority": "low",
    },
    {
      "id": 6,
      "title": "Submit Ticket",
      "description": "Create a support ticket for tracking",
      "icon": Icons.confirmation_number,
      "availability": "Available 24/7",
      "responseTime": "Within 4 hours",
      "type": "ticket",
      "isAvailable": true,
      "priority": "medium",
    },
  ];

  Map<String, List<Map<String, dynamic>>> faqByCategory = {
    "general": [
      {
        "question": "What are your spa operating hours?",
        "answer": "Our spa is open Monday through Sunday from 8:00 AM to 10:00 PM. Extended hours are available for special bookings.",
        "helpful": 45,
        "category": "general",
      },
      {
        "question": "What should I wear to my spa appointment?",
        "answer": "We provide comfortable robes and slippers. Please wear minimal makeup and comfortable clothing. Remove jewelry before treatments.",
        "helpful": 38,
        "category": "general",
      },
      {
        "question": "Do you offer couple's treatments?",
        "answer": "Yes! We have several couple's suites and offer romantic packages including massages, facials, and relaxation sessions.",
        "helpful": 52,
        "category": "general",
      },
    ],
    "booking": [
      {
        "question": "How far in advance should I book?",
        "answer": "We recommend booking 2-3 days in advance for regular treatments and 1-2 weeks for special packages or weekend appointments.",
        "helpful": 67,
        "category": "booking",
      },
      {
        "question": "Can I modify or cancel my booking?",
        "answer": "Yes, you can modify or cancel bookings up to 24 hours before your appointment without penalty. Same-day changes may incur fees.",
        "helpful": 89,
        "category": "booking",
      },
      {
        "question": "What is your no-show policy?",
        "answer": "No-show appointments are charged 50% of the treatment cost. Please call us if you're running late or need to reschedule.",
        "helpful": 43,
        "category": "booking",
      },
    ],
    "payment": [
      {
        "question": "What payment methods do you accept?",
        "answer": "We accept all major credit cards, debit cards, cash, and digital payments including Apple Pay and Google Pay.",
        "helpful": 56,
        "category": "payment",
      },
      {
        "question": "Do you offer payment plans?",
        "answer": "Yes, we offer flexible payment plans for packages over \$500. Contact our billing department for more details.",
        "helpful": 34,
        "category": "payment",
      },
      {
        "question": "Can I use multiple gift cards?",
        "answer": "Yes, you can combine multiple gift cards for a single purchase. Any remaining balance can be paid with other methods.",
        "helpful": 29,
        "category": "payment",
      },
    ],
    "technical": [
      {
        "question": "I'm having trouble with the mobile app",
        "answer": "Try updating the app to the latest version. If issues persist, clear the app cache or reinstall. Contact tech support for further assistance.",
        "helpful": 41,
        "category": "technical",
      },
      {
        "question": "My booking confirmation didn't arrive",
        "answer": "Check your spam folder first. If still not found, contact us with your booking details and we'll resend the confirmation.",
        "helpful": 37,
        "category": "technical",
      },
      {
        "question": "How do I reset my account password?",
        "answer": "Use the 'Forgot Password' link on the login page. Check your email for reset instructions. Contact support if you don't receive the email.",
        "helpful": 28,
        "category": "technical",
      },
    ],
  };

  List<Map<String, dynamic>> recentTickets = [
    {
      "id": "SP-2024-001",
      "title": "Booking Modification Request",
      "status": "resolved",
      "priority": "medium",
      "created": "2024-01-15",
      "lastUpdate": "2024-01-16",
      "category": "booking",
    },
    {
      "id": "SP-2024-002",
      "title": "Payment Processing Issue",
      "status": "in_progress",
      "priority": "high",
      "created": "2024-01-18",
      "lastUpdate": "2024-01-18",
      "category": "payment",
    },
    {
      "id": "SP-2024-003",
      "title": "App Login Problem",
      "status": "pending",
      "priority": "low",
      "created": "2024-01-20",
      "lastUpdate": "2024-01-20",
      "category": "technical",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Support"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Support Header
            _buildSupportHeader(),

            // Quick Actions
            _buildQuickActions(),

            // Support Options
            _buildSupportOptions(),

            // FAQ Section
            _buildFAQSection(),

            // Recent Tickets
            _buildRecentTickets(),

            // Contact Information
            _buildContactInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.support_agent, color: Colors.white, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We're Here to Help",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Get support for all your spa needs",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search for help...",
                    value: searchQuery,
                    hint: "Booking, payment, treatments...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  "Emergency Help",
                  "Urgent issues",
                  Icons.emergency,
                  dangerColor,
                  () => _handleEmergencySupport(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionCard(
                  "Live Chat",
                  "Chat now",
                  Icons.chat,
                  successColor,
                  () => _startLiveChat(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionCard(
                  "Call Us",
                  "Speak to agent",
                  Icons.phone,
                  infoColor,
                  () => _makePhoneCall(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: color.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: color.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Support Options",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: supportOptions.map((option) {
              return _buildSupportOptionCard(option);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOptionCard(Map<String, dynamic> option) {
    Color priorityColor = _getPriorityColor(option["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              option["icon"] as IconData,
              color: priorityColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${option["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    if (option["isAvailable"])
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Available",
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
                  "${option["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${option["availability"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.speed, color: disabledBoldColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${option["responseTime"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Use",
            size: bs.sm,
            onPressed: () {
              _useSupportOption(option);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //navigateTo ( SpaFAQView )
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Category Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: supportCategories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${category["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          
          // FAQ Items
          Column(
            spacing: spSm,
            children: _getCurrentFAQs().take(3).map((faq) {
              return _buildFAQCard(faq);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCard(Map<String, dynamic> faq) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: primaryColor, size: 18),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${faq["question"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${faq["answer"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Was this helpful?",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () => _markFAQHelpful(faq, true),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.thumb_up, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${faq["helpful"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () => _markFAQHelpful(faq, false),
                child: Icon(Icons.thumb_down, color: disabledBoldColor, size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTickets() {
    if (recentTickets.isEmpty) return SizedBox();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Your Recent Tickets",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //navigateTo ( SpaTicketHistoryView )
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: recentTickets.map((ticket) {
              return _buildTicketCard(ticket);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    Color statusColor = _getTicketStatusColor(ticket["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.confirmation_number,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${ticket["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${ticket["status"]}".replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${ticket["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Updated: ${ticket["lastUpdate"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () {
              _viewTicket(ticket);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildContactRow(Icons.phone, "Phone", "+1 (555) 123-4567"),
                _buildContactRow(Icons.email, "Email", "support@spaluxury.com"),
                _buildContactRow(Icons.location_on, "Address", "123 Spa Street, Wellness City, WC 12345"),
                _buildContactRow(Icons.schedule, "Hours", "Mon-Sun: 8:00 AM - 10:00 PM"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 18),
        SizedBox(width: spSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getCurrentFAQs() {
    return faqByCategory[selectedCategory] ?? [];
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTicketStatusColor(String status) {
    switch (status) {
      case "resolved":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _performSearch() {
    if (searchQuery.isNotEmpty) {
      ss("Searching for: $searchQuery");
      //navigateTo ( SpaSearchResultsView )
    }
  }

  void _handleEmergencySupport() {
    ss("Connecting to emergency support...");
    //navigateTo ( SpaEmergencySupportView )
  }

  void _startLiveChat() {
    ss("Starting live chat...");
    //navigateTo ( SpaLiveChatView )
  }

  void _makePhoneCall() {
    ss("Dialing support number...");
    // Launch phone dialer
  }

  void _useSupportOption(Map<String, dynamic> option) {
    String type = option["type"];
    ss("Using ${option["title"]}...");
    
    switch (type) {
      case "chat":
        //navigateTo ( SpaLiveChatView )
        break;
      case "phone":
        // Launch phone dialer
        break;
      case "email":
        // Launch email client
        break;
      case "video":
        //navigateTo ( SpaVideoCallView )
        break;
      case "faq":
        //navigateTo ( SpaFAQView )
        break;
      case "ticket":
        //navigateTo ( SpaCreateTicketView )
        break;
    }
  }

  void _markFAQHelpful(Map<String, dynamic> faq, bool helpful) {
    if (helpful) {
      faq["helpful"] = (faq["helpful"] as int) + 1;
      ss("Thank you for your feedback!");
    } else {
      si("We'll work on improving this answer");
    }
    setState(() {});
  }

  void _viewTicket(Map<String, dynamic> ticket) {
    ss("Opening ticket ${ticket["id"]}...");
    //navigateTo ( SpaTicketDetailView )
  }
}
