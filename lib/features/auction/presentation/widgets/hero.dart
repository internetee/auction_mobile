
import 'package:flutter/material.dart';

class AuctionHero extends StatelessWidget {
  const AuctionHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/hero.png',
          height: 200,
          width: double.infinity,
        ),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Auctions',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}