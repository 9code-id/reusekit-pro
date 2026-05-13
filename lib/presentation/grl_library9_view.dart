import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary9View extends StatefulWidget {
  @override
  State<GrlLibrary9View> createState() => _GrlLibrary9ViewState();
}

class _GrlLibrary9ViewState extends State<GrlLibrary9View> {
  int currentTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> librarians = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "title": "Senior Research Librarian",
      "department": "Science & Technology",
      "email": "sarah.johnson@library.edu",
      "phone": "+1 (555) 123-4567",
      "office": "Room 205, Second Floor",
      "image": "https://picsum.photos/300/300?random=1&keyword=librarian",
      "specializations": ["Engineering", "Computer Science", "Mathematics"],
      "languages": ["English", "French"],
      "availability": "Mon-Fri 9:00-17:00",
      "status": "Available",
      "rating": 4.9,
      "consultations": 247,
      "bio": "Dr. Johnson specializes in scientific research methodology and database navigation. She has over 15 years of experience helping students and researchers find relevant academic resources.",
    },
    {
      "id": 2,
      "name": "Prof. Michael Chen",
      "title": "Digital Resources Specialist",
      "department": "Digital Collections",
      "email": "m.chen@library.edu",
      "phone": "+1 (555) 123-4568",
      "office": "Room 301, Third Floor",
      "image": "https://picsum.photos/300/300?random=2&keyword=professor",
      "specializations": ["Digital Archives", "Metadata", "Information Systems"],
      "languages": ["English", "Mandarin", "Japanese"],
      "availability": "Tue-Sat 10:00-18:00",
      "status": "In Meeting",
      "rating": 4.8,
      "consultations": 189,
      "bio": "Prof. Chen is an expert in digital library systems and helps users navigate complex digital collections and databases.",
    },
    {
      "id": 3,
      "name": "Lisa Rodriguez",
      "title": "Student Services Librarian",
      "department": "Academic Support",
      "email": "l.rodriguez@library.edu",
      "phone": "+1 (555) 123-4569",
      "office": "Room 101, Ground Floor",
      "image": "https://picsum.photos/300/300?random=3&keyword=teacher",
      "specializations": ["Study Skills", "Research Methods", "Citation Styles"],
      "languages": ["English", "Spanish"],
      "availability": "Mon-Fri 8:00-16:00",
      "status": "Available",
      "rating": 4.7,
      "consultations": 312,
      "bio": "Lisa specializes in helping students develop effective research and study strategies. She conducts workshops on academic writing and citation management.",
    },
    {
      "id": 4,
      "name": "Dr. James Wilson",
      "title": "Humanities Librarian",
      "department": "Arts & Humanities",
      "email": "j.wilson@library.edu",
      "phone": "+1 (555) 123-4570",
      "office": "Room 150, First Floor",
      "image": "https://picsum.photos/300/300?random=4&keyword=scholar",
      "specializations": ["Literature", "History", "Philosophy", "Art History"],
      "languages": ["English", "German", "Latin"],
      "availability": "Wed-Sun 11:00-19:00",
      "status": "On Break",
      "rating": 4.6,
      "consultations": 156,
      "bio": "Dr. Wilson has extensive knowledge in humanities research and helps students navigate historical archives and literary collections.",
    },
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "id": 1,
      "question": "How do I access digital resources from off-campus?",
      "answer": "You can access digital resources from off-campus using your library login credentials through our VPN service or proxy authentication. Visit the library website and click on 'Remote Access' for detailed instructions.",
      "category": "Digital Access",
      "popularity": 95,
      "isHelpful": true,
    },
    {
      "id": 2,
      "question": "What are the library's current opening hours?",
      "answer": "The library is open Monday-Thursday 7:00-24:00, Friday 7:00-20:00, Saturday 9:00-18:00, and Sunday 12:00-24:00. Hours may vary during holidays and exam periods.",
      "category": "General Information",
      "popularity": 89,
      "isHelpful": false,
    },
    {
      "id": 3,
      "question": "How can I renew my borrowed books?",
      "answer": "Books can be renewed online through your library account, by calling the circulation desk, or visiting in person. Renewals are subject to availability and borrowing limits.",
      "category": "Borrowing",
      "popularity": 87,
      "isHelpful": true,
    },
    {
      "id": 4,
      "question": "How do I book a study room?",
      "answer": "Study rooms can be booked through the online reservation system available on our website. You can reserve rooms up to 7 days in advance for a maximum of 4 hours per day.",
      "category": "Study Spaces",
      "popularity": 82,
      "isHelpful": false,
    },
    {
      "id": 5,
      "question": "What citation style should I use for my research paper?",
      "answer": "Citation style depends on your academic discipline. Common styles include APA (Psychology, Education), MLA (Literature, Arts), Chicago (History), and IEEE (Engineering). Check with your instructor or department for specific requirements.",
      "category": "Research Help",
      "popularity": 78,
      "isHelpful": true,
    },
    {
      "id": 6,
      "question": "How can I get help with research for my thesis?",
      "answer": "Schedule a consultation with a subject specialist librarian who can help you develop a research strategy, identify relevant databases, and refine your search techniques. Appointments can be made online or by calling the reference desk.",
      "category": "Research Help",
      "popularity": 76,
      "isHelpful": true,
    },
  ];

  List<Map<String, dynamic>> contactMethods = [
    {
      "id": 1,
      "method": "Live Chat",
      "description": "Get instant help from our librarians",
      "availability": "Mon-Fri 9:00-17:00",
      "icon": Icons.chat,
      "color": primaryColor,
      "isAvailable": true,
    },
    {
      "id": 2,
      "method": "Phone Support",
      "description": "Call our reference desk for assistance",
      "availability": "Mon-Sun 8:00-22:00",
      "icon": Icons.phone,
      "color": successColor,
      "isAvailable": true,
    },
    {
      "id": 3,
      "method": "Email Support",
      "description": "Send detailed questions via email",
      "availability": "24/7 (response within 24 hours)",
      "icon": Icons.email,
      "color": infoColor,
      "isAvailable": true,
    },
    {
      "id": 4,
      "method": "In-Person Help",
      "description": "Visit our information desk",
      "availability": "During library hours",
      "icon": Icons.location_on,
      "color": warningColor,
      "isAvailable": false,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "In Meeting":
        return warningColor;
      case "On Break":
        return infoColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildLibrariansTab() {
    return Column(
      spacing: spSm,
      children: [
        // Search Bar
        QTextField(
          label: "Search librarians",
          value: searchQuery,
          hint: "Search by name, department, or specialization",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),

        // Librarians List
        ...librarians.map((librarian) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${librarian["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${librarian["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(librarian["status"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${librarian["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${librarian["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${librarian["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${librarian["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${librarian["consultations"]} consultations",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Text(
                  "${librarian["bio"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                // Specializations
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Specializations:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (librarian["specializations"] as List).map((spec) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: Text(
                            "$spec",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                // Contact Information
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${librarian["email"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${librarian["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${librarian["office"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${librarian["availability"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Consultation",
                        size: bs.md,
                        onPressed: librarian["status"] == "Available" ? () {} : null,
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.email,
                      size: bs.md,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.phone,
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFAQTab() {
    final categories = faqs.map((faq) => faq["category"] as String).toSet().toList();
    
    return Column(
      spacing: spSm,
      children: [
        // Search Bar
        QTextField(
          label: "Search FAQ",
          value: searchQuery,
          hint: "Search questions and answers",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),

        // Category Filters
        Text(
          "Browse by Category",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: ["All", ...categories].map((category) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: category == "All" ? primaryColor : primaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: category == "All" ? Colors.white : primaryColor,
                ),
              ),
            );
          }).toList(),
        ),

        // FAQ List
        ...faqs.map((faq) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${faq["question"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${faq["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  "${faq["answer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${faq["popularity"]}% find this helpful",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Was this helpful?",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        faq["isHelpful"] = true;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.thumb_up,
                        size: 16,
                        color: faq["isHelpful"] == true ? successColor : disabledColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        faq["isHelpful"] = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.thumb_down,
                        size: 16,
                        color: faq["isHelpful"] == false ? dangerColor : disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildContactTab() {
    return Column(
      spacing: spSm,
      children: [
        // Quick Contact Methods
        Text(
          "Contact Methods",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: contactMethods.map((method) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: method["isAvailable"] == true
                    ? Border.all(color: (method["color"] as Color).withAlpha(100))
                    : Border.all(color: disabledColor),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: method["isAvailable"] == true
                          ? (method["color"] as Color).withAlpha(50)
                          : disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      method["icon"] as IconData,
                      size: 32,
                      color: method["isAvailable"] == true
                          ? method["color"] as Color
                          : disabledColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${method["method"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: method["isAvailable"] == true ? primaryColor : disabledColor,
                    ),
                  ),
                  Text(
                    "${method["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${method["availability"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: method["isAvailable"] == true ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: method["isAvailable"] == true ? "Start Chat" : "Unavailable",
                      size: bs.sm,
                      onPressed: method["isAvailable"] == true ? () {} : null,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        // Contact Form
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Send us a Message",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Your Name",
                value: "",
                onChanged: (value) {},
              ),
              QTextField(
                label: "Email Address",
                value: "",
                onChanged: (value) {},
              ),
              QDropdownField(
                label: "Category",
                items: [
                  {"label": "General Question", "value": "general"},
                  {"label": "Research Help", "value": "research"},
                  {"label": "Technical Issue", "value": "technical"},
                  {"label": "Feedback", "value": "feedback"},
                ],
                value: "",
                onChanged: (value, label) {},
              ),
              QMemoField(
                label: "Message",
                value: "",
                onChanged: (value) {},
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Message",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Help & Support",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Librarians", icon: Icon(Icons.people)),
        Tab(text: "FAQ", icon: Icon(Icons.help)),
        Tab(text: "Contact", icon: Icon(Icons.support_agent)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLibrariansTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildFAQTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildContactTab(),
        ),
      ],
    );
  }
}
