import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';

class CardOverView extends StatelessWidget {
  final String type;
  final String value;
  final IconData icon;

  CardOverView({required this.type, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Card(
        shape: ButtonBorder(),
        elevation: 0,
        color: Colors.white10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              Text(
                type,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
