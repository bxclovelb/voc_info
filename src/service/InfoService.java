package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.VocabularyInfoDao;
import dao.WInfoDao;

public class InfoService {
	private VocabularyInfoDao vocabularyInfoDao ;
	private WInfoDao wInfoDao ;
	
	private static final int COUNT_PER_PAGE = 5;
	

	public Map getRecentTenWords(String userId) {
		Map<String,List> data = new HashMap<String,List>();
		
		List<String> words = vocabularyInfoDao.getRecentTenWords(userId);
		
		data.put("words", words);
		
		return data;
	}
	public Map getUserBand(String userId) {
		Map<String,Integer> data = new HashMap<String,Integer>();
		
		Integer band = vocabularyInfoDao.getUserBand(userId);
		
		data.put("band", band);
		
		return data;
	}
	public Map getVocabulary(String userId) {
		Map<String,Integer> data = new HashMap<String,Integer>();
		
		Integer voc = vocabularyInfoDao.getVocabulary(userId);
		
		data.put("voc", voc);
		
		return data;
	}
	public Map getUserExers(String userId, int pageNo) {
		Map<String,List> data = new HashMap<String,List>();
		
		List exers = wInfoDao.getUserExers(userId,pageNo,COUNT_PER_PAGE);
		
		data.put("exers", exers);
		
		return data;
	}
	public Map getCountPages(String userId) {
		Map<String,Integer> data = new HashMap<String,Integer>();
		
		Integer count = wInfoDao.getCountPages(userId,COUNT_PER_PAGE);
		
		data.put("count", count);
		
		return data;
	}
	public Map getRandomExers(int numExer) {
		Map<String,List> data = new HashMap<String,List>();
		
		List ids = wInfoDao.getRandomExers(numExer);
		
		data.put("ids", ids);
		
		return data;
	}
	public void saveUserBand(String userId, int theBand) {
		vocabularyInfoDao.saveUserBand(userId,theBand);
	}
	
	


	public VocabularyInfoDao getVocabularyInfoDao() {
		return vocabularyInfoDao;
	}
	public void setVocabularyInfoDao(VocabularyInfoDao vocabularyInfoDao) {
		this.vocabularyInfoDao = vocabularyInfoDao;
	}
	public WInfoDao getwInfoDao() {
		return wInfoDao;
	}
	public void setwInfoDao(WInfoDao wInfoDao) {
		this.wInfoDao = wInfoDao;
	}
}
