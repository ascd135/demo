package com.hmportfolio.demo.controllers;

import com.hmportfolio.demo.enums.BoardWriteResult;
import com.hmportfolio.demo.enums.UserFindResult;
import com.hmportfolio.demo.enums.UserLoginResult;
import com.hmportfolio.demo.enums.UserRegisterResult;
import com.hmportfolio.demo.services.BoardService;
import com.hmportfolio.demo.services.UserService;
import com.hmportfolio.demo.vos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@Controller
public class RootController {
    private final UserService userService;
    private final BoardService boardService;

    @Autowired
    public RootController(UserService userService, BoardService boardService) {

        this.userService = userService;
        this.boardService = boardService;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String landingGet(HttpServletResponse response, HttpServletRequest request) {
        return "LandingPage";
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainGet(HttpServletRequest request, HttpServletResponse response) throws SQLException {


        BoardMainResponseVo boardMainResponseVo1 = this.boardService.getArticles("ntc");
        BoardMainResponseVo boardMainResponseVo2 = this.boardService.getArticles("fre");
        request.setAttribute("BoardMainResponseVo1", boardMainResponseVo1);
        request.setAttribute("BoardMainResponseVo2", boardMainResponseVo2);
        return "main";
    }

    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public String mainPost(HttpServletRequest request, HttpServletResponse response,
                          @RequestParam(name = "userId", defaultValue = "") String userId,
                          @RequestParam(name = "userPw", defaultValue = "") String userPw)
            throws SQLException, IOException {
        BoardMainResponseVo boardMainResponseVo1 = this.boardService.getArticles("ntc");
        BoardMainResponseVo boardMainResponseVo2 = this.boardService.getArticles("fre");
        request.setAttribute("BoardMainResponseVo1", boardMainResponseVo1);
        request.setAttribute("BoardMainResponseVo2", boardMainResponseVo2);

        UserLoginVo userLoginVo = new UserLoginVo(userId, userPw, request.getSession());
        UserLoginResult userLoginResult = this.userService.login(userLoginVo);
        request.getSession().setAttribute("UserLoginResult", userLoginResult);
        request.getSession().setAttribute("UserLoginVo", userLoginVo);

        return "main";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerGet(HttpServletRequest request, HttpServletResponse response) {
        return "register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public void registerPost(HttpServletRequest request, HttpServletResponse response,
                             @RequestParam(name = "email", defaultValue = "") String email,
                             @RequestParam(name = "password", defaultValue = "") String password,
                             @RequestParam(name = "name", defaultValue = "") String name,
                             @RequestParam(name = "nickname", defaultValue = "") String nickname,
                             @RequestParam(name = "phone", defaultValue = "") String phone,
                             @RequestParam(name = "id", defaultValue = "") String id)
            throws SQLException, IOException {
        UserRegisterVo userRegisterVo = new UserRegisterVo(email, password, name, nickname, phone, id);
        UserRegisterResult userRegisterResult = this.userService.register(userRegisterVo);
        request.getSession().setAttribute("UserRegisterResult", userRegisterResult);
        request.getSession().setAttribute("UserRegisterVo", userRegisterVo);
        response.sendRedirect("/register");

    }

    @RequestMapping(value = "/findId", method = RequestMethod.GET)
    public String findIdGet(HttpServletRequest request, HttpServletResponse response) {
        return "findId";
    }

    @RequestMapping(value = "/findId", method = RequestMethod.POST)
    public void findIdPost(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(name = "email", defaultValue = "") String email,
                           @RequestParam(name = "name", defaultValue = "") String name) throws SQLException, IOException {

        UserFindIdVo userFindIdVo = new UserFindIdVo(email, name, request.getSession());
        UserFindResult userFindResult = this.userService.findUserId(userFindIdVo);
        request.getSession().setAttribute("UserFindIdVo", userFindIdVo);
        request.getSession().setAttribute("UserFindResult", userFindResult);
        response.sendRedirect("/findId");
    }

    @RequestMapping(value = "/findPw", method = RequestMethod.GET)
    public String findPwGet(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam(name = "step", defaultValue = "1") String step) {

        switch (step) {
            case "2":
                return "code-input";
            case "3":
                return "change-pw";
            default:
                return "findPw";
        }
    }


    @RequestMapping(value = "/findPw", method = RequestMethod.POST)
    public void findPwPost(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(name = "step", defaultValue = "1") String step,
                           @RequestParam(name = "id", defaultValue = "") String id,
                           @RequestParam(name = "name", defaultValue = "") String name,
                           @RequestParam(name = "email", defaultValue = "") String email,
                           @RequestParam(name = "code", defaultValue = "") String code,
                           @RequestParam(name = "npw", defaultValue = "") String npw) throws SQLException, IOException {

        switch (step) {
            case "1":
                UserFindPwVo userFindPwVo = new UserFindPwVo(id, name, email);
                UserFindResult userFindResult = this.userService.reset(request.getSession(), userFindPwVo);
                if (userFindResult == UserFindResult.CODE_SENT) {
                    response.sendRedirect("/findPw?step=2");
                } else {
                    request.getSession().setAttribute("UserFindResult", userFindResult);
                    response.sendRedirect("/findPw");
                }
                break;

            case "2":
                UserFindResult codeCheckResult = this.userService.reset(request.getSession(), code);
                if (codeCheckResult == UserFindResult.CODE_SUCCESS) {
                    response.sendRedirect("/findPw?step=3");
                } else {
                    request.getSession().setAttribute("CodeCheckResult", codeCheckResult);
                    response.sendRedirect("/findPw?step=2");
                }
                break;

            case "3":
                UserFindResult newPasswordResult = this.userService.updateNewPassword(request.getSession(), npw);
                request.getSession().setAttribute("NewPasswordResult", newPasswordResult);
                response.sendRedirect("/findPw?step=3");
                break;

        }
    }

    // 게시판 : 자유게시판 ubd, 공지사항 ntc
    @RequestMapping(value = "/board", method= RequestMethod.GET)
    public String boardGet(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(name = "boardId", defaultValue = "")  String boardId,
                           @RequestParam(name = "boardPage", defaultValue = "1") String boardPage) throws SQLException {

        BoardVo boardVo = new BoardVo(boardId, boardPage);
        BoardResponseVo boardResponseVo = this.boardService.getArticles(request.getSession(), boardVo);
        request.setAttribute("BoardResponseVo", boardResponseVo);

        return "board";
    }

    @RequestMapping(value = "/board", method= RequestMethod.POST)
    public String boardPost(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam(name = "userId", defaultValue = "") String userId,
                            @RequestParam(name = "userPw", defaultValue = "") String userPw,
                            @RequestParam(name = "boardId", defaultValue = "")  String boardId,
                            @RequestParam(name = "boardPage", defaultValue = "1") String boardPage) throws IOException, SQLException {
        this.mainPost(request, response, userId, userPw);
        return this.boardGet(request, response, boardId, boardPage);
    }

    // 글쓰기
    @RequestMapping(value = "/board-write", method = RequestMethod.GET)
    public String boardWriteGet(HttpServletRequest request, HttpServletResponse response,
                                @RequestParam(name = "boardId", defaultValue = "")  String boardId,
                                @RequestParam(name = "boardPage", defaultValue = "1") String boardPage){
        return "board-write";
    }

    @RequestMapping(value = "/board-write", method = RequestMethod.POST)
    public void boardWritePost(HttpServletRequest request, HttpServletResponse response,
                               @RequestParam(name = "boardId", defaultValue = "")  String boardId,
                               @RequestParam(name = "boardPage", defaultValue = "1") String boardPage,
                               @RequestParam(name = "title", defaultValue = "") String title,
                               @RequestParam(name = "content", defaultValue = "") String content) throws SQLException, IOException {
        Object userVoObject = request.getSession().getAttribute("UserVo");
        UserVo userVo = null;
        if (userVoObject instanceof UserVo){
            userVo = (UserVo) userVoObject;
        }

        BoardWriteVo boardWriteVo = new BoardWriteVo(boardId, title, content);
        BoardWriteResult boardWriteResult = this.boardService.write(userVo, boardWriteVo);

        switch(boardWriteResult) {
            case NO_MATCHING_ID:
                response.sendRedirect(String.format("/board?boardId=%s&boardPage=%s", boardId, boardPage));
                break;
            case NOT_ALLOWED:
                response.sendRedirect(String.format("/board?boardId=%s&boardPage=%s", boardId, boardPage));
                break;
            case SUCCESS:
                response.sendRedirect(String.format("/board?boardId=%s", boardId));
                break;
            default:
                response.sendRedirect(String.format("/board?boardId=%s", boardId));
        }
    }

    @RequestMapping(value="/board-read", method = RequestMethod.GET)
    public String readGet(HttpServletResponse response, HttpServletRequest request,
                          @RequestParam(name="articleId", defaultValue = "") String articleId,
                          @RequestParam(name="boardId", defaultValue = "") String boardId,
                          @RequestParam(name="boardPage", defaultValue = "1") String boardPage) throws SQLException {

        Object userVoObject = request.getSession().getAttribute("UserVo");
        UserVo userVo = null;
        if (userVoObject instanceof UserVo){
            userVo = (UserVo) userVoObject;
        }

        BoardReadVo boardReadVo = new BoardReadVo(articleId, boardId, boardPage);
        BoardReadResponseVo boardReadResponseVo = this.boardService.read(userVo, boardReadVo);
        request.setAttribute("BoardReadResponseVo", boardReadResponseVo);
        return "board-read";
    }

    @RequestMapping(value = "/board-read", method = RequestMethod.POST)
    public void readPost(HttpServletResponse response, HttpServletRequest request,
                         @RequestParam(name = "articleId", defaultValue = "") String articleId,
                         @RequestParam(name = "boardId", defaultValue = "") String boardId,
                         @RequestParam(name = "boardPage", defaultValue = "1") String boardPage,
                         @RequestParam(name = "comment", defaultValue = "") String comment) throws SQLException, IOException {

        Object userVoObject = request.getSession().getAttribute("UserVo");
        UserVo userVo = null;
        if (userVoObject instanceof UserVo){
            userVo = (UserVo) userVoObject;
        }

        CommentVo commentVo = new CommentVo(articleId, comment);

        this.boardService.writeComment(userVo, commentVo);

        response.sendRedirect(String.format("/board-read?articleId=%s&boardId=%s&boardPage=%s",
                articleId,
                boardId,
                boardPage));

    }

    @RequestMapping(value = "/board-read", method = RequestMethod.DELETE)
    public void readDelete(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(name = "boardId", defaultValue = "") String boardId,
                           @RequestParam(name = "boardPage", defaultValue = "1") String boardPage,
                           @RequestParam(name = "articleId", defaultValue = "") String articleId) throws SQLException, IOException {

        Object userVoObject = request.getSession().getAttribute("UserVo");
        UserVo userVo = null;
        if(userVoObject instanceof UserVo){
            userVo = (UserVo) userVoObject;
        }

        int articleIdNum;
        try {
            articleIdNum = Integer.parseInt(articleId);
        } catch (NumberFormatException ignored) {
            articleIdNum = -1;
        }

        this.boardService.deleteArticle(userVo, articleIdNum);
        response.sendRedirect("/board?boardId=" + boardId + "&boardPage=" + boardPage);
    }

    // 검색
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchGet(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam(name = "boardId", defaultValue = "") String boardId,
                            @RequestParam(name = "boardPage", defaultValue = "1") String boardPage,
                            @RequestParam(name = "what", defaultValue = "") String what,
                            @RequestParam(name = "keyword", defaultValue = "") String keyword) throws SQLException {

        SearchVo searchVo = new SearchVo(boardId, boardPage, what, keyword);
        BoardResponseVo boardResponseVo = this.boardService.search(request.getSession(), searchVo);
        request.setAttribute("BoardResponseVo", boardResponseVo);
        request.setAttribute("SearchVo", searchVo);

        return "board";
    }

    // 추천
    @RequestMapping(value = "/hit", method = RequestMethod.GET)
    public void hitGet(HttpServletRequest request, HttpServletResponse response,
                         @RequestParam(name ="articleId", defaultValue = "") String articleId) throws SQLException {

        Object userVoObject = request.getSession().getAttribute("UserVo");
        UserVo userVo = null;
        if(userVoObject instanceof UserVo){
            userVo = (UserVo) userVoObject;
        }
        if(userVo == null) {

        } else {
            ArticleHitVo articleHitVo = new ArticleHitVo(articleId, userVo.getIndex());
            this.boardService.toggleHit(articleHitVo);
        }
    }

    @RequestMapping(value = "/get-hit", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
    @ResponseBody
    public String getHitGet(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam(name ="articleId", defaultValue = "") String articleIdString)throws SQLException {
        int articleId= Integer.parseInt(articleIdString);
        int count = this.boardService.getHit(articleId);
        return String.valueOf(count);
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }


}
