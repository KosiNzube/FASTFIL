import 'package:flutter/material.dart';

import '../constants.dart';

class Tags extends StatelessWidget {
  const Tags({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: kDefopadding / 4),
            SizedBox(width: kDefopadding / 2),
            Text(
              "Tags",
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: kGrayColor),
            ),
            Spacer(),
            MaterialButton(
              padding: EdgeInsets.all(10),
              minWidth: 40,
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: kGrayColor,
                size: 20,
              ),
            )
          ],
        ),
        SizedBox(height: kDefopadding / 2),
        buildTag(context, color: Color(0xFF23CF91), title: "Design"),
        buildTag(context, color: Color(0xFF3A6FF7), title: "Work"),
        buildTag(context, color: Color(0xFFF3CF50), title: "Friends"),
        buildTag(context, color: Color(0xFF8338E1), title: "Family"),
      ],
    );
  }

  InkWell buildTag(BuildContext context,
      {required Color color, required String title}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(kDefopadding * 1.5, 10, 0, 10),
        child: Row(
          children: [

            SizedBox(width: kDefopadding / 2),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: kGrayColor),
            ),
          ],
        ),
      ),
    );
  }
}
