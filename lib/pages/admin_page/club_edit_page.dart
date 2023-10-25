import 'package:flutter/material.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/enums/social_media.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/contact_extension.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/extensions/social_media_extension.dart';
import 'package:nightlife/helpers/club_text_field.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/work_day.dart';
import 'package:nightlife/pages/admin_page/form_button.dart';
import 'package:provider/provider.dart';

class ClubEditPage extends StatefulWidget {
  const ClubEditPage({super.key});

  @override
  State<ClubEditPage> createState() => _ClubEditPageState();
}

class _ClubEditPageState extends State<ClubEditPage> {
  final timePattern = RegExp(r'^([01][0-9]|2[0-3]):[0-5][0-9] - ([01][0-9]|2[0-3]):[0-5][0-9]$');
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late Club _club;

  @override
  Widget build(BuildContext context) {
    _club = context.read<Club>();
    return SingleChildScrollView(
      child: Form(
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
              labelText: "Description Croatian",
              initialValue: _club.descriptionHr,
              onChanged: (value) => _club.descriptionHr = value,
              maxLines: null,
            ),
            ClubTextField(
              labelText: "Description English",
              initialValue: _club.descriptionEn,
              onChanged: (value) => _club.descriptionEn = value,
              maxLines: null,
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
              icon: Icon(Contact.web.icon),
            ),
            ClubTextField(
              labelText: 'Email',
              initialValue: _club.contacts[Contact.email] ?? '',
              onChanged: (value) => _club.contacts[Contact.email] = value,
              icon: Icon(Contact.email.icon),
            ),
            ClubTextField(
              labelText: 'Instagram',
              initialValue: _club.socialMedia[SocialMedia.instagram] ?? '',
              onChanged: (value) => _club.socialMedia[SocialMedia.instagram] = value,
              icon: Icon(SocialMedia.instagram.icon),
            ),
            ClubTextField(
              labelText: 'Facebook',
              initialValue: _club.socialMedia[SocialMedia.facebook] ?? '',
              onChanged: (value) => _club.socialMedia[SocialMedia.facebook] = value,
              icon: Icon(SocialMedia.facebook.icon),
            ),
            ClubTextField(
              labelText: 'Image url',
              initialValue: _club.imageUrl,
              onChanged: (value) => _club.imageUrl = value,
              icon: const Icon(Icons.image),
              maxLines: null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text("Work days"),
                  children: _club.workHours.keys.toList().rearrange((p0, p1) => p0.index - p1.index).map((dayOfWeek) {
                    WorkDay day = _club.workHours[dayOfWeek]!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 80, child: Text(dayOfWeek.name)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                width: 200,
                                child: ClubTextField(
                                  initialValue: day.hours,
                                  labelText: "hh:mm - hh:mm",
                                  onChanged: (value) => day.hours = value,
                                  validate: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      if (day.typeOfMusic.isNotEmpty) return "Missing working hours";
                                      return null;
                                    }
                                    if (!timePattern.hasMatch(value)) return "The time is not in correct format";
                                    if (day.typeOfMusic.isEmpty) return "Select at least one genre";
                                    if (day.typeOfMusic.length > 3) return "Select at most 3 genres";
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text("Types of music (${day.typeOfMusic.join(', ')})"),
                            children: TypeOfMusic.values.toList().rearrange((p0, p1) => p0.name.compareTo(p1.name)).map((type) {
                              return CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(type.toString()),
                                value: day.typeOfMusic.contains(type),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      day.typeOfMusic.add(type);
                                    } else {
                                      day.typeOfMusic.remove(type);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormButton(
                action: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await FormButton.tryAction(context, () async {
                      if (_club.id.isEmpty)
                        await Club.createClub(_club);
                      else
                        await Club.updateClub(_club);
                    });
                  }
                },
                label: "Save",
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
