import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsWarrantyView extends StatefulWidget {
  const EcsWarrantyView({super.key});

  @override
  State<EcsWarrantyView> createState() => _EcsWarrantyViewState();
}

class _EcsWarrantyViewState extends State<EcsWarrantyView> {
  String selectedWarrantyType = "manufacturer";
  bool isRegistered = false;
  String serialNumber = "";
  DateTime purchaseDate = DateTime.now();
  
  Map<String, dynamic> product = {
    "name": "Premium Wireless Headphones",
    "brand": "Sony",
    "model": "WH-1000XM5",
    "image": "https://picsum.photos/400/300?random=1&keyword=headphones",
    "price": 399.99,
    "sku": "SONY-WH1000XM5-B",
  };

  List<Map<String, dynamic>> warrantyOptions = [
    {
      "type": "manufacturer",
      "name": "Manufacturer Warranty",
      "duration": "1 Year",
      "price": 0.0,
      "coverage": [
        "Manufacturing defects",
        "Hardware malfunctions",
        "Parts replacement",
        "Labor costs",
      ],
      "exclusions": [
        "Physical damage",
        "Water damage",
        "Normal wear and tear",
      ],
      "included": true,
    },
    {
      "type": "extended",
      "name": "Extended Warranty",
      "duration": "2 Years Additional",
      "price": 79.99,
      "coverage": [
        "Everything in manufacturer warranty",
        "Extended coverage period",
        "Priority repair service",
        "Expedited replacement",
      ],
      "exclusions": [
        "Physical damage",
        "Water damage",
        "Theft or loss",
      ],
      "included": false,
    },
    {
      "type": "premium",
      "name": "Premium Protection Plan",
      "duration": "3 Years Total",
      "price": 149.99,
      "coverage": [
        "Complete coverage",
        "Accidental damage protection",
        "Liquid damage protection",
        "Theft protection",
        "Battery replacement",
        "24/7 support",
      ],
      "exclusions": [
        "Intentional damage",
        "Pre-existing conditions",
      ],
      "included": false,
    },
  ];

  List<Map<String, dynamic>> warrantyHistory = [
    {
      "product": "Smartphone XYZ",
      "type": "Extended Warranty",
      "status": "Active",
      "expiryDate": "2025-03-15",
      "claimsUsed": 0,
      "maxClaims": 3,
    },
    {
      "product": "Laptop ABC",
      "type": "Premium Protection",
      "status": "Expired",
      "expiryDate": "2024-01-20",
      "claimsUsed": 1,
      "maxClaims": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warranty"),
        actions: [
          IconButton(
            onPressed: () {
              _showWarrantyHistory();
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${product["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${product["brand"]} ${product["model"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "SKU: ${product["sku"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(product["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH5,
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
            SizedBox(height: spMd),

            // Warranty Registration Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isRegistered ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isRegistered ? successColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isRegistered ? Icons.check_circle : Icons.warning,
                    color: isRegistered ? successColor : warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isRegistered ? "Warranty Registered" : "Warranty Not Registered",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isRegistered ? successColor : warningColor,
                          ),
                        ),
                        Text(
                          isRegistered 
                              ? "Your product warranty is active and registered"
                              : "Register your product to activate warranty coverage",
                          style: TextStyle(
                            fontSize: 12,
                            color: isRegistered ? successColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isRegistered)
                    QButton(
                      label: "Register",
                      size: bs.sm,
                      onPressed: () {
                        _showRegistrationDialog();
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Warranty Options
            Container(
              width: double.infinity,
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
                    "Warranty Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...warrantyOptions.map((warranty) {
                    bool isSelected = selectedWarrantyType == warranty["type"];
                    bool isIncluded = warranty["included"];
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedWarrantyType = warranty["type"];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
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
                                            "${warranty["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? primaryColor : Colors.black,
                                            ),
                                          ),
                                          if (isIncluded)
                                            Container(
                                              margin: EdgeInsets.only(left: spSm),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: spXs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Text(
                                                "Included",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        "${warranty["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (warranty["price"] > 0)
                                      Text(
                                        "\$${(warranty["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : successColor,
                                        ),
                                      )
                                    else
                                      Text(
                                        "FREE",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "Coverage:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(warranty["coverage"] as List<String>).map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: successColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            if ((warranty["exclusions"] as List).isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: spSm),
                                  Text(
                                    "Exclusions:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  ...(warranty["exclusions"] as List<String>).map((item) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: spXs),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.cancel,
                                            color: dangerColor,
                                            size: 16,
                                          ),
                                          SizedBox(width: spSm),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Warranty Benefits
            Container(
              width: double.infinity,
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
                    "Why Choose Extended Warranty?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildBenefitItem(
                    Icons.security,
                    "Peace of Mind",
                    "Protection against unexpected repair costs",
                  ),
                  _buildBenefitItem(
                    Icons.support_agent,
                    "Expert Support",
                    "Access to certified technicians and customer support",
                  ),
                  _buildBenefitItem(
                    Icons.flash_on,
                    "Fast Service",
                    "Priority repair and replacement services",
                  ),
                  _buildBenefitItem(
                    Icons.savings,
                    "Cost Savings",
                    "Potentially save hundreds on repair costs",
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Warranty Terms
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "• Warranty must be purchased within 30 days of product purchase\n"
                    "• Product registration is required for warranty activation\n"
                    "• Original purchase receipt required for all claims\n"
                    "• Extended warranty begins after manufacturer warranty expires\n"
                    "• Terms and conditions apply, see full details in warranty agreement",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            if (!isRegistered)
              Column(
                children: [
                  QButton(
                    label: "Register Product & Add Warranty",
                    size: bs.md,
                    onPressed: () {
                      _processWarranty();
                    },
                  ),
                  SizedBox(height: spSm),
                ],
              )
            else
              QButton(
                label: "Add Extended Warranty",
                size: bs.md,
                onPressed: () {
                  _processWarranty();
                },
              ),

            // Links
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    ss("Opening warranty terms");
                  },
                  child: Text(
                    "View Terms",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ss("Contacting support");
                  },
                  child: Text(
                    "Contact Support",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ss("Filing warranty claim");
                  },
                  child: Text(
                    "File Claim",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Register Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Serial Number",
                value: serialNumber,
                hint: "Enter product serial number",
                onChanged: (value) {
                  serialNumber = value;
                },
              ),
              SizedBox(height: spMd),
              QDatePicker(
                label: "Purchase Date",
                value: purchaseDate,
                onChanged: (value) {
                  purchaseDate = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                back();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isRegistered = true;
                });
                back();
                ss("Product registered successfully!");
              },
              child: Text("Register"),
            ),
          ],
        );
      },
    );
  }

  void _showWarrantyHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Warranty History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: warrantyHistory.length,
                  itemBuilder: (context, index) {
                    final item = warrantyHistory[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["product"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["type"]} • Expires: ${item["expiryDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Claims: ${item["claimsUsed"]}/${item["maxClaims"]} • Status: ${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: item["status"] == "Active" ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _processWarranty() {
    if (!isRegistered) {
      _showRegistrationDialog();
    } else {
      ss("Warranty added successfully!");
    }
  }
}
