import 'package:flutter/material.dart';

import '../data/book.dart';

//This Widget Implements the screen where the user can read the book
class BookRead extends StatefulWidget {
  const BookRead({super.key, required this.book});

  final Book book;

  @override
  State<BookRead> createState() => _BookReadState();
}

class _BookReadState extends State<BookRead> {
  //Index of the current page being viewed by the user.
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (widget.book.pages.isEmpty)
            ? const Center(child: Text("This Book is Empty")) //If book has no pages
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              //Reduce page number, only if valid
                              if (index > 0) {
                                index--;
                              }
                            });
                          },
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          "Page ${index+1}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //Increase page number, only if valid
                              setState(() {
                                if (index + 1 < widget.book.pages.length) {
                                  index++;
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                    //Display content of the selected page
                    Text(
                      widget.book.pages[index],
                      softWrap: true,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
