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
import processing.opengl.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

ArrayList<Province> provinces;
int windowWidth = 1920;
int windowHeight = 1080;

/////////////////////////////////////////////////////////////////////////////////////////////// CLASS PROVINCE ////////

public class Province {
	String nom;
	int[] populations = new int[21];

	int[] redwines = new int[21];
	int[] whitewines = new int[21];
	int[] wineCoolers = new int[21];
	int[] ciders = new int[21];
	int[] sparkWines = new int[21];
	int[] otherWines = new int[21];
	int[] brandys = new int[21];
	int[] gins = new int[21];
	int[] liquers = new int[21];
	int[] rums = new int[21];
	int[] whiskys = new int[21];
	int[] vodkas = new int[21];
	int[] otherSpirits = new int[21];
	int[] spiritCoolers = new int[21];
	int[] beers = new int[21];

	// color colour; 

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
	// int spiritCount = 0; 
	// int wineCount = 0; 
	// int beerCount = 0; 
	int redwineCount = 0;
	int whitewineCount = 0;
	int wineCoolerCount = 0;
	int ciderCount = 0;
	int sparkWineCount = 0;
	int otherWineCount = 0;

	int brandyCount = 0;
	int ginCount = 0;
	int liquerCount = 0;
	int rumCount = 0;
	int whiskyCount = 0;
	int vodkaCount = 0;
	int otherSpiritCount = 0;
	int spiritCoolerCount = 0; 
  
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
			// spiritCount = 0; 
			// wineCount = 0; 
			// beerCount = 0; 
			
			redwineCount = 0;
			whitewineCount = 0;
			wineCoolerCount = 0;
			ciderCount = 0;
			sparkWineCount = 0;
			otherWineCount = 0;

			brandyCount = 0;
			ginCount = 0;
			liquerCount = 0;
			rumCount = 0;
			whiskyCount = 0;
			vodkaCount = 0;
			otherSpiritCount = 0;
			spiritCoolerCount = 0;

			beerCount = 0;

			if(beverage.equals("Red wines")){
				currentProvince.redwines[redwineCount] = strValue;
				redwineCount++;
			}else if(beverage.equals("White wines")){
				currentProvince.whitewines[whitewineCount] = strValue;
				whitewineCount++;
			}else if(beverage.equals("Coolers, wines")){
				currentProvince.wineCoolers[wineCoolerCount] = strValue;
				wineCoolerCount++;
			}else if(beverage.equals("Cider, wines")){
				currentProvince.ciders[ciderCount] = strValue;
				ciderCount++;
			}else if(beverage.equals("Sparkling, wines")){
				currentProvince.sparkWines[sparkWineCount] = strValue;
				sparkWineCount++;
			}else if(beverage.equals("Other wines")){
				currentProvince.otherWines[otherWineCount] = strValue;
				otherWineCount++;
			}else if(beverage.equals("Brandy")){
				currentProvince.brandys[brandyCount] = strValue;
				brandyCount++;
			}else if(beverage.equals("Gin")){
				currentProvince.gins[ginCount] = strValue;
				ginCount++;
			}else if(beverage.equals("Liquers")){
				currentProvince.liquers[liquerCount] = strValue;
				liquerCount++;
			}else if(beverage.equals("Rum")){
				currentProvince.rums[rumCount] = strValue;
				rumCount++;
			}else if(beverage.equals("Whisky")){
				currentProvince.whiskys[whiskyCount] = strValue;
				whiskyCount++;
			}else if(beverage.equals("Vodka")){
				currentProvince.vodkas[vodkaCount] = strValue;
				vodkaCount++;
			}else if(beverage.equals("Other spirits")){
				currentProvince.otherSpirits[otherSpiritCount] = strValue;
				otherSpiritCount++;
			}else if(beverage.equals("Coolers, spirits")){
				currentProvince.spiritCoolers[spiritCoolerCount] = strValue;
				spiritCoolerCount++;
			}else if(beverage.equals("Beer")){
				currentProvince.beers[beerCount] = strValue;
				beerCount++;
			}
		}else if(name.equals(prevName)){
			if(beverage.equals("Red wines")){
				currentProvince.redwines[redwineCount] = strValue;
				redwineCount++;
				if(redwineCount>21){ redwineCount=0; }
			}else if(beverage.equals("White wines")){
				currentProvince.whitewines[whitewineCount] = strValue;
				whitewineCount++;
				if(whitewineCount>21){ whitewineCount=0; }
			}else if(beverage.equals("Coolers, wines")){
				currentProvince.wineCoolers[wineCoolerCount] = strValue;
				wineCoolerCount++;
				if(wineCoolerCount>21){ wineCoolerCount=0; }
			}else if(beverage.equals("Cider, wines")){
				currentProvince.ciders[ciderCount] = strValue;
				ciderCount++;
				if(ciderCount>21){ ciderCount=0; }
			}else if(beverage.equals("Sparkling, wines")){
				currentProvince.sparkWines[sparkWineCount] = strValue;
				sparkWineCount++;
				if(sparkWineCount>21){ sparkWineCount=0; }
			}else if(beverage.equals("Other wines")){
				currentProvince.otherWines[otherWineCount] = strValue;
				otherWineCount++;
				if(otherWineCount>21){ otherWineCount=0; }
			}else if(beverage.equals("Brandy")){
				currentProvince.brandys[brandyCount] = strValue;
				brandyCount++;
				if(brandyCount>21){ brandyCount=0; }
			}else if(beverage.equals("Gin")){
				currentProvince.gins[ginCount] = strValue;
				ginCount++;
				if(ginCount>21){ ginCount=0; }
			}else if(beverage.equals("Liquers")){
				currentProvince.liquers[liquerCount] = strValue;
				liquerCount++;
				if(liquerCount>21){ liquerCount=0; }
			}else if(beverage.equals("Rum")){
				currentProvince.rums[rumCount] = strValue;
				rumCount++;
				if(rumCount>21){ rumCount=0; }
			}else if(beverage.equals("Whisky")){
				currentProvince.whiskys[whiskyCount] = strValue;
				whiskyCount++;
				if(whiskyCount>21){ whiskyCount=0; }
			}else if(beverage.equals("Vodka")){
				currentProvince.vodkas[vodkaCount] = strValue;
				vodkaCount++;
				if(vodkaCount>21){ vodkaCount=0; }
			}else if(beverage.equals("Other spirits")){
				currentProvince.otherSpirits[otherSpiritCount] = strValue;
				otherSpiritCount++;
				if(otherSpiritCount>21){ otherSpiritCount=0; }
			}else if(beverage.equals("Coolers, spirits")){
				currentProvince.spiritCoolers[spiritCoolerCount] = strValue;
				spiritCoolerCount++;
				if(spiritCoolerCount>21){ spiritCoolerCount=0; }
			}else if(beverage.equals("Beer")){
				currentProvince.beers[beerCount] = strValue;
				beerCount++;
				if(beerCount>21){ beerCount=0; }
			}
			// if(beverage.equals("Total wines")){
			// 	currentProvince.wines[wineCount] = strValue;
			// 	wineCount++;
			// 	if(wineCount>21){ wineCount = 0; }
			// }else if(beverage.equals("Total spirits")){
			// 	currentProvince.spirits[spiritCount] = strValue;
			// 	spiritCount++;
			// 	if(spiritCount>21){ spiritCount = 0; }
			// }else if(beverage.equals("Beer")){
			// 	currentProvince.beers[beerCount] = strValue;
			// 	beerCount++;
			// 	if(beerCount>21){ beerCount = 0; }
			// }
			// currentProvince.colour = color(random(255), random(255), random(255));
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
PImage thisImage;
int totalWidth = 250;
int totalHeight = 300;
int baseHeight = 10;
int resolution = 100;
float elevationScale = (float)(totalHeight-baseHeight)/255;
WETriangleMesh mesh;
ToxiclibsSupport gfx;

void setup() {
	size(windowWidth, windowHeight, OPENGL);
	thisImage = createImage(420,420,RGB);

	background(255);
	// noLoop();
	provinces = loadData();
	// beginRecord(PDF, "canada.pdf");
	// {
	// 	drawEach();
	// }
	// endRecord();

	for(Province prov : provinces){
		if(prov.returnNom() != null && prov.returnNom().contains("Quebec")){
			println("found Quebec");
			buildGraph(prov, 0, 0);
			background(0);
		}
	}
	// render3D(thisImage);

	thisImage.resize(resolution, resolution);

	Terrain terrain = new Terrain(resolution, resolution, 20);
	float[] el = new float[resolution*resolution];
	for (int i=0; i<thisImage.pixels.length; i++) {
		// we use the brightness of each pixel
		// as a metric for elevation
		// (however damped down to avoid crazy spikes)
		el[i] = brightness(thisImage.pixels[i])*elevationScale;
	}
	terrain.setElevation(el);
	mesh = new WETriangleMesh();
	terrain.toMesh(mesh,-10);
	new LaplacianSmooth().filter(mesh,1);

	String fileName="quebec.stl";
	// save mesh in STL format in sketch folder

	mesh.saveAsSTL(sketchPath(fileName));
	gfx = new ToxiclibsSupport(this);

}

void draw() { //drawEach()
	background(0);
	lights();
	image(thisImage, 0, 0);
	translate(width/2, height/2, 0);
	rotateX(mouseY *0.01);
	rotateY(mouseX *0.01);
	// turn off wireframe/outline
	noStroke();
	// draw the mesh
	gfx.mesh(mesh);
	// float x = 50;
	// float y = 50;
	// float rowCount = 0;
	// float columnCount = 0;
	// float ellipseSize = 3;
	// println(provinces);
	
	// for(Province prov : provinces){
	// 	if(prov.returnNom() != null && prov.returnNom().contains("Quebec")){
	// 		println("found Quebec");
	// 		buildGraph(prov, 0, 0);
	// 		background(0);
	// 	}
	// }

	// image(thisImage, 400, 60);
	// render3D(thisImage);
	// for (Province prov : provinces) {
	// 	buildGraph(prov, x, y); 
	// 	// println(prov.nom+"	x:"+x+"	y:"+y);
	// 	if (rowCount%7==0 && rowCount!=0) {
	// 	  y+=500;
	// 	  x=50;
	// 	}
	// 	x+=430;
	// 	columnCount++;
	// 	rowCount++;
	// }//end run through provinces
}//end draw

////////////////////////////////////////////////////////////////////////////////////////////////////// DRAW IT 3D! ////////
// int totalWidth = 250;
// int totalHeight = 40;
// int baseHeight = 10;
// float elevationScale = (float)(totalHeight-baseHeight)/255;
// void render3D(PImage img){
// 	Terrain terrain = new Terrain(420, 420, 20);
// 	float[] el = new float[420*420];
// 	for (int i=0; i<img.pixels.length; i++) {
// 		// we use the brightness of each pixel
// 		// as a metric for elevation
// 		// (however damped down to avoid crazy spikes)
// 		el[i] = brightness(img.pixels[i])*elevationScale;
// 	}
// 	terrain.setElevation(el);
// 	mesh = new WETriangleMesh();
// 	terrain.toMesh(mesh,-10);
// 	new LaplacianSmooth().filter(mesh,1);
// 	String fileName="rendered.stl";
// 	// save mesh in STL format in sketch folder
// 	mesh.saveAsSTL(sketchPath(fileName));
// 	gfx = new ToxiclibsSupport(this);
// }




////////////////////////////////////////////////////////////////////////////////////////////////////// DRAW IT! ////////

void buildGraph(Province p, float xStartPoint, float yStartPoint) {

	int x = (int) xStartPoint;
	int y = (int) yStartPoint;

	int boxWidth = 20;
	int boxHeight = 28;

	// fill(0);
	// textSize(12);
	// text(p.nom, x, y-20);
	// textSize(6);
	noStroke();
	float fillValue = 0;

	int[][] alcohols = { p.redwines, p.whitewines, p.wineCoolers, p.ciders, p.sparkWines, p.otherWines, p.brandys, p.gins, p.liquers, p.rums, p.whiskys, p.vodkas, p.otherSpirits, p.spiritCoolers, p.beers };

	// println("////////////////////////////////// "+p.nom);
	for(int i=0; i<21; i++){
		// fill(0);
		// text(i+1993, x+(i*boxWidth), y+430);

		for(int l = 0; l<15; l++){
			if(p.populations[i]>0){

				fillValue = (alcohols[l][i]*100) / (p.populations[i]/1000);		
				if(	alcohols[l]==p.redwines ||
					alcohols[l]==p.whitewines ||
					alcohols[l]==p.otherWines){
					fill(map(fillValue, 0, 600, 0, 255));
				}else if(alcohols[l]==p.wineCoolers ||
					alcohols[l]==p.ciders ||
					alcohols[l]==p.sparkWines){
					fill(map(fillValue, 0, 300, 0, 255));
				}else if(alcohols[l]==p.brandys ||
					alcohols[l]==p.gins ||
					alcohols[l]==p.liquers){
					fill(map(fillValue, 0, 50, 0, 255));
				}else if(alcohols[l]==p.rums ||
					alcohols[l]==p.whiskys ||
					alcohols[l]==p.vodkas ||
					alcohols[l]==p.otherSpirits ||
					alcohols[l]==p.spiritCoolers){ 
					fill(map(fillValue, 0, 200, 0, 255));
				}else{
					fill(map(fillValue, 0, 7800, 0, 255));
				}
				rect(x+(i*boxWidth), y+(boxHeight*l), boxWidth, boxHeight);
			}
		}//end alcohol index
	}//end years

	thisImage = get(0,0,420,420);
}




















