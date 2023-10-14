import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Providers/db_provider.dart';
import '../../../Screens/BottomNavPages/Diagnostics/add_diagnostic.dart';
import '../../../Styles/colors.dart';
import '../../../Utils/message.dart';
import '../../../Utils/router.dart';
import 'package:provider/provider.dart';

import '../../../Providers/detch_polls_provider.dart';

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({super.key});

  @override
  State<DiagnosticsPage> createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FetchPollsProvider>(builder: (context, polls, child) {
        if (_isFetched == false) {
          polls.fetchUserPolls();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return SafeArea(
          child: polls.isLoading == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : polls.userPollsList.isEmpty
              ? const Center(
            child: Text("Sem diagnosticos no momento"),
          )
              : CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ...List.generate(polls.userPollsList.length,
                              (index) {
                            final data = polls.userPollsList[index];

                            log(data.data().toString());
                            Map author = data["author"];
                            Map poll = data["poll"];
                            Timestamp date = data["dateCreated"];

                            List<dynamic> options = poll["options"];

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
                                children: [
                                  ListTile(
                                    contentPadding:
                                    const EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          author["profileImage"]),
                                    ),
                                    title: Text(author["name"]),
                                    subtitle: Text(DateFormat.yMEd()
                                        .format(date.toDate())),
                                    trailing: Consumer<DbProvider>(
                                        builder:
                                            (context, delete, child) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                (_) {
                                              if (delete.message != "") {
                                                if (delete.message.contains(
                                                    "Diagnóstico Deletado")) {
                                                  success(context,
                                                      message:
                                                      delete.message);
                                                  polls.fetchUserPolls();
                                                  delete.clear();
                                                } else {
                                                  error(context,
                                                      message:
                                                      delete.message);
                                                  delete.clear();
                                                }
                                              }
                                            },
                                          );
                                          return IconButton(
                                              onPressed:
                                              delete.deleteStatus == true
                                                  ? null
                                                  : () {
                                                ///
                                                delete.deletePoll(
                                                    pollId:
                                                    data.id);
                                              },
                                              icon: delete.deleteStatus ==
                                                  true
                                                  ? const CircularProgressIndicator()
                                                  : const Icon(Icons.delete));
                                        }),
                                  ),
                                  Text(poll["question"]),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ...List.generate(options.length,
                                          (index) {
                                        final dataOption = options[index];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Stack(
                                                  children: [
                                                    LinearProgressIndicator(
                                                      minHeight: 30,
                                                      value: dataOption[
                                                      "percent"] /
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
                                                          horizontal: 10),
                                                      height: 30,
                                                      child: Text(dataOption[
                                                      "answer"]),
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
                                        );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextPage(context, Questionnaire());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void success(BuildContext context, {required String message}) {}
}