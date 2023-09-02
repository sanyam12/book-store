//Implementation of Data Class for Book
class Book {
  String name = ""; // Name of the Book.
  String link = ""; // This is the URL for the image of the Book.
  String description = ""; //Description of the Book.
  int price = 0; // Price of the Book
  List<String> pages = []; //The text content of each page of a book is stored here.

  //Constructor for the class Book
  Book({
    required this.name,
    required this.link,
    required this.price,
    required this.description,
    required this.pages
  });

  //Implementation to build Book from the JSON object sent by server
  factory Book.fromJson(Map<String, dynamic> json) {
    List<String> list = []; //If the book is empty, the list remains empty
    if(json["pages"]!=null){
      list = (json["pages"] as List).map((e) => e.toString()).toList();
    }
    return Book(
        name: json['name'],
        link: json['link'],
        price: int.parse(json['price'].toString()),
        description: json["description"],
        pages: list
    );
  }

  //Implementation to build JSON object from Book object.
  Map toJson() => {
    'name': name,
    'link': link,
    "description": description,
    "price": price,
    "pages":pages
  };
}
