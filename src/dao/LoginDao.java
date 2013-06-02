package dao;

public interface LoginDao{

	public boolean login(String username, String password) ;

	public String getUserId(String username);

	public String getNickname(String username);

}
