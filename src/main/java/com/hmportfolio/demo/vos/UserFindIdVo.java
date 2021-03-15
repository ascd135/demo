package com.hmportfolio.demo.vos;

import javax.servlet.http.HttpSession;

public class UserFindIdVo {
    private final String email;
    private final String name;
    private final HttpSession session;

    public UserFindIdVo(String email, String name, HttpSession session) {
        this.email = email;
        this.name = name;
        this.session = session;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public HttpSession getSession() {
        return session;
    }
}
