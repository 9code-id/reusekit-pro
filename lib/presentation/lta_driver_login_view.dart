import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDriverLoginView extends StatefulWidget {
  const LtaDriverLoginView({super.key});

  @override
  State<LtaDriverLoginView> createState() => _LtaDriverLoginViewState();
}

class _LtaDriverLoginViewState extends State<LtaDriverLoginView> {
  final formKey = GlobalKey<FormState>();
  String driverLicense = "";
  String password = "";
  String vehicleNumber = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  List<Map<String, dynamic>> quickStats = [
    {
      "title": "Active Drivers",
      "value": "2,847",
      "icon": Icons.local_shipping,
      "color": successColor,
    },
    {
      "title": "Today's Deliveries",
      "value": "1,234",
      "icon": Icons.assignment_turned_in,
      "color": primaryColor,
    },
    {
      "title": "Average Rating",
      "value": "4.8",
      "icon": Icons.star,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Login"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 60,
                    color: Colors.white,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Driver Portal",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Sign in to manage your deliveries",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Stats Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          size: 24,
                          color: stat["color"] as Color,
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${stat["value"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${stat["title"]}",
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
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Login Form
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Driver Authentication",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Driver License Field
                    QTextField(
                      label: "Driver License Number",
                      value: driverLicense,
                      hint: "Enter your license number",
                      validator: Validator.required,
                      onChanged: (value) {
                        driverLicense = value;
                        setState(() {});
                      },
                    ),
                    
                    // Vehicle Number Field
                    QTextField(
                      label: "Vehicle Registration Number",
                      value: vehicleNumber,
                      hint: "Enter vehicle number",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Password",
                          value: password,
                          hint: "Enter your password",
                          obscureText: obscurePassword,
                          validator: Validator.required,
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              obscurePassword = !obscurePassword;
                              setState(() {});
                            },
                            child: Text(
                              obscurePassword ? "Show" : "Hide",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Remember Me
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Keep me signed in",
                                "value": true,
                                "checked": rememberMe,
                              }
                            ],
                            value: [
                              if (rememberMe)
                                {
                                  "label": "Keep me signed in",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                rememberMe = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle forgot password
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In as Driver",
                        size: bs.md,
                        icon: Icons.login,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle driver login
                            ss("Driver authentication successful");
                          }
                        },
                      ),
                    ),
                    
                    // Registration Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // ss('Next page'));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "New driver? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Register Here",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Emergency Contact
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: warningColor,
                    size: 24,
                  ),
                  
                  SizedBox(width: spMd),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        
                        Text(
                          "Contact driver support: +1 (555) 123-4567",
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
            ),
          ],
        ),
      ),
    );
  }
}
