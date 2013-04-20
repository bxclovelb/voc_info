package dao.impl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dao.WInfoDao;

public class WInfoDaoImpl implements WInfoDao{
	private SessionFactory sessionFactoryW;
	
	@Override
	public List<String> getUserExers(String userId, int pageNo , int countPerPage) {
		
		Session session = sessionFactoryW.openSession();
		String sql = "SELECT score,serial_number,date_time"
				+" FROM user_vocabulary_submit_record WHERE user_id = '"+userId
				+"' ORDER BY date_time DESC LIMIT "+(pageNo * countPerPage)+","
				+countPerPage;
		SQLQuery query = session.createSQLQuery(sql);
		
		List<String> exers = query.list();
		
		session.close();
		
		return exers;
	}
	@Override
	public Integer getCountPages(String userId,int countPerPage) {
		Session session = sessionFactoryW.openSession();
		String sql = "SELECT * FROM user_vocabulary_submit_record WHERE user_id = '"
				+userId+"'";
		SQLQuery query = session.createSQLQuery(sql);
		
		int count = query.list().size();
		int pages = count / countPerPage;
		if(count % countPerPage != 0){
			pages++;
		}
		
		session.close();
		
		return pages;
	}
	@Override
	public List<Integer> getRandomExers(int numExer) {
		Session session = sessionFactoryW.openSession();
		String sql = "SELECT MAX(index_id) max_id FROM cached_voc_expanding";
		SQLQuery query = session.createSQLQuery(sql);
		List list = query.list();
		
		int maxId = Integer.parseInt(list.get(0).toString());
		
		List<Integer> randIds = new ArrayList<Integer>();
		for(int i=0;i<numExer;i++){
			while(true){
				Random rand = new Random();
				int randId = rand.nextInt(maxId);
				sql = "SELECT * FROM cached_voc_expanding WHERE index_id = "+randId;
				query = session.createSQLQuery(sql);
				int count = query.list().size();
				
				if(count != 0){
					boolean flag = true;
					if(randIds.contains(randId)){
						flag = false;
					}
					if(flag){
						randIds.add(randId);
						break;
					}
				}
			}
		}
		
		return randIds;
	}
	
	
	

	public SessionFactory getSessionFactoryW() {
		return sessionFactoryW;
	}
	public void setSessionFactoryW(SessionFactory sessionFactoryW) {
		this.sessionFactoryW = sessionFactoryW;
	}
}