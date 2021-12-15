<!DOCTYPE html>
<html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.ezen.myapp.domain.*" %>
    <%BoardVo bv = (BoardVo)request.getAttribute("bv");%>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <meta name="description" content=""/>
        <meta name="author" content=""/>
        <title>다양한 사람들의 만남 MBTING
        </title>
        <!-- Favicon-->
        <link
        rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/assets/img/main/favicon1.png"/>
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css"/>
        <link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
        <link
        href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<%=request.getContextPath()%>/resources/css/styles.css" rel="stylesheet"/>
        <!-- include libraries(jQuery, bootstrap) -->
        <!-- include libraries(jQuery, bootstrap) --><script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"> </script>
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
        <!-- include summernote css/js-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
        <!-- include summernote-ko-KR -->
        <script src="/resources/js/summernote-ko-KR.js"></script>
        <style>
            .hn {
                font-family: 'Hanna', sans-serif;
            }
            .jg {
                font-family: 'Jeju Gothic', sans-serif;
            }
            .fileDrop {
                width: 1197px;
                height: 200px;
                border: 1px dotted blue;
            }
            small {
                margin-left: 3px;
                font-weight: bold;
                color: gray;
            }
            #write123{
            border: 1px solid;
            }
        </style>
        <!--  <script>
            $(document).ready(function() {
            	
                $('#contents').summernote();
        
            });
          </script> -->
        <script>
            $(document).ready(function () {
                $('#contents').on('keyup', function () {
                    $('#test_cnt').html("(" + $(this).val().length + " / 300)");
                    if ($(this).val().length > 300) {
                        $(this).val($(this).val().substring(0, 300));
                        $('#test_cnt').html("(300 / 300)");
                    }
                });
                var fontSizes = [
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                    '14',
                    '16',
                    '18',
                    '20',
                    '22',
                    '24',
                    '28',
                    '30',
                    '36',
                    '50',
                    '72',
                    '100'
                ];
                var fontNames = [
                    'Arial',
                    'Arial Black',
                    'Comic Sans MS',
                    'Courier New',
                    '맑은 고딕',
                    '궁서',
                    '굴림체',
                    '굴림',
                    '바탕체'
                ];
                var toolbar = [
                    // 글꼴 설정
                    [
                        'fontname', ['fontname']
                    ],
                    // 글자 크기 설정
                    [
                        'fontsize', ['fontsize']
                    ],
                    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
                    [
                        'style',
                        [
                            'bold', 'italic', 'underline'
                        ]
                    ],
                    // 필요시 추가'strikethrough', 'clear'
                    // 글자색
                    [
                        'color',
                        [
                            'forecolor', 'color'
                        ]
                    ],
                    // 표만들기
                    [
                        'table', ['table']
                    ],
                    // 글머리 기호, 번호매기기, 문단정렬
                    [
                        'para',
                        [
                            'ul', 'ol', 'paragraph'
                        ]
                    ],
                    // 줄간격
                    [
                        'height', ['height']
                    ],
                    // 그림첨부, 링크만들기, 동영상첨부
                    // ['insert',['picture','link','video']],
                    // 코드보기, 확대해서보기, 도움말
                    ['view', ['codeview']] // 필요시 추가 ,'fullscreen', 'help'
                ];
                var setting = {
                    height: 300,
                    width: 1050,
                    minHeight: null,
                    maxHeight: null,
                    focus: true,
                    lang: 'ko-KR',
                    toolbar: toolbar,
                    fontSizes: fontSizes,
                    fontNames: fontNames,
                    callbacks: { // 여기 부분이 이미지를 첨부하는 부분
                        onImageUpload: function (files, editor, welEditable) {
                            for (var i = files.length - 1; i >= 0; i--) {
                                uploadSummernoteImageFile(files[i], this);
                            }
                        }
                    }
                };
                $('#contents').summernote(setting);
            });
        </script>
        <script type="text/javascript">
            function check() {
                var fm = document.frm;
                if (fm.subject.value == "") {
                    swal("제목을 입력해주세요", " ", "warning");
                    fm.subject.focus();
                    return false;
                } else if (fm.contents.value == "") {
                    swal("내용을 입력해주세요", " ", "warning");
                    fm.contents.focus();
                    return false;
                } else if (fm.pwd.value == "") {
                    swal("비밀번호를 입력해주세요", " ", "warning");
                    fm.pwd.focus();
                    return false;
                }
                fm.action ="<%=request.getContextPath()%>/board/boardWriteAction.do";
                fm.method = "post";
                // fm.enctype="multipart/form-data"
                fm.submit();
                return;
            }
            // 파일 첨부 부분
            function addFilePath(msg) {
               // alert(msg);
            }
            function checkImageType(fileName) {
                var pattern = /jpg$|gif$|png$|jpeg$/i;
               // alert(fileName.match(pattern));
                return fileName.match(pattern);
            }
            function getOriginalName(fileName) {
                
                if (checkImageType(fileName)) {
                    return;
                }
                var idx = fileName.lastIndexOf("_") + 1;
               // alert(idx);
                return fileName.substr(idx);
            }
           
            function getImageLink(fileName) {
                if (! checkImageType(fileName)) {
                    return;
                }

                var front = fileName.substr(0, 12);
               
                var end = fileName.substr(14);
                return front + end;
            }
        </script>
        <script>
            $(document).ready(function () {
                //alert('test');
                $(".fileDrop").on("dragenter dragover", function (event) {
                    event.preventDefault();
                });
                $(".fileDrop").on("drop", function (event) {
                    event.preventDefault();
                    var files = event
                        .originalEvent
                        .dataTransfer
                        .files;
                    var file = files[0];
                    var formData = new FormData();
                    formData.append("file", file);
                    //alert("file" + file);
                    $.ajax({
                        url:'<%=request.getContextPath()%>/board/uploadAjax.do',
                        data: formData,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        type: 'POST',
                        error: function () {
                            alert("올바른 파일이 아닙니다.");
                        },
                        success: function (data) { // /2018/05/30/s-sdsdsd-ssd22q.jpg
                           // alert(data);
                            // input--> sdsdsd-ssd22q.jpg
                            $("#uploadfile").val(data.replace("s-", ""));
                            var str = "";
                            if (checkImageType(data)) {
                                str = "<div>" + "<a href=' <%=request.getContextPath()%>/board/displayFile.do?fileName=" + getImageLink(data) + "'>" + "<img src=' <%=request.getContextPath()%>/board/displayFile.do?fileName=" + data + "' />" + getImageLink(data) + "</a>" + "</div>";
                            } else {
                                str = "<div>" + "<a href=' <%=request.getContextPath()%>/board/displayFile.do?fileName=" + data + "'>" + getOriginalName(data) + "</a>" + "</div>";
                            }
                            $(".uploadedList").append(str);
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="<%=request.getContextPath()%>/index2.do"><img src="<%=request.getContextPath()%>/resources/assets/img/main/logo1.png" alt="..."/></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/serviceIntroduction.do">서비스 소개</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/Board2.do">게시판</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/debate.do">TALK</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/consulting.do">상담</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/infoM.do">MBTI정보</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/serviceCenter.do">고객센터</a>
                        </h4>
                        <h4>
                            <a class="nav-link jg" href="<%=request.getContextPath()%>/memberProfile.do">회원정보</a>
                        </h4>
                    </ul>
                </div>
            </div>
        </nav>
        <br><br><br>
        <div
            id="container">
            <!-- div_inner str -->
            <div
                class="div_inner">
                <!-- notice_wrap str -->
                <div class="contents_wrap">
                    <h1 class="con_title">
                        <div id="container1">
                            <br>
                            <h1 style="padding-left: 400px;">
                                MBTING 글쓰기페이지
                            </h1>
                            <form name="frm">
                                <table class="type091" style="width:1200px">
                                    <tr style="background-color:#f9f9f9">
                                        <td style="Text-align:center">제목</td>
                                        <td><input type="text" name="subject" style="width:300px;" maxlength="18"></td>
                                    </tr>
                                    <tr>
                                        <td style="Text-align:center; vertical-align : middle;">내용</td>
                                        <td>
                                            <textarea name="contents" id="contents" style="resize: none; width:600px; height:200px;"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="Text-align:center;" "margin=auto;">비밀번호</td>
                                        <td><input type="password" name="pwd" id="write123"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="background-color:#f9f9f9; Text-align:center"><input type="hidden" id="uploadfile" name="uploadfile">파일첨부</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="fileDrop"></div>
                                            <div class="uploadedList"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button class="btn" onClick="check();return false;">확인</button>
                                            <button class="btn" onClick="reset();">리셋</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </body>
                    </html>