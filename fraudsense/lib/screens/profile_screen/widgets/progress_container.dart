import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      required this.comment});
  final IconData icon;
  final String title;
  final String value;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
      margin: EdgeInsets.all(Responsive.getWidth(context) * .01),
      height: Responsive.getHeight(context) * .15,
      width: Responsive.getWidth(context) * .95,
      decoration: BoxDecoration(
        color: const Color.fromARGB(157, 196, 196, 196),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: Responsive.getHeight(context) * .14,
            width: Responsive.getWidth(context) * .20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(icon),
            ),
          ),
          const HorizantalSpace(width: .05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Responsive.getWidth(context) * .65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoSizeText(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(height: .01),
              SizedBox(
                height: Responsive.getHeight(context) * .01,
                width: Responsive.getWidth(context) * .65,
                child: const LinearProgressIndicator(
                  color: Color.fromARGB(148, 255, 82, 82),
                  backgroundColor: Color.fromARGB(157, 145, 144, 144),
                  value: .5,
                ),
              ),
              const VerticalSpace(height: .01),
              AutoSizeText(
                comment,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
