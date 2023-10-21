import 'package:flutter/material.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/model/administration.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/user_info.dart';
import 'package:nightlife/widgets/add_member.dart';
import 'package:provider/provider.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({super.key});

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: Administration(context.read<Club>().id).self,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          Administration administration = snapshot.data as Administration;
          return Provider.value(
            value: snapshot.data as Administration,
            child: Column(
              children: [
                const AddMember(),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemCount: administration.members.length,
                    itemBuilder: (context, index) {
                      String userId = administration.members.keys.elementAt(index);
                      UserInfo user = administration.members[userId]!;
                      return ListTile(
                        title: Text(user.username),
                        subtitle: Text(user.role.toString()),
                        trailing: user.role == Role.admin
                            ? null
                            : TextButton.icon(
                                label: const Text("Remove user"),
                                icon: const Icon(Icons.close),
                                onPressed: () => administration.removeMember(userId),
                              ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
