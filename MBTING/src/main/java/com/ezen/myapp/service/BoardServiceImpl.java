package com.ezen.myapp.service;

import java.beans.Transient;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.myapp.domain.BoardVo;
import com.ezen.myapp.domain.CommentVo;
import com.ezen.myapp.domain.SearchCriteria;
import com.ezen.myapp.persistence.BoardService_Mapper;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService  {

	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public int boardInsert(String subject, String contents, String pwd, String ip, int midx, String filename) {
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("subject", subject);
		hm.put("contents", contents);
		hm.put("pwd", pwd);
		hm.put("ip", ip);
		hm.put("midx", midx);
		hm.put("filename", filename);
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int result = bsm.boardInsert(hm);
		
		return result;
	}


	@Override
	public int boardTotalCount(SearchCriteria scri) {
		int cnt = 0;
		BoardService_Mapper bsm=sqlSession.getMapper(BoardService_Mapper.class);
		cnt = bsm.boardTotalCount(scri);
		return cnt;
	}
	
	@Override
	public int boardTotalCount2(SearchCriteria scri, int midx) {
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("scri", scri);
		hm.put("midx", midx);
		int cnt = 0;
		BoardService_Mapper bsm=sqlSession.getMapper(BoardService_Mapper.class);
		cnt = bsm.boardTotalCount2(hm);
		return cnt;
	}


	@Override
	public ArrayList<BoardVo> boardSelectAll(SearchCriteria scri) {

		HashMap<String,Object> hm = new HashMap<String, Object>();
		hm.put("keyword", scri.getKeyword());
		hm.put("searchType", scri.getSearchType());
		hm.put("start", (scri.getPage()-1)*scri.getPerPageNum());
		hm.put("end", scri.getPerPageNum());
		ArrayList<BoardVo> alist = null;
		System.out.println("alist:"+alist);
		BoardService_Mapper bsm =sqlSession.getMapper(BoardService_Mapper.class);
		System.out.println("alist:"+alist);
		alist = bsm.boardSelectAll(hm);
		System.out.println("alist:"+alist);
		System.out.println("keyword:"+scri.getKeyword());
		System.out.println("searchType:"+scri.getSearchType());
		return alist;
	}
	
	@Override
	public ArrayList<BoardVo> boardSelectAll2(SearchCriteria scri, int midx) {
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("start", (scri.getPage()-1)*scri.getPerPageNum());
		hm.put("end", scri.getPerPageNum());
		hm.put("midx", midx);
		ArrayList<BoardVo> alist2 = null;
		BoardService_Mapper bsm =sqlSession.getMapper(BoardService_Mapper.class);	
		alist2 = bsm.boardSelectAll2(hm);
		System.out.println("alist2:"+alist2.get(0).getBidx());
		return alist2;
	}

	@Override
	public BoardVo boardSelectOne(int bidx) {
		
	BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
	BoardVo bv = bsm.boardSelectOne(bidx);			
		return bv;
	}


	@Override
	public ArrayList<CommentVo> commentSelectAll(int bidx) {
	BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
	ArrayList<CommentVo> clist = bsm.commentSelectAll(bidx);
		
		return clist;
	}


	@Override
	public int commentInsert(CommentVo cv) {
	
	//HashMap<String,Object> hm = new HashMap<String,Object>();	
		
		
	BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
	int value = bsm.commentInsert(cv);
		
		
		return value;
	}

	@Transactional
	@Override
	public int commentDel(int cidx,int bidx) {

		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int value = bsm.commentDel(cidx);
		bsm.updateReplyCnt(bidx);
		
		return value;
	}


	@Override
	public ArrayList<CommentVo> commentMo(int bidx, int page) {
		
		HashMap<String,Integer> hm = new HashMap<String,Integer>();
		hm.put("bidx", bidx);
		
		//mysql limit에서 연산이 안되어서 *5추가
		hm.put("page", 5*page);		
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		ArrayList<CommentVo> clist = bsm.commentMo(hm);
		return clist;
	}


	@Override
	public int commentTotalPage(int bidx) {
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int value = bsm.commentTotalPage(bidx);	
		
		return value;
	}


	@Override
	public int boardModify(int bidx, String subject, String contents, String pwd) {
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("bidx", bidx);
		hm.put("subject", subject);	
		hm.put("contents", contents);	
		hm.put("pwd", pwd);	
		
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int value = bsm.boardModify(hm);
		return value;
	}


	@Override
	public int boardDelete(int bidx, String pwd) {
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("bidx", bidx);
		hm.put("pwd", pwd);			
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int value = bsm.boardDelete(hm);
		
		return value;
	}

	@Override
	public boolean plusCnt(int bidx) {
		
	BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
	
	boolean value = bsm.plusCnt(bidx);
	 
	return value;
	}


	@Override
	public int updateReplyCnt(int bidx) {
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		
		int value = bsm.updateReplyCnt(bidx);
		
		return value;
	}



	@Override
	public int hitCnt(int bidx) {
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		
		int value = bsm.hitCnt(bidx);
		
		return value;
	}

	@Override
	public int Inserthit(int bidx, int midx) {
		HashMap<String,Object> hm = new HashMap<String,Object>();
		
		hm.put("bidx", bidx);
		hm.put("midx", midx);
		
		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);
		int result = bsm.Inserthit(hm);
		
		return result;
	}




//	@Transactional
//	@Override
//	public int boardReply(int originbidx, int depth, int nlevel, String subject, String contents, String writer,
//			String ip, int midx, String pwd) {
//		
//		HashMap<String,Object> hm =new HashMap<String,Object>();
//		hm.put("originbidx", originbidx);
//		hm.put("depth", depth);
//		hm.put("nlevel", nlevel);
//		hm.put("subject", subject);	
//		hm.put("contents", contents);	
//		hm.put("writer", writer);	
//		hm.put("pwd", pwd);
//		hm.put("ip", ip);
//		hm.put("midx", midx);
//		
//		BoardService_Mapper bsm = sqlSession.getMapper(BoardService_Mapper.class);	
//		bsm.boardReplyUpdate(originbidx, depth);
//		int value = bsm.boardReplyInsert(hm);
//		return value;
//	}




}
