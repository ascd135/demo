let loginForm = window.document.body.querySelector("#login-form");

loginForm.onsubmit = function () {

    let emailInput = loginForm.elements["userId"];
    let passwordInput = loginForm.elements["userPw"];
    if (emailInput.value === "") {
        alert("이메일을 입력해주세요.");
        emailInput.focus();
        return false;
    } else if (passwordInput.value === "") {
        alert("비밀번호를 입력해주세요.");
        passwordInput.focus();
        return false;
    } else {
        return true;
    }
}

let bottomSearchForm = window.document.body.querySelector("#bottom-search-form");

bottomSearchForm.onsubmit = function () {

    let whatInput = bottomSearchForm.elements["what"];
    let keywordInput = bottomSearchForm.elements["keyword"];
    if (whatInput.value === "") {
        alert("옵션을 선택해주세요.");
        whatInput.focus();
        return false;
    } else if (keywordInput.value === "") {
        alert("검색어를 입력해주세요.");
        keywordInput.focus();
        return false;
    } else {
        return true;
    }

}