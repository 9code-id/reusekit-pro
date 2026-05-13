import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTenantManagementView extends StatefulWidget {
  const RmaTenantManagementView({super.key});

  @override
  State<RmaTenantManagementView> createState() => _RmaTenantManagementViewState();
}

class _RmaTenantManagementViewState extends State<RmaTenantManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedProperty = "All";

  List<Map<String, dynamic>> tenants = [
    {
      "id": "TNT001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "unit": "Unit 204",
      "property": "Downtown Apartment Complex",
      "lease_start": "2024-01-15",
      "lease_end": "2024-12-15",
      "rent_amount": 2400.0,
      "status": "Active",
      "payment_status": "Paid",
      "last_payment": "2024-12-01", 
      "emergency_contact": "John Johnson - +1 (555) 987-6543",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "lease_months": 12,
      "deposit": 2400.0,
      "pets": ["Dog - Max"],
      "notes": "Excellent tenant, always pays on time",
    },
    {
      "id": "TNT002",
      "name": "Michael Chen",
      "email": "m.chen@email.com", 
      "phone": "+1 (555) 234-5678",
      "unit": "Villa 3",
      "property": "Riverside Villa Community",
      "lease_start": "2024-03-01",
      "lease_end": "2025-02-28",
      "rent_amount": 3200.0,
      "status": "Active",
      "payment_status": "Overdue",
      "last_payment": "2024-11-01",
      "emergency_contact": "Lisa Chen - +1 (555) 876-5432",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "lease_months": 12,
      "deposit": 3200.0,
      "pets": [],
      "notes": "Usually reliable, recent payment delay",
    },
    {
      "id": "TNT003",
      "name": "Emily Rodriguez",
      "email": "emily.r@email.com",
      "phone": "+1 (555) 345-6789",
      "unit": "Condo 12B",
      "property": "Garden Heights Condos",
      "lease_start": "2024-06-01",
      "lease_end": "2025-05-31",
      "rent_amount": 1800.0,
      "status": "Notice Given",
      "payment_status": "Paid",
      "last_payment": "2024-12-01",
      "emergency_contact": "Carlos Rodriguez - +1 (555) 765-4321",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "lease_months": 12,
      "deposit": 1800.0,
      "pets": ["Cat - Luna"],
      "notes": "Moving out at lease end",
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Notice Given", "value": "Notice Given"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> propertyItems = [
    {"label": "All", "value": "All"},
    {"label": "Downtown Apartment Complex", "value": "Downtown Apartment Complex"},
    {"label": "Riverside Villa Community", "value": "Riverside Villa Community"},
    {"label": "Garden Heights Condos", "value": "Garden Heights Condos"},
  ];

  List<Map<String, dynamic>> get filteredTenants {
    return tenants.where((tenant) {
      bool matchesSearch = tenant["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tenant["unit"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tenant["email"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || tenant["status"] == selectedStatus;
      bool matchesProperty = selectedProperty == "All" || tenant["property"] == selectedProperty;
      
      return matchesSearch && matchesStatus && matchesProperty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tenant Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Tenants", icon: Icon(Icons.people)),
        Tab(text: "Lease Details", icon: Icon(Icons.description)),
        Tab(text: "Communications", icon: Icon(Icons.message)),
      ],
      tabChildren: [
        _buildTenantsTab(),
        _buildLeaseDetailsTab(),
        _buildCommunicationsTab(),
      ],
    );
  }

  Widget _buildTenantsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildTenantsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Tenants",
                  value: searchQuery,
                  hint: "Search by name, unit, or email",
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
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
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
                  label: "Property",
                  items: propertyItems,
                  value: selectedProperty,
                  onChanged: (value, label) {
                    selectedProperty = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTenantsList() {
    return Column(
      spacing: spSm,
      children: filteredTenants.map((tenant) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(
                width: 4,
                color: tenant["status"] == "Active" ? successColor :
                       tenant["status"] == "Notice Given" ? warningColor : dangerColor,
              ),
            ),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${tenant["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${tenant["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${tenant["unit"]} - ${tenant["property"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: tenant["status"] == "Active" ? successColor.withAlpha(20) :
                                       tenant["status"] == "Notice Given" ? warningColor.withAlpha(20) : 
                                       dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${tenant["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: tenant["status"] == "Active" ? successColor :
                                         tenant["status"] == "Notice Given" ? warningColor : dangerColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: tenant["payment_status"] == "Paid" ? successColor.withAlpha(20) :
                                       tenant["payment_status"] == "Overdue" ? dangerColor.withAlpha(20) :
                                       warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${tenant["payment_status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: tenant["payment_status"] == "Paid" ? successColor :
                                         tenant["payment_status"] == "Overdue" ? dangerColor :
                                         warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Divider(color: disabledColor),
              Row(
                children: [
                  Expanded(
                    child: _buildTenantInfo("Rent", "\$${((tenant["rent_amount"] as num).toDouble()).currency}", Icons.monetization_on),
                  ),
                  Expanded(
                    child: _buildTenantInfo("Lease End", "${tenant["lease_end"]}", Icons.calendar_today),
                  ),
                  Expanded(
                    child: _buildTenantInfo("Contact", "${tenant["phone"]}", Icons.phone),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Last Payment: ${tenant["last_payment"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if ((tenant["pets"] as List).isNotEmpty)
                          Text(
                            "Pets: ${(tenant["pets"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTenantInfo(String label, String value, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaseDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildLeaseOverview(),
          _buildExpiringLeases(),
          _buildRenewalOpportunities(),
        ],
      ),
    );
  }

  Widget _buildLeaseOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Lease Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildLeaseStatCard("Active Leases", "49", Icons.description, successColor),
              _buildLeaseStatCard("Expiring Soon", "8", Icons.warning, warningColor),
              _buildLeaseStatCard("Up for Renewal", "12", Icons.refresh, infoColor),
              _buildLeaseStatCard("Notice Given", "3", Icons.notifications, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaseStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
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

  Widget _buildExpiringLeases() {
    List<Map<String, dynamic>> expiringLeases = [
      {
        "tenant": "Sarah Johnson",
        "unit": "Unit 204",
        "property": "Downtown Apartment Complex",
        "lease_end": "2024-12-15",
        "days_remaining": 3,
        "rent": 2400.0,
      },
      {
        "tenant": "Michael Chen",
        "unit": "Villa 3",
        "property": "Riverside Villa Community",
        "lease_end": "2025-02-28",
        "days_remaining": 72,
        "rent": 3200.0,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  "Expiring Leases",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...expiringLeases.map((lease) {
            Color urgencyColor = (lease["days_remaining"] as int) <= 7 ? dangerColor :
                                (lease["days_remaining"] as int) <= 30 ? warningColor : infoColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: urgencyColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: urgencyColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 50,
                    decoration: BoxDecoration(
                      color: urgencyColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${lease["tenant"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${lease["unit"]} - ${lease["property"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Expires: ${lease["lease_end"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: urgencyColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${lease["days_remaining"]} days left",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: urgencyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${((lease["rent"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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

  Widget _buildRenewalOpportunities() {
    List<Map<String, dynamic>> renewals = [
      {
        "tenant": "Emily Rodriguez",
        "unit": "Condo 12B",
        "property": "Garden Heights Condos",
        "current_rent": 1800.0,
        "suggested_rent": 1950.0,
        "lease_end": "2025-05-31",
        "renewal_probability": "High",
        "tenant_rating": 4.8,
      },
      {
        "tenant": "David Kim",
        "unit": "Apt 105",
        "property": "Downtown Apartment Complex",
        "current_rent": 2200.0,
        "suggested_rent": 2350.0,
        "lease_end": "2025-03-15",
        "renewal_probability": "Medium",
        "tenant_rating": 4.2,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  "Renewal Opportunities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Generate Reports",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...renewals.map((renewal) {
            Color probabilityColor = renewal["renewal_probability"] == "High" ? successColor :
                                   renewal["renewal_probability"] == "Medium" ? warningColor : dangerColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
                boxShadow: [shadowXs],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${renewal["tenant"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${renewal["unit"]} - ${renewal["property"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: probabilityColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${renewal["renewal_probability"]} Probability",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: probabilityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildRenewalStat("Current Rent", "\$${((renewal["current_rent"] as num).toDouble()).currency}"),
                      ),
                      Expanded(
                        child: _buildRenewalStat("Suggested Rent", "\$${((renewal["suggested_rent"] as num).toDouble()).currency}"),
                      ),
                      Expanded(
                        child: _buildRenewalStat("Rating", "${(renewal["tenant_rating"] as num).toStringAsFixed(1)}★"),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start Renewal Process",
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildRenewalStat(String label, String value) {
    return Column(
      spacing: spXs,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
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
    );
  }

  Widget _buildCommunicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCommunicationOptions(),
          _buildRecentCommunications(),
          _buildTemplates(),
        ],
      ),
    );
  }

  Widget _buildCommunicationOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Communication Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildCommunicationCard("Send Notice", "Legal notices & announcements", Icons.announcement, warningColor),
              _buildCommunicationCard("Rent Reminder", "Payment due reminders", Icons.payment, infoColor),
              _buildCommunicationCard("Maintenance Update", "Work order status updates", Icons.build, successColor),
              _buildCommunicationCard("Lease Renewal", "Renewal discussions", Icons.refresh, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCommunications() {
    List<Map<String, dynamic>> communications = [
      {
        "type": "Rent Reminder",
        "recipient": "Michael Chen",
        "subject": "December Rent Payment Reminder",
        "sent_date": "2024-12-05",
        "status": "Delivered",
        "method": "Email",
      },
      {
        "type": "Maintenance Update",
        "recipient": "Sarah Johnson", 
        "subject": "Plumbing Repair Completed",
        "sent_date": "2024-12-03",
        "status": "Read",
        "method": "SMS",
      },
      {
        "type": "Lease Notice",
        "recipient": "Emily Rodriguez",
        "subject": "Lease Renewal Options",
        "sent_date": "2024-12-01",
        "status": "Responded",
        "method": "Email",
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  "Recent Communications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...communications.map((comm) {
            Color statusColor = comm["status"] == "Read" || comm["status"] == "Responded" ? successColor :
                              comm["status"] == "Delivered" ? infoColor : warningColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      comm["method"] == "Email" ? Icons.email : Icons.sms,
                      color: statusColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${comm["subject"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "To: ${comm["recipient"]} • ${comm["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Sent: ${comm["sent_date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${comm["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
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
        ],
      ),
    );
  }

  Widget _buildTemplates() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Late Payment Notice",
        "description": "Standard notice for overdue rent payments",
        "category": "Payment",
        "last_used": "2024-12-05",
        "usage_count": 12,
      },
      {
        "name": "Lease Renewal Offer",
        "description": "Initial lease renewal discussion template",
        "category": "Lease",
        "last_used": "2024-12-01",
        "usage_count": 8,
      },
      {
        "name": "Maintenance Completion",
        "description": "Work order completion notification",
        "category": "Maintenance",
        "last_used": "2024-12-03",
        "usage_count": 15,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  "Message Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create New",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...templates.map((template) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.message,
                      color: primaryColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Used ${template["usage_count"]} times",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Last: ${template["last_used"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        icon: Icons.send,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
