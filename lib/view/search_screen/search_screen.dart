import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:notely_app/controller/note_card_controller.dart';
import 'package:notely_app/controller/search_controller.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';
import 'package:notely_app/view/home_screen/widgets/note_card_fullview/note_card_fullview.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var noteCardController = context.read<NoteCardController>();
    var searchScreenController = context.read<SearchScreenController>();

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: primarycolordark,
            )),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50, left: 50, right: 10),
          child: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {});
              }
              noteCardController.filterNotes(value);
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "Search for Notes",
              hintStyle: subtextdark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<NoteCardController>(
        builder: (context, noteController, _) {
          if (searchController.text.isEmpty) {
            return FutureBuilder<List<String>>(
              future: searchScreenController.getRecentSearches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Lottie.asset('assets/animation/empty.json'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text("Recent Searches", style: maintextdark),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recentSearch = snapshot.data![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    searchController.text = recentSearch;
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(recentSearch, style: subtextdark),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: primarycolordark,
                                        ),
                                        onPressed: () async {
                                          await searchScreenController
                                              .removeRecentSearch(recentSearch);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            // Show filtered notes when a search query is entered
            final filteredNotes = noteController.notes
                .where((note) => note.title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
                .toList();
            if (filteredNotes.isEmpty) {
              // Show "Not Found" message when no search results
              return Center(
                child: Text('No Data', style: maintextdark),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoteCardFullView(
                                      category: note.category,
                                      title: note.title,
                                      description: note.description,
                                      date: DateFormat('dd-MM-yyyy')
                                          .format(note.date),
                                    )));
                            // Add the searched query to recent searches when a note is selected
                            searchScreenController
                                .addRecentSearch(searchController.text);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primarycolorlight,
                                border: Border(
                                    left: BorderSide(
                                  color: primarycolordark,
                                  width: 7,
                                )),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.purple,
                                              Colors.red
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            note.category,
                                            style: subtextlight,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  note.title,
                                  style: maintextdark,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Text(
                                    note.description,
                                    textAlign: TextAlign.justify,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: subtextdark,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(note.date),
                                      style: subtextdark,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
