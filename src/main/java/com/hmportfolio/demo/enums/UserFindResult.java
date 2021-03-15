package com.hmportfolio.demo.enums;

public enum UserFindResult {
    FIND_SUCCESS,
    FIND_FAIL,
    EMAIL_NOT_FOUND,
    NAME_NOT_FOUND,

    NO_MATCHING_USER,   //1단계에서 일치하는 회원을 찾을 수 없었을때
    CODE_SENT,          // 1단계에서 일치하는 회원을 찾아서, 인증번호를 전송한 후
    CODE_SUCCESS,       // 2단계에서 올바른 코드를 적은경우
    CODE_FAIL,          // 2단계에서 올바르지 않은 코드를 적은경우

    CHANGE_SUCCESS,     // 3단계에서 비밀번호 변경이 성공한 경우
    CHANGE_FAIL         // 3단계에서 비밀번호 변경이 실패한 경우

}
