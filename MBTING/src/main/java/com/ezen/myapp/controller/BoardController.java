package com.ezen.myapp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ezen.myapp.service.BoardService;
import com.ezen.myapp.util.MediaUtils;
import com.ezen.myapp.util.UploadFileUtiles;
import com.ezen.myapp.domain.BoardVo;
import com.ezen.myapp.domain.CommentVo;
import com.ezen.myapp.domain.MemberVo;
import com.ezen.myapp.domain.PageMaker;
import com.ezen.myapp.domain.SearchCriteria;


@Controller
public class BoardController  {
	
	@Autowired
	BoardService bs;
	
	//@Autowired
	//SqlSession sqlsession;
	
	@Autowired
	PageMaker pm;
	
	@Resource(name="uploadPath2")
	private String uploadPath;	
	
	@RequestMapping(value="/boardWrite.do")
	public String boardWrite() {		
		//System.out.println("sqlsession"+sqlsession);
		return "boardWrite";
	}	
	
	@RequestMapping(value="/board/boardWriteAction.do")
	public String boardWriteAction(
			@RequestParam("subject") String subject,
			@RequestParam("contents") String contents,
			@RequestParam("pwd") String pwd,
			@RequestParam("uploadfile") String uploadfile,
			HttpSession session
			) {		
		String ip= null;
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {			
			e.printStackTrace();
		}
		int midx = (int)session.getAttribute("midx");
		String membernickname = (String)session.getAttribute("membernickname");
		String membermbti= (String)session.getAttribute("membermbti");
		int result = bs.boardInsert(subject, contents, pwd, ip, midx, uploadfile);
		
		return "redirect:/boardList.do";
	}
	@RequestMapping(value="/boardList.do")
	public String boardList(SearchCriteria scri, Model model) {
	
		System.out.println("scri:"+scri);	
	int cnt = bs.boardTotalCount(scri);
	System.out.println("cnt"+cnt);
	ArrayList<BoardVo> alist = 	bs.boardSelectAll(scri);
	System.out.println("alist"+alist);	
	
	pm.setScri(scri);
	pm.setTotalCount(cnt);
	
	model.addAttribute("alist", alist);
	model.addAttribute("pm", pm);
		
	return "boardList";
	}
	
	@RequestMapping(value="/board/boardContents.do")
	public String boardContents(
			@RequestParam("bidx") int bidx,		
			Model model,HttpSession session) {		
		BoardVo bv = bs.boardSelectOne(bidx);
		model.addAttribute("bv", bv);
		bs.plusCnt(bidx);//조회수
		bs.hitCnt(bidx);//추천수 
		int midx = (int)session.getAttribute("midx");
		String membernickname = (String)session.getAttribute("membernickname");
		model.addAttribute("midx", midx);
		model.addAttribute("membernickname", membernickname);
		
		return "boardContents";
	}
	
	//추천하기
		@ResponseBody
		@RequestMapping(value="/board/hitAction.do")
		public HashMap<String,Integer>Inserthit(@RequestParam("bidx") int bidx,HttpSession session
				) {
			String ip= null;
			try {
				ip = InetAddress.getLocalHost().getHostAddress();
			} catch (UnknownHostException e) {			
				e.printStackTrace();
			}
			System.out.println("hitAction : "+bidx);
			int midx = (int)session.getAttribute("midx");
			int result = bs.Inserthit(bidx,midx);
			int result2 = bs.hitCnt(bidx);//추천수 
			System.out.println("result:"+result);
			System.out.println("result2:"+result2);
			HashMap<String,Integer> hm = new HashMap<String,Integer>();
			System.out.println("hm"+hm);
			hm.put("result", result);		
			
			return hm;
		}
		
		
	@RequestMapping(value="/board/boardModify.do")
	public String boardModify(
			@RequestParam("bidx") int bidx, 
			Model model) {
		
		
		BoardVo bv = bs.boardSelectOne(bidx);
		model.addAttribute("bv", bv);		
		
		return "boardModify";
	}
	
	@RequestMapping(value="/board/boardModifyAction.do")
	public String boardModifyAction(
			@RequestParam("bidx") int bidx,
			@RequestParam("subject") String subject,
			@RequestParam("contents") String contents,
			@RequestParam("pwd") String pwd,
			RedirectAttributes rttr
			) {
		
		int value = bs.boardModify(bidx, subject, contents, pwd);
		
		String movelocation = null;
		if (value ==0) {
			movelocation = "redirect:/board/boardModify.do?bidx="+bidx;			
		}else {
			rttr.addFlashAttribute("msg", "수정완료되었습니다.");
			movelocation = "redirect:/board/boardContents.do?bidx="+bidx;			
		}
		
		return movelocation;
	}
	
	@RequestMapping(value="/board/boardDelete.do")
	public String boardDelete(
			@ModelAttribute("bidx") int bidx,Model model) {
		

		BoardVo bv = bs.boardSelectOne(bidx);
		model.addAttribute("bv", bv);		
		
		return "boardDelete";
	}
	
	@RequestMapping(value="/board/boardDeleteAction.do")
	public String boardDeleteAction(
			@RequestParam("bidx") int bidx,			
			@RequestParam("pwd") String pwd,
			RedirectAttributes rttr
			) {
		

		int value = bs.boardDelete(bidx, pwd);
		rttr.addFlashAttribute("msg", "삭제완료되었습니다.");
		
		
		return "redirect:/boardList.do";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/board/uploadAjax.do",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		
		System.out.println("파일이름:"+file.getOriginalFilename());		
	
		String uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, 
				file.getOriginalFilename(), 
				file.getBytes());
		
		
		ResponseEntity<String> entity = null;
		entity = new ResponseEntity<String>(uploadedFileName,HttpStatus.CREATED);
		
		//  /2018/05/30/s-dfsdfsdf-dsfsff.jsp
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/board/displayFile.do", method=RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		
		System.out.println("fileName:"+fileName);
		
		InputStream in = null;		
		ResponseEntity<byte[]> entity = null;
		
	//	logger.info("FILE NAME :"+fileName);
		
		try{
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();		
			 
			in = new FileInputStream(uploadPath+fileName);
			
			
			if(mType != null){
				headers.setContentType(mType);
			}else{
				
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");				
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers,
					HttpStatus.CREATED);
			
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally{
			in.close();
		}
		return entity;
	} 
} 

	
	
	
	

