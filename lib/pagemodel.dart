import 'package:flutter/material.dart';

class PageModel{
  String _image;
  IconData _icons;
  String _title;
  String _description;

  PageModel(this._image, this._icons, this._title, this._description);

  String get description => _description;

  String get title => _title;

  IconData get icons => _icons;

  String get image => _image;


}