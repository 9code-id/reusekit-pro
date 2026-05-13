import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPinSetupView extends StatefulWidget {
  const BfaPinSetupView({super.key});

  @override
  State<BfaPinSetupView> createState() => _BfaPinSetupViewState();
}

class _BfaPinSetupViewState extends State<BfaPinSetupView> {
  String enteredPin = "";
  String confirmPin = "";
  bool isConfirmationStep = false;
  bool loading = false;
  
  List<String> pin1 = [];
  List<String> pin2 = [];

  void _addDigit(String digit) {
    if (!isConfirmationStep) {
      if (pin1.length < 6) {
        pin1.add(digit);
        enteredPin = pin1.join();
        setState(() {});
        
        if (pin1.length == 6) {
          Future.delayed(Duration(milliseconds: 500), () {
            isConfirmationStep = true;
            setState(() {});
          });
        }
      }
    } else {
      if (pin2.length < 6) {
        pin2.add(digit);
        confirmPin = pin2.join();
        setState(() {});
        
        if (pin2.length == 6) {
          _validatePin();
        }
      }
    }
  }

  void _removeDigit() {
    if (!isConfirmationStep) {
      if (pin1.isNotEmpty) {
        pin1.removeLast();
        enteredPin = pin1.join();
        setState(() {});
      }
    } else {
      if (pin2.isNotEmpty) {
        pin2.removeLast();
        confirmPin = pin2.join();
        setState(() {});
      }
    }
  }

  void _clearPin() {
    if (!isConfirmationStep) {
      pin1.clear();
      enteredPin = "";
    } else {
      pin2.clear();
      confirmPin = "";
    }
    setState(() {});
  }

  Future<void> _validatePin() async {
    if (enteredPin == confirmPin) {
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("PIN setup completed successfully");
      // navigateTo(BfaBiometricSetupView());
    } else {
      se("PINs do not match. Please try again.");
      isConfirmationStep = false;
      pin1.clear();
      pin2.clear();
      enteredPin = "";
      confirmPin = "";
      setState(() {});
    }
  }

  Widget _buildPinDots(List<String> currentPin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        bool isSelected = index < currentPin.length;
        return Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.symmetric(horizontal: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : disabledColor,
            shape: BoxShape.circle,
            boxShadow: isSelected ? [shadowSm] : [],
          ),
        );
      }),
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _addDigit(number),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusXl),
          border: Border.all(color: disabledOutlineBorderColor),
          boxShadow: [shadowSm],
        ),
        child: Center(
          child: Text(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PIN Setup"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (isConfirmationStep) {
              isConfirmationStep = false;
              pin2.clear();
              confirmPin = "";
              setState(() {});
            } else {
              back();
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            SizedBox(height: sp2xl),
            
            // Header Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.lock,
                size: 50,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title & Description
            Text(
              isConfirmationStep ? "Confirm Your PIN" : "Create Your PIN",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              isConfirmationStep 
                  ? "Please re-enter your 6-digit PIN to confirm"
                  : "Create a 6-digit PIN to secure your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // PIN Status
            if (!isConfirmationStep && pin1.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "PIN Length: ${pin1.length}/6",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            
            if (isConfirmationStep && pin2.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Confirmation: ${pin2.length}/6",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            
            SizedBox(height: spXl),
            
            // PIN Dots Display
            _buildPinDots(isConfirmationStep ? pin2 : pin1),
            
            SizedBox(height: sp3xl),
            
            // Number Pad
            if (!loading)
              Expanded(
                child: Column(
                  children: [
                    // Row 1: 1, 2, 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton("1"),
                        _buildNumberButton("2"),
                        _buildNumberButton("3"),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Row 2: 4, 5, 6
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton("4"),
                        _buildNumberButton("5"),
                        _buildNumberButton("6"),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Row 3: 7, 8, 9
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton("7"),
                        _buildNumberButton("8"),
                        _buildNumberButton("9"),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Row 4: Clear, 0, Backspace
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _clearPin,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXl),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: warningColor,
                              size: 30,
                            ),
                          ),
                        ),
                        
                        _buildNumberButton("0"),
                        
                        GestureDetector(
                          onTap: _removeDigit,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXl),
                            ),
                            child: Icon(
                              Icons.backspace,
                              color: dangerColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Loading State
            if (loading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Setting up your PIN...",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            SizedBox(height: spLg),
            
            // PIN Security Tips
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "PIN Security Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Avoid using obvious patterns like 123456\n• Don't use your birth date or phone number\n• Keep your PIN confidential and secure",
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
    );
  }
}
