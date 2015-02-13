/**
 * Laurie Waxman
 * 12.02.2015
 * Prototyping 
 *
 * Data from: 
 * http://www5.statcan.gc.ca/cansim/a47
 **/

import java.util.Collections;
import processing.pdf.*;

ArrayList<Province> provinces;

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {

  provinces = loadData();
}

public class Province {
  String name;
  
  int[] years = new int[20];
  float[] spiritCsmp = new float[20];
  float[] wineCsmp = new float[20];
  float[] beerCsmp = new float[20];
  
  color colour;
  
  String returnName() {
    return name;
  }
}


ArrayList<Province> loadData() {
  Table alcConsumption;
  Table population;
  int yr = 1993;
  int rowCount = 0;
  HashMap<String, Province> provinces = new HashMap<String, Province>();

  alcConsumption = loadTable("alcoholConsumptionCAN__new.csv", "header");
  // population = loadTable("populationProvinces.csv", "header");

  int thisYear = 0;
  String prevName = "";

  //runs through columns, 
  //for each row in that column... do something
  for (TableRow row : alcConsumption.rows ()) {
    
    String name = row.getString("GEO").trim();
    String year = row.getString("Ref_Date").trim();
    
    Province newProvince = new Province();
    
    if (!name.equals(prevName)) {
      println("////////////////////////////// NEW PROVINCE  :" + name);
      prevName = name;  
      
      newProvince.name = name;
      newProvince.colour = color(random(200), random(200), random(255));
      provinces.put("key", newProvince);
      
    }
    
//    newProvince.name = name;
    
    rowCount++;
  }

  return new ArrayList<Province>(provinces.values());
}//end loading data
















