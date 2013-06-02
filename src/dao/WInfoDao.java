package dao;

import java.util.List;

public interface WInfoDao {

	public List<Object[]> getUserExers(String userId, int pageNo , int countPerPage);

	public Integer getCountPages(String userId,int countPerPage);

	public List<Integer> getRandomExers(int countPerPage);

	public Object[] getuserInfo(String userId);


}
