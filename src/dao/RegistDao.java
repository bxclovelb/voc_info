package dao;

public interface RegistDao {

	public boolean saveUser(String username, String password, String nickname,
			String email);

	public boolean checkUsername(String username);

}
