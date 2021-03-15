package com.hmportfolio.demo.vos;

import com.hmportfolio.demo.enums.BoardReadResult;

import java.util.ArrayList;

public class BoardReadResponseVo {
    private final BoardReadResult boardReadResult;
    private final String title;
    private final String text;
    private final String writer;
    private final String writtenAt;
    private final int hit;
    private final ArrayList<CommentItemVo> comments;

    public BoardReadResponseVo(BoardReadResult boardReadResult, String title, String text, String writer, String writtenAt, int hit, ArrayList<CommentItemVo> comments) {
        this.boardReadResult = boardReadResult;
        this.title = title;
        this.text = text;
        this.writer = writer;
        this.writtenAt = writtenAt;
        this.hit = hit;
        this.comments = comments;
    }

    public BoardReadResult getBoardReadResult() {
        return boardReadResult;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }

    public String getWriter() {
        return writer;
    }

    public String getWrittenAt() {
        return writtenAt;
    }

    public ArrayList<CommentItemVo> getComments() {
        return comments;
    }

    public int getHit() {
        return hit;
    }
}
