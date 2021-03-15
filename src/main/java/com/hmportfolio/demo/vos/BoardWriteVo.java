package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.interfaces.BoardIdImpl;

public class BoardWriteVo implements BoardIdImpl {
    private final String boardid;
    private final String title;
    private final String content;

    public BoardWriteVo(String boardid, String title, String content) {
        this.boardid = boardid;
        this.title = title;
        this.content = content;
    }

    @Override
    public String getBoardid() {
        return boardid;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }
}
