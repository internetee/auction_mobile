import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:auction_mobile/features/auction/presentation/widgets/bids_form.dart';
import 'package:flutter/material.dart';

class AuctionCard extends StatefulWidget {
  final Auction auction;

  const AuctionCard({
    super.key,
    required this.auction,
  });

  @override
  State<AuctionCard> createState() => _AuctionCardState();
}

class _AuctionCardState extends State<AuctionCard> {
  void _addBidOverlay() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) {
        return BidsForm(auction: widget.auction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.auction.domainName),
                Text(
                  widget.auction.type == 'english' ? 'IO' : 'PO',
                  style: TextStyle(
                    color: widget.auction.type == 'english' ? Colors.blue : Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(widget.auction.endsAt ?? 'No end date'),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${widget.auction.highestBid} €',
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.auction.highestBidder ?? 'No bids yet',
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
              onPressed: _addBidOverlay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Bid'),
            ),
          ],
        ),
      ),
    );
  }
}

