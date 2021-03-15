package com.hmportfolio.demo.vos;

public class UserFindPwVo {
    private final String id;
    private final String name;
    private final String email;

    public UserFindPwVo(String id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}
