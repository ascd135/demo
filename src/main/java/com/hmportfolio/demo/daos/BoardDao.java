package com.hmportfolio.demo.daos;

import com.hmportfolio.demo.interfaces.BoardIdImpl;
import com.hmportfolio.demo.vos.*;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@Repository
public class BoardDao {

    public BoardLevelVo selectBoardLevel(Connection connection, BoardIdImpl boardIdImpl) throws SQLException {
        BoardLevelVo boardLevelVo = null;
        try (PreparedStatement preparedStatement = connection.prepareStatement("select `board_read_level` as `boardReadLevel`, `board_write_level` as `boardWriteLevel` from `hmportfolio`.`boards` where `board_id` = ?"))
        {
            preparedStatement.setString(1, boardIdImpl.getBoardid());
            preparedStatement.executeQuery();
            try (ResultSet resultSet = preparedStatement.getResultSet()){
                while (resultSet.next()){
                    boardLevelVo = new BoardLevelVo(resultSet.getInt("boardReadLevel"), resultSet.getInt("boardWriteLevel"));
                }
            }
        }

        return boardLevelVo;
    }

    public void insertArticle(Connection connection, UserVo userVo, BoardWriteVo boardWriteVo) throws SQLException {
        try(PreparedStatement preparedStatement = connection.prepareStatement("" +
                "insert into hmportfolio.articles(user_id, board_id, article_title, article_content) " +
                "values (?,?,?,?)")) {
            preparedStatement.setString(1, userVo.getUserid());
            preparedStatement.setString(2, boardWriteVo.getBoardid());
            preparedStatement.setString(3, boardWriteVo.getTitle());
            preparedStatement.setString(4, boardWriteVo.getContent());
            preparedStatement.execute();
        }
    }

    // 게시글 가져오기
    public ArrayList<ArticleVo> selectArticles(Connection connection, BoardVo boardVo) throws  SQLException {

        ArrayList<ArticleVo> articles = new ArrayList<>();

        try(PreparedStatement preparedStatement = connection.prepareStatement("select `articles`.`article_index` as `articleIndex`, "+
                "`users`.`user_nickname` as `userNickname`, " +
                "`articles`.`article_title` as `articleTitle`, " +
                "`articles`.`article_content` as `articleContent`, " +
                "`articles`.`article_written_at` as `articleWrittenAt`, " +
                "`articles`.`article_hit` as `articleHit` " +
                "from `hmportfolio`.`articles` " +
                "inner join `hmportfolio`.`users` on `articles`.`user_id` = `users`.`user_id` " +
                "where `board_id` = ? " +
                "order by `article_index` desc " +
                "limit ?, 20")) {

            preparedStatement.setString(1, boardVo.getBoardid());
            preparedStatement.setInt(2, (boardVo.getBoardpage()-1)*20);
            preparedStatement.executeQuery();

            try(ResultSet resultSet = preparedStatement.getResultSet()) {
                while(resultSet.next()) {
                    int articleIndex = resultSet.getInt("articleIndex");
                    int commentCount = this.selectCommentCount(connection, articleIndex);
                    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(resultSet.getTimestamp("articleWrittenAt"));
                    ArticleVo articleVo = new ArticleVo(
                            articleIndex,
                            resultSet.getString("articleTitle"),
                            resultSet.getString("articleContent"),
                            resultSet.getString("userNickname"),
                            date,
                            resultSet.getInt("articleHit"),
                            commentCount
                    );
                    articles.add(articleVo);
                }
            }
        }
        return articles;
    }

    // 글의 갯수
    public int selectTotalArticleCount(Connection connection, BoardVo boardVo) throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count(`article_index`) as `count` from `hmportfolio`.`articles` where `board_id` = ?")){
            preparedStatement.setString(1, boardVo.getBoardid());
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()) {
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }


    // 게시글번호로 게시글 1개 가져오기
    public ArticleVo selectArticle(Connection connection, int articleIndex) throws SQLException {
        ArticleVo articleVo = null;
        try (PreparedStatement preparedStatement = connection.prepareStatement("" +
                "select `article`.`article_index` as `articleIndex`, " +
                "`user`.`user_nickname` as `userNickname`, " +
                "`article`.`article_title` as `articleTitle`, " +
                "`article`.`article_content` as `articleContent`, " +
                "`article`.`article_written_at` as `articleWrittenAt`, " +
                "`article`.`article_hit` as `articleHit` " +
                "from `hmportfolio`.`articles` as `article` " +
                "inner join `hmportfolio`.`users` as `user` on `article`.`user_id` = `user`.`user_id` " +
                "where `article_index` = ?")){

            preparedStatement.setInt(1,articleIndex);
            preparedStatement.executeQuery();
            try (ResultSet resultSet = preparedStatement.getResultSet()) {
                while(resultSet.next()){
                    int commentCount = this.selectCommentCount(connection, articleIndex);
                    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(resultSet.getTimestamp("articleWrittenAt"));
                    articleVo = new ArticleVo(
                            resultSet.getInt("articleIndex"),
                            resultSet.getString("articleTitle"),
                            resultSet.getString("articleContent"),
                            resultSet.getString("userNickname"),
                            date,
                            resultSet.getInt("articleHit"),
                            commentCount);
                }
            }
        }
        return articleVo;
    }

    private int selectCommentCount(Connection connection, int articleIndex) throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("" +
                "select count(`article_index`) as `count` " +
                "from `hmportfolio`.`comments` " +
                "where `article_index` = ?")){
            preparedStatement.setInt(1,articleIndex);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()) {
                resultSet.next();
                count = resultSet.getInt("count");
            }

        }
        return count;
    }

    public ArrayList<CommentItemVo> selectComments(Connection connection, int articleIndex) throws SQLException {
        ArrayList<CommentItemVo> comments = new ArrayList<>();
        try(PreparedStatement preparedStatement = connection.prepareStatement("" +
                "select `user`.`user_nickname` as `userNickname`, `comment`.`comment_text` as `commentText`, `comment`.`comment_written_at` as `commentWrittenAt` " +
                "from `hmportfolio`.`comments` as `comment` " +
                "inner join `hmportfolio`.`users` as `user` on `comment`.`user_nickname` = `user`.`user_nickname` " +
                "where `comment`.`article_index` = ? " +
                "order by `comment`.`comment_index`")) {
            preparedStatement.setInt(1, articleIndex);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                while(resultSet.next()){
                    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(resultSet.getTimestamp("commentWrittenAt"));
                    CommentItemVo commentItemVo = new CommentItemVo(
                            resultSet.getString("userNickname"),
                            resultSet.getString("commentText"),
                            date
                    );
                    comments.add(commentItemVo);
                }
            }

        }
        return comments;
    }

    public void insertComment(Connection connection, UserVo userVo, CommentVo commentVo) throws SQLException {
        try(PreparedStatement preparedStatement = connection.prepareStatement(""+
                "insert into hmportfolio.comments (article_index, user_nickname, comment_text) values (?,?,?)")) {
            preparedStatement.setInt(1, commentVo.getArticleId());
            preparedStatement.setString(2, userVo.getNickname());
            preparedStatement.setString(3, commentVo.getText());
            preparedStatement.execute();
        }

    }


    // 글 삭제
    public void deleteArticle(Connection connection, int articleId) throws SQLException {
        try(PreparedStatement preparedStatement = connection.prepareStatement("" +
                "delete from hmportfolio.articles where article_index = ?")) {
            preparedStatement.setInt(1, articleId);
            preparedStatement.execute();
        }
    }


    // 글 검색
    public ArrayList<ArticleVo> selectArticles(Connection connection, SearchVo searchVo) throws SQLException {
        ArrayList<ArticleVo> articles = new ArrayList<>();

        String query;

        if(searchVo.getWhat().equals("title")) {
            query ="" +
                    "select articles.article_index as articleIndex, " +
                    "user.user_nickname as userNickname, " +
                    "articles.article_title as articleTitle, " +
                    "articles.article_content as articleContent, " +
                    "articles.article_written_at as articleWrittenAt, " +
                    "articles.article_hit as articleHit " +
                    "from hmportfolio.articles " +
                    "inner join hmportfolio.users as `user` on articles.user_id = `user`.user_id " +
                    "where board_id = ? " +
                    "and replace(`article_title`, ' ', '') like '%" + searchVo.getKeyword() + "%' " +
                    "order by `article_index` desc " +
                    "limit ?, 20";

        } else if (searchVo.getWhat().equals("title-content")) {
            query ="" +
                    "select articles.article_index as articleIndex, " +
                    "user.user_nickname as userNickname, " +
                    "articles.article_title as articleTitle, " +
                    "articles.article_content as articleContent, " +
                    "articles.article_written_at as articleWrittenAt, " +
                    "articles.article_hit as articleHit " +
                    "from hmportfolio.articles " +
                    "inner join hmportfolio.users as `user` on articles.user_id = `user`.user_id " +
                    "where board_id = ? " +
                    "and replace(`article_title`, ' ', '') like '%" + searchVo.getKeyword() + "%' or " +
                    "replace(`article_content`, ' ','') like '%" + searchVo.getKeyword() + "%' " +
                    "order by `article_index` desc " +
                    "limit ?, 20";
        } else {
            query ="" +
                    "select articles.article_index as articleIndex, " +
                    "user.user_nickname as userNickname, " +
                    "articles.article_title as articleTitle, " +
                    "articles.article_content as articleContent, " +
                    "articles.article_written_at as articleWrittenAt, " +
                    "articles.article_hit as articleHit " +
                    "from hmportfolio.articles " +
                    "inner join hmportfolio.users as `user` on articles.user_id = `user`.user_id " +
                    "where board_id = ? " +
                    "and user.user_nickname = '" + searchVo.getKeyword() + "' " +
                    "order by `article_index` desc " +
                    "limit ?, 20";
        }
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, searchVo.getBoardid());
            preparedStatement.setInt(2, (searchVo.getBoardpage()-1)*20);
            System.out.println(searchVo.getBoardpage());
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                while(resultSet.next()) {
                    int articleIndex = resultSet.getInt("articleIndex");
                    int commentCount = this.selectCommentCount(connection, articleIndex);
                    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(resultSet.getTimestamp("articleWrittenAt"));
                    ArticleVo articleVo = new ArticleVo(
                            articleIndex,
                            resultSet.getString("articleTitle"),
                            resultSet.getString("articleContent"),
                            resultSet.getString("userNickname"),
                            date,
                            resultSet.getInt("articleHit"),
                            commentCount
                    );
                    articles.add(articleVo);
                }
            }
        }
        return articles;
    }

    public int selectSearchArticleCount(Connection connection, SearchVo searchVo) throws  SQLException{
        int count;
        String query;
        if (searchVo.getWhat().equals("title")) {
            query = "" +
                    "select count(`article_index`) as `count` " +
                    "from `hmportfolio`.`articles` as `article` " +
                    "where `board_id` = ? " +
                    "and replace(`article_title`,' ','') like '%" + searchVo.getKeyword() + "%' ";
        }else if (searchVo.getWhat().equals("title-content")) {
            // 제목 + 내용 기준 검색
            query = "" +
                    "select count(`article_index`) as `count` " +
                    "from `hmportfolio`.`articles` as `article` " +
                    "where `board_id` = ? " +
                    "and (replace(`article_title`,' ','') like '%" + searchVo.getKeyword() + "%' or " +
                    "replace(`article_content`,' ',' ') like '%" + searchVo.getKeyword() + "%') ";
        } else {
            // 작성자 기준 검색
            query = "" +
                    "select count(`article_index`) as `count` " +
                    "from `hmportfolio`.`articles` as `article` " +
                    "inner join `hmportfolio`.`users` as `user` on `article`.`user_id` = `user`.`user_id` " +
                    "where `board_id` = ? " +
                    "and `user`.`user_nickname` = '" + searchVo.getKeyword() + "' ";

        }
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)){
            preparedStatement.setString(1, searchVo.getBoardid());
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()) {
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    public int selectHitCount(Connection connection, ArticleHitVo articleHitVo) throws SQLException {
        int count;
        String query = "select count(hit_index) as `count` from hmportfolio.article_hits where article_index = ? and user_index = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, articleHitVo.getArticleid());
            preparedStatement.setInt(2, articleHitVo.getUserid());
            try(ResultSet resultSet=preparedStatement.executeQuery()){
                resultSet.next();
                count=resultSet.getInt("count");
            }
        }
        return count;

    }

    public int selectHitCount(Connection connection,int articleId) throws SQLException {
        int count;
        String query = "select count(hit_index) as `count` from hmportfolio.article_hits where article_index = ? ";
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1,articleId);
            try(ResultSet resultSet=preparedStatement.executeQuery()){
                resultSet.next();
                count=resultSet.getInt("count");
            }
        }
        return count;

    }

    public void insertHit(Connection connection, ArticleHitVo articleHitVo) throws SQLException {
        String query = "insert into hmportfolio.article_hits(article_index, user_index) values (?,?)";
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, articleHitVo.getArticleid());
            preparedStatement.setInt(2, articleHitVo.getUserid());

            preparedStatement.execute();
        }
    }

    public void deleteHit(Connection connection, ArticleHitVo articleHitVo) throws SQLException {
        String query = "delete from hmportfolio.article_hits where article_index =? and user_index = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, articleHitVo.getArticleid());
            preparedStatement.setInt(2, articleHitVo.getUserid());

            preparedStatement.execute();
        }
    }


    public ArrayList<ArticleVo> selectArticlesWithHit(Connection connection, String boardid) throws  SQLException {
        ArrayList<ArticleVo> articles = new ArrayList<>();

        try(PreparedStatement preparedStatement = connection.prepareStatement(""+
                "SELECT `article`.`article_index`      AS `articleIndex`, " +
                "`article`.`article_title`      AS `articleTitle`, " +
                "`user`.`user_nickname`         AS `userNickname`, " +
                "`article`.`article_content` AS `articleContent`, " +
                "`article`.`article_written_at` AS `articleWrittenAt`, " +
                "(SELECT COUNT(`hit`.`hit_index`) FROM `hmportfolio`.`article_hits` AS `hit` WHERE `hit`.`article_index` = `article`.`article_index`) AS `hitCount` " +
                "FROM `hmportfolio`.`articles` AS `article` " +
                "LEFT JOIN `hmportfolio`.`users` AS `user` ON `article`.`user_id` = `user`.`user_id` " +
                "WHERE `board_id` = ? " +
                "ORDER BY `hitCount` DESC, articleWrittenAt DESC " +
                "limit 10")) {

            preparedStatement.setString(1, boardid);
            preparedStatement.executeQuery();

            try(ResultSet resultSet = preparedStatement.getResultSet()) {
                while(resultSet.next()) {
                    int articleIndex = resultSet.getInt("articleIndex");
                    int commentCount = this.selectCommentCount(connection, articleIndex);
                    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(resultSet.getTimestamp("articleWrittenAt"));
                    ArticleVo articleVo = new ArticleVo(
                            articleIndex,
                            resultSet.getString("articleTitle"),
                            resultSet.getString("articleContent"),
                            resultSet.getString("userNickname"),
                            date,
                            resultSet.getInt("hitCount"),
                            commentCount
                    );
                    articles.add(articleVo);
                }
            }
        }
        return articles;
    }
}
