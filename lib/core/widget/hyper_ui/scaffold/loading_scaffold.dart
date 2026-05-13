// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LoadingScaffold extends StatelessWidget {
  final String? message;
  const LoadingScaffold({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: spMd),
            if (message != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sp2xl),
                child: Text(
                  "$message",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsLg,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
