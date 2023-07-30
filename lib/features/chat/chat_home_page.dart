import 'package:pet_keeper_front/features/chat/logics/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chatpage.dart';
import 'comps/styles.dart';
import 'comps/widgets.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);
  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Functions.updateAvailability();
    super.initState();
  }

  final firestore = FirebaseFirestore.instance;
  bool open = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.indigo.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Usuarios recientes',
                              style: Styles.h1(),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  open == true ? open = false : open = true;
                                });
                              },
                              icon: Icon(
                                open == true
                                    ? Icons.close_rounded
                                    : Icons.search_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: StreamBuilder(
                          stream: firestore.collection('rooms').snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            List data = !snapshot.hasData
                                ? []
                                : snapshot.data!.docs
                                    .where((element) => element['users']
                                        .toString()
                                        .contains(FirebaseAuth
                                            .instance.currentUser!.uid))
                                    .toList();
                            while (snapshot.connectionState !=
                                    ConnectionState.active &&
                                snapshot.connectionState !=
                                    ConnectionState.done) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, i) {
                                List users = data[i]['users'];
                                var friend = users.where((element) =>
                                    element !=
                                    FirebaseAuth.instance.currentUser!.uid);
                                var user = friend.isNotEmpty
                                    ? friend.first
                                    : users
                                        .where((element) =>
                                            element ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .first;
                                return FutureBuilder(
                                    future: firestore
                                        .collection('users')
                                        .doc(user)
                                        .get(),
                                    builder: (context, AsyncSnapshot snap) {
                                      return !snap.hasData
                                          ? Container()
                                          : ChatWidgets.circleProfile(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ChatPage(
                                                        id: user,
                                                        name: snap.data['name'],
                                                        photoUrl: snap
                                                            .data['profileUrl'],
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              name: snap.data['name'],
                                              photo: snap.data['profileUrl']);
                                    });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Chats',
                              style: Styles.h1().copyWith(color: Colors.indigo),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder(
                                stream:
                                    firestore.collection('rooms').snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  List data = !snapshot.hasData
                                      ? []
                                      : snapshot.data!.docs
                                          .where((element) => element['users']
                                              .toString()
                                              .contains(FirebaseAuth
                                                  .instance.currentUser!.uid))
                                          .toList();
                                  while (snapshot.connectionState !=
                                          ConnectionState.active &&
                                      snapshot.connectionState !=
                                          ConnectionState.done) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, i) {
                                      List users = data[i]['users'];
                                      var friend = users.where((element) =>
                                          element !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                      var user = friend.isNotEmpty
                                          ? friend.first
                                          : users
                                              .where((element) =>
                                                  element ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              .first;
                                      return FutureBuilder(
                                          future: firestore
                                              .collection('users')
                                              .doc(user)
                                              .get(),
                                          builder:
                                              (context, AsyncSnapshot snap) {
                                            return !snap.hasData
                                                ? Container()
                                                : ChatWidgets.card(
                                                    title: snap.data['name'],
                                                    photo:
                                                        snap.data['profileUrl'],
                                                    subtitle: data[i]
                                                        ['last_message'],
                                                    time: DateFormat('hh:mm a')
                                                        .format(data[i][
                                                                'last_message_time']
                                                            .toDate()),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return ChatPage(
                                                              id: user,
                                                              name: snap
                                                                  .data['name'],
                                                              photoUrl: snap
                                                                      .data[
                                                                  'profileUrl'],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                          });
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open)
          ],
        ),
      ),
    );
  }
}
