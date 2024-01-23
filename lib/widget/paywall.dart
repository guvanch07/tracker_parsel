import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Paywall extends StatefulWidget {
  final String title;
  final String description;
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const Paywall({
    Key? key,
    required this.title,
    required this.description,
    required this.packages,
    required this.onClickedPackage,
  }) : super(key: key);

  @override
  State<Paywall> createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            buildPackages()
          ],
        ),
      ),
    );
  }

  Widget buildPackages() => ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.packages.length,
        itemBuilder: (context, index) {
          final package = widget.packages[index];
          return buildPackage(context, package);
        },
      );

  Widget buildPackage(BuildContext context, Package package) {
    final product = package.product;
    return Card(
      color: Color(0xffF57300),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(product.description),
          onTap: () => widget.onClickedPackage(package),
          trailing: Text(
            product.priceString,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
