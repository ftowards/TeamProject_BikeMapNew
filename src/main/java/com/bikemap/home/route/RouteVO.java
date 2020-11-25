package com.bikemap.home.route;

public class RouteVO {
	
	private int noroute;
	private String title;
	private String routepoint1;
	private String routepoint2;
	private String routepoint3;
	private String routepoint4;
	private String routepoint5;
	private String routepoint6;
	private String routepoint7;
	private String geocode;
	
	private String polyline;
	private String mapcenter;
	private int maplevel;
	
	private String userid;
	private double distance;
	private double ascent;
	private double descent;
	private String region;
	private String closed;
	private String writedate;
	
	private double rating;
	
	public int getNoroute() {
		return noroute;
	}
	public void setNoroute(int noroute) {
		this.noroute = noroute;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRoutepoint1() {
		return routepoint1;
	}
	public void setRoutepoint1(String routepoint1) {
		this.routepoint1 = routepoint1;
	}
	public String getRoutepoint2() {
		return routepoint2;
	}
	public void setRoutepoint2(String routepoint2) {
		this.routepoint2 = routepoint2;
	}
	public String getRoutepoint3() {
		return routepoint3;
	}
	public void setRoutepoint3(String routepoint3) {
		this.routepoint3 = routepoint3;
	}
	public String getRoutepoint4() {
		return routepoint4;
	}
	public void setRoutepoint4(String routepoint4) {
		this.routepoint4 = routepoint4;
	}
	public String getRoutepoint5() {
		return routepoint5;
	}
	public void setRoutepoint5(String routepoint5) {
		this.routepoint5 = routepoint5;
	}
	public String getRoutepoint6() {
		return routepoint6;
	}
	public void setRoutepoint6(String routepoint6) {
		this.routepoint6 = routepoint6;
	}
	public String getRoutepoint7() {
		return routepoint7;
	}
	public void setRoutepoint7(String routepoint7) {
		this.routepoint7 = routepoint7;
	}
	public String getGeocode() {
		return geocode;
	}
	public void setGeocode(String geocode) {
		this.geocode = geocode;
	}
	public String getPolyline() {
		return polyline;
	}
	public void setPolyline(String polyline) {
		this.polyline = polyline;
	}
	public String getMapcenter() {
		return mapcenter;
	}
	public void setMapcenter(String mapcenter) {
		this.mapcenter = mapcenter;
	}
	public int getMaplevel() {
		return maplevel;
	}
	public void setMaplevel(int maplevel) {
		this.maplevel = maplevel;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public double getAscent() {
		return ascent;
	}
	public void setAscent(double ascent) {
		this.ascent = ascent;
	}
	public double getDescent() {
		return descent;
	}
	public void setDescent(double descent) {
		this.descent = descent;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getClosed() {
		return closed;
	}
	public void setClosed(String closed) {
		this.closed = closed;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	
	////////////// 삽질의 시작 /////////////////////
	public String getRoutepoint1name() {
		return routepoint1.substring(0,routepoint1.indexOf("[/]"));
	}
	public String getRoutepoint1point() {
		return routepoint1.substring(routepoint1.indexOf("[/]")+3);
	}
	public String getRoutepoint2name() {
		return routepoint2.substring(0,routepoint2.indexOf("[/]"));
	}
	public String getRoutepoint2point() {
		return routepoint2.substring(routepoint2.indexOf("[/]")+3);
	}
	public String getRoutepoint3name() {
		return routepoint3.substring(0,routepoint3.indexOf("[/]"));
	}
	public String getRoutepoint3point() {
		return routepoint3.substring(routepoint3.indexOf("[/]")+3);
	}
	public String getRoutepoint4name() {
		return routepoint4.substring(0,routepoint4.indexOf("[/]"));
	}
	public String getRoutepoint4point() {
		return routepoint4.substring(routepoint4.indexOf("[/]")+3);
	}
	public String getRoutepoint5name() {
		return routepoint5.substring(0,routepoint5.indexOf("[/]"));
	}
	public String getRoutepoint5point() {
		return routepoint5.substring(routepoint5.indexOf("[/]")+3);
	}
	public String getRoutepoint6name() {
		return routepoint6.substring(0,routepoint6.indexOf("[/]"));
	}
	public String getRoutepoint6point() {
		return routepoint6.substring(routepoint6.indexOf("[/]")+3);
	}
	public String getRoutepoint7name() {
		return routepoint7.substring(0,routepoint7.indexOf("[/]"));
	}
	public String getRoutepoint7point() {
		return routepoint7.substring(routepoint7.indexOf("[/]")+3);
	}
	
}
