package dao.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import dao.RegistDao;

public class RegistDaoImpl implements RegistDao {
	private SessionFactory sessionFactoryW;


	@Override
	public boolean saveUser(String username, String password, String nickname,
			String email) {
		Session session = sessionFactoryW.openSession();
		String sql = "INSERT INTO users (username,user_id,password,nickname,email,create_date) "+
				"VALUES('"+username+"','"+
				UUID.randomUUID().toString().trim().replaceAll("-","")+"','"+
				password+"','"+nickname+"','"+email+"','"+
				SimpleDateFormat.getDateTimeInstance().format(new Date())+"')";
		Transaction tx = session.beginTransaction();
		SQLQuery query = session.createSQLQuery(sql);
		
		try {
			query.executeUpdate();
			return true;
		} catch (Exception e) {
			return false;
		} finally{
			tx.commit();
			session.close();
		}
	}
	@Override
	public boolean checkUsername(String username) {
		Session session = sessionFactoryW.openSession();
		String sql = "SELECT COUNT(username) count FROM users WHERE username = '"+
				username+"'";
		SQLQuery query = session.createSQLQuery(sql);
		int count = Integer.parseInt(query.list().get(0).toString());
		
		if(count == 0){
			return true;
		}else{
			return false;
		}
	}
	
	
	
	public SessionFactory getSessionFactoryW() {
		return sessionFactoryW;
	}
	public void setSessionFactoryW(SessionFactory sessionFactoryW) {
		this.sessionFactoryW = sessionFactoryW;
	}
}
