import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Collections; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class coasters extends PApplet {

/**
* Laurie Waxman
* 12.02.2015
* Prototyping 
*
* Data from: 
* http://www5.statcan.gc.ca/cansim/a47
**/




ArrayList<Province> provinces;

public void setup(){
	size(800,800);
}

public void draw(){

	provinces = loadData();
}

public class Province {
  String name;

  int[] years = new int[20];
  float[] spiritCsmp = new float[20];
  float[] wineCsmp = new float[20];
  float[] beerCsmp = new float[20];

  int colour;

  public String returnName() {
    return name;
  }

}


public ArrayList<Province> loadData() {
  Table alcConsumption;
  Table population;
  int yr = 1993;
  int rowCount = 0;

  HashMap<String, Province> provinces = new HashMap<String, Province>();

  alcConsumption = loadTable("alcoholConsumptionCAN__new.csv", "header");
  // population = loadTable("populationProvinces.csv", "header");

  int thisYear = 0;
  String prevName = "";
  
  //runs through columns to get year,
  //and rows to get information for said year
  for (TableRow row : alcConsumption.rows()) {

  	Province newProvince = new Province();
  	
	String name = row.getString("GEO");//.trim();
    println("row #"+rowCount+"	name:" + name);
    // year = row.getString("Ref_Date").trim();

    // String provKey = name+"_"+count;

    // println("last name: " + prevName);

    if(name!=prevName){
	    prevName = name;
	    println("////////// NEW PROVINCE");
    }

    newProvince.name = name;
    newProvince.colour = color(random(200), random(200), random(255));
	provinces.put("key", newProvince);


  	rowCount++;
  }

  return new ArrayList<Province>(provinces.values());
}//end loading data

















  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "coasters" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
