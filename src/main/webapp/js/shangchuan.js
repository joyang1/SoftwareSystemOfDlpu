function imgDivHide()
{
 document.getElementById("divPreview").style.display="none";
}

//preview image
function previewImage(fileObj,imgPreview,divPreview)
{ 
    var allowImgExtType = "jpg,jpeg,bmp,gif,png"; //jpg,jpeg,bmp,gif,png,��
    var updImg = document.getElementById("updImg").value;
    //alert(updImg);
    var imgExt = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();
    var browserVersion = window.navigator.userAgent.toUpperCase();
    if(updImg.indexOf(imgExt) > -1 && allowImgExtType.indexOf(imgExt) != -1)
    {
        if (browserVersion.indexOf("MSIE") > -1)
        {
            if(browserVersion.indexOf("MSIE 6.0") > -1)
            {   //ie6
                document.getElementById(imgPreview).setAttribute("src",fileObj.value);
            } else { 
             //ie[7-8]��ie9
                fileObj.select();
                var newPreview = document.getElementById(divPreview + "New");
                if(newPreview == null)
                {
                    newPreview = document.createElement("div");
                    newPreview.setAttribute("id",divPreview + "New");
                    newPreview.style.width = document.getElementById(imgPreview).style.width;
                    newPreview.style.height = document.getElementById(imgPreview).style.height;
                    newPreview.style.border = "solid 1px #d2e2e2";
                }
                newPreview.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";                            
                var tempDivPreview = document.getElementById(divPreview);
                tempDivPreview.parentNode.insertBefore(newPreview,tempDivPreview);
                tempDivPreview.style.display="none";
            }
        } else if(browserVersion.indexOf("FIREFOX") > -1 ){
         //firefox
            var firefoxVersion = parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);
            if(firefoxVersion < 7)
            {
             //firefox7
                document.getElementById(imgPreview).setAttribute("src",fileObj.files[0].getAsDataURL());
            } else { 
             //firefox7.0+
                document.getElementById(imgPreview).setAttribute("src",window.URL.createObjectURL(fileObj.files[0]));
            }
            document.getElementById("divPreview").style.display="block";
        } else if(fileObj.files) {
            //chrome17+
            if(typeof FileReader !== "undefined")
            {
                var reader = new FileReader();
                reader.onload = function(e)
                {
                    document.getElementById(imgPreview).setAttribute("src",e.target.result);
                }
                reader.readAsDataURL(fileObj.files[0]);
                document.getElementById("divPreview").style.display="block";
            } else if(browserVersion.indexOf("SAFARI") > -1) {
//                alert("��ʱ��֧��Safari�����!");
            }
        } else {
         document.getElementById("divPreview").style.display="block";
            document.getElementById(divPreview).setAttribute("src",fileObj.value);
        }
    } else {
//        alert("��֧����" + imgExt + "Ϊ��׺����ļ�!");
        fileObj.value = "";//���ѡ���ļ�
        if(browserVersion.indexOf("MSIE") > -1)
        {
            fileObj.select();
            document.selection.clear();
        }
        fileObj.outerHTML = fileObj.outerHTML;
    }
}

function upload()
{
 //your upload code
}