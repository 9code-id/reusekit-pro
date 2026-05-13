import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice6View extends StatefulWidget {
  @override
  State<GrlInvoice6View> createState() => _GrlInvoice6ViewState();
}

class _GrlInvoice6ViewState extends State<GrlInvoice6View> {
  List<Map<String, dynamic>> clients = [
    {
      "id": "1",
      "name": "TechStart Inc.",
      "email": "contact@techstart.com",
      "phone": "+1 (555) 987-6543",
      "address": "789 Innovation Drive, San Francisco, CA 94105",
      "totalInvoices": 12,
      "totalAmount": 25400.0,
      "lastInvoiceDate": "2024-01-15",
      "status": "Active",
      "avatarColor": primaryColor,
    },
    {
      "id": "2",
      "name": "Digital Solutions Ltd.",
      "email": "info@digitalsol.com",
      "phone": "+1 (555) 456-7890",
      "address": "456 Business Ave, New York, NY 10001",
      "totalInvoices": 8,
      "totalAmount": 18200.0,
      "lastInvoiceDate": "2024-01-12",
      "status": "Active",
      "avatarColor": successColor,
    },
    {
      "id": "3",
      "name": "Marketing Pro Agency",
      "email": "hello@marketingpro.com",
      "phone": "+1 (555) 123-4567",
      "address": "123 Marketing Street, Los Angeles, CA 90210",
      "totalInvoices": 15,
      "totalAmount": 32100.0,
      "lastInvoiceDate": "2024-01-10",
      "status": "Active",
      "avatarColor": warningColor,
    },
    {
      "id": "4",
      "name": "StartUp Innovations",
      "email": "team@startup.com",
      "phone": "+1 (555) 234-5678",
      "address": "321 Innovation Blvd, Austin, TX 78701",
      "totalInvoices": 6,
      "totalAmount": 14800.0,
      "lastInvoiceDate": "2024-01-08",
      "status": "Inactive",
      "avatarColor": dangerColor,
    },
    {
      "id": "5",
      "name": "E-Commerce Solutions",
      "email": "support@ecommerce.com",
      "phone": "+1 (555) 345-6789",
      "address": "654 Commerce St, Seattle, WA 98101",
      "totalInvoices": 20,
      "totalAmount": 45600.0,
      "lastInvoiceDate": "2024-01-05",
      "status": "Active",
      "avatarColor": infoColor,
    },
  ];

  String searchQuery = "";
  String selectedStatus = "All";
  List<String> statusOptions = ["All", "Active", "Inactive"];

  List<Map<String, dynamic>> get filteredClients {
    var filtered = clients;

    if (selectedStatus != "All") {
      filtered = filtered.where((client) => client["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((client) =>
          client["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          client["email"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewClient,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            _buildStatsCards(),
            _buildSearchAndFilter(),
            _buildClientsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    int totalClients = clients.length;
    int activeClients = clients.where((c) => c["status"] == "Active").length;
    double totalRevenue = clients.fold(0.0, (sum, client) => sum + (client["totalAmount"] as double));
    int totalInvoices = clients.fold(0, (sum, client) => sum + (client["totalInvoices"] as int));

    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: _buildStatCard(
            "Total Clients",
            totalClients.toString(),
            Icons.people,
            primaryColor,
          ),
        ),
        Expanded(
          child: _buildStatCard(
            "Active Clients",
            activeClients.toString(),
            Icons.check_circle,
            successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
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
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search clients...",
                  prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spSm,
                  ),
                ),
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: DropdownButton<String>(
              value: selectedStatus,
              underline: SizedBox.shrink(),
              items: statusOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                selectedStatus = value!;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Clients (${filteredClients.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.sort,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    Icon(
                      Icons.filter_list,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (filteredClients.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: disabledColor,
                  ),
                  Text(
                    "No clients found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else
            ...List.generate(filteredClients.length, (index) {
              final client = filteredClients[index];
              return _buildClientItem(client, index == filteredClients.length - 1);
            }),
        ],
      ),
    );
  }

  Widget _buildClientItem(Map<String, dynamic> client, bool isLast) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: client["avatarColor"],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                "${client["name"]}".substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${client["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: client["status"] == "Active" 
                            ? successColor.withAlpha(25)
                            : dangerColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${client["status"]}",
                        style: TextStyle(
                          color: client["status"] == "Active" ? successColor : dangerColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${client["email"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${client["phone"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        Text(
                          "\$${(client["totalAmount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 2,
                      children: [
                        Text(
                          "Invoices",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        Text(
                          "${client["totalInvoices"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last Invoice: ${client["lastInvoiceDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    Row(
                      spacing: spXs,
                      children: [
                        GestureDetector(
                          onTap: () => _viewClientDetails(client),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.visibility,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _editClient(client),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: successColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _createInvoiceForClient(client),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.receipt,
                              size: 16,
                              color: warningColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _deleteClient(client),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
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

  void _addNewClient() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add New Client",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              QTextField(
                label: "Client Name",
                value: "",
                onChanged: (value) {},
              ),
              QTextField(
                label: "Email",
                value: "",
                onChanged: (value) {},
              ),
              QTextField(
                label: "Phone",
                value: "",
                onChanged: (value) {},
              ),
              QTextField(
                label: "Address",
                value: "",
                onChanged: (value) {},
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Add Client",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Client added successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _viewClientDetails(Map<String, dynamic> client) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: client["avatarColor"],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${client["name"]}".substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${client["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${client["status"]}",
                        style: TextStyle(
                          color: client["status"] == "Active" ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${client["email"]}"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${client["phone"]}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(child: Text("${client["address"]}")),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "\$${(client["totalAmount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Total Invoices",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${client["totalInvoices"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _editClient(Map<String, dynamic> client) {
    si("Edit client functionality");
  }

  void _createInvoiceForClient(Map<String, dynamic> client) {
    si("Create invoice for ${client["name"]}");
  }

  void _deleteClient(Map<String, dynamic> client) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this client?");
    if (isConfirmed) {
      clients.removeWhere((c) => c["id"] == client["id"]);
      setState(() {});
      ss("Client deleted successfully");
    }
  }
}
