import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/chat/comps/styles.dart';
import 'package:pet_keeper_front/features/chat/comps/widgets.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String name;
  final String photoUrl;
  const ChatPage(
      {Key? key, required this.id, required this.name, required this.photoUrl})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var roomId;
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.photoUrl != ''
                ? SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: NetworkImageWidget(
                        borderRadiusImageFile: 50,
                        placeHolderBoxFit: BoxFit.cover,
                        networkImageBoxFit: BoxFit.cover,
                        imageUrl: widget.photoUrl,
                        progressIndicatorBuilder: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        placeHolder: "assets/images/profile_default.png",
                      ),
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    )),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                StreamBuilder(
                  stream:
                      firestore.collection('users').doc(widget.id).snapshots(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return !snapshot.hasData
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Last seen: ${DateFormat('hh:mm a').format(snapshot.data!['date_time'].toDate())}',
                              style: Styles.h1().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white70,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: Styles.friendsBox(),
                child: StreamBuilder(
                    stream: firestore.collection('rooms').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<QueryDocumentSnapshot?> allData = snapshot
                              .data!.docs
                              .where((element) =>
                                  element['users'].contains(widget.id) &&
                                  element['users'].contains(
                                      FirebaseAuth.instance.currentUser!.uid))
                              .toList();
                          QueryDocumentSnapshot? data =
                              allData.isNotEmpty ? allData.first : null;
                          if (data != null) {
                            roomId = data.id;
                          }
                          return data == null
                              ? Container()
                              : StreamBuilder(
                                  stream: data.reference
                                      .collection('messages')
                                      .orderBy('datetime', descending: true)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snap) {
                                    return !snap.hasData
                                        ? Container()
                                        : ListView.builder(
                                            itemCount: snap.data!.docs.length,
                                            reverse: true,
                                            itemBuilder: (context, i) {
                                              return ChatWidgets.messagesCard(
                                                  snap.data!.docs[i]
                                                          ['send_by'] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                  snap.data!.docs[i]['message'],
                                                  DateFormat('hh:mm a').format(
                                                      snap.data!
                                                          .docs[i]['datetime']
                                                          .toDate()));
                                            },
                                          );
                                  });
                        } else {
                          return Center(
                            child: Text(
                              'No hay mensajes',
                              style: Styles.h1()
                                  .copyWith(color: Colors.indigo.shade400),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        );
                      }
                    }),
              ),
            ),
            Container(
              color: Colors.white,
              child: ChatWidgets.messageField(onSubmit: (controller) {
                if (controller.text != '') {
                  if (roomId != null) {
                    Map<String, dynamic> data = {
                      'message': controller.text.trim(),
                      'send_by': FirebaseAuth.instance.currentUser!.uid,
                      'datetime': DateTime.now(),
                    };
                    firestore.collection('rooms').doc(roomId).update({
                      'last_message_time': DateTime.now(),
                      'last_message': controller.text,
                    });
                    firestore
                        .collection('rooms')
                        .doc(roomId)
                        .collection('messages')
                        .add(data);
                  } else {
                    Map<String, dynamic> data = {
                      'message': controller.text.trim(),
                      'send_by': FirebaseAuth.instance.currentUser!.uid,
                      'datetime': DateTime.now(),
                    };
                    firestore.collection('rooms').add({
                      'users': [
                        widget.id,
                        FirebaseAuth.instance.currentUser!.uid,
                      ],
                      'last_message': controller.text,
                      'last_message_time': DateTime.now(),
                    }).then((value) {
                      value.collection('messages').add(data);
                    });
                  }
                }

                controller.clear();
              }),
            )
          ],
        ),
      ),
    );
  }
}
