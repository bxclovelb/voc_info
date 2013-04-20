package action;

import java.util.HashMap;
import java.util.Map;

import service.InfoService;

import com.opensymphony.xwork2.ActionSupport;

public class InfoAction extends ActionSupport {
	private String userId;
	private int pageNo;
	private int theBand;
	private int numExer;
	
	private Map<String,Object> data = new HashMap<String,Object>();
	
	private InfoService infoService;
	
	
	
	public String showInfo(){
		return SUCCESS;
	}
	public String getRecentTenWords(){
		data = infoService.getRecentTenWords(userId);
		return SUCCESS;
	}
	public String getUserBand(){
		data = infoService.getUserBand(userId);
		return SUCCESS;
	}
	public String getVocabulary(){
		data = infoService.getVocabulary(userId);
		return SUCCESS;
	}
	public String getUserExers(){
		data = infoService.getUserExers(userId,pageNo);
		return SUCCESS;
	}
	public String getCountPages(){
		data = infoService.getCountPages(userId);
		return SUCCESS;
	}
	public String getRandomExers(){
		data = infoService.getRandomExers(numExer);
		return SUCCESS;
	}
	public String saveUserBand(){
		infoService.saveUserBand(userId,theBand);
		return SUCCESS;
	}
	

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getTheBand() {
		return theBand;
	}
	public void setTheBand(int theBand) {
		this.theBand = theBand;
	}
	public int getNumExer() {
		return numExer;
	}
	public void setNumExer(int numExer) {
		this.numExer = numExer;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	public InfoService getInfoService() {
		return infoService;
	}
	public void setInfoService(InfoService infoService) {
		this.infoService = infoService;
	}
}
