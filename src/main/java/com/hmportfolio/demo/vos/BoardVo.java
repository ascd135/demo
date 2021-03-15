package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.interfaces.BoardIdImpl;

public class BoardVo implements BoardIdImpl {
    private final String boardid;
    private final int boardpage;

    public BoardVo(String boardid, int boardpage) {
        this.boardid = boardid;
        this.boardpage = boardpage;
    }

    public BoardVo(String boardid, String boardpage) {
        this.boardid = boardid;

        int pageNum;
        try{
            pageNum = Integer.parseInt(boardpage);
        } catch (NumberFormatException ignored) {
            pageNum = 1;
        }
        this.boardpage = pageNum;
    }

    @Override
    public String getBoardid() {
        return boardid;
    }

    public int getBoardpage() {
        return boardpage;
    }
}
