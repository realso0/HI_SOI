package com.bit.hi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bit.hi.domain.vo.LikeVo;
import com.bit.hi.domain.vo.PostVo;
import com.bit.hi.domain.vo.ScrapVo;
import com.bit.hi.domain.vo.UserVo;
import com.bit.hi.service.PostService;
import com.bit.hi.util.ArrayCriteria;
import com.bit.hi.util.FindCriteria;
import com.bit.hi.util.PagingMaker;

@Controller
@RequestMapping("/post")
public class PostController {
	
	private static final Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@Autowired
	private PostService postService;

	@RequestMapping(value="/soifactorylist")
	public String soiFactoryList(@ModelAttribute("fCri") FindCriteria fCri, @ModelAttribute("arrCri") ArrayCriteria arrCri, Model model) throws Exception{

		model.addAttribute("bindMap", postService.getAllPostList(fCri, arrCri));

		PagingMaker pagingMaker=new PagingMaker();
		pagingMaker.setCri(fCri);
		pagingMaker.setTotalData(postService.selectTotalCount(fCri));

		model.addAttribute("pagingMaker", pagingMaker);
		model.addAttribute("arrCri", arrCri);
		
		return "soifactory/fac-main";
	}
	
	@RequestMapping(value="/soiread/{postNo}")
	public String soiRead(HttpSession session, Model model, @PathVariable("postNo") int postNo, @ModelAttribute("fCri") FindCriteria fCri, @ModelAttribute("arrCri") ArrayCriteria arrCri) throws Exception{
		UserVo authUser=(UserVo)session.getAttribute("authUser");
		
		boolean scrapChk = false;
		boolean likeChk = false;

		if (postService.getEachPostForModify(postNo)!=null) {
			if(authUser != null) {
				List<ScrapVo> scrapVo = postService.getUserScrapList(authUser.getUserId());
				List<LikeVo> likeVo = postService.getUserLikeList(authUser.getUserId());
				for (int i=0; i<scrapVo.size(); i++) {
					if (scrapVo.get(i).getPostNo() == postNo) {
						scrapChk = true;
						break;
					}
				}
				
				for (int i=0; i<likeVo.size(); i++) {
					if (likeVo.get(i).getPostNo() == postNo) {
						likeChk = true;
						break;
					}
				}			
			}
			
			model.addAttribute("scrapChk", scrapChk);
			model.addAttribute("likeChk", likeChk);
			model.addAttribute("postVo", postService.getEachPost(postNo));
			model.addAttribute("ctrl","\r\n");
			
			return "soifactory/soiread";
		} else {
			return "redirect:/post/soifactorylist";
		}
	}
	
	@RequestMapping(value="/soiwriteform")
	public String soiWriteForm(HttpSession session) throws Exception{
		UserVo authUser= (UserVo)session.getAttribute("authUser");
		
		String url;
		if (authUser==null) {
			url="redirect:/post/soifactorylist";
		} else {
			url="soifactory/soiwriteform";
		}
		return url;
	}
	
	@RequestMapping(value="/soiwrite")
	public String soiWrite(@ModelAttribute PostVo postVo, HttpSession session, @RequestParam(value="postHideFace", required=false, defaultValue="N") String postHideFace,
			@RequestParam(value="postSharable", required=false, defaultValue="N") String postSharable) throws Exception{
		UserVo authUser=(UserVo)session.getAttribute("authUser");
		postVo.setWriterId(authUser.getUserId()); //유저 아이디
		postVo.setPostHideFace(postHideFace);
		postVo.setPostSharable(postSharable);
		logger.info("소이팩토리 작성된 글 정보 : " + postVo);
		postService.writePost(postVo); //ioi로 videoNo를 가져와서, 일단 post에 값 insert해볼 것임.
		return "redirect:/post/soifactorylist";
	}
	
	@RequestMapping(value="/soidelete")
	public String soiDelete(@RequestParam("postNo") int postNo, FindCriteria fCri, ArrayCriteria arrCri, RedirectAttributes reAttr) throws Exception{
		System.out.println(postNo);
		postService.deletePost(postNo);
		
		reAttr.addAttribute("page", fCri.getPage());
		reAttr.addAttribute("numPerPage", fCri.getNumPerPage());
		reAttr.addAttribute("findType", fCri.getFindType());
		reAttr.addAttribute("keyword", fCri.getKeyword());
		reAttr.addAttribute("facArray", arrCri.getFacArray());
		return "redirect:/post/soifactorylist";
	}
	
	@RequestMapping(value="/soimodifyform")
	public String soiModifyForm(@RequestParam("postNo") int postNo, @RequestParam("writerId") String writerId, @ModelAttribute("fCri") FindCriteria fCri, @ModelAttribute("arrCri") ArrayCriteria arrCri, Model model, HttpSession session) throws Exception{
		UserVo authUser=(UserVo)session.getAttribute("authUser");
		
		String url;
		if (authUser.getUserId().equals(writerId)) {
			PostVo postVo=postService.getEachPostForModify(postNo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("ctrl","\r\n");
			url="soifactory/soimodifyform";
		} else {
			url="redirect:/post/soifactorylist";
		}
		return url;
	}
	
	@RequestMapping(value="/soimodify")
	public String soiModify(@ModelAttribute PostVo postVo, FindCriteria fCri, ArrayCriteria arrCri, HttpSession session, RedirectAttributes reAttr, @RequestParam(value="postHideFace", required=false, defaultValue="N") String postHideFace,
			@RequestParam(value="postSharable", required=false, defaultValue="N") String postSharable) throws Exception{
		UserVo authUser=(UserVo)session.getAttribute("authUser");
		
		String url;
		if (authUser.getUserId().equals(postVo.getWriterId())) {
			postVo.setWriterId(authUser.getUserId()); //유저 아이디
			postVo.setPostHideFace(postHideFace);
			postVo.setPostSharable(postSharable);
			
			postService.updateEachPostForModify(postVo);
			int postNo=postVo.getPostNo();
			
			reAttr.addAttribute("page", fCri.getPage());
			reAttr.addAttribute("numPerPage", fCri.getNumPerPage());
			reAttr.addAttribute("findType", fCri.getFindType());
			reAttr.addAttribute("keyword", fCri.getKeyword());
			reAttr.addAttribute("facArray", arrCri.getFacArray());
			url="redirect:/post/soiread/"+postNo;
		} else {
			url="redirect:/post/soifactorylist";
		}
		return url;
	}

}
