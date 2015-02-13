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

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {

  loadData();
}


void loadData(){
  Table alcConsumption;
  Table population;
  int yr = 1993;
  int rowCount = 0;

  alcConsumption = loadTable("alcoholConsumptionCAN__new.csv", "header");
  // population = loadTable("populationProvinces.csv", "header");

  int thisYear = 0;
  String prevName = "";

  //runs through columns, 
  //for each row in that column... do something
  for (TableRow row : alcConsumption.rows ()) {
    
    String name = row.getString("GEO").trim();
    String year = row.getString("Ref_Date").trim();
    
    
    if (!name.equals(prevName)) {
      println("////////////////////////////// NEW PROVINCE  :" + name);
      prevName = name;      
    }    
    rowCount++;
  }

}//end loading data








//public class Province {
//  String name;
//  
//  int[] years = new int[20];
//  float[] spiritCsmp = new float[20];
//  float[] wineCsmp = new float[20];
//  float[] beerCsmp = new float[20];
//  
//  color colour;
//  
//  String returnName() {
//    return name;
//  }
//}







