package com.hmportfolio.demo.services;

import com.hmportfolio.demo.daos.BoardDao;
import com.hmportfolio.demo.daos.UserDao;
import com.hmportfolio.demo.enums.BoardReadResult;
import com.hmportfolio.demo.enums.BoardResponseResult;
import com.hmportfolio.demo.enums.BoardWriteResult;
import com.hmportfolio.demo.vos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;


@Service
public class BoardService {
    private final DataSource dataSource;
    private final UserDao userDao;
    private final BoardDao boardDao;

    @Autowired
    public BoardService(DataSource dataSource, UserDao userDao, BoardDao boardDao) {
        this.dataSource = dataSource;
        this.userDao = userDao;
        this.boardDao = boardDao;
    }


    // 글 쓰기
    public BoardWriteResult write(UserVo userVo, BoardWriteVo boardWriteVo) throws SQLException {

        try (Connection connection = this.dataSource.getConnection()) {

            // 게시판의 레벨을 가지고옴
            BoardLevelVo boardLevelVo = this.boardDao.selectBoardLevel(connection, boardWriteVo);

            if (boardLevelVo == null) {
                return BoardWriteResult.NO_MATCHING_ID;
            }

            if (userVo.getUserlevel() > boardLevelVo.getWriteLevel()) {
                // 권한 x
                return BoardWriteResult.NOT_ALLOWED;
            }

            this.boardDao.insertArticle(connection, userVo, boardWriteVo);
            return BoardWriteResult.SUCCESS;
        }

    }

    // 게시글 가져오기
    public BoardResponseVo getArticles(HttpSession session, BoardVo boardVo) throws SQLException {
        BoardResponseVo boardResponseVo;

        try (Connection connection = this.dataSource.getConnection()) {

            BoardLevelVo boardLevelVo = this.boardDao.selectBoardLevel(connection, boardVo);
            session.setAttribute("BoardLevelVo", boardLevelVo);

            // 모든 사용자가 읽을거니까 레벨비교 필요가없음
            ArrayList<ArticleVo> articles = this.boardDao.selectArticles(connection, boardVo);
            int requestPage = boardVo.getBoardpage();
            int total = this.boardDao.selectTotalArticleCount(connection, boardVo);
            int maxPage = total % 20 == 0 ? total / 20 : (int) Math.floor((double) total / 20) + 1;
            int startPage = (total / 20) / 15 + 1;
            int endPage = maxPage;
            boardResponseVo = new BoardResponseVo(BoardResponseResult.OKAY, articles, requestPage, maxPage, startPage, endPage, false);

        }

        return boardResponseVo;

    }

    // 유저의 레벨을 가져오기
    private int getUserLevel(HttpSession session) {
        Object userVoObject = session.getAttribute("UserVo");
        UserVo userVo = null;
        if (userVoObject instanceof UserVo) {
            userVo = (UserVo) userVoObject;
        }

        int userLevel;
        if (userVo == null) {
            userLevel = 3;
        } else {
            userLevel = userVo.getUserlevel();
        }
        return userLevel;
    }

    public BoardReadResponseVo read(UserVo userVo, BoardReadVo boardReadVo) throws SQLException {
        try (Connection connection = this.dataSource.getConnection()) {

            // 모든 레벨 유저 다 읽게 해줌
            ArticleVo articleVo = this.boardDao.selectArticle(connection, boardReadVo.getArticleId());

            if (articleVo == null) {
                return new BoardReadResponseVo(BoardReadResult.NO_MATCHING_ARTICLE_ID, null, null, null, null, 0, null);
            }

            ArrayList<CommentItemVo> comments = this.boardDao.selectComments(connection, boardReadVo.getArticleId());
            return new BoardReadResponseVo(BoardReadResult.SUCCESS, articleVo.getTitle(), articleVo.getContent(), articleVo.getWriter(), articleVo.getWrittenAt(), articleVo.getHit(), comments);
        }
    }

    public void writeComment(UserVo userVo, CommentVo commentVo) throws SQLException {
        try (Connection connection = this.dataSource.getConnection()) {
            this.boardDao.insertComment(connection, userVo, commentVo);
        }
    }

    // 글 삭제
    public void deleteArticle(UserVo userVo, int articleId) throws SQLException {
        try (Connection connection = this.dataSource.getConnection()) {
            ArticleVo articleVo = this.boardDao.selectArticle(connection, articleId);

            boolean delete;

            if (userVo.getUserlevel() == 1) {
                // 관리자
                delete = true;
            } else if (userVo.getUserlevel() < 3 && userVo.getNickname().equals(articleVo.getWriter())) {
                // 작성자
                delete = true;
            } else {
                delete = false;
            }

            if (delete) {
                this.boardDao.deleteArticle(connection, articleId);
            }
        }
    }

    // 검색
    public BoardResponseVo search(HttpSession session, SearchVo searchVo) throws SQLException {
        BoardResponseVo boardResponseVo;

        try (Connection connection = this.dataSource.getConnection()) {

            ArrayList<ArticleVo> articles = this.boardDao.selectArticles(connection, searchVo);
            int requestPage = searchVo.getBoardpage();
            int total = this.boardDao.selectSearchArticleCount(connection, searchVo);
            int maxPage = total % 20 == 0 ? total / 20 : (int) Math.floor((double) total / 20) + 1;
            int startPage = (total / 20) / 15 + 1;
            int endPage = maxPage;
            boardResponseVo = new BoardResponseVo(BoardResponseResult.OKAY, articles, requestPage, maxPage, startPage, endPage, true);
        }
        return boardResponseVo;
    }

    // 추천
    public void toggleHit(ArticleHitVo articleHitVo) throws SQLException {
        try (Connection connection = this.dataSource.getConnection()) {
            boolean isHit = this.boardDao.selectHitCount(connection, articleHitVo) > 0;
            if (isHit) {
                this.boardDao.deleteHit(connection, articleHitVo);
            } else {
                this.boardDao.insertHit(connection, articleHitVo);
            }
        }
    }

    public int getHit(int articleId) throws SQLException {
        try (Connection connection = this.dataSource.getConnection()) {
            return this.boardDao.selectHitCount(connection, articleId);
        }
    }

    // 메인에서 게시판 띄워주기
    public BoardMainResponseVo getArticles(String boardId) throws SQLException {
        BoardMainResponseVo boardMainResponseVo;

        try (Connection connection = this.dataSource.getConnection()) {

            ArrayList<ArticleVo> articles = this.boardDao.selectArticlesWithHit(connection, boardId);
            boardMainResponseVo = new BoardMainResponseVo(BoardResponseResult.OKAY, articles);
        }
        return boardMainResponseVo;
    }
}
