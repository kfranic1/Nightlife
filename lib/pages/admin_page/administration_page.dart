import 'package:flutter/material.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/model/administration.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/widgets/add_member.dart';
import 'package:provider/provider.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({super.key});

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> with AutomaticKeepAliveClientMixin {
  final Map<String, Person> _members = {};

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: Administration(context.read<Club>().id).self,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        Administration administration = snapshot.data as Administration;

        _members.removeWhere((key, value) => !administration.members.contains(key));

        return Provider.value(
          value: administration,
          child: Column(
            children: [
              const AddMember(),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: administration.members.length,
                  itemBuilder: (context, index) {
                    String userId = administration.members[index];
                    return FutureBuilder(
                        future: _members.containsKey(userId) ? Future.value(_members[userId]!) : Person.tryGet(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) return const ListTile(title: LinearProgressIndicator());
                          Person user = snapshot.data as Person;
                          _members[userId] = user;
                          return ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.adminData!.role.toString()),
                            trailing: user.adminData!.role == Role.admin
                                ? null
                                : TextButton.icon(
                                    label: const Text("Remove user"),
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      administration.removeMember(user.id);
                                      _members.remove(user.id); // Update local state
                                    },
                                  ),
                          );
                        });
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
