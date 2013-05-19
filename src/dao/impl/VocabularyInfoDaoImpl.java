package dao.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dao.VocabularyInfoDao;

public class VocabularyInfoDaoImpl implements VocabularyInfoDao{
	private SessionFactory sessionFactoryVocabulary;
	
	@Override
	public List<String> getRecentTenWords(String userId) {
		Session session = sessionFactoryVocabulary.openSession();
		String sql = "SELECT word FROM vocbook_users_words WHERE user_id = '"+userId
					+"' ORDER BY create_date DESC LIMIT 0,10";
		SQLQuery query = session.createSQLQuery(sql);
		
		List<String> words = query.list();
		
		session.close();
		
		return words;
	}
	@Override
	public Integer getUserBand(String userId) {
		Session session = sessionFactoryVocabulary.openSession();
		String sql = "SELECT band FROM vocbook_users_band WHERE user_id = '"+userId+"'";
		SQLQuery query = session.createSQLQuery(sql);
		
		List<Integer> bands = query.list();
		int band = 0;
		
		if(bands.size() == 0){
			band = -1;
		}else{
			band = (Integer)bands.get(0);
		}
		session.close();
		return band;
	}
	@Override
	public Integer getVocabulary(String userId) {
		Session session = sessionFactoryVocabulary.openSession();
		String sql = "SELECT vocabulary FROM voc_test_users_vocabulary WHERE user_id = '"
				+userId+"'";
		SQLQuery query = session.createSQLQuery(sql);
		
		List<Integer> vocs = query.list();
		int voc = 0;
		
		if(vocs.size() == 0){
			voc = -1;
		}else{
			voc = (Integer)vocs.get(0);
		}
		session.close();
		return voc;
	}
	@Override
	public void saveUserBand(String userId, int theBand) {
		Session session = sessionFactoryVocabulary.openSession();
		String sql = "SELECT COUNT(*) count FROM vocbook_users_band WHERE user_id = '"
				+userId+"'";
		SQLQuery query = session.createSQLQuery(sql);
		
		int count = Integer.parseInt(query.list().get(0).toString());

		if(count == 0){
			sql = "INSERT INTO vocbook_users_band(user_id,band) VALUES('"
					+userId+"',"+theBand+")";
			query = session.createSQLQuery(sql);
			query.executeUpdate();
		}else{
			sql = "UPDATE vocbook_users_band SET band="+theBand+" WHERE user_id = '"
					+userId+"'";
			query = session.createSQLQuery(sql);
			query.executeUpdate();
		}
		
		session.close();
	}
	

	public SessionFactory getSessionFactoryVocabulary() {
		return sessionFactoryVocabulary;
	}
	public void setSessionFactoryVocabulary(SessionFactory sessionFactoryVocabulary) {
		this.sessionFactoryVocabulary = sessionFactoryVocabulary;
	}
	
}
