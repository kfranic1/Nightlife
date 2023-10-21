import 'package:flutter/material.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/model/administration.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/widgets/dropdown_filter.dart';
import 'package:provider/provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  late Administration administration;

  Role role = Role.ambasador;
  Person? member;
  bool loadingMember = false;

  @override
  Widget build(BuildContext context) {
    administration = context.watch<Administration>();
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text("Add user"),
        childrenPadding: const EdgeInsets.all(8),
        children: [
          TextFormField(
            key: _key,
            controller: _controller,
            decoration: InputDecoration(
              labelText: "user id",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              suffix: loadingMember
                  ? const LinearProgressIndicator()
                  : TextButton(
                      child: const Text("Load"),
                      onPressed: () async {
                        if (_key.currentState?.validate() == false) return;
                        setState(() => loadingMember = true);
                        member = await Person.tryGet(_controller.text);
                        if (member == null && context.mounted)
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('A user with this ID doesn\'t exist'),
                            duration: Duration(seconds: 2),
                          ));
                        setState(() => loadingMember = false);
                      },
                    ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) return "ID can't be empty";
              if (administration.members.containsKey(value)) return "This user is already added.";
              return null;
            },
          ),
          const SizedBox(height: 10),
          DropdownFilter<Role>(
            label: "Role",
            value: role,
            onChanged: (Role? role) => setState(() => this.role = role!),
            onClear: null,
            items: Map.fromIterable(
              Role.values.toList(),
              key: (element) => element,
              value: (element) => element.toString(),
            ),
          ),
          if (member != null)
            Row(
              children: [
                Text(member!.name),
                TextButton(
                  onPressed: () {
                    administration.addMember(member!, context.read<Club>(), role);
                    setState(() {
                      member = null;
                      _controller.clear();
                    });
                  },
                  child: const Text("Add member"),
                )
              ],
            ),
        ],
      ),
    );
  }
}
