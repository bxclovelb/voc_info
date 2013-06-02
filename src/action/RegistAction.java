package action;

import java.util.Map;

import service.LoginLogoutService;
import service.RegistService;

import com.opensymphony.xwork2.ActionSupport;

public class RegistAction extends ActionSupport {
	private String username;
	private String password;
	private String nickname;
	private String email;
	
	private RegistService registService;
	
	private Map data;
	private boolean result;
	
	public String showRegist(){
		return SUCCESS;
	}
	public String saveUser(){
		System.out.println(username+","+password+","+nickname+","+email);
		data = registService.saveUser(username,password,nickname,email);
		return SUCCESS;
	}
	public String checkUsername(){
		result = registService.checkUsername(username);
		return SUCCESS;
	}
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public RegistService getRegistService() {
		return registService;
	}
	public void setRegistService(RegistService registService) {
		this.registService = registService;
	}
	public Map getData() {
		return data;
	}
	public void setData(Map data) {
		this.data = data;
	}
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
}
