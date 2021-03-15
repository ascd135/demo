package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.interfaces.BoardIdImpl;

public class SearchVo implements BoardIdImpl {
    private final String boardid;
    private final int boardpage;
    private final String what;
    private final String keyword;

    public SearchVo(String boardid, String boardpage, String what, String keyword) {

        int pageNum;
        try {
            pageNum = Integer.parseInt(boardpage);
        } catch (NumberFormatException ignored) {
            pageNum = -1;
        }



        this.boardid = boardid;
        this.boardpage = pageNum;
        this.what = what;
        this.keyword = keyword;
    }

    @Override
    public String getBoardid() {
        return boardid;
    }

    public int getBoardpage() {
        return boardpage;
    }

    public String getWhat() {
        return what;
    }

    public String getKeyword() {
        return keyword;
    }
}
