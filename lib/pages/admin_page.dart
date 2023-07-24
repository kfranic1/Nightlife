import 'package:flutter/material.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:provider/provider.dart';

import '../model/club.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Club _club = Club(
    id: '',
    name: 'New Club',
    location: '',
    typeOfMusic: [],
    contacts: {},
    review: null,
    imageUrl: '',
  );

  late List<Club> clubs;

  @override
  void initState() {
    ClubList clubList = context.read<ClubList>();
    clubs = List.from(clubList.clubs);
    clubs.add(_club);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          DropdownButton<Club>(
            value: _club,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(),
            focusColor: Colors.transparent,
            onChanged: (Club? club) => setState(() => _club = club!),
            items: clubs
                .map((club) => DropdownMenuItem<Club>(
                      value: club,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          club.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          ClubTextField(
            labelText: "Club name",
            initialValue: _club.name,
            onChanged: (value) => _club.name = value,
            validate: true,
          ),
          ClubTextField(
            labelText: 'Address',
            initialValue: _club.location,
            onChanged: (value) => _club.location = value,
            validate: true,
          ),
          ClubTextField(
            labelText: 'Phone',
            initialValue: _club.contacts[Contact.phone] ?? '',
            onChanged: (value) => _club.contacts[Contact.phone] = value,
          ),
          ClubTextField(
            labelText: 'Web',
            initialValue: _club.contacts[Contact.web] ?? '',
            onChanged: (value) => _club.contacts[Contact.web] = value,
          ),
          ClubTextField(
            labelText: 'Email',
            initialValue: _club.contacts[Contact.email] ?? '',
            onChanged: (value) => _club.contacts[Contact.email] = value,
          ),
          ClubTextField(
            labelText: 'Instagram',
            initialValue: _club.contacts[Contact.instagram] ?? '',
            onChanged: (value) => _club.contacts[Contact.instagram] = value,
          ),
          ClubTextField(
            labelText: 'Facebook',
            initialValue: _club.contacts[Contact.facebook] ?? '',
            onChanged: (value) => _club.contacts[Contact.facebook] = value,
          ),
          ClubTextField(
            labelText: 'Image url',
            initialValue: _club.imageUrl,
            onChanged: (value) => _club.imageUrl = value,
          ),
          FloatingActionButton(
            onPressed: loading
                ? null
                : () async {
                    setState(() => loading = true);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        if (_club.id.isEmpty)
                          await Club.createClub(_club);
                        else
                          await Club.updateClub(_club);
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operation successful')));
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: ${error.toString()}')));
                      } finally {
                        setState(() => loading = false);
                      }
                    }
                  },
            child: loading ? const CircularProgressIndicator() : const Icon(Icons.save),
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}

class ClubTextField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final void Function(String)? onChanged;
  final bool validate;

  const ClubTextField({
    Key? key,
    required this.labelText,
    required this.initialValue,
    this.onChanged,
    this.validate = false,
  }) : super(key: key);

  @override
  State<ClubTextField> createState() => _ClubTextFieldState();
}

class _ClubTextFieldState extends State<ClubTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(ClubTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: widget.onChanged,
      validator: widget.validate ? (value) => value == null || value.isEmpty ? "Element can't be empty" : null : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
