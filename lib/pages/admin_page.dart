import 'package:flutter/material.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:provider/provider.dart';

import '../enums/type_of_music.dart';
import '../helpers/club_text_field.dart';
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
    description: '',
    location: '',
    typeOfMusic: [],
    contacts: {for (var element in Contact.values) element: ""},
    review: null,
    imageUrl: '',
  );

  late List<Club> clubs;
  late List<bool> typeOfMusicSelected;

  @override
  void initState() {
    super.initState();
    clubs = List.from(context.read<ClubList>().clubs);
    clubs.add(_club);
  }

  @override
  Widget build(BuildContext context) {
    typeOfMusicSelected = TypeOfMusic.values.map((type) => _club.typeOfMusic.contains(type)).toList();
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<Club>(
              value: _club,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(),
              focusColor: Colors.transparent,
              onChanged: (Club? club) => setState(() {
                _formKey.currentState!.reset();
                _club = club!;
              }),
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
          ),
          ClubTextField(
            labelText: "Club name",
            initialValue: _club.name,
            onChanged: (value) => _club.name = value,
            validate: true,
          ),
          ClubTextField(
            labelText: "Description",
            initialValue: _club.description,
            onChanged: (value) => _club.description = value,
          ),
          ClubTextField(
            labelText: 'Address',
            initialValue: _club.location,
            onChanged: (value) => _club.location = value,
            validate: true,
            icon: const Icon(Icons.location_pin),
          ),
          ClubTextField(
            labelText: 'Phone',
            initialValue: _club.contacts[Contact.phone] ?? '',
            onChanged: (value) => _club.contacts[Contact.phone] = value,
            icon: Icon(Contact.phone.icon),
          ),
          ClubTextField(
            labelText: 'Web',
            initialValue: _club.contacts[Contact.web] ?? '',
            onChanged: (value) => _club.contacts[Contact.web] = value,
            icon: const Icon(Icons.web),
          ),
          ClubTextField(
            labelText: 'Email',
            initialValue: _club.contacts[Contact.email] ?? '',
            onChanged: (value) => _club.contacts[Contact.email] = value,
            icon: const Icon(Icons.email),
          ),
          ClubTextField(
            labelText: 'Instagram',
            initialValue: _club.contacts[Contact.instagram] ?? '',
            onChanged: (value) => _club.contacts[Contact.instagram] = value,
            icon: Icon(Contact.instagram.icon),
          ),
          ClubTextField(
            labelText: 'Facebook',
            initialValue: _club.contacts[Contact.facebook] ?? '',
            onChanged: (value) => _club.contacts[Contact.facebook] = value,
            icon: Icon(Contact.facebook.icon),
          ),
          ClubTextField(
            labelText: 'Image url',
            initialValue: _club.imageUrl,
            onChanged: (value) => _club.imageUrl = value,
            icon: const Icon(Icons.image),
            maxLines: null,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ExpansionTile(
              title: Text("Types of music (${_club.typeOfMusic.join(', ')})"),
              children: TypeOfMusic.values.map((type) {
                int index = type.index;
                return DropdownMenuItem(
                  value: type,
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(type.toString()),
                    value: typeOfMusicSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        typeOfMusicSelected[index] = value!;
                        if (value) {
                          _club.typeOfMusic.add(type);
                        } else {
                          _club.typeOfMusic.remove(type);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
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
                      }
                    }
                    setState(() => loading = false);
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
