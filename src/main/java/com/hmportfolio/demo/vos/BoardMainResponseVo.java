package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.enums.BoardResponseResult;

import java.util.ArrayList;

public class BoardMainResponseVo {
    private final BoardResponseResult boardResponseResult;
    private final ArrayList<ArticleVo> articles;

    public BoardMainResponseVo(BoardResponseResult boardResponseResult, ArrayList<ArticleVo> articles) {
        this.boardResponseResult = boardResponseResult;
        this.articles = articles;
    }

    public BoardResponseResult getBoardResponseResult() {
        return boardResponseResult;
    }

    public ArrayList<ArticleVo> getArticles() {
        return articles;
    }
}
