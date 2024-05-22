import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/menu_screen/data/menu_screen_data.dart';

class MenuScreenContainer extends StatelessWidget {
  const MenuScreenContainer({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
        height: Responsive.getHeight(context) * .13,
        width: Responsive.getWidth(context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(157, 196, 196, 196),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: Responsive.getWidth(context) * .95,
          child: Row(
            children: <Widget>[
              Container(
                height: Responsive.getHeight(context) * .12,
                width: Responsive.getWidth(context) * .20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(menuData[index].icon),
                ),
              ),
              const HorizantalSpace(width: .05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    menuData[index].title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpace(height: .01),
                  SizedBox(
                    width: Responsive.getWidth(context) * .55,
                    child: AutoSizeText(
                      menuData[index].description,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
