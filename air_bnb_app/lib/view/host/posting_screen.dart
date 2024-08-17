import 'package:air_bnb_app/view/host/create_posting_screen.dart';
import 'package:air_bnb_app/view/widgets/posting_list_tile.dart';
import 'package:flutter/material.dart';

class MyPosting extends StatefulWidget {
  const MyPosting({super.key});

  @override
  State<MyPosting> createState() => _MyPostingState();
}

class _MyPostingState extends State<MyPosting> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(
        top: 25),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 0, 26, 26),
        child: InkResponse(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.2,

              )
            ),

            child: PostingListTile(

            ),
          ),
        ),
      ),
    );
  }
}
