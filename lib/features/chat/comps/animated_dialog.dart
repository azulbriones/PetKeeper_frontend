import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_keeper_front/features/chat/comps/widgets.dart';
import 'package:intl/intl.dart';

import '../chatpage.dart';

class AnimatedDialog extends StatefulWidget {
  final double height;
  final double width;

  const AnimatedDialog({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  final firestore = FirebaseFirestore.instance;
  final controller = TextEditingController();
  String search = '';
  bool show = false;

  @override
  void dispose() {
    show = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.height != 0) {
      Timer(const Duration(milliseconds: 200), () {
        setState(() {
          show = true;
        });
      });
    } else {
      setState(() {
        show = false;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                color: widget.width == 0
                    ? Colors.indigo.withOpacity(0)
                    : Colors.indigo.shade400,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.width == 0 ? 100 : 12),
                  bottomRight: Radius.circular(widget.width == 0 ? 100 : 12),
                  bottomLeft: Radius.circular(widget.width == 0 ? 100 : 12),
                )),
            child: widget.width == 0
                ? null
                : !show
                    ? null
                    : Column(
                        children: [
                          ChatWidgets.searchField(onChange: (a) {
                            setState(() {
                              search = a;
                            });
                          }),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: StreamBuilder(
                                  stream:
                                      firestore.collection('users').snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    List data = !snapshot.hasData
                                        ? []
                                        : snapshot.data!.docs
                                            .where((element) =>
                                                element['name']
                                                    .toString()
                                                    .contains(search) ||
                                                element['name']
                                                    .toString()
                                                    .contains(search))
                                            .where((element) => !element['id']
                                                .contains(FirebaseAuth
                                                    .instance.currentUser!.uid))
                                            .toList();
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, i) {
                                        Timestamp time = data[i]['date_time'];
                                        return ChatWidgets.card(
                                          title: data[i]['name'],
                                          photo: data[i]['profileUrl'],
                                          time: DateFormat('EEE hh:mm')
                                              .format(time.toDate()),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ChatPage(
                                                    id: data[i].id.toString(),
                                                    name: data[i]['name'],
                                                    photoUrl: data[i]
                                                        ['profileUrl'],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
