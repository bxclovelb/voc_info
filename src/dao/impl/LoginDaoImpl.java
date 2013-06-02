package dao.impl;

import java.math.BigInteger;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dao.LoginDao;

public class LoginDaoImpl implements LoginDao {
	private SessionFactory sessionFactoryW;
	
	@Override
	public boolean login(String username, String password) {
		String sql = "SELECT COUNT(*) count FROM users "+
				"WHERE username = '"+username+
				"' AND password = '"+password+"'";
		
		Session session = sessionFactoryW.openSession();
		SQLQuery query = session.createSQLQuery(sql);
		int count = Integer.parseInt(((BigInteger)query.list().get(0)).toString());
		
		session.close();
		
		if(count == 1){
			return true;
		}else{
			return false;
		}
	}
	@Override
	public String getUserId(String username) {
		String sql = "SELECT user_id FROM users "+
				"WHERE username = '"+username+"'";
		
		Session session = sessionFactoryW.openSession();
		SQLQuery query = session.createSQLQuery(sql);
		String userId = (String)query.list().get(0);
		
		session.close();
		
		return userId;
	}
	@Override
	public String getNickname(String username) {
		String sql = "SELECT nickname FROM users WHERE username = '"+
				username+"'";
		Session session = sessionFactoryW.openSession();
		SQLQuery query = session.createSQLQuery(sql);
		String nickname = (String)query.list().get(0);
		
		session.close();
		
		return nickname;
	}
	

	public SessionFactory getSessionFactoryW() {
		return sessionFactoryW;
	}
	public void setSessionFactoryW(SessionFactory sessionFactoryW) {
		this.sessionFactoryW = sessionFactoryW;
	}
}
