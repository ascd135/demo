let writerForm = window.document.body.querySelector("#write-form");

ClassicEditor.create(writerForm.querySelector("textarea"),
    {
        ckfinder : {
            uploadUrl : '/bbs/upload_image'
        }
    });