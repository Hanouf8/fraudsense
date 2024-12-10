import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FakeMobileScreen extends StatefulWidget {
  const FakeMobileScreen(
      {super.key,
      required this.contactTitle,
      required this.receivedMessage,
      required this.receivedLink,
      required this.isVerifiedContact,
      required this.messageTime,
      required this.textDirection,
      this.disableFooter = false,
      this.disableUnnecessaryIcons = false});

  final String contactTitle;
  final String receivedMessage;
  final String receivedLink;
  final bool isVerifiedContact;
  final String messageTime;
  final TextDirection textDirection;

  final bool disableFooter;
  final bool disableUnnecessaryIcons;

  @override
  State<FakeMobileScreen> createState() => _FakeMobileScreenState();
}

class _FakeMobileScreenState extends State<FakeMobileScreen> {
  //make a small animation of typing then sending the message
  final Color backgroundColor = Colors.amber.shade50;

  final Color iconsColor = Colors.white;
  //make it so any links inside the message have a line under them like normal messages, and numbers should also be highlighted

  RichText messageText() {
    return RichText(
      textDirection: widget.textDirection,
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black),
        children: [
          TextSpan(text: "${widget.receivedMessage} "),
          TextSpan(
              text: widget.receivedLink,
              style: const TextStyle(decoration: TextDecoration.underline))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color headerColor = Colors.blueGrey.shade900;
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  header(headerColor),
                  Flexible(
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(color: backgroundColor),
                        constraints: const BoxConstraints.expand(),
                      ),
                      messageBox(),
                    ]),
                  ),
                  if (!widget.disableFooter) footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox footer() {
    return SizedBox(
      height: 45,
      child: Container(
        decoration: BoxDecoration(color: iconsColor),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Type a message..",
                style: TextStyle(color: Colors.black26),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.send,
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox header(Color headerColor) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(color: headerColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: iconsColor,
                    maxRadius: 18,
                    child: Icon(Icons.person, color: Colors.grey.shade400, size: 16 * 2),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    constraints: const BoxConstraints(minWidth: 5.0, maxWidth: 150.0),
                    // color: Colors.red,
                    child: SizedBox(
                      child: AutoSizeText(
                        maxLines: 1,
                        widget.contactTitle,
                        maxFontSize: 16,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(color: iconsColor, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.isVerifiedContact)
                    Icon(
                      Icons.verified,
                      size: 18,
                      color: Colors.yellow.shade800,
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  if (!widget.disableUnnecessaryIcons)
                    Icon(
                      Icons.videocam_rounded,
                      color: iconsColor,
                    ),
                  const SizedBox(width: 10),
                  if (!widget.disableUnnecessaryIcons)
                    Icon(
                      Icons.search,
                      color: iconsColor,
                    ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.menu_rounded,
                    color: iconsColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget messageBox() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(minWidth: 5.0, maxWidth: 300.0),
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15))),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.end,
        children: [
          Padding(padding: const EdgeInsets.only(right: 8.0), child: messageText()),
          Text(
            textDirection: TextDirection.ltr,
            widget.messageTime,
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
