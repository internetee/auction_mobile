import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:flutter/material.dart';

class BidsForm extends StatefulWidget {
  BidsForm({
    super.key,
    required this.auction,
  });

  final Auction auction;

  @override
  State<BidsForm> createState() => _BidsFormState();
}

class _BidsFormState extends State<BidsForm> {
  @override
  Widget build(BuildContext context) {
    var _bidAmount = widget.auction.highestBid;

    return Form(
      key: GlobalKey<FormState>(),
      child: Column(
        children: [
          const Text('Add bid'),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Bid amount',
            ),
            initialValue: _bidAmount.toString(),
            validator: (value) {
              if (value == null || value.isEmpty || double.tryParse(value) == null || double.tryParse(value)! <= 0) {
                return 'Please enter a correct amount. The amount must be greater than 0.';
              }
              return null;
            },
            onSaved: (value) {
              _bidAmount = double.parse(value!);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add bid'),
          ),
        ],
      ),
    );
  }
}
