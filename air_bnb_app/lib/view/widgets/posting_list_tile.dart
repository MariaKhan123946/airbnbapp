import 'package:air_bnb_app/view/host/create_posting_screen.dart';
import 'package:flutter/material.dart';
 // Make sure to import the CreatePostingScreen.

class PostingListTile extends StatefulWidget {
  const PostingListTile({super.key});

  @override
  State<PostingListTile> createState() => _PostingListTileState();
}

class _PostingListTileState extends State<PostingListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 11.0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePostingScreen(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 8.0), // Added space between the icon and text
            Text(
              'Create a listing',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
