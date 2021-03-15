package com.hmportfolio.demo.services;

import com.hmportfolio.demo.daos.UserDao;
import com.hmportfolio.demo.enums.UserFindResult;
import com.hmportfolio.demo.enums.UserLoginResult;
import com.hmportfolio.demo.enums.UserRegisterResult;
import com.hmportfolio.demo.vos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Random;

@Service
public class UserService {
    private final DataSource dataSource;
    private final UserDao userDao;

    @Autowired
    public UserService(DataSource dataSource, UserDao userDao) {
        this.dataSource = dataSource;
        this.userDao = userDao;
    }

    // 로그인
    public UserLoginResult login(UserLoginVo userLoginVo) throws SQLException {

        UserLoginResult userLoginResult;

        if( userLoginVo.getId().equals("") || userLoginVo.getPassword().equals("")){
            userLoginResult = UserLoginResult.FAILURE;
        }

        try (Connection connection = this.dataSource.getConnection()){
            UserVo userVo = this.userDao.selectUser(connection, userLoginVo);
            if(userVo == null) {
                userLoginResult = UserLoginResult.FAILURE;
            } else {
                userLoginVo.getSession().setAttribute("UserVo", userVo);
                userLoginResult = UserLoginResult.SUCCESS;
            }
        }
        return userLoginResult;
    }

    // 회원가입
    public UserRegisterResult register(UserRegisterVo userRegisterVo) throws SQLException {
        UserRegisterResult userRegisterResult = null;

        try (Connection connection = this.dataSource.getConnection()) {

            if(this.userDao.selectEmailCount(connection, userRegisterVo.getEmail()) > 0) {
                // 이메일이 이미 있는지
                userRegisterResult = UserRegisterResult.EMAIL_DUPLICATE;
            } else if (this.userDao.selectNicknameCount(connection, userRegisterVo.getNickname()) > 0) {
                //  닉네임이 이미 있는지
                userRegisterResult = UserRegisterResult.NICKNAME_DUPLICATE;
            } else if (this.userDao.selectIdCount(connection, userRegisterVo.getId()) > 0) {
                // 아이디가 이미 있는지
                userRegisterResult = UserRegisterResult.ID_DUPLICATE;
            } else if (this.userDao.selectPhoneCount(connection, userRegisterVo.getPhone()) > 0) {
                // 휴대폰 번호가
                userRegisterResult = UserRegisterResult.PHONE_DUPLICATE;
            } else {
                // db에 회원정보 넣기
                this.userDao.insertUser(connection, userRegisterVo);
                if(this.userDao.selectEmailCount(connection, userRegisterVo.getEmail()) > 0){
                    // 정보 넣고나서 검색했을때 이메일이 있으면? == 잘들어갔으면
                    userRegisterResult = UserRegisterResult.SUCCESS;
                } else {
                    // 오류났으면
                    userRegisterResult = UserRegisterResult.FAILURE;
                }
            }
        }
        return userRegisterResult;
    }

    public UserFindResult findUserId(UserFindIdVo userFindIdVo) throws SQLException {
        UserFindResult userFindResult = null;
        String userId;

        try(Connection connection = this.dataSource.getConnection()) {

            if (this.userDao.selectEmailCount(connection, userFindIdVo.getEmail()) < 1){
                userFindResult = UserFindResult.EMAIL_NOT_FOUND;
            } else if (this.userDao.selectNameCount(connection, userFindIdVo.getName()) < 1){
                userFindResult = UserFindResult.NAME_NOT_FOUND;
            } else{
                userId = this.userDao.findUser(connection, userFindIdVo);
                if (userId != null) {
                    userFindResult = UserFindResult.FIND_SUCCESS;
                    userFindIdVo.getSession().setAttribute("userId", userId);

                } else {
                    userFindResult = UserFindResult.FIND_FAIL;
                }
            }

        }
        return userFindResult;
    }

    public UserFindResult reset(HttpSession session, UserFindPwVo userFindPwVo) throws SQLException {

        UserFindResult userFindResult;

        try(Connection connection = this.dataSource.getConnection()){
            UserVo userVo = this.userDao.selectUser(connection, userFindPwVo);
            if (userVo == null){
                // 전달된 아이디, 이름, 이메일과 일치하는 회원이 없다.
                userFindResult = UserFindResult.NO_MATCHING_USER;
            } else {
                // 있다. 코드를 생성해서 db에 넣자
                Random random = new Random();
                String code = String.format("%06d", random.nextInt(999999));
                this.userDao.insertResetCode(connection, userVo.getIndex(), code);
                session.setAttribute("resetUserIndex", userVo.getIndex());
                session.setAttribute("resetCode", code);

                // 코드넣음
                userFindResult = UserFindResult.CODE_SENT;
            }
        }
        return userFindResult;
    }

    public UserFindResult reset(HttpSession session, String code) throws SQLException {
        UserFindResult userResetResult;
        try(Connection connection = this.dataSource.getConnection()) {

            // 세션으로 넘겨온 비밀번호 변경을 하려는 유저의 인덱스
            Object userIndexObject = session.getAttribute("resetUserIndex");
            int userIndex = Integer.parseInt(String.valueOf(userIndexObject));
            int count = this.userDao.selectResetCodeCount(connection, userIndex, code);
            if(count == 1){
                userResetResult = UserFindResult.CODE_SUCCESS;

            } else {
                userResetResult = UserFindResult.CODE_FAIL;
            }
        }
        return userResetResult;
    }

    public UserFindResult updateNewPassword(HttpSession session, String npw) throws SQLException{

        UserFindResult newPasswordResult;

        try(Connection connection = this.dataSource.getConnection()) {

            // 세션으로 넘겨온 비밀번호 변경을 하려는 유저의 인덱스
            Object userIndexObject = session.getAttribute("resetUserIndex");
            int userIndex = Integer.parseInt(String.valueOf(userIndexObject));

            // 새 비밀번호로 변경
            this.userDao.updateNewPassword(connection, userIndex, npw);

            if(this.userDao.selectChangedPassword(connection, userIndex, npw) > 0) {
                newPasswordResult = UserFindResult.CHANGE_SUCCESS;
            } else {
                newPasswordResult = UserFindResult.CHANGE_FAIL;
            }
        }
        return newPasswordResult;
    }

}
