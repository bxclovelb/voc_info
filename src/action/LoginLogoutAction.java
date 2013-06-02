package action;

import java.util.Map;

import service.LoginLogoutService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class LoginLogoutAction extends ActionSupport {
	private String username;
	private String password;
	
	private LoginLogoutService loginLogoutService;
	
	private Map data;
	
	public String showLogin(){
		return SUCCESS;
	}
	public String login(){
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session = context.getSession();
		data = loginLogoutService.login(username,password,session);
		return SUCCESS;
	}
	public String logout(){
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session = context.getSession();
		data = loginLogoutService.logout(session);
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
	public LoginLogoutService getLoginLogoutService() {
		return loginLogoutService;
	}
	public void setLoginLogoutService(LoginLogoutService loginLogoutService) {
		this.loginLogoutService = loginLogoutService;
	}
	public Map getData() {
		return data;
	}
	public void setData(Map data) {
		this.data = data;
	}
}
