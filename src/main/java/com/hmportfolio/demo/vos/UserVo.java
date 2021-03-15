package com.hmportfolio.demo.vos;

public class UserVo {
    private final int index;
    private final String email;
    private final String password;
    private final String name;
    private final String nickname;
    private final int userlevel;
    private final String userphone;
    private final String userid;

    public UserVo(int index, String email, String password, int userlevel, String name, String nickname, String userphone, String userid) {
        this.index = index;
        this.email = email;
        this.password = password;
        this.name = name;
        this.nickname = nickname;
        this.userlevel = userlevel;
        this.userphone = userphone;
        this.userid = userid;
    }

    public int getIndex() {
        return index;
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

    public int getUserlevel() {
        return userlevel;
    }

    public String getUserphone() {
        return userphone;
    }

    public String getUserid() {
        return userid;
    }
}
