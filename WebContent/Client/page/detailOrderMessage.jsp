<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>订单详情</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet"  type="text/css"  href="../css/header.css"/>  
        <link rel="stylesheet"  type="text/css"  href="../css/detailOrderMessage.css"/>      

    </head>
    <body>

        <div id="header">
            <div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->

            <div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
            <div id="title">订单详情</div>
        </div>

        <div id="content">


            
            <div id="product">
                <div id="productImgDiv"><img id="productImg" src="../images/product.jpg"/></div>

            </div>	
            
           

            <div class="orderMainMessage">


                <div class="orderMessage">
                    <div class="productName">
                        <span class="blackBold">2015现磨五常稻花香大米</span>
                    </div>

                    <div class="middleTag">
                        <div class="tagLeft">商品价格：</div><div class="blackNormal" id="productPrice">唐兴 元</div>
                    </div>

                    <div class="middleTag">
                        <div class="tagLeft">运费：</div><div class="orangeText" id="freight">99元</div>
                    </div>

                    <div class="middleTag">
                        <div class="tagLeft">实付款：</div><div class="orangeText" id="paid">233元</div>
                    </div>

                    <div class="middleTag">
                        <div class="tagLeft">预计发货时间：</div><div class="blackNormal" id="timeToDeliver">11-20至11-31</div>
                    </div>
                </div>

                <div class="functionButton" id="button1">第一按钮</div>

                <div class="functionButton" id="button2">第二按钮</div>

            </div>

            <div class="moreMessage">            

                <div class="middleTag">
                    <div class="tagLeft">收货地址：</div><div class="blackNormal" id="aimLocation">北京交通大学999号宿舍楼101室</div>
                </div>

                <div class="middleTag">
                    <div class="tagLeft">收货人：</div><div class="blackNormal" id="recieverName">唐兴元</div>
                </div>

                <div class="middleTag">
                    <div class="tagLeft">手机号码：</div><div class="blackNormal" id="telephoneNumber">13333333333</div>
                </div>

            </div>

        </div>
    </body>
</html>
