import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaSupportView extends StatefulWidget {
  const DlaSupportView({Key? key}) : super(key: key);

  @override
  State<DlaSupportView> createState() => _DlaSupportViewState();
}

class _DlaSupportViewState extends State<DlaSupportView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";

  // New Ticket Fields
  String ticketTitle = "";
  String ticketDescription = "";
  String ticketPriority = "Medium";
  String ticketCategory = "General";

  List<Map<String, dynamic>> supportTickets = [
    {
      "id": "TIC001",
      "title": "Route optimization not working",
      "description": "GPS routing system is providing inefficient routes, causing delivery delays",
      "category": "Technical",
      "priority": "High",
      "status": "Open",
      "createdAt": "2024-01-15T09:30:00",
      "updatedAt": "2024-01-15T14:20:00",
      "assignedTo": "Technical Support Team",
      "responses": [
        {
          "id": "R001",
          "sender": "Support Agent",
          "message": "We've received your report about route optimization issues. Our team is investigating the GPS routing system.",
          "timestamp": "2024-01-15T10:15:00",
          "isAgent": true,
        },
        {
          "id": "R002",
          "sender": "You",
          "message": "The issue is still persisting. Routes are adding 30+ minutes to delivery times.",
          "timestamp": "2024-01-15T14:20:00",
          "isAgent": false,
        },
      ],
    },
    {
      "id": "TIC002",
      "title": "Vehicle maintenance schedule",
      "description": "Need to update vehicle maintenance schedule for fleet vehicle #DV-145",
      "category": "Administrative",
      "priority": "Medium",
      "status": "In Progress",
      "createdAt": "2024-01-14T16:45:00",
      "updatedAt": "2024-01-15T11:30:00",
      "assignedTo": "Fleet Management",
      "responses": [
        {
          "id": "R003",
          "sender": "Fleet Manager",
          "message": "Maintenance schedule has been updated. Next service is scheduled for January 20th.",
          "timestamp": "2024-01-15T11:30:00",
          "isAgent": true,
        },
      ],
    },
    {
      "id": "TIC003",
      "title": "Login credentials not working",
      "description": "Unable to access delivery app with current credentials. Password reset not working.",
      "category": "Account",
      "priority": "Critical",
      "status": "Resolved",
      "createdAt": "2024-01-13T08:15:00",
      "updatedAt": "2024-01-13T12:45:00",
      "assignedTo": "IT Support",
      "responses": [
        {
          "id": "R004",
          "sender": "IT Support",
          "message": "We've reset your credentials and sent new login details to your registered email.",
          "timestamp": "2024-01-13T12:45:00",
          "isAgent": true,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> faqItems = [
    {
      "id": "FAQ001",
      "question": "How do I report a failed delivery?",
      "answer": "To report a failed delivery, go to the 'Failed Deliveries' section in the app and tap the '+' button. Fill in the delivery details, failure reason, and any additional notes. The system will automatically notify the dispatch team and customer.",
      "category": "Delivery",
      "helpful": 45,
      "notHelpful": 3,
    },
    {
      "id": "FAQ002",
      "question": "What should I do if my vehicle breaks down?",
      "answer": "If your vehicle breaks down: 1) Pull over safely and turn on hazard lights, 2) Contact emergency dispatch immediately, 3) Secure all packages, 4) Wait for roadside assistance, 5) Complete incident report in the app.",
      "category": "Emergency",
      "helpful": 38,
      "notHelpful": 1,
    },
    {
      "id": "FAQ003",
      "question": "How do I update my delivery route?",
      "answer": "You can update your delivery route in the 'Route Planning' section. Tap 'Optimize Route' to let the system recalculate the best path, or manually drag and drop delivery stops to reorder them.",
      "category": "Route Planning",
      "helpful": 52,
      "notHelpful": 5,
    },
    {
      "id": "FAQ004",
      "question": "What are the customer contact protocols?",
      "answer": "Always maintain professional communication. Call customers 15-30 minutes before arrival. If no answer, send SMS notification. For delivery issues, explain clearly and offer solutions. Never share personal information.",
      "category": "Customer Service",
      "helpful": 29,
      "notHelpful": 2,
    },
    {
      "id": "FAQ005",
      "question": "How do I track my performance metrics?",
      "answer": "Performance metrics are available in the 'Dashboard' section. You can view delivery completion rates, customer ratings, on-time performance, and weekly/monthly summaries. Metrics are updated in real-time.",
      "category": "Performance",
      "helpful": 33,
      "notHelpful": 4,
    },
  ];

  List<Map<String, dynamic>> get filteredTickets {
    List<Map<String, dynamic>> filtered = supportTickets;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return "${ticket["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${ticket["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedPriority != "All") {
      filtered = filtered.where((ticket) => ticket["priority"] == selectedPriority).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((ticket) => ticket["status"] == selectedStatus).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get filteredFAQ {
    if (searchQuery.isEmpty) return faqItems;
    
    return faqItems.where((faq) {
      return "${faq["question"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${faq["answer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${faq["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  void _createNewTicket() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Create New Support Ticket",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QTextField(
                      label: "Ticket Title",
                      value: ticketTitle,
                      hint: "Brief description of the issue",
                      validator: Validator.required,
                      onChanged: (value) {
                        ticketTitle = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Category",
                      items: [
                        {"label": "General", "value": "General"},
                        {"label": "Technical", "value": "Technical"},
                        {"label": "Account", "value": "Account"},
                        {"label": "Administrative", "value": "Administrative"},
                        {"label": "Emergency", "value": "Emergency"},
                      ],
                      value: ticketCategory,
                      onChanged: (value, label) {
                        ticketCategory = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Priority",
                      items: [
                        {"label": "Low", "value": "Low"},
                        {"label": "Medium", "value": "Medium"},
                        {"label": "High", "value": "High"},
                        {"label": "Critical", "value": "Critical"},
                      ],
                      value: ticketPriority,
                      onChanged: (value, label) {
                        ticketPriority = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Description",
                      value: ticketDescription,
                      hint: "Please provide detailed information about your issue...",
                      validator: Validator.required,
                      onChanged: (value) {
                        ticketDescription = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit Ticket",
                        icon: Icons.send,
                        size: bs.sm,
                        onPressed: () {
                          if (ticketTitle.isNotEmpty && ticketDescription.isNotEmpty) {
                            Navigator.pop(context);
                            _submitTicket();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTicket() {
    String newId = "TIC${(supportTickets.length + 1).toString().padLeft(3, '0')}";
    Map<String, dynamic> newTicket = {
      "id": newId,
      "title": ticketTitle,
      "description": ticketDescription,
      "category": ticketCategory,
      "priority": ticketPriority,
      "status": "Open",
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
      "assignedTo": "Support Team",
      "responses": [],
    };

    setState(() {
      supportTickets.insert(0, newTicket);
      ticketTitle = "";
      ticketDescription = "";
      ticketCategory = "General";
      ticketPriority = "Medium";
    });

    ss("Support ticket created successfully");
  }

  void _showTicketDetails(Map<String, dynamic> ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Ticket Details",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${ticket["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getStatusColor("${ticket["status"]}"),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.confirmation_number,
                            color: _getStatusColor("${ticket["status"]}"),
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${ticket["id"]} - ${ticket["status"]}",
                            style: TextStyle(
                              color: _getStatusColor("${ticket["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${ticket["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${ticket["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${ticket["priority"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${ticket["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getPriorityColor("${ticket["priority"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${ticket["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Assigned to: ${ticket["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Created: ${DateTime.parse("${ticket["createdAt"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spLg),
                    Text(
                      "Conversation History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(ticket["responses"] as List).map((response) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: response["isAgent"] ? Colors.blue.shade50 : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: response["isAgent"] ? infoColor : primaryColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${response["sender"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: response["isAgent"] ? infoColor : primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                DateTime.parse("${response["timestamp"]}").dMMMy,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${response["message"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    if ((ticket["responses"] as List).isEmpty)
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Text(
                              "No responses yet. Our team will reply soon.",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Support Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Tickets", icon: Icon(Icons.confirmation_number)),
        Tab(text: "FAQ", icon: Icon(Icons.help)),
      ],
      tabChildren: [
        _buildTicketsTab(),
        _buildFAQTab(),
      ],
    );
  }

  Widget _buildTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search tickets...",
                  value: searchQuery,
                  hint: "Title or description",
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
                onPressed: () => _showTicketFilters(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Ticket",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () => _createNewTicket(),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "${filteredTickets.length} tickets",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (selectedPriority != "All" || selectedStatus != "All")
                GestureDetector(
                  onTap: () {
                    selectedPriority = "All";
                    selectedStatus = "All";
                    setState(() {});
                  },
                  child: Text(
                    "Clear Filters",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          ...filteredTickets.map((ticket) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor("${ticket["priority"]}"),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${ticket["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${ticket["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor("${ticket["status"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${ticket["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${ticket["priority"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${ticket["priority"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getPriorityColor("${ticket["priority"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${ticket["description"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${ticket["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      DateTime.parse("${ticket["updatedAt"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _showTicketDetails(ticket),
                  ),
                ),
              ],
            ),
          )).toList(),
          if (filteredTickets.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    searchQuery.isNotEmpty ? "No tickets found" : "No support tickets",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    searchQuery.isNotEmpty 
                        ? "Try adjusting your search terms"
                        : "Create your first support ticket",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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

  Widget _buildFAQTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Search FAQ...",
            value: searchQuery,
            hint: "Questions, answers, or categories",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor),
            ),
            child: Row(
              children: [
                Icon(Icons.help, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Find answers to common questions. Can't find what you're looking for? Create a support ticket.",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          ...filteredFAQ.map((faq) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: ExpansionTile(
              title: Text(
                "${faq["question"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: spXs),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${faq["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.thumb_up, size: 12, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${faq["helpful"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${faq["answer"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Text(
                            "Was this helpful?",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.thumb_up,
                            size: bs.sm,
                            onPressed: () => ss("Marked as helpful"),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.thumb_down,
                            size: bs.sm,
                            onPressed: () => ss("Marked as not helpful"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
          if (filteredFAQ.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No FAQ found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search terms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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

  void _showTicketFilters() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Tickets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Priority",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Critical", "value": "Critical"},
                {"label": "High", "value": "High"},
                {"label": "Medium", "value": "Medium"},
                {"label": "Low", "value": "Low"},
              ],
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Status",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Open", "value": "Open"},
                {"label": "In Progress", "value": "In Progress"},
                {"label": "Resolved", "value": "Resolved"},
                {"label": "Closed", "value": "Closed"},
              ],
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
