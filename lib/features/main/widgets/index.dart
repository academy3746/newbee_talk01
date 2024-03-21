import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: const Center(
          child: Text(
            'INDEX',
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
