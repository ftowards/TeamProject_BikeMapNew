package com.bikemap.home.route;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class RoutePlaceVO {
	
	private int noboard;
	private String food1;
		private JsonObject food1json;
	private String food2;
		private JsonObject food2json;
	private String food3;
		private JsonObject food3json;
	private String food4;
		private JsonObject food4json;
	private String food5;
		private JsonObject food5json;

	private String sights1;
		private JsonObject sights1json;
	private String sights2;
		private JsonObject sights2json;
	private String sights3;
		private JsonObject sights3json;
	private String sights4;
		private JsonObject sights4json;
	private String sights5;
		private JsonObject sights5json;
		
	private String accom1;
		private JsonObject accom1json;
	private String accom2;
		private JsonObject accom2json;
	private String accom3;
		private JsonObject accom3json;
	private String accom4;
		private JsonObject accom4json;
	private String accom5;
		private JsonObject accom5json;
		
	private String conve1;
		private JsonObject conve1json;
	private String conve2;
		private JsonObject conve2json;
	private String conve3;
		private JsonObject conve3json;
	private String conve4;
		private JsonObject conve4json;
	private String conve5;
		private JsonObject conve5json;
		
	public int getNoboard() {
		return noboard;
	}
	public void setNoboard(int noroute) {
		this.noboard = noroute;
	}
	public String getFood1() {
		return food1;
	}
	public void setFood1(String food1) {
		this.food1 = food1;
		food1json = (JsonObject) JsonParser.parseString(food1);
	}
	public String getFood2() {
		return food2;
	}
	public void setFood2(String food2) {
		this.food2 = food2;
		food2json = (JsonObject) JsonParser.parseString(food2);
	}
	public String getFood3() {
		return food3;
	}
	public void setFood3(String food3) {
		this.food3 = food3;
		food3json = (JsonObject) JsonParser.parseString(food3);
	}
	public String getFood4() {
		return food4;
	}
	public void setFood4(String food4) {
		this.food4 = food4;
		food4json = (JsonObject) JsonParser.parseString(food4);
	}
	public String getFood5() {
		return food5;
	}
	public void setFood5(String food5) {
		this.food5 = food5;
		food5json = (JsonObject) JsonParser.parseString(food5);
	}
	public String getSights1() {
		return sights1;
	}
	public void setSights1(String sights1) {
		this.sights1 = sights1;
		sights1json = (JsonObject) JsonParser.parseString(sights1);
	}
	public String getSights2() {
		return sights2;
	}
	public void setSights2(String sights2) {
		this.sights2 = sights2;
		sights2json = (JsonObject) JsonParser.parseString(sights2);
	}
	public String getSights3() {
		return sights3;
	}
	public void setSights3(String sights3) {
		this.sights3 = sights3;
		sights3json = (JsonObject) JsonParser.parseString(sights3);
	}
	public String getSights4() {
		return sights4;
	}
	public void setSights4(String sights4) {
		this.sights4 = sights4;
		sights4json = (JsonObject) JsonParser.parseString(sights4);
	}
	public String getSights5() {
		return sights5;
	}
	public void setSights5(String sights5) {
		this.sights5 = sights5;
		sights5json = (JsonObject) JsonParser.parseString(sights5);
	}
	public String getAccom1() {
		return accom1;
	}
	public void setAccom1(String accom1) {
		this.accom1 = accom1;
		accom1json = (JsonObject) JsonParser.parseString(accom1);
	}
	public String getAccom2() {
		return accom2;
	}
	public void setAccom2(String accom2) {
		this.accom2 = accom2;
		accom2json = (JsonObject) JsonParser.parseString(accom2);
	}
	public String getAccom3() {
		return accom3;
	}
	public void setAccom3(String accom3) {
		this.accom3 = accom3;
		accom3json = (JsonObject) JsonParser.parseString(accom3);
	}
	public String getAccom4() {
		return accom4;
	}
	public void setAccom4(String accom4) {
		this.accom4 = accom4;
		accom4json = (JsonObject) JsonParser.parseString(accom4);
	}
	public String getAccom5() {
		return accom5;
	}
	public void setAccom5(String accom5) {
		this.accom5 = accom5;
		accom5json = (JsonObject) JsonParser.parseString(accom5);
	}
	public String getConve1() {
		return conve1;
	}
	public void setConve1(String conve1) {
		this.conve1 = conve1;
		conve1json = (JsonObject) JsonParser.parseString(conve1);
	}
	public String getConve2() {
		return conve2;
	}
	public void setConve2(String conve2) {
		this.conve2 = conve2;
		conve2json = (JsonObject) JsonParser.parseString(conve2);
	}
	public String getConve3() {
		return conve3;
	}
	public void setConve3(String conve3) {
		this.conve3 = conve3;
		conve3json = (JsonObject) JsonParser.parseString(conve3);
	}
	public String getConve4() {
		return conve4;
	}
	public void setConve4(String conve4) {
		this.conve4 = conve4;
		conve4json = (JsonObject) JsonParser.parseString(conve4);
	}
	public String getConve5() {
		return conve5;
	}
	public void setConve5(String conve5) {
		this.conve5 = conve5;
		conve5json = (JsonObject) JsonParser.parseString(conve5);
	}
	
	///////////////  데이터 읽어오기 지옥 ////////////////

	public String getFood1addressname() {
		if(food1json == null) {
			return null;
		}else {
			return food1json.get("address_name").getAsString();
		}
	}
	public String getFood1placename() {
		if(food1json == null) {
			return null;
		}else {
			return food1json.get("place_name").getAsString();
		}
	}
	public String getFood1placeurl() {
		if(food1json == null) {
			return null;
		}else {
			return food1json.get("place_url").getAsString();
		}
	}
	public String getFood1point() {
		if(food1json == null) {
			return null;
		}else {
			return food1json.get("x").getAsString() + "/" + food1json.get("y").getAsString() ;
		}
	}

	public String getFood2addressname() {
		if(food2json == null) {
			return null;
		}else {
			return food2json.get("address_name").getAsString();
		}
	}
	public String getFood2placename() {
		if(food2json == null) {
			return null;
		}else {
			return food2json.get("place_name").getAsString();
		}
	}
	public String getFood2placeurl() {
		if(food2json == null) {
			return null;
		}else {
			return food2json.get("place_url").getAsString();
		}
	}
	public String getFood2point() {
		if(food2json == null) {
			return null;
		}else {
			return food2json.get("x").getAsString() + "/" + food1json.get("y").getAsString() ;
		}
	}
	
	public String getFood3addressname() {
		if(food3json == null) {
			return null;
		}else {
			return food3json.get("address_name").getAsString();
		}
	}
	public String getFood3placename() {
		if(food3json == null) {
			return null;
		}else {
			return food3json.get("place_name").getAsString();
		}
	}
	public String getFood3placeurl() {
		if(food3json == null) {
			return null;
		}else {
			return food3json.get("place_url").getAsString();
		}
	}
	public String getFood3point() {
		if(food3json == null) {
			return null;
		}else {
			return food3json.get("x").getAsString() + "/" + food3json.get("y").getAsString() ;
		}
	}
	
	public String getFood4addressname() { 
		if(food4json == null) {
			return null;
		}else {
			return food4json.get("address_name").getAsString();
		}
	}
	public String getFood4placename() {
		if(food4json == null) {
			return null;
		}else {
			return food4json.get("place_name").getAsString();
		}
	}
	public String getFood4placeurl() {
		if(food4json == null) {
			return null;
		}else {
			return food4json.get("place_url").getAsString();
		}
	}
	public String getFood4point() {
		if(food4json == null) {
			return null;
		}else {
			return food4json.get("x").getAsString() + "/" + food4json.get("y").getAsString() ;
		}
	}
	
	public String getFood5addressname() {
		if(food5json == null) {
			return null;
		}else {
			return food5json.get("address_name").getAsString();
		}
	}
	public String getFood5placename() {
		if(food5json == null) {
			return null;
		}else {
			return food5json.get("place_name").getAsString();
		}
	}
	public String getFood5placeurl() {
		if(food5json == null) {
			return null;
		}else {
			return food5json.get("place_url").getAsString();
		}
	}
	public String getFood5point() {
		if(food5json == null) {
			return null;
		}else {
			return food5json.get("x").getAsString() + "/" + food5json.get("y").getAsString() ;
		}
	}
	
	public String getSights1addressname() {
		if(sights1json == null) {
			return null;
		}else {
			return sights1json.get("address_name").getAsString();
		}
	}
	public String getSights1placename() {
		if(sights1json == null) {
			return null;
		}else {
			return sights1json.get("place_name").getAsString();
		}
	}
	public String getSights1placeurl() {
		if(sights1json == null) {
			return null;
		}else {
			return sights1json.get("place_url").getAsString();
		}
	}
	public String getSights1point() {
		if(sights1json == null) {
			return null;
		}else {
			return sights1json.get("x").getAsString() + "/" + sights1json.get("y").getAsString() ;
		}
	}
	
	public String getSights2addressname() {
		if(sights2json == null) {
			return null;
		}else {
			return sights2json.get("address_name").getAsString();
		}
	}
	public String getSights2placename() {
		if(sights2json == null) {
			return null;
		}else {
			return sights2json.get("place_name").getAsString();
		}
	}
	public String getSights2placeurl() {
		if(sights2json == null) {
			return null;
		}else {
			return sights2json.get("place_url").getAsString();
		}
	}
	public String getSights2point() {
		if(sights2json == null) {
			return null;
		}else {
			return sights2json.get("x").getAsString() + "/" + sights2json.get("y").getAsString() ;
		}
	}
	
	public String getSights3addressname() {
		if(sights3json == null) {
			return null;
		}else {
			return sights3json.get("address_name").getAsString();
		}
	}
	public String getSights3placename() {
		if(sights3json == null) {
			return null;
		}else {
			return sights3json.get("place_name").getAsString();
		}
	}
	public String getSights3placeurl() {
		if(sights3json == null) {
			return null;
		}else {
			return sights3json.get("place_url").getAsString();
		}
	}
	public String getSights3point() {
		if(sights3json == null) {
			return null;
		}else {
			return sights3json.get("x").getAsString() + "/" + sights3json.get("y").getAsString() ;
		}
	}
	
	public String getSights4addressname() {
		if(sights4json == null) {
			return null;
		}else {
			return sights4json.get("address_name").getAsString();
		}
	}
	public String getSights4placename() {
		if(sights4json == null) {
			return null;
		}else {
			return sights4json.get("place_name").getAsString();
		}
	}
	public String getSights4placeurl() {
		if(sights4json == null) {
			return null;
		}else {
			return sights4json.get("place_url").getAsString();
		}
	}
	public String getSights4point() {
		if(sights4json == null) {
			return null;
		}else {
			return sights4json.get("x").getAsString() + "/" + sights4json.get("y").getAsString() ;
		}
	}
	
	public String getSights5addressname() {
		if(sights5json == null) {
			return null;
		}else {
			return sights5json.get("address_name").getAsString();
		}
	}
	public String getSights5placename() {
		if(sights5json == null) {
			return null;
		}else {
			return sights5json.get("place_name").getAsString();
		}
	}
	public String getSights5placeurl() {
		if(sights5json == null) {
			return null;
		}else {
			return sights5json.get("place_url").getAsString();
		}
	}
	public String getSights5point() {
		if(sights5json == null) {
			return null;
		}else {
			return sights5json.get("x").getAsString() + "/" + sights5json.get("y").getAsString() ;
		}
	}
	
	public String getAccom1addressname() {
		if(accom1json == null) {
			return null;
		}else {
			return accom1json.get("address_name").getAsString();
		}
	}
	public String getAccom1placename() {
		if(accom1json == null) {
			return null;
		}else {
			return accom1json.get("place_name").getAsString();
		}
	}
	public String getAccom1placeurl() {
		if(accom1json == null) {
			return null;
		}else {
			return accom1json.get("place_url").getAsString();
		}
	}
	public String getAccom1point() {
		if(accom1json == null) {
			return null;
		}else {
			return accom1json.get("x").getAsString() + "/" + accom1json.get("y").getAsString() ;
		}
	}
	
	public String getAccom2addressname() {
		if(accom2json == null) {
			return null;
		}else {
			return accom2json.get("address_name").getAsString();
		}
	}
	public String getAccom2placename() {
		if(accom2json == null) {
			return null;
		}else {
			return accom2json.get("place_name").getAsString();
		}
	}
	public String getAccom2placeurl() {
		if(accom2json == null) {
			return null;
		}else {
			return accom2json.get("place_url").getAsString();
		}
	}
	public String getAccom2point() {
		if(accom2json == null) {
			return null;
		}else {
			return accom2json.get("x").getAsString() + "/" + accom2json.get("y").getAsString() ;
		}
	}
	
	public String getAccom3addressname() {
		if(accom3json == null) {
			return null;
		}else {
			return accom3json.get("address_name").getAsString();
		}
	}
	public String getAccom3placename() {
		if(accom3json == null) {
			return null;
		}else {
			return accom3json.get("place_name").getAsString();
		}
	}
	public String getAccom3placeurl() {
		if(accom3json == null) {
			return null;
		}else {
			return accom3json.get("place_url").getAsString();
		}
	}
	public String getAccom3point() {
		if(accom3json == null) {
			return null;
		}else {
			return accom3json.get("x").getAsString() + "/" + accom3json.get("y").getAsString() ;
		}
	}
	
	public String getAccom4addressname() {
		if(accom4json == null) {
			return null;
		}else {
			return accom4json.get("address_name").getAsString();
		}
	}
	public String getAccom4placename() {
		if(accom4json == null) {
			return null;
		}else {
			return accom4json.get("place_name").getAsString();
		}
	}
	public String getAccom4placeurl() {
		if(accom4json == null) {
			return null;
		}else {
			return accom4json.get("place_url").getAsString();
		}
	}
	public String getAccom4point() {
		if(accom4json == null) {
			return null;
		}else {
			return accom4json.get("x").getAsString() + "/" + accom4json.get("y").getAsString() ;
		}
	}
	
	public String getAccom5addressname() {
		if(accom5json == null) {
			return null;
		}else {
			return accom5json.get("address_name").getAsString();
		}
	}
	public String getAccom5placename() {
		if(accom5json == null) {
			return null;
		}else {
			return accom5json.get("place_name").getAsString();
		}
	}
	public String getAccom5placeurl() {
		if(accom5json == null) {
			return null;
		}else {
			return accom5json.get("place_url").getAsString();
		}
	}
	public String getAccom5point() {
		if(accom5json == null) {
			return null;
		}else {
			return accom5json.get("x").getAsString() + "/" + accom5json.get("y").getAsString() ;
		}
	}
	
	public String getConve1addressname() {
		if(conve1json == null) {
			return null;
		}else {
			return conve1json.get("address_name").getAsString();
		}
	}
	public String getConve1placename() {
		if(conve1json == null) {
			return null;
		}else {
			return conve1json.get("place_name").getAsString();
		}
	}
	public String getConve1placeurl() {
		if(conve1json == null) {
			return null;
		}else {
			return conve1json.get("place_url").getAsString();
		}
	}
	public String getConve1point() {
		if(conve1json == null) {
			return null;
		}else {
			return conve1json.get("x").getAsString() + "/" + conve1json.get("y").getAsString() ;
		}
	}
	
	public String getConve2addressname() {
		if(conve2json == null) {
			return null;
		}else {
			return conve2json.get("address_name").getAsString();
		}
	}
	public String getConve2placename() {
		if(conve2json == null) {
			return null;
		}else {
			return conve2json.get("place_name").getAsString();
		}
	}
	public String getConve2placeurl() {
		if(conve2json == null) {
			return null;
		}else {
			return conve2json.get("place_url").getAsString();
		}
	}
	public String getConve2point() {
		if(conve2json == null) {
			return null;
		}else {
			return conve2json.get("x").getAsString() + "/" + conve2json.get("y").getAsString() ;
		}
	}
	
	public String getConve3addressname() {
		if(conve3json == null) {
			return null;
		}else {
			return conve3json.get("address_name").getAsString();
		}
	}
	public String getConve3placename() {
		if(conve3json == null) {
			return null;
		}else {
			return conve3json.get("place_name").getAsString();
		}
	}
	public String getConve3placeurl() {
		if(conve3json == null) {
			return null;
		}else {
			return conve3json.get("place_url").getAsString();
		}
	}
	public String getConve3point() {
		if(conve3json == null) {
			return null;
		}else {
			return conve3json.get("x").getAsString() + "/" + conve3json.get("y").getAsString() ;
		}
	}
	
	public String getConve4addressname() {
		if(conve4json == null) {
			return null;
		}else {
			return conve4json.get("address_name").getAsString();
		}
	}
	public String getConve4placename() {
		if(conve4json == null) {
			return null;
		}else {
			return conve4json.get("place_name").getAsString();
		}
	}
	public String getConve4placeurl() {
		if(conve4json == null) {
			return null;
		}else {
			return conve4json.get("place_url").getAsString();
		}
	}
	public String getConve4point() {
		if(conve4json == null) {
			return null;
		}else {
			return conve4json.get("x").getAsString() + "/" + conve4json.get("y").getAsString() ;
		}
	}
	
	public String getConve5addressname() {
		if(conve5json == null) {
			return null;
		}else {
			return conve5json.get("address_name").getAsString();
		}
	}
	public String getConve5placename() {
		if(conve5json == null) {
			return null;
		}else {
			return conve5json.get("place_name").getAsString();
		}
	}
	public String getConve5placeurl() {
		if(conve5json == null) {
			return null;
		}else {
			return conve5json.get("place_url").getAsString();
		}
	}
	public String getConve5point() {
		if(conve5json == null) {
			return null;
		}else {
			return conve5json.get("x").getAsString() + "/" + conve5json.get("y").getAsString() ;
		}
	}
}
