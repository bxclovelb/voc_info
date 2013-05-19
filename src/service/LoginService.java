package service;

import java.util.HashMap;
import java.util.Map;

import dao.LoginDao;

public class LoginService {
	
	private LoginDao loginDao ;

	public Map login(String username, String password) {
		Map data = new HashMap();
		
		boolean success = loginDao.login(username,password);
		data.put("success", success);
		
		if(success){
			data.put("userId", loginDao.getUserId(username));
		}
		
		return data;
	}

	public LoginDao getLoginDao() {
		return loginDao;
	}
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
}
