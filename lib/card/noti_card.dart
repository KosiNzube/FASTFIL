import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../extensions.dart';
import '../modelspx/notification.dart';

class notiCard extends StatelessWidget {
  const notiCard({
     this.isActive = true,
    required this.email,
    required this.press,
  });

  final bool isActive;
  final Notificationx email;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(email.image),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "FASTFIL"+ "\n",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: email.header,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            email.timestamp.toDate().timeZoneName,
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    email.context,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    /*
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.5,
                        ),

                     */
                  )
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBadgeColor,
                ),
              ).addNeumorphism(
                blurRadius: mode.brightness==Brightness.dark?0: 15,
                borderRadius: mode.brightness==Brightness.dark?9: 15,
                offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
              ),
            )
            /*
            if (email.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: WebsafeSvg.asset(
                  "assets/Icons/Markup filled.svg",
                  height: 18,
                  color: email.tagColor,
                ),


              )

             */
          ],
        ),
      ),
    );
  }
}
