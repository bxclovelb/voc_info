package service;

import java.util.HashMap;
import java.util.Map;

import dao.LoginDao;

public class LoginLogoutService {
	
	private LoginDao loginDao ;

	public Map login(String username, String password, Map<String, Object> session) {
		Map data = new HashMap();
		
		boolean success = loginDao.login(username,password);
		data.put("success", success);
		
		if(success){
			String userId = loginDao.getUserId(username); 
			data.put("userId", userId);
			session.put("userId", userId);
			
			String nickname = loginDao.getNickname(username);
			session.put("nickname", nickname);
		}
		
		return data;
	}
	public Map logout(Map<String, Object> session) {
		Map data = new HashMap();

		String nickname = (String)session.get("nickname");
		String userId = (String)session.get("userId");
		if(nickname != null && userId != null){
			session.remove("nickname");
			session.remove("userId");
		}
		data.put("success", true);
		
		return data;
	}
	

	public LoginDao getLoginDao() {
		return loginDao;
	}
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
}
