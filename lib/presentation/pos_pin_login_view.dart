import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPinLoginView extends StatefulWidget {
  const PosPinLoginView({super.key});

  @override
  State<PosPinLoginView> createState() => _PosPinLoginViewState();
}

class _PosPinLoginViewState extends State<PosPinLoginView> {
  String enteredPin = "";
  String selectedUser = "";
  bool loading = false;
  
  final List<Map<String, dynamic>> users = [
    {
      "id": "user_1",
      "name": "John Manager",
      "role": "Manager",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "pin": "1234",
      "lastLogin": "Today 09:30 AM",
      "isOnline": true,
    },
    {
      "id": "user_2", 
      "name": "Sarah Cashier",
      "role": "Cashier",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "pin": "5678",
      "lastLogin": "Today 08:15 AM",
      "isOnline": true,
    },
    {
      "id": "user_3",
      "name": "Mike Assistant",
      "role": "Assistant",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "pin": "9876",
      "lastLogin": "Yesterday 06:45 PM",
      "isOnline": false,
    },
    {
      "id": "user_4",
      "name": "Emma Supervisor",
      "role": "Supervisor",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "pin": "4321",
      "lastLogin": "Today 07:20 AM",
      "isOnline": true,
    },
  ];

  final List<String> pinNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(5),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    QButton(
                      icon: Icons.arrow_back,
                      size: bs.sm,
                      onPressed: () {
                        back();
                      },
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PIN Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Quick access for staff",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Email Login",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('PosLoginView')
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      // User Selection
                      if (selectedUser.isEmpty) _buildUserSelection(),
                      
                      // PIN Entry
                      if (selectedUser.isNotEmpty) _buildPinEntry(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Your Account",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        Text(
          "Choose your user account to continue with PIN login",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spLg),

        // Online Users
        Text(
          "Online Now",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
        SizedBox(height: spSm),

        ...users.where((user) => user["isOnline"] == true).map((user) {
          return _buildUserCard(user);
        }).toList(),
        
        SizedBox(height: spMd),

        // Offline Users
        Text(
          "Offline",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),

        ...users.where((user) => user["isOnline"] == false).map((user) {
          return _buildUserCard(user);
        }).toList(),
      ],
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () {
          selectedUser = user["id"];
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: user["isOnline"] ? successColor.withAlpha(30) : disabledOutlineBorderColor,
            ),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${user["avatar"]}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: primaryColor.withAlpha(20),
                            child: Icon(
                              Icons.person,
                              color: primaryColor,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (user["isOnline"])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${user["role"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last login: ${user["lastLogin"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Icon(
                Icons.keyboard_arrow_right,
                color: disabledBoldColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinEntry() {
    final user = users.firstWhere((u) => u["id"] == selectedUser);
    
    return Column(
      children: [
        // User Info
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectedUser = "";
                  enteredPin = "";
                  setState(() {});
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Change User",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${user["avatar"]}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: primaryColor.withAlpha(20),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "${user["name"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${user["role"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),

        // PIN Display
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Text(
                "Enter Your PIN",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              // PIN Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 16,
                    height: 16,
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    decoration: BoxDecoration(
                      color: index < enteredPin.length ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  );
                }),
              ),
              SizedBox(height: spLg),
              
              // PIN Keypad
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 80,
                children: [
                  ...pinNumbers.take(9).map((number) => _buildPinButton(number)),
                  _buildPinButton("", isAction: true, icon: Icons.backspace),
                  _buildPinButton("0"),
                  _buildPinButton("", isAction: true, icon: Icons.check, isConfirm: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPinButton(String number, {bool isAction = false, IconData? icon, bool isConfirm = false}) {
    return GestureDetector(
      onTap: () {
        if (isAction) {
          if (icon == Icons.backspace && enteredPin.isNotEmpty) {
            enteredPin = enteredPin.substring(0, enteredPin.length - 1);
            setState(() {});
          } else if (icon == Icons.check && enteredPin.length == 4) {
            _verifyPin();
          }
        } else if (enteredPin.length < 4) {
          enteredPin += number;
          setState(() {});
          
          // Auto-verify when 4 digits entered
          if (enteredPin.length == 4) {
            Future.delayed(Duration(milliseconds: 300), () {
              _verifyPin();
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(spXs),
        height: 60,
        decoration: BoxDecoration(
          color: isConfirm && enteredPin.length == 4 ? primaryColor : 
                 isAction ? disabledColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isConfirm && enteredPin.length == 4 ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Center(
          child: isAction
              ? Icon(
                  icon,
                  color: isConfirm && enteredPin.length == 4 ? Colors.white : disabledBoldColor,
                  size: 24,
                )
              : Text(
                  number,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
        ),
      ),
    );
  }

  void _verifyPin() {
    if (enteredPin.length != 4) return;
    
    loading = true;
    setState(() {});
    
    final user = users.firstWhere((u) => u["id"] == selectedUser);
    
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      
      if (enteredPin == user["pin"]) {
        ss("Welcome ${user["name"]}!");
        // navigateTo('PosDashboardView', arguments: {"user": user})
      } else {
        se("Incorrect PIN. Please try again.");
        enteredPin = "";
        setState(() {});
      }
    });
  }
}
