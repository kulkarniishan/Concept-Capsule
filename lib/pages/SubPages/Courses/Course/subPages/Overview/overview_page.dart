import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    Card card() {
      var heading = '\$2300 per month';
      var subheading = '2 bed, 1 bath, 1300 sqft';
      var cardImage =
          NetworkImage('https://source.unsplash.com/random/800x600?house');
      var supportingText =
          'Beautiful home to rent, recently refurbished with modern appliances...';
      return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
            ),
            Container(
              height: 100.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   alignment: Alignment.centerLeft,
            //   child: Text(supportingText),
            // ),
          ],
        ),
      );
    }

    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 8.0 / 10.0,
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return card();
            },
          ),
        ),
      ),
    );
  }
}
