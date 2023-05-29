package com.khj.exam.demo.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.khj.exam.demo.service.ArticleService;
import com.khj.exam.demo.service.BoardService;
import com.khj.exam.demo.service.GenFileService;
import com.khj.exam.demo.service.ReactionPointService;
import com.khj.exam.demo.service.ReplyService;
import com.khj.exam.demo.utill.Ut;
import com.khj.exam.demo.vo.Article;
import com.khj.exam.demo.vo.Board;
import com.khj.exam.demo.vo.GenFile;
import com.khj.exam.demo.vo.Reply;
import com.khj.exam.demo.vo.ResultData;
import com.khj.exam.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {
	private ArticleService articleService;
	private BoardService boardService;
	private ReactionPointService reactionPointService;
	private ReplyService replyService;
	private GenFileService genFileService;
	private Rq rq;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public UsrArticleController(ArticleService articleService, BoardService boardService,
			ReactionPointService reactionPointService, ReplyService replyService, GenFileService genFileService, Rq rq) {
		this.articleService = articleService;
		this.boardService = boardService;
		this.reactionPointService = reactionPointService;
		this.replyService = replyService;
		this.genFileService = genFileService;
		this.rq = rq;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/usr/article/image_upload", method = RequestMethod.POST)
	public String imageUpload(@RequestParam("image")MultipartFile multipartFile,
							  @RequestParam String uri, HttpServletRequest request, MultipartRequest multipartRequest) {

		if(multipartFile.isEmpty()) {
			logger.warn("user_write image upload detected, but there's no file.");
			return "not found";
		}

		String directory = request.getSession().getServletContext().getRealPath("resources/upload/talk/");

		String fileName = multipartFile.getOriginalFilename();
		int lastIndex = fileName.lastIndexOf(".");
		String ext = fileName.substring(lastIndex, fileName.length());
		String newFileName = LocalDate.now() + "_" + System.currentTimeMillis() + ext;

		try {
			File image = new File(directory + newFileName);

			multipartFile.transferTo(image);

		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		} finally {
			logger.info("uri : {}", uri);
			logger.info("Image Path : {}", directory);
			logger.info("File_name : {}", newFileName);
		}

		// 주소값 알아내기
		String path = request.getContextPath();
		int index = request.getRequestURL().indexOf(path);
		String url = request.getRequestURL().substring(0, index);

		// https://localhost:8080/bombom/resources/upload/파일이름
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
            multipartFile = fileMap.get(fileInputName);

            if ( multipartFile.isEmpty() == false ) {
                genFileService.save(multipartFile, rq.getLoginedMemberId());
            }
        }

		return url + request.getContextPath() + "/resources/upload/talk/" + newFileName;
	}

	// 액션 메서드 시작
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(@RequestParam(defaultValue = "1") String genFileIdsStr, @RequestParam(defaultValue = "1") int boardId, String title, String body, String replaceUri) {
		
//		Integer boardId로 한 다음 아래 주석을 풀어주시면 됩니다.
//		if (Ut.empty(boardId)) {
//			return rq.jsHistoryBack("게시판을 선택해주세요.");
//		}
		
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("title(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("body(을)를 입력해주세요.");
		}

		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body, genFileIdsStr);

		int id = writeArticleRd.getData1();

		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", id);
		}

		return rq.jsReplace(Ut.f("%d번 글이 생성되었습니다.", id), replaceUri);
	}

	@RequestMapping("/usr/article/write")
	public String showWrite() {
		return "usr/article/write";
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title, body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {
		Board board = boardService.getBoardById(boardId);

		if (board == null) {
			return rq.historyBackJsOnview(Ut.f("%d번 게시판은 존재하지 않습니다.", boardId));
		}

		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
		int itemsCountInAPage = 10;
		int pagesCount = (int) Math.ceil((double) articlesCount / itemsCountInAPage);

		List<Article> articles = articleService.getForPrintArticles(rq.getLoginedMemberId(), boardId,
				searchKeywordTypeCode, searchKeyword, itemsCountInAPage, page);

		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);

		return "usr/article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		model.addAttribute("article", article);
		
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);
		int repliesCount = replies.size();
		model.addAttribute("replies", replies);
		
		ResultData actorCanMakeReactionPointRd = reactionPointService.actorCanMakeReactionPoint(rq.getLoginedMemberId(), "article", id);

		model.addAttribute("actorCanMakeReaction", actorCanMakeReactionPointRd.isSuccess());
		
		if ( actorCanMakeReactionPointRd.getResultCode().equals("F-2") ) {
			int sumReactionPointByMemberId = (int) actorCanMakeReactionPointRd.getData1();
			
			if ( sumReactionPointByMemberId > 0 ) {
				model.addAttribute("actorCanCancelGoodReaction", true);
			}
			else {
				model.addAttribute("actorCanCancelBadReaction", true);
			}
		}
		

		List<GenFile> files   = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		article.getExtraNotNull().put("file__common__attachment", filesMap);

		return "usr/article/detail";
	}

	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData<Integer> doIncreaseHitCountRd(int id) {
		ResultData<Integer> increaseHitCountRd = articleService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData<Integer> rd = ResultData.newData(increaseHitCountRd, "hitCount",
				articleService.getArticleHitCount(id));

		rd.setData2("id", id);

		return rd;
	}

	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public ResultData<Article> getArticle(int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
		}

		return ResultData.from("S-1", Ut.f("%d번 게시물입니다.", id), "article", article);
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
		}

		if (article.getMemberId() != rq.getLoginedMemberId()) {
			return rq.jsHistoryBack("권한이 없습니다.");
		}

		articleService.deleteArticle(id);

		return rq.jsReplace(Ut.f("%d번 게시물을 삭제하였습니다.", id), "../article/list");
	}

	@RequestMapping("/usr/article/modify")
	public String ShowModify(Model model, int id, String title, String body) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.historyBackJsOnview(Ut.f("%d번 게시물이 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackJsOnview(actorCanModifyRd.getMsg());
		}
		
		List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		article.getExtraNotNull().put("file__common__attachment", filesMap);
		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물이 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBack(actorCanModifyRd.getMsg());
		}

		articleService.modifyArticle(id, title, body);

		return rq.jsReplace(Ut.f("%d번 글이 수정되었습니다.", id), Ut.f("../article/detail?id=%d", id));
	}
	// 액션 메서드 끝

}
