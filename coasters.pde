/**
* Laurie Waxman
* 12.02.2015
* Prototyping 
*
* Data from: 
* http://www5.statcan.gc.ca/cansim/a47
**/

// when you encounter a new name, 
// create a new object. 
// object name = name; 
// object years = years;
// object beer = beer;


//pdf & arrayLists
import java.util.Collections;
import processing.pdf.*;

//3d rendering, stl export
import processing.data.*;
import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

ArrayList<Province> provinces;
int windowWidth = 1920;
int windowHeight = 1080;

/////////////////////////////////////////////////////////////////////////////////////////////// CLASS PROVINCE ////////

public class Province {
	String nom;
	// int[] years = new int[20];
	int[] populations = new int[21];
	int[] beers = new int[21];
	int[] wines = new int[21];
	int[] spirits = new int[21];
	color colour; 

	String returnNom() {
		return nom;
	}

}

int readInt(String s) {
	if(s.trim().equals("..")) return -1;  //if it's N/A
	if (s.trim().equals("")) return 0;  //if it's empty
	return Integer.parseInt(s.replace(",", ""));
}

////////////////////////////////////////////////////////////////////////////////////////////////// LOAD DATA ////////

ArrayList<Province> loadData() {
    println("/////////////////// LOADING DATA");
 
	HashMap<String, Province> provinces = new HashMap<String, Province>();
	
	Table alcConsumption = loadTable("alcoholConsumptionCAN__new.csv", "header");
	Table population = loadTable("populationProvinces.csv", "header");
	int annee = 1993;
	int thisYear = 0;
	String prevName = "";
	Province currentProvince = new Province();
	int spiritCount = 0; 
	int wineCount = 0; 
	int beerCount = 0; 
  
	int yrCount = 0;
	for (TableRow row : alcConsumption.rows()) {

		String name = row.getString("GEO").trim();
		int strYear = readInt(row.getString("Ref_Date").trim());
		String beverage = row.getString("BEVERAGE");
		int strValue = readInt(row.getString("Value"));	
	
		if(!name.equals(prevName) || prevName == ""){
			// println("////////////////////////////// NEW PROVINCE: " + name);
			currentProvince = new Province();
			currentProvince.nom = name;
			prevName = name;
			spiritCount = 0; 
			wineCount = 0; 
			beerCount = 0; 
			if(beverage.equals("Total wines")){
				currentProvince.wines[wineCount] = strValue;
				wineCount++;
			}else if(beverage.equals("Total spirits")){
				currentProvince.spirits[spiritCount] = strValue;
				spiritCount++;
			}else if(beverage.equals("Beer")){
				currentProvince.beers[beerCount] = strValue;
				beerCount++;
			}
		}else if(name.equals(prevName)){
			if(beverage.equals("Total wines")){
				currentProvince.wines[wineCount] = strValue;
				wineCount++;
				if(wineCount>21){ wineCount = 0; }
			}else if(beverage.equals("Total spirits")){
				currentProvince.spirits[spiritCount] = strValue;
				spiritCount++;
				if(spiritCount>21){ spiritCount = 0; }
			}else if(beverage.equals("Beer")){
				currentProvince.beers[beerCount] = strValue;
				beerCount++;
				if(beerCount>21){ beerCount = 0; }
			}
			currentProvince.colour = color(random(255), random(255), random(255));
		}

		// println(strYear +" 	BEER:"+currentProvince.beers[yrCount] + " 	WINE:"+currentProvince.wines[yrCount]+ " 	SPIR:"+currentProvince.spirits[yrCount] + " 	POP:"+currentProvince.populations[yrCount] );
		String provinceKey = name; 

		yrCount++;
		if(yrCount>20) yrCount = 0;
		provinces.put(provinceKey, currentProvince);
	
	}

	int popCount = 0 ;
	for (TableRow row : population.rows()) {
		String nom = row.getString("Geography").trim();
		String provinceKey = nom;// + "_" + annee;
		Province loadedProvince = provinces.get(provinceKey);
		// println("//////////////////////////////////////////////////"+loadedProvince.nom);

		for (annee=1993; annee<2014; annee++){
			thisYear = annee-1993;
			int pop = readInt(row.getString(""+annee+""));

			if (loadedProvince != null) {
				loadedProvince.populations[thisYear] = pop;
			}

//			println(annee + " 	BEER:"+loadedProvince.beers[thisYear] + " 	WINE:"+loadedProvince.wines[thisYear]+ " 	SPIR:"+loadedProvince.spirits[thisYear] + " 	POP:"+loadedProvince.populations[thisYear] );
			// println(loadedProvince.nom + "	" + annee +":"+ loadedProvince.populations[thisYear]);
			popCount++;
			if(popCount>20) popCount = 0; 

		}//end years
	}//end rows

  return new ArrayList<Province>(provinces.values());
}

////////////////////////////////////////////////////////////////////////////////////////////////////// SETUP ////////


void setup() {
	size(windowWidth, windowHeight);
	background(255);
	noLoop();
	provinces = loadData();
	beginRecord(PDF, "canada.pdf");
	{
		drawEach();
	}
	endRecord();

}

void drawEach() {
	float x = 0;
	float y = 0;
	float rowCount = 0;
	float columnCount = 0;
	float ellipseSize = 3;

	// println("provinces: "+ provinces);
	for (Province prov : provinces) {
		// println(prov.returnNom());
	
		if (rowCount%7==0) {
		  println(prov.nom+"	x:"+x+"	y:"+y);
		  y+=500;
		  x=0;
		}
		x+=430;

		buildGraph(prov, x, y); 

		columnCount++;
		rowCount++;
	}//end run through provinces
}//end draw

////////////////////////////////////////////////////////////////////////////////////////////////////// DRAW IT! ////////

void buildGraph(Province p, float xStartPoint, float yStartPoint) {
	float beerPC = 0.00;
	float winePC = 0.00;
	float spirPC = 0.00;

	int x = (int) xStartPoint;
	int y = (int) yStartPoint;

	int boxWidth = 20;
	int boxHeight = 140;

	fill(0);
	textSize(12);
	text(p.nom, x, y-20);
	textSize(6);
	noStroke();

	// println("////////////////////////////////// "+p.nom);
	for(int i=0; i<21; i++){
		if(p.populations[i]>0){
			beerPC = (p.beers[i]*100) / (p.populations[i]/100);
			fill(map(beerPC/50, 0, 20, 0, 250));
			rect(x+(i*boxWidth), y, boxWidth, boxHeight);
			// println(i+1993 + "	beer/pop:" + beerPC/50);
		
			winePC = (p.wines[i]*100) / (p.populations[i]/100);
			fill(map(winePC/10, 0, 20, 0, 250));
			rect(x+(i*boxWidth), y+(boxHeight), boxWidth, boxHeight);
			// println(i+1993 + "	wine/pop:" + winePC/10);

			spirPC = (p.spirits[i]*100) / (p.populations[i]/100);
			fill(map(spirPC/10, 0, 20, 0, 250));
			rect(x+(i*boxWidth), y+(boxHeight*2), boxWidth, boxHeight);
			// println(i+1993 + "	spir/pop:" + spirPC/10);

			fill(0);
			text(i+1993, x+(i*boxWidth), y-5);
		}
	}

}





























