package dao;

import java.util.List;

public interface VocabularyInfoDao {

	public List<String> getRecentTenWords(String userId);

	public Integer getUserBand(String userId);

	public Integer getVocabulary(String userId);

	public void saveUserBand(String userId, int theBand);

}
