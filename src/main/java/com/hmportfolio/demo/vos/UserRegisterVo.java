package com.hmportfolio.demo.vos;

public class UserRegisterVo {
    private final String email;
    private final String password;
    private final String name;
    private final String nickname;
    private final String phone;
    private final String id;


    public UserRegisterVo(String email, String password, String name, String nickname, String phone, String id) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.nickname = nickname;
        this.phone = phone;
        this.id= id;

    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getNickname() {
        return nickname;
    }

    public String getPhone() {
        return phone;
    }

    public String getId() {
        return id;
    }
}
