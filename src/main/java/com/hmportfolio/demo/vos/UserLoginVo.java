package com.hmportfolio.demo.vos;

import javax.servlet.http.HttpSession;

public class UserLoginVo {
    private final String id;
    private final String password;
    private final HttpSession session;

    public UserLoginVo(String id, String password, HttpSession session) {
        this.id = id;
        this.password = password;
        this.session = session;
    }

    public String getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }

    public HttpSession getSession() {
        return session;
    }
}
