import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: const Center(
          child: Text(
            'INFO',
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size42,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
