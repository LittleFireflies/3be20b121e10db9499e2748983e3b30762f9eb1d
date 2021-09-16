import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kulina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kamis, 16 September 2021',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  ProductItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
            'https://www.themealdb.com/images/media/meals/uuyrrx1487327597.jpg'),
        Row(
          children: [
            Text(
              '4.7',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RatingBar.builder(
              itemSize: 15,
              itemCount: 5,
              initialRating: 4.7,
              allowHalfRating: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (_) {},
            )
          ],
        ),
        Text(
          'Poutine',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
        ),
        Text(
          "by Antoine's",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Japanese",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rp 15,852',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
            SizedBox(width: 4),
            Text(
              'termasuk ongkir',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text('Tambah ke keranjang'),
        ),
      ],
    );
  }
}
