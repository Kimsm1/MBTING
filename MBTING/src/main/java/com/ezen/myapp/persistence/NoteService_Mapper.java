package com.ezen.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;

import com.ezen.myapp.domain.BoardVo;
import com.ezen.myapp.domain.NoteVo;
import com.ezen.myapp.domain.SearchCriteria;


public interface NoteService_Mapper {
	
	public int noteSend(HashMap<String,Object> hm);
	
	public ArrayList<NoteVo> noteListRecv(String recv_nick);
	
	public ArrayList<NoteVo> noteListSend(String send_nick);

	public int noteDelete(int no);

	public NoteVo noteSelectOne(int no);
	
	public int noteTotalCount(String send_nick);
	
	public int noteTotalCount2(String recv_nick);

	public ArrayList<NoteVo> noteSelectAll(HashMap<String, Object> hm);
	



}
