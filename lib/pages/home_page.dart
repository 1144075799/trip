import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
const APPBAR_SCROOL_OFFSET=100;
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls=[
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552986695585&di=b160ee7530ba30e185cf429f7352688c&imgtype=0&src=http%3A%2F%2Fpic171.nipic.com%2Ffile%2F20180702%2F24206353_113744600000_2.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552986695584&di=16fd3e424b3df2b5bb39d3023723b4b8&imgtype=0&src=http%3A%2F%2Fpic.lvmama.com%2Fuploads%2Fpc%2Fplace2%2F2015-04-25%2Fe781877e-56f4-4eb1-a30e-0e3ed6a8751a.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552986695584&di=75da2f1d503d5e661b98cc3467b414b2&imgtype=0&src=http%3A%2F%2Fimg0.ph.126.net%2FZrRJ7e9fAbzoBQmv1V-zRg%3D%3D%2F6597995555446859331.jpg'
  ];

   double appBarAlpha=0;

  _onScroll(offset){
    double alpha=offset/APPBAR_SCROOL_OFFSET;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }
    setState(() {
     appBarAlpha=alpha; 
    });
    // print(appBarAlpha);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
              onNotification: (ScrollNotification){
                if(ScrollNotification is ScrollUpdateNotification && ScrollNotification.depth==0){
                  // 滚动且是列表滚动的时候  第0个元素
                  _onScroll(ScrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context,int index){
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(title: Text('哈哈'),),
                  )
                ],
              ),
            )
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color:Colors.white),
              child: Center(
                child: Padding(padding: EdgeInsets.only(top:20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ) 
    );
  }
}