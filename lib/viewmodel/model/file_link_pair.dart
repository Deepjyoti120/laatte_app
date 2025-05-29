import 'dart:io';

class FileLinkPair {
  // final String name;
  // final String type;
  final String? link;
  // final int size;
  // final String sizeText;
  final File? file;
  FileLinkPair({
    // required this.name,
    this.file,
    this.link,
    // required this.type,
    // required this.size,
    // required this.sizeText,
  });
  // make this model class from json
  factory FileLinkPair.fromJson(Map<String, dynamic> json) {
    return FileLinkPair(
      // name: json['name'] as String,
      // type: json['type'] as String,
      link: json['link'] as String?,
      // size: json['size'] as int,
      // sizeText: json['sizeText'] as String,
      // file: json['file'] as File,
    );
  }
  // make json from this model class
  Map<String, dynamic> toJson() {
    return {
      // 'name': name,
      // 'type': type,
      'link': link,
      // 'size': size,
      // 'sizeText': sizeText,
      // 'file': file,
    };
  }
}
