(() => {
    let yOffset = 0;
    const sceneInfo = [
        {
            // 0
            scrollHeight: 0,
            objects : {
                container : document.querySelector('#scroll-section-0'),
                titleText : document.querySelector('#title-text')
            }
        },

        {
            // 1
            scrollHeight: 0,
            objects : {
                container : document.querySelector('#scroll-section-1'),
            }
        },

        {
            // 2
            scrollHeight: 0,
            objects : {
                container : document.querySelector('#scroll-section-2'),
            }
        },

        {
            // 3
            scrollHeight: 0,
            objects : {
                container : document.querySelector('#scroll-section-3'),
            }
        }
    ]

    // 세션의 높이 세팅
    function setLayout() {

        for (let i = 0; i < sceneInfo.length; i++) {
            sceneInfo[i].scrollHeight = 1 * window.innerHeight;
            sceneInfo[i].objects.container.style.height = `${sceneInfo[i].scrollHeight}px`;
        }
    }

    function changeColor(yOffset) {
        if (yOffset < sceneInfo[0].scrollHeight-1) {
            document.querySelector('.top-nav').style.borderBottomColor = `#ffffff`;
            document.querySelector('.top-nav-link a.home-title').style.color = `#ffffff`;
            document.querySelector('.top-nav-link a.a').style.color = `#ffffff`;
            document.querySelector('.top-nav-link a.b').style.color = `#ffffff`;
            document.querySelector('.top-nav-link a.c').style.color = `#ffffff`;
            document.querySelector('.top-nav-link a.d').style.color = `#ffffff`;
            document.querySelector('.top-nav-link a.e').style.color = `#ffffff`;
        }
        else {
            document.querySelector('.top-nav').style.borderBottomColor = `#000000`;
            document.querySelector('.top-nav-link a.home-title').style.color = `#000000`;
            document.querySelector('.top-nav-link a.a').style.color = `#000000`;
            document.querySelector('.top-nav-link a.b').style.color = `#000000`;
            document.querySelector('.top-nav-link a.c').style.color = `#000000`;
            document.querySelector('.top-nav-link a.d').style.color = `#000000`;
            document.querySelector('.top-nav-link a.e').style.color = `#000000`;
        }
    }

    window.addEventListener('scroll', () => {
       yOffset = window.pageYOffset;
       changeColor(yOffset);

    });

    window.addEventListener('load', setLayout);
    window.addEventListener('resize', setLayout);
    
}) ();

