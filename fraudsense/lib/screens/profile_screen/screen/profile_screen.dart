import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/profile_screen/widgets/achievements_widget.dart';
import 'package:fraudsense/screens/profile_screen/widgets/progress_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const VerticalSpace(height: .02),
          SizedBox(
            height: Responsive.getHeight(context) * .10,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(157, 196, 196, 196),
                  radius: Responsive.getWidth(context) * .10,
                  child: Icon(
                    Icons.person,
                    size: Responsive.getWidth(context) * .09,
                    color: Colors.black,
                  ),
                ),
                const HorizantalSpace(width: .02),
                AutoSizeText(
                  'User Name',
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const VerticalSpace(height: .01),
          const AchievementsWidget(),
          const VerticalSpace(height: .05),
          SizedBox(
            height: Responsive.getHeight(context) * .35,
            child: const Column(
              children: <Widget>[
                ProgressContainer(
                  icon: Icons.hourglass_bottom,
                  title: 'Completed Levels',
                  value: '1/1',
                  comment: 'Complete all Levels',
                ),
                VerticalSpace(height: .01),
                ProgressContainer(
                  icon: Icons.stars,
                  title: 'Points Earned',
                  value: '1000/2000',
                  comment: 'Reach 2000 points',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
