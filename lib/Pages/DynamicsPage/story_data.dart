// 聊天数据
class Story {
//  var id;
  String image;
  String title;
  String subTitle;
  String description;
  List imageList;

  Story(  this.image, this.title, this.subTitle , this.description, this.imageList);

  Map<String,dynamic> toMap() {
    var map = new Map<String,dynamic>();
    //  map ['id'] =id;
    map ['title'] = title;
    map ['subTitle'] = subTitle;
    map ['description'] = description;
    map ['imageList'] = imageList;
    return map;
  }

  static Story fromMap(Map<String,dynamic> map) {
    Story story;
    //   item.id = map ['id'];
    story.title = map ['title'];
    story.subTitle = map ['subTitle'];
    story.description = map['description'];
    story.imageList = map ['imageList'];
  }

  static List<Story> fromMapList(dynamic mapList) {
    List<Story> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  void addStory(image, title, subTitle, description,imageList){
  //  List<Story> storyData = List();
    Story story = new Story(image, title, subTitle, description,imageList);
    storyData.add(story);
    print("增加Story");
  }

  void show() {
   // List<Story> storyData = List();
    print(storyData.toList());
  }

  void delete(value) {
    storyData.remove(value);
  }

}
//Future<Story> addStory(image,title,subTitle,description) async {
//  Story story = new Story( image, title, subTitle, description);
//  story.title = title;
//  story.subTitle =subTitle;
//  story.description = description;
//
//}

List<Story> storyData = [
  new Story(
//      1,
      'images/cover/01.jpg',
      'zy',
      '2019-3-20',
      '真，善，美，需要被克制，以及带有一定程度的损伤、压抑和伤痛。自由的，放肆的，愉悦的，流泻的，到最后才会显示出某种失控的力量的变形。',
      [
        'images/story/01/01.jpg',
        'images/story/01/02.jpg',
        'images/story/01/03.jpg',
        'images/story/01/04.jpg',
        'images/story/01/05.jpg',
        'images/story/01/06.jpg',
      ]
  ),
//  new Story(
// //     2,
//      'images/cover/02.jpg',
//      '小女孩',
//      '2019-5-19',
//      '与他人干燥而清洁的关系，对聚合别离淡然，是旅途中需培养的与人相关的任务。或者说，习惯走在路途上的人，必须习惯无情。',
////      [
////        'images/story/02/01.jpg',
////        'images/story/02/02.jpg',
////        'images/story/02/03.jpg',
////        'images/story/02/04.jpg',
////        'images/story/02/05.jpg',
////      ]
//  ),
//  new Story(
// //     3,
//      'images/cover/03.jpg',
//      '白白',
//      '2019-5-20',
//      '再怎样经济和精神独立，为了情感和肉身有人相伴，就必须面对现实的琐碎庸俗，面对烦忧。面对分歧。',
//    //  []
//  ),
  new Story(
  //    4,
      'images/cover/04.jpg',
      '99',
      '2019-5-21',
      '每一个孩子身上，都有光亮与黑暗包裹。他们属于自我的果实，不是成人手中的泥土，也不是世人的祈祷。',
      []
  ),
  new Story(
  //    5,
      'images/cover/05.jpg',
      'lanye',
      '2019-5-23',
      '究其本质，情爱是一条通往各自生命深渊边际的路径。最终目的是趋近真相。',
      []
  ),
//  new Story(
//  //    6,
//      'images/cover/06.jpg',
//      'zyy',
//      '2019-5-27',
//      '如果命运的河流带来什么，那么就捞起什么。一路播种收获，不过如此而已。',
//    //  []
//  )
];