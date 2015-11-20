$(document).ready(function () {

    if(module_activated) {
        getTrad();
        $(document).on('DOMNodeInserted', function (e) {
            getTrad();
        });
        $(document).ajaxComplete(function () {
            getTrad()
        });
    }
});

$.fn.justtext = function() {

    return $(this)  .clone()
        .children()
        .remove()
        .end()
        .text();

};

function getTrad(){
    var regex = new RegExp('\|(.*?)\|');
    var regexShow =   new RegExp('--','g');
    $('th,td,h1,h2,h2,h3,h4,h5,h6,li,select,option,a,img,div,button,span,p,label,input').each(function(){

        if ( $(this).children().length ==0
            ||($(this).find('*').length ==1&& $(this).children(":first").html()=="")
            ||($(this).find('*').length==1&& $(this).children(":first").is("a"))
            ||($(this).find('*').length ==0&& $(this).is("div"))
            ||hasChildWithText($(this),true)
            ||($(this).find('*').length ==1&& $(this).children(":first").html().indexOf(".")==-1
            && $(this).find('*').length ==1&& $(this).children(":first").html().indexOf("_")==-1)
            )

            if(regex.test($(this).attr('href'))||regex.test($(this).attr('value'))||regex.test($(this).html())||regex.test($(this).attr("placeholder"))){

                var result=false ;
                var matches=null;
                if($(this).children(":first").is("a")||$(this).is("a"))
                {
                    if (regex.test($(this).justtext()) && typeof $(this).html()!="undefined"){

                        matches = $(this).justtext().match(/\|(.*?)\|/);
                        if(matches!=null)
                            $(this).html($(this).html().replace("|"+matches[1]+"|","")) ;
                    }
                }


                if(matches==null&&regex.test($(this).val()) && $(this).val() !='0'&&typeof $(this).val()!="undefined" ) {
                    matches = $(this).val().match(/\|(.*?)\|/);

                    if(matches!=null)
                        $(this).val($(this).val().replace("|"+matches[1]+"|","")) ;
                }
                if(matches==null&&regex.test($(this).attr('value')) && $(this).val() !='0'&& typeof $(this).attr('value')!="undefined" ) {
                    matches = $(this).attr('value').match(/\|(.*?)\|/);

                    if(matches!=null)
                        $(this).attr('value',$(this).attr('value').replace("|"+matches[1]+"|",""))
                }
                if (matches==null&&regex.test($(this).justtext()) && typeof $(this).justtext()!="undefined"){

                    matches = $(this).justtext().match(/\|(.*?)\|/);
                    if(matches!=null)
                        $(this).html($(this).html().replace("|"+matches[1]+"|","")) ;
                }
                if(matches==null&&regex.test($(this).attr("placeholder")) && typeof $(this).attr('placeholder')!="undefined") {
                    matches = $(this).attr('placeholder').match(/\|(.*?)\|/);
                    if(matches!=null)
                        $(this).attr('placeholder',$(this).attr('placeholder').replace("|"+matches[1]+"|","")) ;
                }


                if (matches!=false&&matches!=null){
                    if(typeof $(this).attr('title')!="undefined" ){

                        $(this).attr('title',$(this).attr('title').replace( "|"+matches[1]+"|",""));

                        $(this).attr('title',  $(this).attr('title')+ " => "+matches[1].replace(regexShow,"."));
                        if(typeof $(this).attr('href')!="undefined" ){
                            matches = $(this).attr('href').match(/\|(.*?)\|/);
                            if(matches!=null){
                                $(this).attr('href',$(this).attr('href').replace( "|"+matches[1]+"|",""));
                                $(this).attr('title',  $(this).attr('title')+ "\n href => "+matches[1].replace(regexShow,"."));
                            }
                        }
                    }
                    else  {

                        $(this).attr('title',"=> "+matches[1].replace(regexShow,"."));
                        if(typeof $(this).attr('href')!="undefined" ){
                            matches = $(this).attr('href').match(/\|(.*?)\|/);
                            if(matches!=null){
                                $(this).attr('href',$(this).attr('href').replace( "|"+matches[1]+"|",""));
                                $(this).attr('title',  $(this).attr('title')+ "\n href => "+matches[1].replace(regexShow,"."));
                            }
                        }
                    }


                }

            }
    });

}



function hasChildWithText(obj,isEmpty)
{
    if(isEmpty)
    {
        if($.trim(obj.justtext())!='' ){
            return true;
        }
        obj.children().each(function(index) {
            if($(this).find('*').length>0)
                isEmpty=hasChildWithText($(this),isEmpty)
            else
            if(typeof $(this).html()!="undefined"&& $(this).html()!="" && $(this).html()!=null )
            {
                isEmpty=false;
                return false;
            }



        });
        return isEmpty;
    }
    else
        return false;
}

