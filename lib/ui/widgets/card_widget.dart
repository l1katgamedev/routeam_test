import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final item;

  const CardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2D333B),
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF444C56), width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    item.name ?? 'There is no name',
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF539BD5)),
                  )),
              subtitle: Text(
                item.description ?? "There is no description",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    color: Color(0xFFFFFAA0),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Text(
                    item.stargazers.toString() ?? '0',
                    style: TextStyle(
                      color: Color(0xFFFFFAA0),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.person_outline_outlined,
                    color: Colors.white,
                  ),
                  Text(item.watchers.toString() ?? '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  Text(item.language ?? 'No language',
                      style: TextStyle(
                        color: Color(0xFF539BD5),
                        fontSize: 16,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
