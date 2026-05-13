import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerProfileView extends StatefulWidget {
  const CmaCustomerProfileView({super.key});

  @override
  State<CmaCustomerProfileView> createState() => _CmaCustomerProfileViewState();
}

class _CmaCustomerProfileViewState extends State<CmaCustomerProfileView> {
  bool loading = false;
  bool isEditing = false;

  // Customer profile data
  String name = "Jennifer Smith";
  String email = "jennifer.smith@globtech.com";
  String phone = "+1 (555) 987-6543";
  String company = "GlobTech Industries";
  String position = "Marketing Director";
  String website = "www.globtech.com";
  String address = "456 Business Plaza, Suite 200, Metro City, MC 54321";
  String industry = "Manufacturing";
  String employeeCount = "500";
  String annualRevenue = "75000000";
  String taxId = "98-7654321";
  String preferredPayment = "Net 30";
  String customerType = "enterprise";
  String status = "active";
  String notes = "Long-term strategic partner with excellent payment history. Key decision maker for technology purchases within the organization.";
  
  List<String> tags = ["Strategic", "High Value", "Manufacturing", "Decision Maker"];
  String profileImage = "https://picsum.photos/200/200?random=1&keyword=professional";

  double creditLimit = 100000.00;
  double outstandingBalance = 5500.00;
  int totalOrders = 68;
  double totalSpent = 42800.00;
  double rating = 4.7;

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> customerTypes = [
    {"label": "Standard", "value": "standard"},
    {"label": "Premium", "value": "premium"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Startup", "value": "startup"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Suspended", "value": "suspended"},
  ];

  List<Map<String, dynamic>> paymentOptions = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Net 15", "value": "net_15"},
    {"label": "Net 30", "value": "net_30"},
    {"label": "Net 60", "value": "net_60"},
    {"label": "Cash on Delivery", "value": "cod"},
  ];

  List<Map<String, dynamic>> industryOptions = [
    {"label": "Technology", "value": "technology"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Retail", "value": "retail"},
    {"label": "Construction", "value": "construction"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile"),
        actions: [
          if (!isEditing)
            GestureDetector(
              onTap: () {
                isEditing = true;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spMd),
                child: Icon(Icons.edit),
              ),
            ),
          if (isEditing)
            GestureDetector(
              onTap: () => _cancelEdit(),
              child: Container(
                margin: EdgeInsets.only(right: spMd),
                child: Icon(Icons.close),
              ),
            ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                profileImage,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (isEditing)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => _changeProfileImage(),
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$position at $company",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: status == "active"
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: status == "active"
                                    ? successColor
                                    : dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                customerType.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                              size: 20,
                              color: warningColor,
                            );
                          }),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$rating/5.0",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Customer Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "$totalOrders",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Orders",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${totalSpent.currency}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Spent",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${outstandingBalance.currency}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: outstandingBalance > 0
                                    ? warningColor
                                    : successColor,
                                ),
                              ),
                              Text(
                                "Outstanding",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Basic Information
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
                          "Basic Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QTextField(
                          label: "Full Name",
                          value: name,
                          validator: Validator.required,
                          onChanged: (value) {
                            if (isEditing) {
                              name = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Email Address",
                          value: email,
                          validator: Validator.email,
                          onChanged: (value) {
                            if (isEditing) {
                              email = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Phone Number",
                          value: phone,
                          validator: Validator.required,
                          onChanged: (value) {
                            if (isEditing) {
                              phone = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Position/Title",
                          value: position,
                          onChanged: (value) {
                            if (isEditing) {
                              position = value;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Company Information
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
                          "Company Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QTextField(
                          label: "Company Name",
                          value: company,
                          validator: Validator.required,
                          onChanged: (value) {
                            if (isEditing) {
                              company = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Website",
                          value: website,
                          onChanged: (value) {
                            if (isEditing) {
                              website = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Industry",
                          items: industryOptions,
                          value: industry,
                          onChanged: (value, label) {
                            if (isEditing) {
                              industry = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QNumberField(
                          label: "Employee Count",
                          value: employeeCount,
                          onChanged: (value) {
                            if (isEditing) {
                              employeeCount = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QNumberField(
                          label: "Annual Revenue (\$)",
                          value: annualRevenue,
                          onChanged: (value) {
                            if (isEditing) {
                              annualRevenue = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Tax ID",
                          value: taxId,
                          onChanged: (value) {
                            if (isEditing) {
                              taxId = value;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Address Information
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
                          "Address Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QMemoField(
                          label: "Business Address",
                          value: address,
                          onChanged: (value) {
                            if (isEditing) {
                              address = value;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Account Settings
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
                          "Account Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QDropdownField(
                          label: "Customer Type",
                          items: customerTypes,
                          value: customerType,
                          onChanged: (value, label) {
                            if (isEditing) {
                              customerType = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: status,
                          onChanged: (value, label) {
                            if (isEditing) {
                              status = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Preferred Payment",
                          items: paymentOptions,
                          value: preferredPayment,
                          onChanged: (value, label) {
                            if (isEditing) {
                              preferredPayment = value;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: spSm),
                        QNumberField(
                          label: "Credit Limit (\$)",
                          value: creditLimit.toString(),
                          onChanged: (value) {
                            if (isEditing) {
                              creditLimit = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Customer Tags
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
                          "Customer Tags",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: tags.map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (isEditing) ...[
                                    SizedBox(width: spXs),
                                    GestureDetector(
                                      onTap: () => _removeTag(tag),
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        if (isEditing) ...[
                          SizedBox(height: spSm),
                          QButton(
                            label: "Add Tag",
                            icon: Icons.add,
                            size: bs.sm,
                            onPressed: () => _addTag(),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Notes
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
                          "Notes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QMemoField(
                          label: "Customer Notes",
                          value: notes,
                          hint: "Add notes about this customer...",
                          onChanged: (value) {
                            if (isEditing) {
                              notes = value;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Action Buttons
                  if (isEditing)
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            size: bs.md,
                            onPressed: () => _cancelEdit(),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Save Changes",
                            size: bs.md,
                            onPressed: () => _saveProfile(),
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Contact Customer",
                            icon: Icons.phone,
                            size: bs.md,
                            onPressed: () => _contactCustomer(),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Orders",
                            icon: Icons.shopping_cart,
                            size: bs.md,
                            onPressed: () => _viewOrders(),
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: spLg),
                ],
              ),
            ),
          ),
    );
  }

  void _changeProfileImage() {
    ss("Opening image picker for profile photo");
  }

  void _removeTag(String tag) {
    tags.remove(tag);
    setState(() {});
  }

  void _addTag() {
    showDialog(
      context: context,
      builder: (context) {
        String newTag = "";
        return AlertDialog(
          title: Text("Add Tag"),
          content: QTextField(
            label: "Tag Name",
            value: newTag,
            onChanged: (value) {
              newTag = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newTag.isNotEmpty && !tags.contains(newTag)) {
                  tags.add(newTag);
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      loading = false;
      isEditing = false;
      setState(() {});

      ss("Customer profile updated successfully");
    }
  }

  void _cancelEdit() {
    isEditing = false;
    setState(() {});
    si("Changes cancelled");
  }

  void _contactCustomer() {
    ss("Contacting $name at $phone");
  }

  void _viewOrders() {
    ss("Opening order history for $name");
  }
}
