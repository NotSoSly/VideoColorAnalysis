import java.awt.*;

//Comparator for the ColorCounter class
class CountComparator implements Comparator {
  int compare(Object o1, Object o2) {
    double int1 = ((ColorCounter) o1).factor;
    double int2 = ((ColorCounter) o2).factor;
    return (int1<int2) ? -1 : (int1==int2) ? 0 : 1;
  }
}

//Alt Comparator for the ColorCounter class
//Sorts by Hue, Brightness, Saturation
class RGBComparator implements Comparator {
  int compare(Object o1, Object o2) {
    int aR = (((ColorCounter) o1).farbe >> 16) & 0xFF;;
    int aG = (((ColorCounter) o1).farbe >> 8) & 0xFF;
    int aB = ((ColorCounter) o1).farbe& 0xFF;
    float[] hsv1 = new float[3];
    Color.RGBtoHSB(aR, aG, aB, hsv1);
    
    int bR = (((ColorCounter) o2).farbe >> 16) & 0xFF;;
    int bG = (((ColorCounter) o2).farbe >> 8) & 0xFF;
    int bB = ((ColorCounter) o2).farbe& 0xFF;
    float[] hsv2 = new float[3];
    Color.RGBtoHSB(bR, bG, bB, hsv2);
    
    //return (hsv1[0]<hsv2[0]) ? -1 : (hsv1[0]==hsv2[0]) ? 0 : 1;
    return 
    (hsv1[0]<hsv2[0]) ? -1 : 
    (hsv1[0]>hsv2[0]) ? 1 : 
    (hsv1[2]<hsv2[2]) ? -1 : 
    (hsv1[2]>hsv2[2]) ? 1 : 
    (hsv1[1]<hsv2[1]) ? -1 : 
    (hsv1[1]>hsv2[1]) ? 1 :
    0;
  }
}

color avgcolor;
color atacolor=color(127,127,127);
color anticolor;
color anticolorlow;
color anticolorhigh;

void getavgcolor(){
  float avgred=0;
  float avggreen=0;
  float avgblue=0;

  for(int i=0; i<video.pixels.length;i++){
    avgred+=red(video.pixels[i]);
    avggreen+=green(video.pixels[i]);
    avgblue+=blue(video.pixels[i]);
  }
  avgred=avgred/video.pixels.length;
  avggreen=avggreen/video.pixels.length;
  avgblue=avgblue/video.pixels.length;
  avgcolor=color(round(avgred),round(avggreen),round(avgblue));
  atacolor=color(red(atacolor)+(red(avgcolor)-red(atacolor))/frameCount,green(atacolor)+(green(avgcolor)-green(atacolor))/frameCount,blue(atacolor)+(blue(avgcolor)-blue(atacolor))/frameCount);
  colorMode(HSB, 360, 100, 100);
  anticolor=color(360-hue(atacolor),200-saturation(atacolor),200-brightness(atacolor));
  anticolorlow=color(360-hue(atacolor)-30,200-saturation(atacolor),200-brightness(atacolor)-30);
  anticolorhigh=color(360-hue(atacolor)+30,200-saturation(atacolor),200-brightness(atacolor)+30);
  colorMode(RGB,255,255,255);
}
