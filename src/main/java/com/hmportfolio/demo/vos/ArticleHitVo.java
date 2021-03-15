package com.hmportfolio.demo.vos;

public class ArticleHitVo {
    private final int articleid;
    private final int userid;

    public ArticleHitVo(String articleid, int userid) {
        this.articleid =Integer.parseInt(articleid);
        this.userid = userid;
    }

    public int getArticleid() {
        return articleid;
    }

    public int getUserid() {
        return userid;
    }
}
