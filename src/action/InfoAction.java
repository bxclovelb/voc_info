package action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import service.InfoService;

import com.opensymphony.xwork2.ActionSupport;

public class InfoAction extends ActionSupport {
	private String userId;
	private String nickname;
	private String username;
	private String email;
	private int pageNo;
	private int theBand;
	private int numExer;
	
	private Map<String,Object> data = new HashMap<String,Object>();
	
	private InfoService infoService;
	
	
	
	public String showInfo(){
		Object[] info = infoService.getUserInfo(userId);
		username = (String)info[0];
		nickname = (String)info[1];
		email = (String)info[2];
		return SUCCESS;
	}
	public String getRecentTenWords(){
		data.clear();
		data = infoService.getRecentTenWords(userId);
		return SUCCESS;
	}
	public String getUserBand(){
		data.clear();
		data = infoService.getUserBand(userId);
		return SUCCESS;
	}
	public String getVocabulary(){
		data.clear();
		data = infoService.getVocabulary(userId);
		return SUCCESS;
	}
	public String getUserExers(){
		data.clear();
		data = infoService.getUserExers(userId,pageNo);
		
		List<Object[]> list = (List<Object[]>)data.get("exers");
		for(Object[] obj : list){
			System.out.println(obj[2]);
		}
		
		return SUCCESS;
	}
	public String getCountPages(){
		data.clear();
		data = infoService.getCountPages(userId);
		return SUCCESS;
	}
	public String getRandomExers(){
		data.clear();
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
