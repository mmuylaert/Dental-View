import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Providers/db_provider.dart';
import '../../../Providers/detch_polls_provider.dart';
import '../../../Screens/BottomNavPages/Diagnostics/add_diagnostic.dart';
import '../../../Styles/colors.dart';
import '../../../Utils/dynamic_utils.dart';
import '../../../Utils/message.dart';
import '../../../Utils/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFetched = false;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FetchPollsProvider>(builder: (context, polls, child) {
        if (_isFetched == false) {
          polls.fetchAllPolls();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return SafeArea(
          child: polls.isLoading == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : polls.pollsList.isEmpty
              ? const Center(
            child: Text('Sem diagnósticos no momento'),
          )
              : CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      ...List.generate(polls.pollsList.length,
                              (index) {
                            final DocumentSnapshot<Object?> data = polls.pollsList[index];

                            log(data.data().toString());
                            final Map author = data['author'];
                            final Map poll = data['poll'];
                            final Timestamp date = data['dateCreated'];

                            final List voters = poll['voters'];

                            final List<dynamic> options = poll['options'];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: AppColors.grey),
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    contentPadding:
                                    const EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          author['profileImage']),
                                    ),
                                    title: Text(author['name']),
                                    subtitle: Text(DateFormat.yMEd()
                                        .format(date.toDate())),
                                    trailing: IconButton(
                                        onPressed: () {
                                          ///
                                          DynamicLinkProvider()
                                              .createLink(data.id)
                                              .then(Share.share);
                                        },
                                        icon: const Icon(Icons.share)),
                                  ),
                                  Text(poll['question']),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ...List.generate(options.length,
                                          (index) {
                                        final dataOption = options[index];
                                        return Consumer<DbProvider>(
                                            builder: (context, vote, child) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                    (_) {
                                                  if (vote.message != '') {
                                                    if (vote.message.contains(
                                                        'Vote Recorded')) {
                                                      success(context,
                                                          message: vote.message);
                                                      polls.fetchAllPolls();
                                                      vote.clear();
                                                    } else {
                                                      error(context,
                                                          message: vote.message);
                                                      vote.clear();
                                                    }
                                                  }
                                                },
                                              );
                                              return GestureDetector(
                                                onTap: () {
                                                  log(user!.uid);

                                                  ///Update vote
                                                  if (voters.isEmpty) {
                                                    log('No vote');
                                                    vote.votePoll(
                                                        pollId: data.id,
                                                        pollData: data,
                                                        previousTotalVotes:
                                                        poll['total_votes'],
                                                        seletedOptions:
                                                        dataOption['answer']);
                                                  } else {
                                                    final isExists =
                                                    voters.firstWhere(
                                                            (element) =>
                                                        element['uid'] ==
                                                            user!.uid,
                                                        orElse: () {});
                                                    if (isExists == null) {
                                                      log('User does not exist');
                                                      vote.votePoll(
                                                          pollId: data.id,
                                                          pollData: data,
                                                          previousTotalVotes:
                                                          poll['total_votes'],
                                                          seletedOptions:
                                                          dataOption[
                                                          'answer']);
                                                      //
                                                    } else {
                                                      error(context,
                                                          message:
                                                          'You have already voted');
                                                    }
                                                    print(isExists.toString());
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Stack(
                                                          children: <Widget>[
                                                            LinearProgressIndicator(
                                                              minHeight: 30,
                                                              value: dataOption[
                                                              'percent'] /
                                                                  100,
                                                              backgroundColor:
                                                              AppColors.white,
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  10),
                                                              height: 30,
                                                              child: Text(
                                                                  dataOption[
                                                                  'answer']),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          "${dataOption["percent"]}%")
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                  Text(
                                      "Total votes : ${poll["total_votes"]}")
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void success(BuildContext context, {required String message}) {}
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User?>('user', user));
  }
}