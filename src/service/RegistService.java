package service;

import java.util.HashMap;
import java.util.Map;

import dao.RegistDao;

public class RegistService {
	private RegistDao registDao;

	
	public Map saveUser(String username, String password, String nickname,
			String email) {
		Map data = new HashMap();
		
		boolean success = registDao.saveUser(username,password,nickname,email);
		data.put("success", success);
		
		return data;
	}
	public boolean checkUsername(String username) {
		return registDao.checkUsername(username);
	}
	
	
	
	public RegistDao getRegistDao() {
		return registDao;
	}
	public void setRegistDao(RegistDao registDao) {
		this.registDao = registDao;
	}
}
