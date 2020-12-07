package com.bikemap.home.route;

public class SavedMyRouteVO {

	
	private int noboard;
	private String title;
	private String userid;
	private double distance;
	private String region;
	
	private int noroutecate;

	public int getNoboard() {
		return noboard;
	}


	public void setNoboard(int noboard) {
		this.noboard = noboard;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
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


	public String getRegion() {
		return region;
	}


	public void setRegion(String region) {
		String[] regions = region.split("/");
		String[] list = new String[regions.length];
		
		list[0] = regions[0];
		int nxt = 1;
		
		for(int i = 1; i<regions.length; i++) {
			int cnt = 0;
			for(int j = 0; j < list.length ; j++) {
				if(regions[i].equals(list[j])) {
					cnt++;
				}
			}
			if(cnt == 0) {
				list[nxt++] = regions[i];
			}
		}
		region = list[0];
		for(int i = 1; i < list.length ; i++) {
			if(list[i] != null) {
				region += "/"+list[i];
			}
		}
	
		this.region = region;
	}


	public int getNoroutecate() {
		return noroutecate;
	}


	public void setNoroutecate(int noroutecate) {
		this.noroutecate = noroutecate;
	}

	

}
