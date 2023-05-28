import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/search/models/state_servies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? medicelSelected;

  bool isSelected = false;
  int q = 8;
  TextEditingController? _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController?.addListener(() => setState(() {}));
  }

// *----------------------------------------------------
  // * function for filter our liste
  void updateListe(String value) {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 16, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tSearchHeadline,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const Text(
                    tMedical,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: tDefaultSize * 1.5,
              ),
              TypeAheadField(
                noItemsFoundBuilder: (context) => SizedBox(
                  height: 75,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.search_off,
                          size: 30,
                          color: Colors.blue,
                        ),
                        // ignore: unnecessary_const
                        const Text(tNoResultsFounds,
                            // ignore: unnecessary_const
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: Colors.white, // Color ta3 nafida
                    elevation: 4.0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                debounceDuration: const Duration(milliseconds: 400),
                textFieldConfiguration: TextFieldConfiguration(
                    textInputAction: TextInputAction.search,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        suffixIcon: _textEditingController!.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                onPressed: () =>
                                    _textEditingController!.clear(),
                                icon: const Icon(Icons.close)),
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: tSearch,
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.grey.shade900,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none))),
                suggestionsCallback: (value) {
                  return StateService.getSuggestions(value);
                },
                itemBuilder: (context, String suggestion) {
                  return Card(
                    color: Colors.blue.withOpacity(0.3),
                    elevation: 4,
                    margin: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                            minRadius: 20,
                            child: Image.asset(
                              "assets/logo/medicine.png",
                              height: 22,
                              width: 22,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              suggestion,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    medicelSelected = suggestion;
                    isSelected = true;
                  });
                },
              ),
              const SizedBox(
                height: tDefaultSize - 10,
              ),
              SizedBox(
                  child: isSelected
                      ? Card(
                          color: Colors.blue,
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Image.asset(
                              tmedicineLogo,
                              height: 20,
                              width: 20,
                            ),
                            title: Text(medicelSelected!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            subtitle: const Text('Nom commercial',
                                style: TextStyle(color: Colors.white)),
                            trailing: Text.rich(TextSpan(
                                text: '$q',
                                style: const TextStyle(color: Colors.green),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const TextSpan(
                                    text: ' boîte',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ])),
                          ),
                        )
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
