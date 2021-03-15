package com.hmportfolio.demo.daos;

import com.hmportfolio.demo.vos.*;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDao {

    public UserVo selectUser(Connection connection, UserLoginVo userLoginVo) throws SQLException {
        UserVo userVo = null;
        try (PreparedStatement preparedStatement = connection.prepareStatement("" +
                "SELECT user_index as userIndex, " +
                "       user_email as userEmail, " +
                "       user_password as userPassword, " +
                "       user_level as userLevel, " +
                "       user_name as userName, " +
                "       user_nickname as userNickname, " +
                "       user_phone as userPhone, " +
                "       user_id as userId " +
                "FROM hmportfolio.users " +
                "WHERE user_id = ? " +
                "  AND user_password = ? ")) {

            preparedStatement.setString(1, userLoginVo.getId());
            preparedStatement.setString(2, userLoginVo.getPassword());
            preparedStatement.executeQuery();

            try (ResultSet resultSet = preparedStatement.getResultSet()){
                while (resultSet.next()){
                    userVo = new UserVo(
                            resultSet.getInt("userIndex"),
                            resultSet.getString("userEmail"),
                            resultSet.getString("userPassword"),
                            resultSet.getInt("userLevel"),
                            resultSet.getString("userName"),
                            resultSet.getString("userNickname"),
                            resultSet.getString("userPhone"),
                            resultSet.getString("userId"));
                }
            }
        }
        return userVo;

    }

    // 이미 아이디가 있는지 아이디 카운트. 있으면 1
    public int selectIdCount(Connection connection, String id)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count('user_index') as count from hmportfolio.users where user_id = ?")) {
            preparedStatement.setString(1,id);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    // 이미 이메일이 있는지 이메일 카운트. 있으면 1
    public int selectEmailCount(Connection connection, String email)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count('user_index') as count from hmportfolio.users where user_email = ?")) {
            preparedStatement.setString(1,email);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    // 이미 닉네임이 있는지 닉네임 카운트. 있으면 1
    public int selectNicknameCount(Connection connection, String nickname)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count('user_index') as count from hmportfolio.users where user_nickname = ?")) {
            preparedStatement.setString(1,nickname);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    // 이미 폰번호 있는지 폰번호 카운트. 있으면 1
    public int selectPhoneCount(Connection connection, String phone)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count('user_index') as count from hmportfolio.users where user_phone = ?")) {
            preparedStatement.setString(1, phone);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    // 이미 이름이 있는지 닉네임 카운트. 있으면 1
    public int selectNameCount(Connection connection, String name)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count('user_index') as count from hmportfolio.users where user_name = ?")) {
            preparedStatement.setString(1,name);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }

    // db에 정보 넣기
    public void insertUser(Connection connection, UserRegisterVo userRegisterVo) throws SQLException {
        try(PreparedStatement preparedStatement = connection.prepareStatement("insert into hmportfolio.users(user_email, user_password, user_name, user_nickname, user_phone, user_id) values (?,?,?,?,?,?)")) {
            preparedStatement.setString(1, userRegisterVo.getEmail());
            preparedStatement.setString(2, userRegisterVo.getPassword());
            preparedStatement.setString(3, userRegisterVo.getName());
            preparedStatement.setString(4, userRegisterVo.getNickname());
            preparedStatement.setString(5, userRegisterVo.getPassword());
            preparedStatement.setString(6, userRegisterVo.getId());
            preparedStatement.execute();
        }
    }

    // id 찾기
    public String findUser(Connection connection, UserFindIdVo userFindIdVo) throws SQLException {
        String id;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select user_id as id from hmportfolio.users where user_email like ? and user_name like ?")) {
            preparedStatement.setString(1, userFindIdVo.getEmail());
            preparedStatement.setString(2, userFindIdVo.getName());
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                id = resultSet.getString("id");
            }
        }
        return id;
    }

    // 비밀번호 변경시 필요한 id, email, name 이 들어간 selectUser
    public UserVo selectUser(Connection connection, UserFindPwVo userFindPwVo) throws SQLException{

        UserVo userVo = null;

        try(PreparedStatement preparedStatement = connection.prepareStatement("" +
                "SELECT user_index as userIndex, " +
                "       user_email as userEmail, " +
                "       user_password as userPassword, " +
                "       user_level as userLevel, " +
                "       user_name as userName, " +
                "       user_nickname as userNickname, " +
                "       user_phone as userPhone, " +
                "       user_id as userId " +
                "FROM hmportfolio.users " +
                "WHERE user_id = ? " +
                "  AND user_name = ? " +
                "  AND user_email = ? ")) {
            preparedStatement.setString(1, userFindPwVo.getId());
            preparedStatement.setString(2, userFindPwVo.getName());
            preparedStatement.setString(3, userFindPwVo.getEmail());
            preparedStatement.executeQuery();

            try (ResultSet resultSet = preparedStatement.getResultSet()){
                while (resultSet.next()){
                    userVo = new UserVo(
                            resultSet.getInt("userIndex"),
                            resultSet.getString("userEmail"),
                            resultSet.getString("userPassword"),
                            resultSet.getInt("userLevel"),
                            resultSet.getString("userName"),
                            resultSet.getString("userNickname"),
                            resultSet.getString("userPhone"),
                            resultSet.getString("userId"));
                }
            }

        }
        return userVo;
    }

    // db에 코드를 생성해서 넣기
    public void insertResetCode(Connection connection, int userIndex, String code) throws SQLException {

        try(PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO hmportfolio.user_reset_codes " +
                "(user_index, code, code_expires_at) Values(?,?,DATE_ADD(NOW(), INTERVAL 3 MINUTE))")){

            preparedStatement.setInt(1, userIndex);
            preparedStatement.setString(2, code);

            preparedStatement.execute();
        }
    }

    public int selectResetCodeCount(Connection connection, int userIndex, String code) throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT(code_index) AS count FROM " +
                "hmportfolio.user_reset_codes WHERE user_index = ? AND code = ? AND code_expires_at > NOW()")){
            preparedStatement.setInt(1, userIndex);
            preparedStatement.setString(2, code);
            preparedStatement.executeQuery();
            try (ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;

    }

    public void updateNewPassword(Connection connection, int userIndex, String npw) throws SQLException {

        try(PreparedStatement preparedStatement = connection.prepareStatement("update hmportfolio.users set user_password = ? where user_index = ?")) {
            preparedStatement.setString(1, npw);
            preparedStatement.setInt(2, userIndex);
            preparedStatement.execute();
        }
    }

    // 변경된 비밀번호를 가진 유저 1 / 0
    public int selectChangedPassword(Connection connection, int userIndex, String npw)throws SQLException {
        int count;
        try(PreparedStatement preparedStatement = connection.prepareStatement("select count(user_index) as count from hmportfolio.users where user_index = ? and user_password = ?")) {
            preparedStatement.setInt(1, userIndex);
            preparedStatement.setString(2, npw);
            preparedStatement.executeQuery();
            try(ResultSet resultSet = preparedStatement.getResultSet()){
                resultSet.next();
                count = resultSet.getInt("count");
            }
        }
        return count;
    }


}
