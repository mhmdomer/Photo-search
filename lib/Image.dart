class MyImage {

  String _lightImageUrl;
  String _bigImageUrl;

  MyImage(this._lightImageUrl, this._bigImageUrl);

  get light => _lightImageUrl;
  get big => _bigImageUrl;
  set light (String url) {
    this._lightImageUrl = url;
  }
  set big (String url) {
    this._bigImageUrl = url;
  }

  static List<MyImage> getImages(List hits) {
    List<MyImage> list = List();
    for(int i = 0; i < hits.length; i++) {
      list.add(MyImage(hits[i]['previewURL'], hits[i]['largeImageURL']));
    }
    return list;
  }

}