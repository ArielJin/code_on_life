





import 'dart:math';
import 'dart:typed_data';

import 'package:gbk2utf8/gbk2utf8.dart';

class RandomUtils {

  ///自动生成名字（中文）
  static String getRandomName(int len){

    String ret = "";

    for (int i = 0; i < len ; i++) {

      String str = null;
      int hightPos, lowPos;
      Random random = Random();
      hightPos = (176 + random.nextInt(39).abs());
      lowPos = (161 + random.nextInt(93).abs());
      Uint8List b = new Uint8List(2);
      b[0] = hightPos;
      b[1] = lowPos;

      str = gbk.decode(b);
      ret += str;

    }
    return ret;
  }

  ///生成随机用户名，数字和字母组成,
  static String getStringRandom(int len) {

    String val = "";

    Random random = Random();

    for (int i = 0; i < len; i++) {

      String charOrNum = random.nextInt(2)%2==0?"char":"num";

      if("char" == charOrNum) {

        int temp = random.nextInt(2) %2 == 0 ? 65 : 97;
        val += String.fromCharCode(random.nextInt(26) + temp);


      } else {
        val += random.nextInt(10).toString();

      }

    }

    return val;

  }


}