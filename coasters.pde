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

int boxSize = 25;

void setup() {
  size(1680, 1020);
  background(255);
  noLoop();
}

void draw() {
  loadData();
}


int readInt(String s) {
  if(s.trim().equals("..")) return -1;  //if it's NA
  if (s.trim().equals("")) return 0;  //if it's empty
  return Integer.parseInt(s.replace(",", ""));
} 

void loadData(){
  Table alcConsumption;
  Table population;

  int rowCount = 0;
  int xPos = -580; 
  int highestVal = 0;
  color fillColour = color(0,0,0);

  alcConsumption = loadTable("alcoholConsumptionCAN__new.csv", "header");
  // population = loadTable("populationProvinces.csv", "header");
  String prevName = "";
  stroke(255);

  //runs through columns, 
  //for each row in that column... do something
  for (TableRow row : alcConsumption.rows ()) {
    
    String name = row.getString("GEO").trim();
    String strYear = row.getString("Ref_Date").trim();
    String beverage = row.getString("BEVERAGE");
    String strValue = row.getString("Value");
    
    int value = readInt(strValue);
    int year = readInt(strYear);
    int y = 0;
    int x = 0; 
    
    if(value>highestVal){
      highestVal = value;
    }
    println("highest value = " + highestVal);
     
    if (!name.equals(prevName)) {
      println("////////////////////////////// NEW PROVINCE: " + name);
      prevName = name;      
      xPos += 600;
      fill(0);
      textSize(50);
      text(name, xPos, 800);
    }   
   
   if (beverage.equals("Total spirits")) {
       fillColour = color(0, 0, map(value, 0, highestVal, 0, 255) );
       y = 100;  
       println("YEAR:" + year + "  BEV:SPIR  name: " + name);
   }else if (beverage.equals("Total wines")) {
       fillColour = color(0, map(value, 0, highestVal, 0, 255), 0); 
       y = 200;   
       println("YEAR:" + year + "  BEV:WINE  name: " + name);
   }else if (beverage.equals("Beer")) {
       fillColour = color(map(value, 0, highestVal, 0, 255), 0, 0);
        y = 300;  
       println("YEAR:" + year + "  BEV:BEER  name: " + name);
   }
   fill(fillColour);
   rect( (map(year, 1993, 2013, 0, 500))+xPos, y, boxSize, boxSize);
   rowCount++;
   
   fill(0);
   textSize(7);
   text(year, (map(year, 1993, 2013, 0, 500))+xPos, y);
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







