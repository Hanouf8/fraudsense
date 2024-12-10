// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:fraudsense/core/components/space_boxes.dart';
// import 'package:fraudsense/core/utils/responsive.dart';

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const VerticalSpace(height: .02),
//           SizedBox(
//             width: Responsive.getWidth(context) * .80,
//             child: AutoSizeText(
//               'Welcome to Farudsense',
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(fontWeight: FontWeight.w800),
//               maxLines: 1,
//             ),
//           ),
//           const VerticalSpace(height: .01),
//           SizedBox(
//             width: Responsive.getWidth(context) * .80,
//             child: AutoSizeText(
//               'What whould you like to do?',
//               style: Theme.of(context).textTheme.headlineLarge,
//               maxLines: 1,
//             ),
//           ),
//           const VerticalSpace(height: .10),
//           SizedBox(
//               height: Responsive.getHeight(context) * .60,
//               child: ListView.separated(
//                   itemBuilder: (context, index) {
//                     return MenuScreenContainer(
//                       index: index,
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const VerticalSpace(height: .01);
//                   },
//                   itemCount: menuData.length)),
//         ],
//       ),
//     );
//   }
// }
