import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsAddressBookView extends StatefulWidget {
  const EcsAddressBookView({super.key});

  @override
  State<EcsAddressBookView> createState() => _EcsAddressBookViewState();
}

class _EcsAddressBookViewState extends State<EcsAddressBookView> {
  List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "type": "Home",
      "name": "Sarah Wilson",
      "phone": "+1 234 567 8900",
      "address": "123 Maple Street, Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
      "isDefault": true,
    },
    {
      "id": 2,
      "type": "Work",
      "name": "Sarah Wilson",
      "phone": "+1 234 567 8900",
      "address": "456 Business Ave, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "country": "United States",
      "isDefault": false,
    },
    {
      "id": 3,
      "type": "Other",
      "name": "John Doe",
      "phone": "+1 234 567 8901",
      "address": "789 Oak Road, House 15",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "country": "United States",
      "isDefault": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Book"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo("AddAddressView")
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Manage Your Addresses",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add, edit, or delete delivery addresses for faster checkout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Add New Address Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Address",
                icon: Icons.add_location,
                size: bs.md,
                onPressed: () {
                  //navigateTo("AddAddressView")
                },
              ),
            ),

            // Address List
            Text(
              "Saved Addresses (${addresses.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...addresses.map((address) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: (address["isDefault"] as bool) 
                        ? primaryColor 
                        : disabledOutlineBorderColor,
                    width: (address["isDefault"] as bool) ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address Type and Default Badge
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getAddressTypeColor("${address["type"]}").withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getAddressTypeIcon("${address["type"]}"),
                                size: 16,
                                color: _getAddressTypeColor("${address["type"]}"),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${address["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getAddressTypeColor("${address["type"]}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (address["isDefault"] as bool) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Default",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        Spacer(),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: disabledBoldColor,
                          ),
                          onSelected: (value) async {
                            if (value == 'edit') {
                              //navigateTo("EditAddressView")
                            } else if (value == 'delete') {
                              bool isConfirmed = await confirm(
                                "Are you sure you want to delete this address?"
                              );
                              if (isConfirmed) {
                                addresses.removeWhere((addr) => addr["id"] == address["id"]);
                                setState(() {});
                                ss("Address deleted successfully");
                              }
                            } else if (value == 'default') {
                              // Set as default
                              for (var addr in addresses) {
                                addr["isDefault"] = addr["id"] == address["id"];
                              }
                              setState(() {});
                              ss("Default address updated");
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: spSm),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                            if (!(address["isDefault"] as bool))
                              PopupMenuItem(
                                value: 'default',
                                child: Row(
                                  children: [
                                    Icon(Icons.star, size: 20),
                                    SizedBox(width: spSm),
                                    Text("Set as Default"),
                                  ],
                                ),
                              ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: dangerColor),
                                  SizedBox(width: spSm),
                                  Text("Delete", style: TextStyle(color: dangerColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Recipient Name and Phone
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${address["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spXs),

                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 18,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${address["phone"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Address Details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${address["address"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${address["city"]}, ${address["state"]} ${address["zipCode"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${address["country"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
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
                            label: "Edit",
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo("EditAddressView")
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Use Address",
                            icon: Icons.check,
                            size: bs.sm,
                            onPressed: () {
                              ss("Address selected for delivery");
                              back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State (when no addresses)
            if (addresses.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Addresses Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Add your first delivery address to get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Address",
                      icon: Icons.add_location,
                      size: bs.md,
                      onPressed: () {
                        //navigateTo("AddAddressView")
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getAddressTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.work;
      case 'other':
        return Icons.location_on;
      default:
        return Icons.location_on;
    }
  }

  Color _getAddressTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return primaryColor;
      case 'work':
        return infoColor;
      case 'other':
        return warningColor;
      default:
        return primaryColor;
    }
  }
}
