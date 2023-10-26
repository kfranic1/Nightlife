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

  Role role = Role.ambasador;
  Person? member;
  bool loadingMember = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Administration administration = context.watch<Administration>();
    return ExpansionTile(
      title: const Text("Add user"),
      childrenPadding: const EdgeInsets.all(8),
      children: [
        TextFormField(
          key: _key,
          controller: _controller,
          decoration: InputDecoration(
            labelText: "user id",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            suffix: TextButton(
              onPressed: loadingMember
                  ? null
                  : () async {
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
              child: const Text("Load"),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) return "ID can't be empty";
            if (administration.members.contains(value)) return "This user is already added.";
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  administration.addMember(
                    userId: member!.id,
                    clubId: context.read<Club>().id,
                    clubName: context.read<Club>().name,
                    role: role,
                  );
                  setState(() {
                    member = null;
                    _controller.clear();
                  });
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "Add member "),
                      TextSpan(text: member!.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: "\nwith role "),
                      TextSpan(text: role.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
