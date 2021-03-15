let findPwForm = window.document.body.querySelector("#findPw-form");

findPwForm.onsubmit = function() {

    if (findPwForm.elements["id"].value === ""){
        alert("아이디를 입력해주세요.");
        findPwForm.elements["id"].focus();
        return false;
    } else if (findPwForm.elements["name"].value === "") {
        alert("이름을 입력해주세요.");
        findPwForm.elements["name"].focus();
        return false;
    } else if (findPwForm.elements["email"].value === "") {
        alert("이메일을 입력해주세요.");
        findPwForm.elements["email"].focus();
        return false;
    } else {
        return true;
    }
}