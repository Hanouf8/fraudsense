import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/profile_screen/data/peofile_screen_data.dart';

class AchievementsWidget extends StatelessWidget {
  const AchievementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.getHeight(context) * .30,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                'Achievements',
                style: Theme.of(context).textTheme.headlineLarge,
                maxLines: 1,
              ),
              const VerticalSpace(height: .01),
              SizedBox(
                height: Responsive.getHeight(context) * .20,
                width: Responsive.getWidth(context),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: Responsive.getHeight(context) * .15,
                        width: Responsive.getWidth(context) * .30,
                        margin:
                            EdgeInsets.all(Responsive.getWidth(context) * .01),
                        padding:
                            EdgeInsets.all(Responsive.getWidth(context) * .01),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(157, 196, 196, 196),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: Responsive.getHeight(context) * .08,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(achievmentsData[index].icon),
                            ),
                            const VerticalSpace(height: .02),
                            AutoSizeText(
                              achievmentsData[index].title,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const VerticalSpace(height: .01),
                            AutoSizeText(achievmentsData[index].value,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const HorizantalSpace(width: .01);
                    },
                    itemCount: achievmentsData.length),
              ),
            ]));
  }
}
