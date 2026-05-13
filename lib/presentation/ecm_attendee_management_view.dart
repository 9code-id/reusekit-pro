import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAttendeeManagementView extends StatefulWidget {
  const EcmAttendeeManagementView({super.key});

  @override
  State<EcmAttendeeManagementView> createState() => _EcmAttendeeManagementViewState();
}

class _EcmAttendeeManagementViewState extends State<EcmAttendeeManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedTicketType = "All";
  String selectedRegistrationDate = "All";
  bool showOnlyCheckedIn = false;

  // Form states for new attendee
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  String ticketType = "general";
  String registrationMethod = "online";
  bool sendWelcomeEmail = true;

  final List<Map<String, dynamic>> attendees = [
    {
      "id": "att001",
      "first_name": "Sarah",
      "last_name": "Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1-555-0123",
      "company": "Tech Innovations Inc",
      "job_title": "Marketing Director",
      "ticket_type": "vip",
      "registration_date": "2024-01-15",
      "status": "confirmed",
      "checked_in": false,
      "check_in_time": null,
      "payment_status": "paid",
      "payment_amount": 299.00,
      "dietary_restrictions": ["Vegetarian"],
      "special_requests": "Accessible seating",
      "registration_method": "online",
      "referral_source": "Social Media",
    },
    {
      "id": "att002",
      "first_name": "Michael",
      "last_name": "Chen",
      "email": "m.chen@techcorp.com",
      "phone": "+1-555-0234",
      "company": "TechCorp Solutions",
      "job_title": "Software Engineer",
      "ticket_type": "general",
      "registration_date": "2024-01-18",
      "status": "confirmed",
      "checked_in": true,
      "check_in_time": "2024-01-30 09:15:00",
      "payment_status": "paid",
      "payment_amount": 199.00,
      "dietary_restrictions": [],
      "special_requests": "",
      "registration_method": "online",
      "referral_source": "Website",
    },
    {
      "id": "att003",
      "first_name": "Emily",
      "last_name": "Rodriguez",
      "email": "emily.r@startup.io",
      "phone": "+1-555-0345",
      "company": "Innovation Startup",
      "job_title": "Product Manager",
      "ticket_type": "early_bird",
      "registration_date": "2024-01-10",
      "status": "confirmed",
      "checked_in": true,
      "check_in_time": "2024-01-30 08:45:00",
      "payment_status": "paid",
      "payment_amount": 149.00,
      "dietary_restrictions": ["Gluten-free"],
      "special_requests": "",
      "registration_method": "mobile",
      "referral_source": "Email Newsletter",
    },
    {
      "id": "att004",
      "first_name": "David",
      "last_name": "Thompson",
      "email": "david.thompson@corp.com",
      "phone": "+1-555-0456",
      "company": "Corporate Enterprises",
      "job_title": "CEO",
      "ticket_type": "vip",
      "registration_date": "2024-01-20",
      "status": "pending_payment",
      "checked_in": false,
      "check_in_time": null,
      "payment_status": "pending",
      "payment_amount": 299.00,
      "dietary_restrictions": [],
      "special_requests": "Executive networking session",
      "registration_method": "phone",
      "referral_source": "Partner Organization",
    },
    {
      "id": "att005",
      "first_name": "Lisa",
      "last_name": "Wang",
      "email": "lisa.wang@design.studio",
      "phone": "+1-555-0567",
      "company": "Creative Design Studio",
      "job_title": "UX Designer",
      "ticket_type": "student",
      "registration_date": "2024-01-22",
      "status": "confirmed",
      "checked_in": false,
      "check_in_time": null,
      "payment_status": "paid",
      "payment_amount": 99.00,
      "dietary_restrictions": ["Vegan"],
      "special_requests": "",
      "registration_method": "online",
      "referral_source": "Social Media",
    },
    {
      "id": "att006",
      "first_name": "Robert",
      "last_name": "Miller",
      "email": "r.miller@consulting.com",
      "phone": "+1-555-0678",
      "company": "Miller Consulting",
      "job_title": "Senior Consultant",
      "ticket_type": "general",
      "registration_date": "2024-01-25",
      "status": "cancelled",
      "checked_in": false,
      "check_in_time": null,
      "payment_status": "refunded",
      "payment_amount": 0.00,
      "dietary_restrictions": [],
      "special_requests": "",
      "registration_method": "online",
      "referral_source": "Website",
    },
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Pending Payment", "value": "pending_payment"},
    {"label": "Cancelled", "value": "cancelled"},
    {"label": "Waitlist", "value": "waitlist"},
  ];

  final List<Map<String, dynamic>> ticketTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "VIP", "value": "vip"},
    {"label": "General", "value": "general"},
    {"label": "Early Bird", "value": "early_bird"},
    {"label": "Student", "value": "student"},
    {"label": "Group", "value": "group"},
  ];

  final List<Map<String, dynamic>> registrationDateOptions = [
    {"label": "All", "value": "All"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 30 Days", "value": "30_days"},
  ];

  final List<Map<String, dynamic>> newTicketTypes = [
    {"label": "VIP", "value": "vip"},
    {"label": "General", "value": "general"},
    {"label": "Early Bird", "value": "early_bird"},
    {"label": "Student", "value": "student"},
    {"label": "Group", "value": "group"},
  ];

  final List<Map<String, dynamic>> registrationMethods = [
    {"label": "Online", "value": "online"},
    {"label": "Phone", "value": "phone"},
    {"label": "Mobile App", "value": "mobile"},
    {"label": "In Person", "value": "person"},
  ];

  List<Map<String, dynamic>> get filteredAttendees {
    return attendees.where((attendee) {
      bool matchesSearch = "${attendee["first_name"]} ${attendee["last_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${attendee["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${attendee["company"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || attendee["status"] == selectedStatus;
      bool matchesTicketType = selectedTicketType == "All" || attendee["ticket_type"] == selectedTicketType;
      bool matchesCheckIn = !showOnlyCheckedIn || attendee["checked_in"] == true;
      
      return matchesSearch && matchesStatus && matchesTicketType && matchesCheckIn;
    }).toList();
  }

  void _clearForm() {
    firstName = "";
    lastName = "";
    email = "";
    phone = "";
    company = "";
    jobTitle = "";
    ticketType = "general";
    registrationMethod = "online";
    sendWelcomeEmail = true;
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'pending_payment':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      case 'waitlist':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTicketTypeColor(String ticketType) {
    switch (ticketType) {
      case 'vip':
        return dangerColor;
      case 'early_bird':
        return successColor;
      case 'student':
        return infoColor;
      case 'group':
        return warningColor;
      case 'general':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getTicketTypeLabel(String ticketType) {
    switch (ticketType) {
      case 'vip':
        return 'VIP';
      case 'early_bird':
        return 'Early Bird';
      case 'student':
        return 'Student';
      case 'group':
        return 'Group';
      case 'general':
        return 'General';
      default:
        return ticketType.toUpperCase();
    }
  }

  Widget _buildAttendeesList() {
    return Column(
      children: [
        // Search and Filters
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              QTextField(
                label: "Search Attendees",
                value: searchQuery,
                hint: "Search by name, email, or company...",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Ticket Type",
                      items: ticketTypeOptions,
                      value: selectedTicketType,
                      onChanged: (value, label) {
                        selectedTicketType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Registration Date",
                      items: registrationDateOptions,
                      value: selectedRegistrationDate,
                      onChanged: (value, label) {
                        selectedRegistrationDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Checked In Only",
                          "value": true,
                          "checked": showOnlyCheckedIn,
                        }
                      ],
                      value: [if (showOnlyCheckedIn) {"label": "Checked In Only", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        showOnlyCheckedIn = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),

        // Summary Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.people,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Attendees",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${attendees.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Checked In",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${attendees.where((a) => a["checked_in"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.schedule,
                      color: warningColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pending Payment",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${attendees.where((a) => a["status"] == "pending_payment").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: infoColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${((attendees.fold(0.0, (sum, a) => sum + (a["payment_amount"] as double))).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),

        // Attendees List
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: filteredAttendees.map((attendee) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${attendee["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${attendee["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${attendee["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTicketTypeColor("${attendee["ticket_type"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getTicketTypeLabel("${attendee["ticket_type"]}"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  "${attendee["first_name"]}".substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${attendee["first_name"]} ${attendee["last_name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${attendee["job_title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            if (attendee["checked_in"] == true)
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${attendee["company"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${attendee["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${attendee["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "\$${((attendee["payment_amount"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Reg: ${attendee["registration_date"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (attendee["checked_in"] == true) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Checked in: ${attendee["check_in_time"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: attendee["checked_in"] ? "Check Out" : "Check In",
                                size: bs.sm,
                                color: attendee["checked_in"] ? warningColor : successColor,
                                onPressed: () {
                                  String action = attendee["checked_in"] ? "checked out" : "checked in";
                                  ss("${attendee["first_name"]} ${attendee["last_name"]} $action successfully!");
                                },
                              ),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                ss("More options for ${attendee["first_name"]} ${attendee["last_name"]}");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAddAttendee() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
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
                  "Add New Attendee",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "First Name",
                        value: firstName,
                        hint: "Enter first name...",
                        validator: Validator.required,
                        onChanged: (value) {
                          firstName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Last Name",
                        value: lastName,
                        hint: "Enter last name...",
                        validator: Validator.required,
                        onChanged: (value) {
                          lastName = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter email address...",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Phone Number",
                  value: phone,
                  hint: "Enter phone number...",
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Company",
                        value: company,
                        hint: "Enter company name...",
                        onChanged: (value) {
                          company = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Job Title",
                        value: jobTitle,
                        hint: "Enter job title...",
                        onChanged: (value) {
                          jobTitle = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Ticket Type",
                        items: newTicketTypes,
                        value: ticketType,
                        onChanged: (value, label) {
                          ticketType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Registration Method",
                        items: registrationMethods,
                        value: registrationMethod,
                        onChanged: (value, label) {
                          registrationMethod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Send Welcome Email",
                      "value": true,
                      "checked": sendWelcomeEmail,
                    }
                  ],
                  value: [if (sendWelcomeEmail) {"label": "Send Welcome Email", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    sendWelcomeEmail = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Attendee",
                        onPressed: () {
                          ss("New attendee added successfully!");
                          _clearForm();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Clear",
                      color: dangerColor,
                      onPressed: _clearForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckinReport() {
    final checkedInAttendees = attendees.where((a) => a["checked_in"] == true).toList();
    final pendingCheckIn = attendees.where((a) => a["checked_in"] == false && a["status"] == "confirmed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Check-in Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Checked In",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${checkedInAttendees.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: attendees.isEmpty ? 0 : checkedInAttendees.length / attendees.length,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(successColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${attendees.isEmpty ? 0 : ((checkedInAttendees.length / attendees.length) * 100).toStringAsFixed(1)}% of total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pending Check-in",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${pendingCheckIn.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: attendees.isEmpty ? 0 : pendingCheckIn.length / attendees.length,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${attendees.isEmpty ? 0 : ((pendingCheckIn.length / attendees.length) * 100).toStringAsFixed(1)}% of total",
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
          SizedBox(height: spMd),

          // Check-in by Ticket Type
          Container(
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
                  "Check-in by Ticket Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...["vip", "general", "early_bird", "student", "group"].map((ticketType) {
                  final typeAttendees = attendees.where((a) => a["ticket_type"] == ticketType).toList();
                  final typeCheckedIn = typeAttendees.where((a) => a["checked_in"] == true).length;
                  final checkInRate = typeAttendees.isEmpty ? 0.0 : (typeCheckedIn / typeAttendees.length) * 100;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getTicketTypeColor(ticketType),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                _getTicketTypeLabel(ticketType),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "$typeCheckedIn/${typeAttendees.length} (${checkInRate.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: checkInRate / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(_getTicketTypeColor(ticketType)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Attendee Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Attendees", icon: Icon(Icons.people)),
        Tab(text: "Add New", icon: Icon(Icons.person_add)),
        Tab(text: "Check-in", icon: Icon(Icons.check_circle)),
      ],
      tabChildren: [
        _buildAttendeesList(),
        _buildAddAttendee(),
        _buildCheckinReport(),
      ],
    );
  }
}
