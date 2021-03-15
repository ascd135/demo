package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.interfaces.BoardIdImpl;

public class BoardReadVo implements BoardIdImpl {
    private final int articleId;
    private final String boardid;
    private final String boardpage;

    public BoardReadVo(String articleId, String boardid, String boardpage) {

        int articleIdNum;
        try {
            articleIdNum = Integer.parseInt(articleId);
        } catch (NumberFormatException ignored) {
            articleIdNum = -1;
        }

        this.articleId = articleIdNum;
        this.boardid = boardid;
        this.boardpage = boardpage;
    }

    public int getArticleId() {
        return articleId;
    }

    @Override
    public String getBoardid() {
        return boardid;
    }

    public String getBoardpage() {
        return boardpage;
    }
}
