import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InformCard extends StatelessWidget {
  const InformCard({
    super.key,
    required this.svgPath,
    required this.title,
    required this.description,
  });

  final String svgPath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 4,
            color: Colors.green,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgPath,
                  semanticsLabel: 'Gift',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            description,
          ),
        ],
      ),
    );
  }
}
