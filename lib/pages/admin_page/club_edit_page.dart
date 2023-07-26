import 'package:flutter/material.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:nightlife/pages/admin_page/form_button.dart';
import 'package:provider/provider.dart';

import '../../enums/type_of_music.dart';
import '../../helpers/club_text_field.dart';
import '../../model/club.dart';

class ClubEditPage extends StatefulWidget {
  const ClubEditPage({super.key});

  @override
  State<ClubEditPage> createState() => _ClubEditPageState();
}

class _ClubEditPageState extends State<ClubEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late List<bool> typeOfMusicSelected;
  late Club _club;

  @override
  Widget build(BuildContext context) {
    _club = context.watch<Club>();
    typeOfMusicSelected = TypeOfMusic.values.map((type) => _club.typeOfMusic.contains(type)).toList();
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
            decoration: DefaultBoxDecoration(),
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
          FormButton(
              formStateKey: _formKey,
              action: () async {
                if (_club.id.isEmpty)
                  await Club.createClub(_club);
                else
                  await Club.updateClub(_club);
              }),
        ].addPadding(),
      ),
    );
  }
}
