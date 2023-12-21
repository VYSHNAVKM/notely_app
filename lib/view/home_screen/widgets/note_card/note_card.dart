import 'package:flutter/material.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';

class NoteCard extends StatefulWidget {
  const NoteCard(
      {super.key,
      this.onEditPressed,
      this.onDeletePressed,
      required this.category,
      required this.title,
      required this.description,
      required this.date});

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final String category;
  final String title;
  final String description;
  final String date;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: primarycolorlight, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.category,
                        style: subtextdark,
                      ),
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: widget.onEditPressed,
                        icon: Icon(
                          Icons.edit,
                          color: primarycolordark,
                        )),
                    IconButton(
                        onPressed: widget.onDeletePressed,
                        icon: Icon(
                          Icons.delete,
                          color: primarycolordark,
                        ))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: maintextdark,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                widget.description,
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
                  widget.date,
                  style: subtextdark,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}