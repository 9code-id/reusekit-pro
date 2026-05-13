import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSponsorManagementView extends StatefulWidget {
  const EcmSponsorManagementView({super.key});

  @override
  State<EcmSponsorManagementView> createState() => _EcmSponsorManagementViewState();
}

class _EcmSponsorManagementViewState extends State<EcmSponsorManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedTier = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> sponsors = [
    {
      "id": 1,
      "name": "Microsoft Corporation",
      "tier": "Platinum",
      "status": "Active",
      "logo": "https://picsum.photos/80/80?random=1&keyword=microsoft",
      "amount": 50000.0,
      "contact": "John Smith",
      "email": "john.smith@microsoft.com",
      "phone": "+1-555-0123",
      "contractStart": "2024-01-15",
      "contractEnd": "2024-12-31",
      "benefits": ["Logo on all materials", "Exhibition booth", "Speaking slot"],
      "deliverables": 8,
      "completedDeliverables": 6,
      "lastActivity": "2024-06-15",
      "paymentStatus": "Paid",
    },
    {
      "id": 2,
      "name": "Google LLC",
      "tier": "Gold",
      "status": "Active",
      "logo": "https://picsum.photos/80/80?random=2&keyword=google",
      "amount": 30000.0,
      "contact": "Sarah Johnson",
      "email": "sarah.j@google.com",
      "phone": "+1-555-0456",
      "contractStart": "2024-02-01",
      "contractEnd": "2024-12-31",
      "benefits": ["Logo placement", "Exhibition booth", "Networking access"],
      "deliverables": 6,
      "completedDeliverables": 5,
      "lastActivity": "2024-06-18",
      "paymentStatus": "Paid",
    },
    {
      "id": 3,
      "name": "Amazon Web Services",
      "tier": "Silver",
      "status": "Pending",
      "logo": "https://picsum.photos/80/80?random=3&keyword=aws",
      "amount": 15000.0,
      "contact": "Michael Brown",
      "email": "m.brown@aws.com",
      "phone": "+1-555-0789",
      "contractStart": "2024-03-01",
      "contractEnd": "2024-12-31",
      "benefits": ["Logo on website", "Networking access"],
      "deliverables": 4,
      "completedDeliverables": 2,
      "lastActivity": "2024-06-10",
      "paymentStatus": "Pending",
    },
    {
      "id": 4,
      "name": "IBM Corporation",
      "tier": "Bronze",
      "status": "Expired",
      "logo": "https://picsum.photos/80/80?random=4&keyword=ibm",
      "amount": 8000.0,
      "contact": "Lisa Davis",
      "email": "lisa.davis@ibm.com",
      "phone": "+1-555-0321",
      "contractStart": "2023-06-01",
      "contractEnd": "2024-05-31",
      "benefits": ["Logo on website"],
      "deliverables": 2,
      "completedDeliverables": 2,
      "lastActivity": "2024-05-30",
      "paymentStatus": "Paid",
    },
    {
      "id": 5,
      "name": "Oracle Corporation",
      "tier": "Gold",
      "status": "Active",
      "logo": "https://picsum.photos/80/80?random=5&keyword=oracle",
      "amount": 25000.0,
      "contact": "David Wilson",
      "email": "d.wilson@oracle.com",
      "phone": "+1-555-0654",
      "contractStart": "2024-01-01",
      "contractEnd": "2024-12-31",
      "benefits": ["Logo placement", "Exhibition booth"],
      "deliverables": 5,
      "completedDeliverables": 3,
      "lastActivity": "2024-06-12",
      "paymentStatus": "Partial",
    },
  ];

  List<String> statusOptions = ["All", "Active", "Pending", "Expired"];
  List<String> tierOptions = ["All", "Platinum", "Gold", "Silver", "Bronze"];

  List<Map<String, dynamic>> get filteredSponsors {
    return sponsors.where((sponsor) {
      bool matchesSearch = sponsor["name"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" ||
          sponsor["status"] == selectedStatus;
      bool matchesTier = selectedTier == "All" ||
          sponsor["tier"] == selectedTier;
      return matchesSearch && matchesStatus && matchesTier;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sponsor Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Sponsors", icon: Icon(Icons.business)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Contracts", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildSponsorsTab(),
        _buildAnalyticsTab(),
        _buildContractsTab(),
      ],
    );
  }

  Widget _buildSponsorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildSearchAndFilters(),
          SizedBox(height: spMd),
          _buildSponsorStats(),
          SizedBox(height: spMd),
          _buildSponsorsList(),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Sponsor",
              size: bs.md,
              onPressed: () {
                ss("Add new sponsor functionality");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        QTextField(
          label: "Search Sponsors",
          value: searchQuery,
          hint: "Enter sponsor name...",
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
                items: statusOptions.map((status) => {
                  "label": status,
                  "value": status,
                }).toList(),
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
                label: "Tier",
                items: tierOptions.map((tier) => {
                  "label": tier,
                  "value": tier,
                }).toList(),
                value: selectedTier,
                onChanged: (value, label) {
                  selectedTier = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSponsorStats() {
    double totalRevenue = sponsors.fold(0.0, (sum, sponsor) => sum + (sponsor["amount"] as double));
    int activeSponsors = sponsors.where((s) => s["status"] == "Active").length;
    int pendingSponsors = sponsors.where((s) => s["status"] == "Pending").length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total Revenue", "\$${(totalRevenue / 1000).toStringAsFixed(0)}K", primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Active", "$activeSponsors", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Pending", "$pendingSponsors", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Total", "${sponsors.length}", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorsList() {
    return Column(
      children: filteredSponsors.map((sponsor) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${sponsor["logo"]}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${sponsor["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            _buildStatusBadge(sponsor["status"]),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            _buildTierBadge(sponsor["tier"]),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((sponsor["amount"] as double) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${sponsor["contact"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(Icons.email, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${sponsor["email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${sponsor["completedDeliverables"]}/${sponsor["deliverables"]} deliverables",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        _buildPaymentBadge(sponsor["paymentStatus"]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        ss("Viewing ${sponsor["name"]} details");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Edit Contract",
                      size: bs.sm,
                      onPressed: () {
                        ss("Editing ${sponsor["name"]} contract");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "Active":
        color = successColor;
        break;
      case "Pending":
        color = warningColor;
        break;
      case "Expired":
        color = dangerColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTierBadge(String tier) {
    Color color;
    switch (tier) {
      case "Platinum":
        color = primaryColor;
        break;
      case "Gold":
        color = warningColor;
        break;
      case "Silver":
        color = disabledBoldColor;
        break;
      case "Bronze":
        color = Color(0xFFCD7F32);
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        tier,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPaymentBadge(String paymentStatus) {
    Color color;
    switch (paymentStatus) {
      case "Paid":
        color = successColor;
        break;
      case "Partial":
        color = warningColor;
        break;
      case "Pending":
        color = dangerColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        paymentStatus,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildRevenueChart(),
          SizedBox(height: spMd),
          _buildTierDistribution(),
          SizedBox(height: spMd),
          _buildMonthlyTrends(),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
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
          Text(
            "Revenue by Tier",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "Revenue Chart Placeholder",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierDistribution() {
    Map<String, int> tierCounts = {};
    for (var sponsor in sponsors) {
      String tier = sponsor["tier"];
      tierCounts[tier] = (tierCounts[tier] ?? 0) + 1;
    }

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
          Text(
            "Sponsor Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...tierCounts.entries.map((entry) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${entry.value}",
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

  Widget _buildMonthlyTrends() {
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
          Text(
            "Monthly Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: secondaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "Monthly Trends Chart",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Contract Management",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...sponsors.map((sponsor) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Expanded(
                        child: Text(
                          "${sponsor["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      _buildStatusBadge(sponsor["status"]),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildContractInfo("Start Date", "${sponsor["contractStart"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildContractInfo("End Date", "${sponsor["contractEnd"]}"),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildContractInfo("Amount", "\$${((sponsor["amount"] as double)).toStringAsFixed(0)}"),
                  SizedBox(height: spSm),
                  Text(
                    "Benefits:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...(sponsor["benefits"] as List).map((benefit) {
                    return Row(
                      children: [
                        Icon(Icons.check, color: successColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "$benefit",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContractInfo(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
