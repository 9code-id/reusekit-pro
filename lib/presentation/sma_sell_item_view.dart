import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSellItemView extends StatefulWidget {
  const SmaSellItemView({super.key});

  @override
  State<SmaSellItemView> createState() => _SmaSellItemViewState();
}

class _SmaSellItemViewState extends State<SmaSellItemView> {
  final formKey = GlobalKey<FormState>();
  
  String title = "";
  String description = "";
  String category = "";
  String condition = "";
  String price = "";
  String originalPrice = "";
  String location = "";
  List<String> images = [];
  bool isNegotiable = false;
  bool freeShipping = false;
  String shippingCost = "";
  List<String> tags = [];
  String tagInput = "";

  List<Map<String, dynamic>> categories = [
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing & Fashion", "value": "Clothing"},
    {"label": "Home & Garden", "value": "Home"},
    {"label": "Books & Education", "value": "Books"},
    {"label": "Sports & Recreation", "value": "Sports"},
    {"label": "Automotive", "value": "Automotive"},
    {"label": "Health & Beauty", "value": "Health"},
    {"label": "Services", "value": "Services"},
    {"label": "Pets & Animals", "value": "Pets"},
    {"label": "Collectibles", "value": "Collectibles"},
  ];

  List<Map<String, dynamic>> conditions = [
    {"label": "New", "value": "New"},
    {"label": "Like New", "value": "Like New"},
    {"label": "Excellent", "value": "Excellent"},
    {"label": "Good", "value": "Good"},
    {"label": "Fair", "value": "Fair"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Your Item"),
        actions: [
          QButton(
            label: "Preview",
            size: bs.sm,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _previewItem();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Guidelines Card
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Tips for a successful listing:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Use clear, high-quality photos\n"
                      "• Write detailed descriptions\n"
                      "• Price competitively\n"
                      "• Respond to messages quickly",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Photos Section
              Container(
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
                        Icon(Icons.photo_camera, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${images.length}/5",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QMultiImagePicker(
                      label: "Add up to 5 photos",
                      value: images,
                      maxImages: 5,
                      hint: "The first photo will be your main image",
                      validator: (images) {
                        if (images == null || images.isEmpty) {
                          return "At least one photo is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        images = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Basic Information
              Container(
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
                        Icon(Icons.info, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Title",
                      value: title,
                      hint: "What are you selling?",
                      validator: Validator.required,
                      onChanged: (value) {
                        title = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe your item in detail. Include condition, features, and reason for selling.",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categories,
                            value: category,
                            onChanged: (value, label) {
                              category = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Condition",
                            items: conditions,
                            value: condition,
                            onChanged: (value, label) {
                              condition = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pricing Section
              Container(
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
                        Icon(Icons.attach_money, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Pricing",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Price (\$)",
                            value: price,
                            hint: "Your asking price",
                            validator: Validator.required,
                            onChanged: (value) {
                              price = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Original Price (\$)",
                            value: originalPrice,
                            hint: "Optional",
                            onChanged: (value) {
                              originalPrice = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Price is negotiable",
                          "value": true,
                          "checked": isNegotiable,
                        }
                      ],
                      value: [
                        if (isNegotiable)
                          {
                            "label": "Price is negotiable",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isNegotiable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Location Section
              Container(
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
                        Icon(Icons.location_on, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Location",
                      value: location,
                      hint: "City, State",
                      validator: Validator.required,
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Shipping Section
              Container(
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
                        Icon(Icons.local_shipping, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Shipping",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Offer free shipping",
                          "value": true,
                          "checked": freeShipping,
                        }
                      ],
                      value: [
                        if (freeShipping)
                          {
                            "label": "Offer free shipping",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        freeShipping = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    if (!freeShipping)
                      QNumberField(
                        label: "Shipping Cost (\$)",
                        value: shippingCost,
                        hint: "How much to charge for shipping",
                        onChanged: (value) {
                          shippingCost = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Tags Section
              Container(
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
                        Icon(Icons.tag, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Tags",
                          style: TextStyle(
                            fontSize: fsH6,  
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add tags",
                            value: tagInput,
                            hint: "e.g., vintage, rare, collectible",
                            onChanged: (value) {
                              tagInput = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: () {
                            if (tagInput.isNotEmpty && !tags.contains(tagInput.toLowerCase())) {
                              tags.add(tagInput.toLowerCase());
                              tagInput = "";
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                    
                    if (tags.isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
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
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () {
                                    tags.remove(tag);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "List Item for Sale",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _submitItem();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _previewItem() {
    final item = {
      "title": title,
      "description": description,
      "category": category,
      "condition": condition,
      "price": double.tryParse(price) ?? 0.0,
      "originalPrice": double.tryParse(originalPrice) ?? 0.0,
      "location": location,
      "images": images,
      "isNegotiable": isNegotiable,
      "freeShipping": freeShipping,
      "shippingCost": double.tryParse(shippingCost) ?? 0.0,
      "tags": tags,
    };
    
    si("Preview item: $title");
    //navigateTo('PreviewItemView', arguments: item)
  }

  void _submitItem() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    final item = {
      "title": title,
      "description": description,
      "category": category,
      "condition": condition,
      "price": double.tryParse(price) ?? 0.0,
      "originalPrice": double.tryParse(originalPrice) ?? 0.0,
      "location": location,
      "images": images,
      "isNegotiable": isNegotiable,
      "freeShipping": freeShipping,
      "shippingCost": double.tryParse(shippingCost) ?? 0.0,
      "tags": tags,
      "postedDate": DateTime.now().toString().substring(0, 10),
      "views": 0,
      "saves": 0,
    };
    
    ss("Item listed successfully!");
    back();
  }
}
