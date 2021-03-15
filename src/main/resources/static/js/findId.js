let findIdForm = window.document.body.querySelector("#findId-form");

findIdForm.onsubmit = function() {

    if (findIdForm.elements["name"].value === ""){
        alert("이름을 입력해주세요.");
        findIdForm.elements["name"].focus();
        return false;
    } else if (findIdForm.elements["email"].value === "") {
        alert("비밀번호를 입력해주세요.");
        findIdForm.elements["email"].focus();
        return false;
    } else {
        return true;
    }
}