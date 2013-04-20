<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Voc_info_c extends CI_Controller {

	public function index($user_id)
	{
		$data['user_id'] = $user_id;
		$this->load->view('voc_info_v',$data);
	}
	
	//获得最近十个复习单词
	function get_recent_ten_words($user_id){
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_recent_ten_words($user_id);
		 
		echo json_encode($result);
	} 
	
	//获得所做的练习的信息
	function get_user_exers($user_id,$page_no){
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_user_exers($user_id,$page_no);
			
		echo json_encode($result);
	}
	
	//获得用户练习分页数
	function get_count_pages($user_id){
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_count_pages($user_id);
	
		echo json_encode($result);
	}
	
	//获得用户词汇量
	function get_vocabulary($user_id){
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_vocabulary($user_id);
		
		echo json_encode($result);
	}
	
	//保存用户所选级别
	function save_user_band($user_id,$band){
		$this->load->model("voc_info_m");
		$this->voc_info_m->save_user_band($user_id,$band);
	}
	
	//获得用户上一次所选级别
	function get_user_band($user_id){
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_user_band($user_id);
		
		echo json_encode($result);
	}
	
	//获得随机推荐的试题
	function get_random_exers($num_exer){
		//试题套数
		$num_exer = 10;
		
		$this->load->model("voc_info_m");
		$result = $this->voc_info_m->get_random_exer($num_exer);
		
		echo json_encode($result);
	}

}
