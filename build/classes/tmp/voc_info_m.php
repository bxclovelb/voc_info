<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Voc_info_m extends CI_Model {
	
	function __construct(){
		parent::__construct();
	}

	//获得最近十个复习单词
	function get_recent_ten_words($user_id){
		$config = $this->get_database_config("genway_vocabulary");
		$db_vocabulary = $this->load->database($config, TRUE);
		
		$sql = "SELECT word FROM vocbook_users_words WHERE user_id = '".$user_id."' ORDER BY create_date DESC LIMIT 0,10";
		$result = $db_vocabulary->query($sql)->result();
		return $result;
	}
	
	//获得所做的练习的信息
	function get_user_exers($user_id,$page_no){
		//每页显示个数
		$count_per_page = 5;
		
		$config = $this->get_database_config("genway_w");
		$db_w = $this->load->database($config, TRUE);
		
		$sql = "SELECT score,serial_number,date_time FROM user_vocabulary_submit_record WHERE user_id = '".$user_id."' ORDER BY date_time DESC LIMIT ".($page_no*$count_per_page).",".$count_per_page;
		$result = $db_w->query($sql)->result();
		
		return $result;
	}
	
	//获得用户练习分页数
	function get_count_pages($user_id){
		//每页显示个数
		$count_per_page = 5;
		
		$config = $this->get_database_config("genway_w");
		$db_w = $this->load->database($config, TRUE);
	
		$sql = "SELECT * FROM user_vocabulary_submit_record WHERE user_id = '".$user_id."'";
		$count = $db_w->query($sql)->num_rows();
		$pages = floor($count / $count_per_page);
		if($count % $count_per_page != 0){
			$pages++;
		}
		
		return $pages;
	}
	
	//获得用户词汇量
	function get_vocabulary($user_id){
		$config = $this->get_database_config("genway_vocabulary");
		$db_vocabulary = $this->load->database($config, TRUE);
		
		$sql = "SELECT vocabulary FROM voc_test_users_vocabulary WHERE user_id = '".$user_id."'";
		$result = $db_vocabulary->query($sql)->result();
		
		if($result == null || $result == ""){
			$result = "";
		}else{
			$result = $result[0]->vocabulary; 
		}
		
		return $result;
	}
	
	//保存用户所选级别
	function save_user_band($user_id,$band){
		$config = $this->get_database_config("genway_vocabulary");
		$db_vocabulary = $this->load->database($config, TRUE);
		
		$sql = "SELECT COUNT(*) count FROM vocbook_users_band WHERE user_id = '".$user_id."'";
		$result = $db_vocabulary->query($sql)->result();
		$count = $result[0]->count;
		
		if($count == 0){
			$sql = "INSERT INTO vocbook_users_band(user_id,band) VALUES('".$user_id."',".$band.")";
			$db_vocabulary->query($sql);
		}else{
			$sql = "UPDATE vocbook_users_band SET band=".$band." WHERE user_id = '".
					$user_id."'";
			$db_vocabulary->query($sql);
		}
	}
	
	//获得用户上一次所选级别
	function get_user_band($user_id){
		$config = $this->get_database_config("genway_vocabulary");
		$db_vocabulary = $this->load->database($config, TRUE);
		
		$sql = "SELECT band FROM vocbook_users_band WHERE user_id = '".$user_id."'";
		$result = $db_vocabulary->query($sql)->result();
		
		if($result == null || $result == ""){
			$result = -1;
		}else{
			$result = $result[0]->band;
		}
		
		return $result;
	}
	
	//获得随机推荐的试题
	function get_random_exer($num_exer){
		$config = $this->get_database_config("genway_w");
		$db_w = $this->load->database($config, TRUE);
		
		$sql = "SELECT MAX(index_id) max_id FROM cached_voc_expanding";		
		$result = $db_w->query($sql)->result();
		$max_id = $result[0]->max_id;
		
		$rand_ids = Array();
		for($i = 0;$i < $num_exer;$i++){
			while(true){
				$rand_id = floor(rand(0, $max_id + 1));
				$sql = "SELECT * FROM cached_voc_expanding WHERE index_id = ".$rand_id;
				$count = $db_w->query($sql)->num_rows();
				if($count != 0){
					$flag = true;
					for($j = 0;$j < count($rand_ids);$j++){
						if($rand_id == $rand_ids[$j]){
							$flag = false;
							break;
						}
					}
					if($flag){
						$rand_ids[] = $rand_id;
						break;
					}
				}
			}
		}
		
		return $rand_ids;
	}
	
	
	
	//获得指定数据库的配置
	function get_database_config($db_name){
		$config['hostname'] = "localhost";
		$config['username'] = "bingoenglish";
		$config['password'] = "bingoenglish";
		$config['database'] = $db_name;
		$config['dbdriver'] = "mysql";
		$config['dbprefix'] = "";
		$config['pconnect'] = FALSE;
		$config['db_debug'] = TRUE;
		$config['cache_on'] = FALSE;
		$config['cachedir'] = "";
		$config['char_set'] = "utf8";
		$config['dbcollat'] = "utf8_general_ci";
		return $config;
	}
	
}
