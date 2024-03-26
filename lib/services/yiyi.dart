import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class yiyi extends StatelessWidget {
  Widget? child;
  Widget? child2;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic commentController;
  ImageProvider? userImage;
  String? labelText;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  yiyi(
      {this.child,
        this.header,
        this.child2,

        this.sendButtonMethod,
        this.formKey,
        this.commentController,
        this.sendWidget,
        this.userImage,
        this.labelText,
        this.focusNode,
        this.errorText,
        this.withBorder = true,
        this.backgroundColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [



       // child2!,

        Divider(
          height: 1,
        ),

        Expanded(child: child!),
        Divider(
          height: 1,
        ),
        header ?? SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,

          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: new BoxDecoration(
                color: Colors.black38,
                borderRadius: new BorderRadius.all(Radius.circular(50))),
            child: CircleAvatar(radius: 50, backgroundImage: userImage),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              autofocus: false, // Set to false to prevent autofocus
              minLines: 1,
              focusNode: focusNode,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                labelText: labelText,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }

  /// This method is used to parse the image from the URL or the path.
  /// `CommentBox.commentImageParser(imageURLorPath: 'url_or_path_to_image')`
  static ImageProvider commentImageParser({imageURLorPath}) {
    try {
      //check if imageURLorPath
      if (imageURLorPath is String) {
        if (imageURLorPath.startsWith('http')) {
          return NetworkImage(imageURLorPath);
        } else {
          return AssetImage(imageURLorPath);
        }
      } else {
        return imageURLorPath;
      }
    } catch (e) {
      //throw error
      throw Exception('Error parsing image: $e');
    }
  }
}


class yiyix extends StatelessWidget {
  Widget? child;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic commentController;
  ImageProvider? userImage;
  String? labelText;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  yiyix(
      {this.child,
        this.header,
        this.sendButtonMethod,
        this.formKey,
        this.commentController,
        this.sendWidget,
        this.userImage,
        this.labelText,
        this.focusNode,
        this.errorText,
        this.withBorder = true,
        this.backgroundColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


        Expanded(child: child!),
        header ?? SizedBox.shrink(),

        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 20),
          child: Container(

            decoration: BoxDecoration(color: Colors.lightBlue,


                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            width: double.maxFinite,
            child: ListTile(
              tileColor: backgroundColor,

              leading: Container(
                height: 40.0,
                width: 40.0,
                decoration: new BoxDecoration(
                    color: Colors.black38,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(radius: 50, backgroundImage: userImage),
              ),
              title: Form(
                key: formKey,
                child: TextFormField(
                  // scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  maxLines: 4,
                  autofocus: true,
                  minLines: 1,
                  focusNode: focusNode,
                  cursorColor: textColor,
                  style: TextStyle(color: textColor),
                  controller: commentController,
                  decoration: InputDecoration(
                    enabledBorder: !withBorder
                        ? InputBorder.none
                        : UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor!),
                    ),
                    focusedBorder: !withBorder
                        ? InputBorder.none
                        : UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor!),
                    ),
                    border: !withBorder
                        ? InputBorder.none
                        : UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor!),
                    ),
                    labelText: labelText,
                    focusColor: textColor,
                    fillColor: textColor,
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  validator: (value) => value!.isEmpty ? errorText : null,
                ),
              ),
              trailing: GestureDetector(
                onTap: sendButtonMethod,
                child: sendWidget,
              ),
            ),
          ),
        )


      ],
    );
  }

  /// This method is used to parse the image from the URL or the path.
  /// `CommentBox.commentImageParser(imageURLorPath: 'url_or_path_to_image')`
  static ImageProvider commentImageParser({imageURLorPath}) {
    try {
      //check if imageURLorPath
      if (imageURLorPath is String) {
        if (imageURLorPath.startsWith('http')) {
          return NetworkImage(imageURLorPath);
        } else {
          return AssetImage(imageURLorPath);
        }
      } else {
        return imageURLorPath;
      }
    } catch (e) {
      //throw error
      throw Exception('Error parsing image: $e');
    }
  }
}
