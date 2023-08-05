import 'package:flutter/material.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/chat/comps/animated_dialog.dart';
import 'package:pet_keeper_front/features/chat/comps/styles.dart';

class ChatWidgets {
  static Widget card({title, photo, time, subtitle, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: Padding(
            padding: const EdgeInsets.all(0.0),
            child: photo == ''
                ? const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ))
                : SizedBox(
                    height: 45,
                    width: 45,
                    child: ClipOval(
                      child: NetworkImageWidget(
                        borderRadiusImageFile: 50,
                        placeHolderBoxFit: BoxFit.cover,
                        networkImageBoxFit: BoxFit.cover,
                        imageUrl: photo,
                        progressIndicatorBuilder: const Center(
                          child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              )),
                        ),
                        placeHolder: "assets/images/profile_default.png",
                      ),
                    ),
                  ),
          ),
          title: Text(title),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static Widget circleProfile({onTap, name, photo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            photo == ''
                ? const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 45,
                    width: 45,
                    child: ClipOval(
                      child: NetworkImageWidget(
                        borderRadiusImageFile: 50,
                        placeHolderBoxFit: BoxFit.cover,
                        networkImageBoxFit: BoxFit.cover,
                        imageUrl: photo,
                        progressIndicatorBuilder: const Center(
                          child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              )),
                        ),
                        placeHolder: "assets/images/profile_default.png",
                      ),
                    ),
                  ),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  name,
                  style: const TextStyle(
                      height: 1.5, fontSize: 12, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
    );
  }

  static Widget messagesCard(bool check, message, time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (check) const Spacer(),
          if (!check)
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 10,
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
            ),
          if (!check)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: Styles.messagesCardStyle2(),
                      child: Text(
                        '$message',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '$time',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (check)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: Styles.messagesCardStyle(),
                      child: Text(
                        '$message',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '$time',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (check)
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 10,
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
            ),
          if (!check) const Spacer(),
        ],
      ),
    );
  }

  static messageField({required onSubmit, controller}) {
    final TextEditingController con = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: Styles.messageFieldCardStyle(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 80),
        child: TextField(
          controller: con,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: Styles.messageTextFieldStyle(
            onSubmit: () {
              onSubmit(con);
            },
          ),
        ),
      ),
    );
  }

  static searchBar(
    open,
  ) {
    return AnimatedDialog(
      height: open ? 400 : 0,
      width: open ? 400 : 0,
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageFieldCardStyle(),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
    );
  }
}
