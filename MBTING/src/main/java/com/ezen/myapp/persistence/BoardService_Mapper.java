package com.ezen.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;

import com.ezen.myapp.domain.BoardVo;
import com.ezen.myapp.domain.CommentVo;
import com.ezen.myapp.domain.SearchCriteria;

public interface BoardService_Mapper {
	
	public int boardInsert(HashMap<String,Object> hm);

	public int boardTotalCount(SearchCriteria scri);
	
	public int boardTotalCount2(HashMap<String,Object> hm);
	
	public ArrayList<BoardVo> boardSelectAll(HashMap<String, Object> hm);
	
	public ArrayList<BoardVo> boardSelectAll2(HashMap<String,Object> hm);

	public BoardVo boardSelectOne(int bidx);

	public ArrayList<CommentVo> commentSelectAll(int bidx);

	public int commentInsert(CommentVo cv);
	
	public int commentDel(int cidx);
	
	public ArrayList<CommentVo> commentMo(HashMap<String,Integer> hm);

	public int commentTotalPage(int bidx);
	
	public int boardModify(HashMap<String,Object> hm);
	
	public int boardDelete(HashMap<String,Object> hm);

	public boolean plusCnt(int bidx);

	public int updateReplyCnt(int bidx);

	public int hitCnt(int bidx);

	public int Inserthit(HashMap<String,Object> hm);




	



}
