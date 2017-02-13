//ajax实现文件
function GetXmlHttpObject()
{
    var xmlHttpRequest = null;
    if (window.ActiveXObject) {
        xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else
    {
        xmlHttpRequest = new XMLHttpRequest();
    }
    return xmlHttpRequest;
}

var xmlHttpRequest = GetXmlHttpObject();

function StartAjax(Methods, url, Asynchronous,string)
{
    
    if (xmlHttpRequest)
    {
        
        xmlHttpRequest.open(Methods, url, Asynchronous);
        if (Methods=="post")
            xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlHttpRequest.onreadystatechange = Callback;
        xmlHttpRequest.send(string)
    }
    else
    {
        CreateFailure();
       
    }
}

function Callback() 
{ 
    switch(xmlHttpRequest.readyState)
    {
        case 0:Requestuninitialized();break;
        case 1:ServerConnectionHasBeenEstablished();break;

        case 2:EquestHasBeenReceived();
        case 3:RequestProcessing();
        case 4:
            {
                if (xmlHttpRequest.status == 200)
                {
                    CallbackSuccess();
                }
                else
                {
                    CallbackFailure();
            
                }
            }
            break;
        default:SendFailure();
    }
}